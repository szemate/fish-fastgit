# fish-fastgit

Fish plugin to auto-generate short aliases for every available Git command.

## Installation

### Using [fundle](https://github.com/tuvistavie/fundle)

Add
```
fundle plugin 'szemate/fish-fastgit'
```
and either
```
fish_git_global_commands
```
or
```
fish_git_fugitive_commands
```
to your `config.fish`, and run `fundle install`.

### Manually

Copy all files from `functions` to `~/.config/fish/functions` directory and add
either of the above commands to your `config.fish`.

## Usage

### `fish_git_global_commands`

Create aliases for every Git command so that they are available without
typing `git` (with the exception of commands that clash with already existing
ones like `mv` or `diff`.)

```
> fish_git_global_commands
> checkout some-branch
> commit
```

### `fish_git_fugitive_commands`

Prefix every Git command with 'G' in the style of
[vim-fugitive](https://github.com/tpope/vim-fugitive).

```
> fish_git_fugitive_commands
> Gcheckout some-branch
> Gcommit
```

### `fish_update_git_aliases`

Regenerate commands, e.g. after creating new Git aliases with `git config`.

```
> git config alias.amend 'commit --amend'
> fish_update_git_aliases
> amend
```

With [hub](https://github.com/github/hub):

```
> alias git hub
> fish_update_git_aliases
> pull-request
```

### `fish_remove_git_aliases`

Erase all the Git aliases.
