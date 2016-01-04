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
* shenfeng写的那个高亮相同东西的插件可以看user.el中的注释
* C-l 将当前光标所在的行置为正中央
* M-. 跳转到定义处
* M-, 跳转到实现处
* C-shift-s+左右方向键 利用paredit来对括号进行移动
* C-shift+左右方向键 the same as above
* C-@ 选中要加上列的范围 C-x r t输入要加入列的内容(_insert mode in evil_)
* shift+上下左右可以切换分割的屏幕
* shift+括号可以跳转到当前最外层的括号位置
* M-j M-k用来切换tabbar上的tab
* C-x C-- / C-x C-+ 缩小 / 放大
* C-g C-_ redo
* C-c M-j / M-x cider-jack-in -> start `cider-jack-in`
* C-c C-l / C-c C-k sync file in namespace in clojure project (for more detail just check cider readme out)
* C-c C-l start interactive ghc in haskell project
* M-x run-ocaml just start the ocaml env (_can choose ocaml or utop usually utop is better_) and C-x C-e to evaluate ocaml code
* C-x C-; to comment ocaml code
* C-x C-i to indent ocaml code
* C-x k kill buffer
* C-x b change buffer
* M-p M-P 用来翻阅各种语言repl或者console(比如utop,interactive-haskell,cider-jack-in等等)中的上一条和下一条代码
* C-c C-n 用来执行coq中的定义之类的
* C-c C-= inserts an = sign and lines up type signatures and other pattern matches nicely.
* C-c C-| inserts a guard
* C-c C-o inserts a guard | otherwise = and lines up existing guards
* C-c C-w inserts a where keyword
* C-c C-. aligns code over a region in a "sensible" fashion.
* M-x -> paredit-splice-sexp (like M-s in Cursive)