---
title: "Moonlander: Split Keyboard and Split Brain"
date: 2024-08-19
draft: false
tags: ["moonlander", "ergonomics", "colemak"]
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

If you were to ask a programmer what their number one productivity tool in their arsenal is, I'd bet very few would say "a keyboard".

This is the very perception I'm hoping to challenge with my purchase of the [Moonlander](https://www.zsa.io/moonlander) keyboard. 

## Current typing setup

I'm currently typing this using a QWERTY layout on a Keychron K2, a 75% keyboard running Cherry MX Browns. 

I've never fully learned to touch type and as a result I type at an average of 80 to 90 wpm. With an accuracy of around 90 to 95%.

As someone who spends majority of the day typing, not learning proper touch typing always weighed heavily on me. I feared I was missing out on a foundational skill.

But most programmers will know that 80 wpm is sufficient to just _get the job done_, so I just carried on.

## A "healthier" alternative

In the last 2 years I've been on a bit of a [health refactor]({{< ref "2022-10-20--changelog-1-quarter-of-the-man-i-used-to-be">}}). 

I have invested in a standing desk and walking treadmill, but never yet bit the bullet on ergonomic type keyboards. 

The Moonlander caught my eye when watching a series of videos by [Ben Vallack](https://www.youtube.com/channel/UC4NNPgQ9sOkBjw6GlkgCylg).
It comes with a nifty configuration tool [Oryx](https://configure.zsa.io), a front-end for the open-source [QMK](https://github.com/qmk/qmk_firmware) keyboard firmware. 

The best feature is the ability to define **layers** on top of existing keys. A common example on standard keyboards would be typing uppercase letters using the SHIFT key. Holding SHIFT activates a **layer** changing the behaviour of pressing a character on the keyboard. On the Moonlander for example, you can define a layer key to make the keys `H`, `J`, `K` and `L` work as the `LEFT`, `DOWN`, `UP` and `RIGHT` keys.

## Dvorak vs Workman vs Colemak

Since the Moonlander is ortholinear (keys directly below and above each other in a sort of grid), I figured that since I was already "re-learning" where my fingers should be (and which finger presses which key) I would take the opportunity to also learn a more efficient and comfortable keyboard layout.

There are many popular alternatives to the horribly inefficient QWERTY layout these days. Dvorak, Workman and Colemak are the more popular ones. But which to choose?

[This video by Ben Vallack](https://www.youtube.com/watch?v=SjeidYNFWvM) discounted Workman for me.

Between Dvorak and Colemak, and by no means an expert in the matter at all, I surmised the following.

> Dvorak puts a strong emphasis on alternating left and right hand movements to limit strain and fatigue while Colemak seems to prefer the _rolling_ movement over common words.

The [Colemak DH](https://colemakmods.github.io/mod-dh/) takes this concept a step further by putting the commonly used `D` and `H` keys in easier positions.

{{< figure src="colemak_layout.png" caption="<span class=\"figure-number\">Figure 1: </span>Colemak DH Layout" link="colemak_layout.png" >}}

I've never experienced any fatigue on pain in my wrists or fingers yet (touch wood), so Dvorak didn't seem more appealing that Colemak.

I decided to go with Colemak DH.

## The learning path

Since the learning (and re-learning) will cause me to take a huge productivity hit initially, my plan is:
- Don't use the Moonlander for work or anything super important (yet)
- Practice 30 minutes each day on [keybr.com](http://keybr.com/) (you can prioritise home row keys first, super useful!)
- Only map the keys when I actually use them via the Oryx tool (this will allow me to commit keys to muscle memory as I use them)

## Defining success

I am not trying to be the fastest typist. For me, comfortability and accuracy should take preference whilst keeping my hands on the keyboard as much as possible. 

It will be interesting to see how much my Vim key-bindings suffer with the new layout, but I'll cross that bridge when I get there.

For now, here's hoping to slowly sculpt the ultimate productivity tool. 

I'll be documenting my journey here. Let's see how it goes.