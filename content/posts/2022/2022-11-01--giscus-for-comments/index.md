---
title: "Giscus for Comments"
date: 2022-11-01
draft: false
tags: ["giscus", "disqus", "privacy", "github"]
author: "Rameez Khan"
showToc: true
TocOpen: false
hidemeta: false
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

> Giscus is a solid option if you're looking for a low-impedance alternative to Disqus.

## Remember when Disqus was a thing?

On my [old blog](https://github.com/rameezk/blog-old) I used an _off-the-shelf_ [Gatsby](https://www.gatsbyjs.com/) template
which came bundled with [Disqus](https://disqus.com/) support.

I didn't know better at the time so I just went with it. 

So I know I'm probably late to the _lets-move-away-from-disqus-party_, but now, re-writing this blog and re-thinking the tech stack behind it, it was time to give some more thought to this.

### So why all the hate?

Disqus is a "free" commenting engine.

"free" as in **you're** probably the product now.

Unfortunately, your website visitors have become the product too.

#### Disqus is an advertising company
Disqus was acquired by Zeta Global in 2017 [^1]. 

[^1]: https://techcrunch.com/2017/12/05/zeta-global-acquires-commenting-service-disqus

So it's definitely not about maximising revenue? Right?


#### People who's tech opinion I trust

Bozhidar Batsov, an Emacs Hacker, and creator of [cider](https://github.com/clojure-emacs/cider) said (a long while ago):

<!-- https://twitter.com/bbatsov/status/1335891387489914880 -->
{{< tweet user="bbatsov" id="1335891387489914880" >}}

#### To summarise

Disqus has:
- High load times (upward of 2MB of data)
- Tracking and targeted ads
- Injected pixel tracking

At this point, the flaws outweigh the benefits.

It's time for an alternative.


## What I was looking for

When looking for an alternative, this is what I had in mind.

- This blog is hosted on [Netlify](https://www.netlify.com/) so I didn't want to self-host anything (no mucking around with VMs or databases of any kind)
- No tracking whatsoever
- Open-source
- A somewhat good user experience (don't want users signing up for a separate service)

## Giscus

[Giscus](https://github.com/giscus/giscus) looked promising. 

It's free and open source. 

It doesn't track you or your users. 

You _can_ self-host if you want, but you don't have to. I believe it is hosted on [Vercel](https://vercel.com/) currently.

The most attractive aspect for me is that it uses [GitHub Discussions](https://docs.github.com/en/discussions) to host the comments. 

GitHub is a platform I'm certainly familiar with and feel comfortable enough to allow for the vendor lock-in.
If users would like to leave a comment (or a post reaction) they would need to have a GitHub account, which I think majority of the users reading my blog would
have.

It is also incredibly simple to setup.

### Setup

Just follow the instructions on [Giscus starter page](https://giscus.app).

To summarise:
1. Enable the GitHub Discussion feature on an existing or new public GitHub repo.
2. Install the Giscus app and allow access to the repo
3. Copy the `script` to your websites template. If you using Hugo it will most probably be `/layouts/partials/comments.html` or something similar.

That's it!

Figures 1 and 2 shows what it looks like.

{{< figure align=center src="example_comments.jpeg" caption="<span class=\"figure-number\">Figure 1: </span>What comments looks like using Giscus" link="example_comments.jpeg" >}}

{{< figure align=center src="example_github_discussions.jpeg" caption="<span class=\"figure-number\">Figure 2: </span>What GitHub Discussions looks like using Giscus" link="example_github_discussions.jpeg" >}}

### Cool features

#### Limiting access from certain origins

It might be wise to restrict access to certain domains. 

Giscus allows for creating a `giscus.json` configuration in the repo hosting the comments. See [here](https://github.com/giscus/giscus/blob/main/ADVANCED-USAGE.md#origins) for
more details.

#### Dynamic theme toggling for light/dark mode

Giscus exposes an [interface](https://github.com/giscus/giscus/blob/main/ADVANCED-USAGE.md#isetconfigmessage) allowing you to send a message to the Giscus iFrame which changes
the theme without needing a full page refresh.

This blog has a button (top left, next to the header, with an ID of `theme-toggle`) which toggles the theme.

In my case, the `comments.html` template is as follows.

```html
<div class="giscus">

<script>
  function getGiscusTheme() {
      const preferredTheme = localStorage.getItem("pref-theme");
      const giscusTheme = preferredTheme == null || preferredTheme == "light" ? "light" : "dark";
      return giscusTheme;
  }

  function setGiscusTheme() {
    function sendMessage(message) {
      const iframe = document.querySelector('iframe.giscus-frame');
      if (!iframe) return;
      iframe.contentWindow.postMessage({ giscus: message }, 'https://giscus.app');
    }
    sendMessage({
      setConfig: {
	  theme: getGiscusTheme() == "light" ? "dark": "light",
      },
    });
  }

  const attrs = {
      "src": "https://giscus.app/client.js",
      "data-repo": "rameezk/blog-comments",
      "data-repo-id": "R_kgDOIWVKbg",
      "data-category": "Announcements",
      "data-category-id": "DIC_kwDOIWVKbs4CSTz_",
      "data-mapping": "pathname",
      "data-strict": "0",
      "data-reactions-enabled": "1",
      "data-emit-metadata": "0",
      "data-input-position": "bottom",
      "data-theme": getGiscusTheme(),
      "data-lang": "en",
      "crossorigin": "anonymous",
      "async": ""
  };

  const giscusScript = document.createElement("script");
  Object.entries(attrs).forEach(([key, value]) => giscusScript.setAttribute(key, value));
    document.body.appendChild(giscusScript);

  const toggle = document.querySelector('#theme-toggle');
  if (toggle) {
    toggle.addEventListener('click', setGiscusTheme);
  }
</script>

<noscript>Please enable JavaScript to view the comments</noscript>
```

#### Locking discussions prevents further comments

If you lock the discussion from GitHub Discussions, this prevents further comments as well.


{{< figure align=center src="example_locking_discussion.jpeg" caption="<span class=\"figure-number\">Figure 3: </span>Locking a discussion on GitHub" link="example_locking_discussion.jpeg" >}}


{{< figure align=center src="example_comments_locked.jpeg" caption="<span class=\"figure-number\">Figure 4: </span>A locked discussion prevents further comments" link="example_comments_locked.jpeg" >}}

## What about migrating old comments from Disqus?

I think my old blog had like 3 users at its peak (no citation here folks, sorry) so I felt comfortable letting these go.

RIP.

## Other Alternatives
### Utterances
[Utterances](https://utteranc.es/) is almost identical to Giscus with just one notable difference. 

Utterances is built on top of GitHub issues, where is Giscus is built on top of GitHub's newer Discussions feature.

I'll admit I'm a bit of a Magpie in this regard.

### Isso

[Isso](https://isso-comments.de/) looked really promising, but again, I didn't want to self-host anything. 

I'm sure it would have been possible with a Netlify's [reverse proxy features](https://docs.netlify.com/routing/redirects/rewrites-proxies/) but I didn't 
want to go down that dark road.

## Conclusion

Giscus provides a low-impedance approach to hosting comments on your site or blog. 

If you're comfortable with the lock-in with using GitHub Discussions it's a great choice.
