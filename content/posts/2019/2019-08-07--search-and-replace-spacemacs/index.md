---
title: "Search and Replace in Multiple Files with Spacemacs"
date: 2019-08-07
# weight: 1
aliases: ["/search-and-replace-spacemacs"]
tags: ["spacemacs", "vim", "editors"]
author: "Rameez Khan"
# author: ["Me", "You"] # multiple authors
showToc: true
TocOpen: false
draft: false
hidemeta: false
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
    image: "cover.png" # image path/url
    relative: false # when using page bundles set this to true
    hidden: true # only hide on current single page
---

## What is Spacemacs
I've been a pure Vim user for many years before I stumbled on Spacemacs.

So what is it?

Spacemacs is a community driven distribution of Emacs. The tagline is `The best editor is neither Emacs nor Vim, it's Emacs and Vim!`. It's pretty much Emacs with a well structured configuration system (via something called "Layers"). You can choose to use Vim like keybindings (or what Emacs people call [evil](https://github.com/emacs-evil/evil)).

I quite like Spacemacs :).

## Searching and Replacing in Multiple Files
A cool trick I learned recently is the ability to search and replace in multiple files.

- With `helm-ag` you can search through all files in your projectile project with `SPC /` or `SPC s p`.
- Enter your search query and a list of files with that occurrence will show up
- Then hit `C-c C-e` and Spacemacs will create a `helm-ag-edit` buffer
- Now you can use any command you'd normally be able to run on a buffer. For example, a simple Vim search and replace `%s/alice/bob/g`.
- Then hit `C-c C-c` to save the changes.

Pretty nifty!

I recommend you try out Spacemacs. It has become my daily editor of choice. You can also check out my personal Spacemacs configuration (`.spacemacs`) in my [dotfiles](https://github.com/rameezk/dotfiles).

That's it for now.

Peace ✌🏽
