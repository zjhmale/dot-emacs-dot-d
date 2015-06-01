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

## 关于git嵌套的问题

如果clone下来的emacs插件内也有.git会造成一个蛋疼的问题，所以写了一个py
script递归的删除plugins路径下的.git 已加入到deploy.sh，push的时候还是
一样push么么哒

## usage

* C-x C-f find file
* C-c ,, navigate file in a project (_use helm-projectile for large scale project_)
* C-x C-c quit
* M-x cider-namespace-refresh refresh a clojure namespace
* M-x cider-jack-in start a clojure repl
* C-x 2 open a horizen tab window
* C-x 3 open a verical tab window
* C-s find string use regex
* M-x cider-restart to restart refresh a clojure project
* C-c C-k compile and reload a clojure file after cider-jack-in
* fn-F8 open the neotree
* C-c C-c create new file in neotree tab
* C-c p f navigate file in a project (_use projectile and slow in large scale project_)
* C-x f navigate file in a project slow and ugly
* evil-mode help me a lot to handle the edit stuff that a used to vim operations
* C-M f 从括号头跳转到对应的括号尾
* C-M b 从括号尾跳转到对应的括号头
* 沈峰写的那个高亮相同东西的插件可以看user.el中的注释
* C-l 将当前光标所在的行置为正中央
* M-. 跳转到定义处
* M-, 跳转到实现处
* C-shift-s+左右方向键 利用paredit来对括号进行移动
* C-shift+左右方向键 the same as above
* C-@ 选中要加上列的范围 C-x r t输入要加入列的内容(_insert column_)
* shift+上下左右可以切换分割的屏幕
* shift+括号可以跳转到当前最外层的括号位置
* M-j M-k用来切换tabbar上的tab
* C-x C-- / C-x C-+ 缩小 / 放大
* C-g C-_ redo
* C-c M-j / M-x cider-jack-in -> start `cider-jack-in`
