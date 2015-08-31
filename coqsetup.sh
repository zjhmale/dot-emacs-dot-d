brew install coq ssreflect emacs
brew install proof-general —with-emacs=`which emacs`

## add following elisp script into user.el or init.el

#(add-to-list 'load-path "/usr/local/Cellar/coq/8.4pl6_1/lib/emacs/site-lisp")
#(setq coq-prog-name "/usr/local/bin/coqtop")
#(setq auto-mode-alist (cons '("\\.v$" . coq-mode) auto-mode-alist))
#(autoload 'coq-mode "coq" "Major mode for editing Coq vernacular." t)
#(load-file "/usr/local/share/emacs/site-lisp/proof-general/generic/proof-site.el")
#(load-file "/usr/local/Cellar/ssreflect/1.5/share/ssreflect/pg-ssr.el")
