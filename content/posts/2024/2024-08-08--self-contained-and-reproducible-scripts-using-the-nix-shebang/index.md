---
title: "Self-Contained and Reproducible Scripts Using the Nix Shebang"
date: 2024-08-08
draft: false
tags: ["nix"]
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

In a previous [Nix](https://rameezkhan.me/tags/nix/) [post]({{< ref "2021-05-10--once-off-commands-with-nix" >}})
I mentioned how you can run once-off commands with Nix without polluting your system environment. 

In this post, I want to demonstrate how you can create self-contained and reproducible scripts using the Nix
[shebang](https://en.wikipedia.org/wiki/Shebang_(Unix)).

## Simple cowsay script

### Using the interactive `nix-shell`

To start, imagine a scenario where you want a cow to "moo" using [cowsay](https://en.wikipedia.org/wiki/Cowsay).

The bash script `moo.sh` would contain.

```bash
#!/usr/bin/env bash

cowsay "moo"
```

To obtain the cowsay binary without polluting your system environment you would first generate a temporary environment.

```shell
nix-shell -p cowsay
```

And then execute the script.

```shell
./moo.sh
```

### Using the `nix-shell` shebang

A cleaner, more contained, approach would be to use the `nix-shell` [shebang](https://nixos.wiki/wiki/Nix-shell_shebang).

The `moo.sh` script would then look like.

```bash
#!/usr/bin/env nix-shell
#!nix-shell -i bash -p cowsay

cowsay "moo"
```

The first line should always be `#!/usr/bin/env nix-shell`.

The second line describes the script language (in this case bash) and the dependencies (cowsay).

Executing the script is then just as simple as executing any executable.

```shell
./moo.sh
```

### Using "pure" environments

The above example doesn't strictly check if `cowsay` was declared in the dependencies. To enforce this check,
i.e. all dependencies used in the script **HAS** to be declared on line 2, you need to use the `--pure` arg.

```bash
#!/usr/bin/env nix-shell
#!nix-shell --pure -i bash -p cowsay

cowsay "moo"
```

## A real world example using my `dot` binary

I was able to simplify my dotfiles by replacing my `shell.nix` with a shebang declaration. See the
[diff](https://github.com/rameezk/dotfiles/commit/503f9b757944c6f68c05b573ca9addd3b9286fea).

## Conclusion

The Nix shebang provides a cleaner, self-contained and reproducible (if you use the `--pure` arg) method of writing scripts.