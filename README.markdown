# Emacs for Clojure Starter Kit

This repo is a minor extension of [The Emacs Starter Kit, v2](https://github.com/technomancy/emacs-starter-kit/tree/v2). Added functionality:

* Sets $PATH so that it's the same as your shell $PATH
* Includes the tomorrow-night and zenburn themes
* Turns off flyspell
* Adds some nrepl hooks, including auto-complete
* Prevents hippie-expand from expanding to file names
* Turns off ido-mode's use-file-name-at-point
* Stores backup files in `~/.saves`
* Installs the following packages by default:
    * starter-kit-lisp
    * starter-kit-bindings
    * starter-kit-ruby
    * clojure-mode
    * clojure-test-mode
    * nrepl
    * auto-complete
    * ac-nrepl

You can see all these tweaks in init.el and user.el

## some note

clone this repo as ~/.emacs.d path

* in command line

```
find ~/.emacs.d/elpa -name \*.elc -exec rm -rf {} \;
```

* in ~/.emacs file or ~/.emacs.d/user.el

```
(byte-recompile-directory (expand-file-name "~/.emacs.d/elpa") 0 t)
```

after recompiled should comment the byte-recompile-directory in the config file

* [bugfix1](https://github.com/auto-complete/auto-complete/issues/118)
* [bugfix2](https://github.com/auto-complete/auto-complete/issues/222)
