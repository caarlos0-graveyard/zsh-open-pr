zsh-open-pr [![Build Status](https://travis-ci.org/caarlos0/zsh-open-pr.svg?branch=master)](https://travis-ci.org/caarlos0/zsh-open-pr)
==================

ZSH plugin to open pull requests from command line.

![gif showing zsh-open-pr in action](https://dl.dropboxusercontent.com/u/247142/projects/git-open-pr.mov.gif)

## What it does

Basically, when you call `open-pr`, the function will verify if you are working
on a fork (by convention, you have an `upstream` remote), then, it will open
your browser in the correct URL so you can just hit the `Create Pull Request`
button.

The function also accepts one argument, in case you want to specify another
target branch (instead of master, which is the convention).

URL breakdown:

```
https://github.com/target-remote/repo/compare/master...origin:random-feature
          |           |            |    |        |   |    |     |
          |           |            |    |        |   |    |      -> the branch
          |           |            |    |        |   |    |         you want
          |           |            |    |        |   |    |         to submit
          |           |            |    |        |   |    |
          |           |            |    |        |   |     -> will appear only
          |           |            |    |        |   |        if you are
          |           |            |    |        |   |        working in a fork
          |           |            |    |        |   |
          |           |            |    |        |    -> default GitHub compare
          |           |            |    |        |       thing
          |           |            |    |        |
          |           |            |    |         -> target branch
          |           |            |    |
          |           |            |     -> default GitHub endpoint to open a PR
          |           |            |
          |           |             -> the target repository, also from origin
          |           |                or upstream remotes
          |           |
          |            -> can be both origin or upstream
          |
           -> default host
```

## Usage

For example, when you work on your own project:

```console
$ git remote -v
origin  git@github.com:caarlos0/zsh-open-pr.git (fetch)
origin  git@github.com:caarlos0/zsh-open-pr.git (push)

$ git branch
* master

$ git checkout -b random-feature
$ touch this-file-is-important
$ git add -A
$ git commit -m 'did some stuff'
$ git push
$ open-pr
# will browse https://github.com/caarlos0/zsh-open-pr/compare/master...random-feature
```

Working on a fork:

```console
$ git remote -v
origin  git@github.com:random-user/zsh-open-pr.git (fetch)
origin  git@github.com:random-user/zsh-open-pr.git (push)
upstream  git@github.com:caarlos0/zsh-open-pr.git (fetch)
upstream  git@github.com:caarlos0/zsh-open-pr.git (push)

$ git branch
* master

$ git checkout -b random-feature
$ touch this-file-is-important
$ git add -A
$ git commit -m 'did some stuff'
$ git push
$ open-pr
# will browse https://github.com/caarlos0/zsh-open-pr/compare/master...random-user:random-feature
```

Previous example, but to a `develop` branch, for instance:

```console
$ open-pr develop
# will browse https://github.com/caarlos0/zsh-open-pr/compare/develop...random-user:random-feature
```

## Install using [antibody](http://getantibody.github.io/)

```console
$ antibody bundle caarlos0/zsh-open-pr
```

## Install using antigen

```console
$ antigen bundle caarlos0/zsh-open-pr
```

## Installing using zgen

```console
$ zgen load caarlos0/zsh-open-pr
```

## Usage

Just hit `open_pr` on your repositories.

You can also alias it:

```console
$ git config --global alias.pr '!zsh -ic \"open_pr $*\"'
$ git pr
```

But I like the following approach more:

```console
gpr() {
  git push origin HEAD && open_pr "$*"
}
```

So I can `git push` and `open_pr` in a single, three letters command:

```console
$ gpr
```

### PATH

You can, instead of sourcing, add the plugin to your path, so git will
automatically detect it. In the latest versions of antibody you can do that:

```console
antibody bundle 'caarlos0/zsh-open-pr kind:path'
```

And then just call `git open-pr`.

## Contributing

The project is linted with Shellcheck and have unit tests. Please, take a look
at them and execute `./build.sh` to make sure it all works well. :beers:
