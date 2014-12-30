zsh-open-github-pr [![Build Status](https://travis-ci.org/caarlos0/zsh-open-github-pr.svg?branch=master)](https://travis-ci.org/caarlos0/zsh-open-github-pr)
==================

zsh open a github pull request from command line.

## Install using antigen

```sh
antigen bundle caarlos0/zsh-open-github-pr
```

## Usage

```sh
git checkout -b random-feature
// do some stuff
git commit -am 'did some stuff'
git push
open-pr
```

This will open an URL like
`https://github.com/origin/repo/compare/master...random-feature`.

This will open your browser (using `open` on OSX and `xdg-open` on Linux) in
a URL to create a Pull Request from your current branch to `upstream` or
`origin` (if there is no `upstream` remote) `master` branch.

In the case you have a `upstream` remote (you are working on a fork), the
previous example will open an URL like

You can also specify another branch, like
`https://github.com/upstream/repo/compare/master...origin:random-feature`

```sh
open-pr experimental
```

This will open an URL like
`https://github.com/origin/repo/compare/random-feature...experimental`. It will
also deal with forks.
