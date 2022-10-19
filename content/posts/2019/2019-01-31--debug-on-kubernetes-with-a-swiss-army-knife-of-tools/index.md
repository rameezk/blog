---
title: "Debug on Kubernetes with a Swiss-Army Knife of Tools"
date: 2019-01-31
# weight: 1
aliases: ["/debug-on-kubernetes-with-a-swiss-army-knife-of-tools"]
tags: ["kubernetes", "docker", "debug"]
author: "Rameez Khan"
# author: ["Me", "You"] # multiple authors
showToc: true
TocOpen: false
draft: false
hidemeta: false
comments: false
# canonicalURL: "https://canonical.url/to/page"
disableShare: false
disableHLJS: false
hideSummary: false
searchHidden: false
ShowReadingTime: true
ShowBreadCrumbs: true
ShowPostNavLinks: true
ShowWordCount: true
ShowRssButtonInSectionTermList: true
UseHugoToc: true
cover:
    image: "debuggery.png" # image path/url
    relative: false # when using page bundles set this to true
    hidden: true # only hide on current single page
---

## Premise

I often find myself needing to debug some network issue on Kubernetes. This is usually something like doing a traceroute to an external or internal address, checking egress IP addresses, or just needing a shell on the Kubernetes cluster.

## The Past

What I used to do is find any running pod on the cluster and shell into it, hoping it's running some sort of base Alpine/Debian image. Then I'd use whatever the built-in package manager is (apt, yum, etc) to install my the tools (nmap, traceroute, ping, etc). 

And I would have to do this every time. 

Every. Damn. Time.

## The Future

So I decided to build my own _debug_ Docker image, which would serve as my Swiss-Army Knife for debugging thing. 

I've called it **Debuggery** and you can clone it [here](https://github.com/rameezk/debuggery). It uses an Alpine base image to keep the size as lean as possible. 

The usage is simple but very convenient. Just set up an alias:
```bash
alias kdebug='kubectl exec -it debuggery -- zsh || kubectl run --rm -it debuggery --image=rameezk/debuggery --restart=Never'
```

Basically, if the _debuggery_ pod is already running it will open a shell on it (zsh of course 🚀), otherwise, it will spin up a new pod. 

That's it. Forks and PR's welcome 😊.

Peace ✌🏽
