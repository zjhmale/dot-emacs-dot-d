;; This is where your customizations should live

;; env PATH
(defun set-exec-path-from-shell-PATH ()
  (let ((path-from-shell (shell-command-to-string "$SHELL -i -c 'echo $PATH'")))
    (setenv "PATH" path-from-shell)
    (setq exec-path (split-string path-from-shell path-separator))))

;; Uncomment the lines below by removing semicolons and play with the
;; values in order to set the width (in characters wide) and height
;; (in lines high) Emacs will have whenever you start it

;; (setq initial-frame-alist '((top . 0) (left . 0) (width . 20) (height . 20)))


;; Place downloaded elisp files in this directory. You'll then be able
;; to load them.
;;
;; For example, if you download yaml-mode.el to ~/.emacs.d/vendor,
;; then you can add the following code to this file:
;;
;; (require 'yaml-mode)
;; (add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
;;

;;(byte-recompile-directory (expand-file-name "~/.emacs.d/elpa") 0 t)
;;(byte-recompile-directory (expand-file-name "~/.emacs.d/elpa/fiplr-0.1.3") 0 t)

;; Adding this code will make Emacs enter yaml mode whenever you open
;; a .yml file
(add-to-list 'load-path "~/.emacs.d/vendor")

;; shell scripts
(setq-default sh-basic-offset 2)
(setq-default sh-indentation 2)

;; Themes
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(add-to-list 'load-path "~/.emacs.d/themes")
;; Uncomment this to increase font size
;; (set-face-attribute 'default nil :height 140)
;; (load-theme 'tomorrow-night-bright t)
;;(load-theme 'wilson t)
;; (require 'zenburn-theme)
;;(add-to-list 'load-path "~/.emacs.d/themes/desert-theme/")
;;(require 'desert-theme)
(add-to-list 'load-path "~/.emacs.d/themes/zenburn-emacs/")
(require 'zenburn-theme)

;;for molokai color theme
;;(add-to-list 'load-path "~/.emacs.d/themes/molokai-theme/")
;;(require 'molokai-theme)

;;for zenburn-theme
;;(add-to-list 'load-path "~/.emacs.d/plugins/zenburn-emacs/")
;;(require 'zenburn-theme)
;;(load-theme 'monokai t)
;;(require 'emacs-color-themes)

;; Flyspell often slows down editing so it's turned off
(remove-hook 'text-mode-hook 'turn-on-flyspell)

(load "~/.emacs.d/vendor/clojure")

;; hippie expand - don't try to complete with file names
(setq hippie-expand-try-functions-list (delete 'try-complete-file-name hippie-expand-try-functions-list))
(setq hippie-expand-try-functions-list (delete 'try-complete-file-name-partially hippie-expand-try-functions-list))

(setq ido-use-filename-at-point nil)

;;window size
;;(setq initial-frame-alist '((top . 0) (left . 0) (width . 126) (height . 34)))
;;font
(set-default-font "Monaco 18")

;;for vim mode
(add-to-list 'load-path "~/.emacs.d/plugins/evil/")
(require 'evil)
(evil-mode 1)

;;for tabbar
(add-to-list 'load-path "~/.emacs.d/plugins/tabbar/")
(require 'tabbar)
(tabbar-mode 1)
(global-set-key [(meta j)] 'tabbar-backward)
(global-set-key [(meta k)] 'tabbar-forward)

;;set scheme env path
;;for now i installed the geiser to run racket so if want to use run-scheme should M-x geiser-mode to disable the geiser-mode first
;;M-x run-scheme
;;C-c C-k to reload and compile the scheme and racket code
(setq scheme-program-name "/usr/local/bin/mit-scheme")

;;show line number
(global-linum-mode t)

;;for highlight current line number
(require 'hlinum)
;;(hlinum-activate)

;;transparent
(set-frame-parameter (selected-frame) 'alpha '(90 90))
(add-to-list 'default-frame-alist '(alpha 90 90))

;;to avoid the blink
(setq visible-bell nil)

;;(show-paren-mode 1) ;; 匹配括号高亮
;;(set-face-bold-p 'show-paren-match t) ;;加粗显示匹配括号
;;括号匹配颜色
(set-face-foreground 'show-paren-match "#004242")
(set-face-background 'show-paren-match "#B0B7B0")

;;for rainbow-delimiters
(require 'rainbow-delimiters)
(add-hook 'clojure-mode-hook 'rainbow-delimiters-mode)
(global-rainbow-delimiters-mode)

;;autopair in common files
(add-to-list 'load-path "~/.emacs.d/plugins/autopair/")
(require 'autopair)
(autopair-global-mode) ;; enable autopair in all buffers
(add-hook 'c++-mode-hook
          #'(lambda ()
              (push '(?< . ?>)
                    (getf autopair-extra-pairs :code))))

(global-set-key (kbd "RET") 'newline-and-indent);;换行自动缩进

;;paredit
(add-to-list 'load-path "~/.emacs.d/plugins/paredit/")
(require 'paredit)
(paredit-mode 1)
;;(define-key paredit-mode-map (kbd "C-S-<left>") 'paredit-backward-slurp-sexp)

;;for ido
;;(require 'ido)
;;(ido-mode t)

;;for ctrl-p function
(require 'fiplr)
(setq fiplr-root-markers '(".git" ".svn"))
(setq fiplr-ignored-globs 
    '((directories (".git" ".svn"))
      (files ("*.jpg" "*.png" "*.zip" "*~" "*.swp" ".*.swp" ".DS_Store"))))

(global-set-key (kbd "C-x f") 'fiplr-find-file)

;;projectile config
(projectile-global-mode)
(setq projectile-completion-system 'grizzl)
(setq projectile-enable-caching t)

;;disable autosave to avoid temp file
(setq auto-save-default nil)

;;for markdown-mode
(autoload 'markdown-mode "markdown-mode"
  "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.markdown\\'". markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'". markdown-mode))

;;for yasnippets
(add-to-list 'load-path
              "~/.emacs.d/plugins/yasnippet")
(require 'yasnippet)
(yas-global-mode 1)
(defun markdown-unset-tab ()
   (define-key markdown-mode-map (kbd "<tab>") nil))
 (add-hook 'markdown-mode-hook 'markdown-unset-tab)
(global-set-key (kbd "C-;") 'yas/expand)

;;for helm
;;(add-to-list 'load-path "~/.emacs.d/plugins/helm")
(require 'helm-config)
(helm-mode t)
;;this is good file navigation for large project it's awesome
(global-set-key (kbd "C-c ,,") 'helm-projectile)

;;for neotree
(add-to-list 'load-path "~/.emacs.d/plugins/neotree")
(require 'neotree)
(global-set-key [f8] 'neotree-toggle)
(define-key neotree-mode-map (kbd "\C-g") 'neotree-refresh)

;;for auto complete
(require 'auto-complete)
(require 'auto-complete-config)
(global-auto-complete-mode t)
(ac-config-default)
(ac-set-trigger-key "TAB")
(ac-set-trigger-key "<tab>")
(setq ac-auto-start 1)
(setq ac-quick-help-delay 0.05)
(setq ac-auto-show-menu 0)
(setq ac-auto-start 1)

;;ruby-electric
(ruby-electric-mode 1)

;;for tab you should type C-q <tab> to trigger tab function
(setq tab-width 4)
(setq default-tab-width 4)
(setq indent-tabs-mode t)

;;for ruby-mode
(require 'ruby-mode)
(setq ruby-deep-indent-paren nil)
;;(setq ruby-indent-level 4)

;;fix can not tab complete in ansi-term mode
(add-hook 'term-mode-hook (lambda()
        (setq yas-dont-activate t)))

;;highlight the numbers which not part of a word
(eval-after-load "ruby-mode"
    '(font-lock-add-keywords 'ruby-mode
      '("\\(loop\\)")))

(eval-after-load "ruby-mode"
     '(font-lock-add-keywords 'ruby-mode
       '(("\\(self\\)"
          . font-lock-constant-face))))

(eval-after-load "ruby-mode"
    '(font-lock-add-keywords 'ruby-mode
      '("\\(new\\)")))

(eval-after-load "ruby-mode"
    '(font-lock-add-keywords 'ruby-mode
      '("\\(=[>]?\\)")))

;;(eval-after-load "ruby-mode"
;;    '(font-lock-add-keywords 'ruby-mode
;;      '("[^a-zA-Z]\\([0-9]+\\)[^a-zA-Z]")))

;;(eval-after-load "ruby-mode"
;;     '(font-lock-add-keywords 'ruby-mode
;;       '(("\\([0-9]+\\)"
;;          . font-lock-constant-face))))

;;(eval-after-load "ruby-mode"
;;     '(font-lock-add-keywords 'ruby-mode
;;       '(("[^a-zA-Z]\\([0-9]+\\)[^a-zA-Z]"
;;          . font-lock-constant-face))))

;;(eval-after-load "ruby-mode"
;;     '(font-lock-add-keywords 'ruby-mode
;;       '(("[^a-zA-Z]\\([0-9]+\\)[^a-zA-Z]\\|[^a-zA-Z]\\([0-9]+\\)\\|\\([0-9]+\\)[^a-zA-Z]"
;;          . font-lock-constant-face))))

(eval-after-load "ruby-mode"
     '(font-lock-add-keywords 'ruby-mode
       '(("\\_<[0-9\\.]+\\_>"
          . font-lock-constant-face))))

(eval-after-load "clojure-mode"
     '(font-lock-add-keywords 'clojure-mode
       '(("\\_<[0-9\\.]+\\_>"
          . font-lock-string-face))))

;;(eval-after-load "clojure-mode"
;;     '(font-lock-add-keywords 'clojure-mode
;;       '(("\\(println\\|update-in\\|stc\\|apply\\|send\\|atom\\)"
;;          . font-lock-function-name-face))))

;;for fenghighlight plugin
;;can check the source code to use M-r M-p M-n
(add-to-list 'load-path "~/.emacs.d/plugins/shenfeng")
(require 'feng-highlight)
(global-set-key (kbd "M-i") 'feng-highlight-at-point)

;;for clojure snippets
(when (require 'yasnippet nil 'noerror)
  (progn
    (yas/load-directory "~/.emacs.d/plugins/yasnippet/snippets")))

;;for maxframe this el will maxsize the emacs window but not
;;fullscreen it 
(add-to-list 'load-path "~/.emacs.d/plugins/maxframe.el")
(require 'maxframe)
(add-hook 'window-setup-hook 'maximize-frame t)

;;to refresh the namespace when start cider-nrepl
;;type M-x cider-namespace-refresh to refresh current namespace when you use require use or refer other namespace
(defun cider-namespace-refresh ()
  (interactive)
  (cider-interactive-eval
   "(require 'clojure.tools.namespace.repl)
    (clojure.tools.namespace.repl/refresh)"))


;;for poweline it's awesome and inspired by vim
(add-to-list 'load-path "~/.emacs.d/plugins/emacs-powerline")
(require 'powerline)
(require 'cl)
(custom-set-faces
 '(mode-line ((t (:foreground "#030303" :background "#bdbdbd" :box nil))))
 '(mode-line-inactive ((t (:foreground "#f9f9f9" :background "#666666" :box nil)))))
;;(setq powerline-color1 "grey22")
;;(setq powerline-color2 "grey40")
(setq powerline-color1 "#3ded1a")
(setq powerline-color2 "#0ad3f2")

;;for haskell development just write a tiny scheme called cleantha
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
;; hslint on the command line only likes this indentation mode;
;; alternatives commented out below.
;;(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
;;(add-hook 'haskell-mode-hook 'turn-on-haskell-simple-indent)
;; Ignore compiled Haskell files in filename completions
(add-to-list 'completion-ignored-extensions ".hi")
(add-hook 'haskell-mode-hook 'interactive-haskell-mode)
;;to run haskell in emacs just use M-x haskell-interactive-mode or just use the combination C-c C-l

;;for scala-mode
(require 'scala-mode2)

;;for ensime
(require 'ensime)
(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)

;;for sbt mode
(require 'sbt-mode)

;;for highlight the match parentheses
;;(require 'highlight-parentheses)

;;(set-default 'truncate-lines t)
;;(global-visual-line-mode 1)
;;(auto-fill-mode 0)
;;为了避免很长的代码在敲了回车之后变成两行，所以加上最大下面这句一句代码超过300列的长度再自动换行
(setq default-fill-column 300)

;;for emmet
(require 'emmet-mode)
;;(emmet-mode t)
;;enable emmet-mode just M-x emmet-mode
;;C-j emmet-preview
(global-set-key (kbd "C-c j") 'emmet-expand-yas)

;;M-x blank-mode to toggle to show white space in source files

;;common clojure usage
;;M-e eval the clojure code
;;M-x clojure-namespace-refresh
;;C-c C-k reload and compile the clojure code a cider powered function
;;M-x cider-jack-in

;;for ocp-indent for ocaml
(add-to-list 'load-path "/Users/zjh/.opam/system/share/emacs/site-lisp")
(require 'ocp-indent)

;;for comment ocaml code or other language
;;M-x comment-region
;;or just use M-; referenced by this link https://www.gnu.org/software/emacs/manual/html_node/emacs/Comment-Commands.html
(global-set-key (kbd "C-x C-;") 'comment-region)

;;for uncomment ocaml code or other language
;;C-u M-x comment-region

;;to indent the ocaml code
(global-set-key (kbd "C-x C-i") 'ocp-indent-line)

;; Indent `=' like a standard keyword.
(setq tuareg-lazy-= t)
;; Indent [({ like standard keywords.
(setq tuareg-lazy-paren t)
;; No indentation after `in' keywords.
(setq tuareg-in-indent 4)

(add-hook 'tuareg-mode-hook
          ;; Turn on auto-fill minor mode.
          (lambda () (auto-fill-mode 1)))

(add-hook 'tuareg-mode-hook
          (function (lambda ()
                      ;;(setq tuareg-in-indent 0)
                      ;;(setq tuareg-let-always-indent t)
                      ;;(setq tuareg-let-indent tuareg-default-indent)
                      ;;(setq tuareg-with-indent 0)
                      ;;(setq tuareg-function-indent 0)
                      ;;(setq tuareg-fun-indent 0)
                      ;;(setq tuareg-parser-indent 0)
                      ;;(setq tuareg-match-indent 0)
                      ;;(setq tuareg-begin-indent tuareg-default-indent)
                      ;;(setq tuareg-parse-indent tuareg-default-indent); .mll
                      ;;(setq tuareg-rule-indent  tuareg-default-indent)
                      ;;(setq tuareg-font-lock-symbols nil)
                      (setq tuareg-begin-indent 4)
                      (setq tuareg-class-indent 4)
                      (setq tuareg-default-indent 4)
                      (setq tuareg-do-indent 4)
                      (setq tuareg-for-while-indent 4)
                      (setq tuareg-fun-indent 4)
                      (setq tuareg-if-then-else-indent 4)
                      (setq tuareg-let-indent 4)
                      (setq tuareg-match-indent 4)
                      (setq tuareg-method-indent 4)
                      (setq tuareg-pipe-extra-unindent 4)
                      (setq tuareg-sig-struct-indent 4)
                      (setq tuareg-try-indent 4)
                      (setq tuareg-val-indent 4))))

;;when to create a ocaml list like [1;2;3] should turn off the paredit-mode cause ; will trigger a new line in paredit-mode

;;for format the ocaml code
;;reference the tuareg cheat sheet http://www.typerex.org/files/cheatsheets/tuareg-mode.pdf
;;C-c C-q or M-x tuareg-indent-phrase
;;C-M-\ or M-x indent-region

;; Indenting module body code at column 0
(defun scheme-module-indent (state indent-point normal-indent) 0)
(put 'module 'scheme-indent-function 'scheme-module-indent)

(put 'and-let* 'scheme-indent-function 1)
(put 'parameterize 'scheme-indent-function 1)
(put 'handle-exceptions 'scheme-indent-function 1)
(put 'when 'scheme-indent-function 1)
(put 'unless 'scheme-indent-function 1)
(put 'match 'scheme-indent-function 1)

(add-to-list 'load-path "~/.emacs.d/plugins/simple-sexp")
(require 'simple-sexp)

(put 'myfunc 'lisp-indent-function 0)

;; Save here instead of littering current directory with emacs backup files
(setq backup-directory-alist `(("." . "~/.saves")))
;;(load-file "/Users/zjh/.opam/system/share/typerex/ocp-indent/ocp-indent.el")

;;for chinese comment reference this configuration http://stackoverflow.com/questions/16162583/tomorrow-theme-for-emacs-shows-chinese-charaters-as-blocks

;;for coq
(add-to-list 'load-path "/usr/local/Cellar/coq/8.4pl6_1/lib/emacs/site-lisp")
(setq coq-prog-name "/usr/local/bin/coqtop")
(setq auto-mode-alist (cons '("\\.v$" . coq-mode) auto-mode-alist))
(autoload 'coq-mode "coq" "Major mode for editing Coq vernacular." t)
(load-file "/usr/local/share/emacs/site-lisp/proof-general/generic/proof-site.el")
(load-file "/usr/local/Cellar/ssreflect/1.5/share/ssreflect/pg-ssr.el")
;;(load-file "/usr/local/Cellar/proof-general/4.2/share/emacs/site-lisp/proof-general/generic/proof-site.el")
