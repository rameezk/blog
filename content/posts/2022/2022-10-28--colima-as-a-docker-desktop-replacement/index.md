---
title: "Colima as a Docker Desktop Replacement?"
date: 2022-10-28
draft: false
tags: ["colima", "docker", "docker-desktop", "nix"]
author: "Rameez Khan"
showToc: true
TocOpen: false
hidemeta: false
comments: false
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
series: []
---

> An attempt at finding a drop-in replacement for Docker Desktop on macOS.

## Why a replacement?

[Docker Desktop](https://www.docker.com/products/docker-desktop) has been the gold standard for building and running containers on macOS.

But what is it? Is it just a fancy container GUI? 

Well, no. 

The single, downloadable package comes built-in with everything you need to build and run Docker images on your machine. Besides running a VM in the background as a daemon, Docker Desktop provides seamless plumbing into the host machine with sane and secure defaults [^1].

[^1]: https://www.docker.com/blog/the-magic-behind-the-scenes-of-docker-desktop/

From a technical perspective, this is fantastic and works fine. However, the following reasons made me start looking for a replacement:
- It is closed source.
- It makes requests to `desktop.docker.com` even with anonymous usage statistics turned off.
- It is no longer free for businesses and corporations. [^2]

[^2]: https://www.docker.com/blog/do-the-new-terms-of-docker-desktop-apply-if-you-dont-use-the-docker-desktop-ui/

## Clearing up some tooling confusions

You may already know this, but I didn't at first. 

There's a difference between `docker` (the CLI) and Docker Desktop.

Docker (the CLI) is installed by default **with** Docker Desktop, but it is also available as a stand-alone installation via [Homebrew](https://formulae.brew.sh/formula/docker) or [Nix](https://search.nixos.org/packages?channel=unstable&show=docker&from=0&size=50&sort=relevance&type=packages&query=docker).

This is similar types of _setup_ to [docker-compose](https://docs.docker.com/compose/install/linux/).

## Colima

As a drop-in replacement [Colima](https://github.com/abiosoft/colima/) seems to be a good choice. It is based on [Lima](https://github.com/lima-vm/lima) and creates a QEMU VM. 

It comes bundled with:
- A CLI interface for common operations (e.g. starting/stop Colima)
- Port forwarding
- Mounting volumes.

And it's **open source**!

### Setup

I'm using [Nix](https://nixos.org/) here, but you can use Homebrew too. 

> By the way, I created a full example [here](https://github.com/rameezk/colima-docker-example), if you'd rather follow that.

1. First, if Docker Desktop is running, stop it. You don't have to uninstall it, it just needs to be stopped.
2. Next, get the tooling. In my `shell.nix` I have:
```nix
let 
  pkgs = import <nixpkgs> { };
in pkgs.mkShell rec {
  buildInputs = with pkgs; [
    colima
    docker-client
    docker-compose
    docker-credential-helpers
  ];
}
```
3. Jump into the nix shell
```shell
nix-shell
```
4. Then, start Colima
```shell
colima start
```
5. Run your docker commands as usual (e.g. `docker build`, `docker-compose up` etc)

#### Proxy Configuration

If you're behind a proxy, there's some additional setup.

After starting Colima via `colima start`, you need to ssh into the VM with `colima ssh`.

Then edit the `/etc/init.d/docker` file

```sh
sudo vi /etc/init.d/docker
```

and append the following:

```sh
set -o allexport
if [ -f /etc/environment ]; then source /etc/environment; fi
set +o allexport
```

Stop Colima with `colima stop`.

On your host machine, create `$HOME/.colima/default/colima.yaml` with your proxy configuration as follows:

```yaml
env:
  HTTP_PROXY: http://proxy.example.com:80
  HTTPS_PROXY: http://proxy.example.com:443
  NO_PROXY: localhost,127.0.0.1,docker-registry.example.com,.corp
```

Then start Colima again via `colima start`.

### What works? What doesn't?

On the performance front, I haven't noticed any significant degradation in performance using Colima. 

Volume mounts and port forwarding work out of the box. Nice.

I had some trouble pulling images from private docker registries. To solve this I had to install [docker-credential-helpers](https://github.com/docker/docker-credential-helpers) (see [shell.nix](#setup) above).


### Opting Out

Colima mutates the `context` field in the `~/.docker/config.json` configuration. To switch back to Docker Desktop (assuming you haven't uninstalled it):

```shell
docker context use default
```

## Conclusion

After testing Colima with a few of own personal projects, I found it to be a suitable drop-in replacement for Docker Desktop. 

The simple CLI provides a low barrier to entry for users looking to migrate. 

Only somewhat notable quirk is the extra steps needed if you're behind a proxy. This would be for users in the minority in any case. In fact, Colima might already be working on a fix. [^3]

[^3]: https://github.com/abiosoft/colima/issues/294#issuecomment-1132857122

I will continue to use Colima on my personal MacBook.
