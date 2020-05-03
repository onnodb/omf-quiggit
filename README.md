<img src="https://cdn.rawgit.com/oh-my-fish/oh-my-fish/e4f1c2e0219a17e2c748b824004c8d0b38055c16/docs/logo.svg" align="left" width="144px" height="144px"/>

#### Quiggit
> A plugin for [Oh My Fish][omf-link].

[![MIT License](https://img.shields.io/badge/license-MIT-007EC7.svg?style=flat-square)](/LICENSE)
[![Fish Shell Version](https://img.shields.io/badge/fish-v3.0.0-007EC7.svg?style=flat-square)](https://fishshell.com)
[![Oh My Fish Framework](https://img.shields.io/badge/Oh%20My%20Fish-Framework-007EC7.svg?style=flat-square)](https://www.github.com/oh-my-fish/oh-my-fish)

<br/>


## Install

```fish
$ omf install https://github.com/onnodb/omf-quiggit.git
```


## Usage

Quiggit will automatically detect when you're cd'ing into a Git repository.
Inside a Git repository, you can then:

* Press Enter on an empty command prompt to run `git status`.

* Enter any Git command, which will then automatically have the word `git`
  prefixed. This is achieved using [fish abbreviations], which are generated
  temporarily while you're inside the Git repository. These abbreviations are
  created for all common Git commands, as well as for any aliases you may have
  defined using `git-config`.

[fish abbreviations]: https://fishshell.com/docs/current/cmds/abbr.html


## Configuration

Available settings:

- `__quiggit_verbose_status`: set to `no` to run `git status -sb` instead of the
  more verbose `git status` (when `yes`). (Default: `no`.)

Change settings by creating the above variables using `set -g` in the current
session, or `set -U`.


# License

[MIT][mit] © [Onno Broekmans][author] et [al][contributors]


[mit]:            https://opensource.org/licenses/MIT
[author]:         https://github.com/onnodb
[contributors]:   https://github.com/onnodb/omf-quiggit/graphs/contributors
[omf-link]:       https://www.github.com/oh-my-fish/oh-my-fish

[license-badge]:  https://img.shields.io/badge/license-MIT-007EC7.svg?style=flat-square
