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
;;(load-theme 'tomorrow-night-bright t)
(require 'zenburn-theme)
;;(add-to-list 'load-path "~/.emacs.d/themes/desert-theme/")
;;(require 'desert-theme)

;;for molokai color theme
;;(add-to-list 'load-path "~/.emacs.d/themes/molokai-theme/")
;;(require 'molokai-theme)

;;for zenburn-theme
;;(add-to-list 'load-path "~/.emacs.d/plugins/zenburn-emacs/")
;;(require 'zenburn-theme)

;; Flyspell often slows down editing so it's turned off
(remove-hook 'text-mode-hook 'turn-on-flyspell)

(load "~/.emacs.d/vendor/clojure")

;; hippie expand - don't try to complete with file names
(setq hippie-expand-try-functions-list (delete 'try-complete-file-name hippie-expand-try-functions-list))
(setq hippie-expand-try-functions-list (delete 'try-complete-file-name-partially hippie-expand-try-functions-list))

(setq ido-use-filename-at-point nil)

;;window size
(setq initial-frame-alist '((top . 0) (left . 0) (width . 126) (height . 34)))
;;font
(set-default-font "Monaco 17")

;;for vim mode
(add-to-list 'load-path "~/.emacs.d/plugins/evil/")
(require 'evil)
(evil-mode 1)

;;set scheme env path
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

;;for rainbow-delimiters
(require 'rainbow-delimiters)
(add-hook 'clojure-mode-hook 'rainbow-delimiters-mode)
(global-rainbow-delimiters-mode)

;;autopair in common files
;;(show-paren-mode 1) ;; 匹配括号高亮
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
       '(("\\_<[0-9]+\\_>"
          . font-lock-constant-face))))

(eval-after-load "clojure-mode"
     '(font-lock-add-keywords 'clojure-mode
       '(("\\_<[0-9]+\\_>"
          . font-lock-string-face))))

;;for fenghighlight plugin
;;can check the source code to use M-r M-p M-n
(add-to-list 'load-path "~/.emacs.d/plugins/shenfeng")
(require 'feng-highlight)
(global-set-key (kbd "M-i") 'feng-highlight-at-point)

;;for clojure snippets
(when (require 'yasnippet nil 'noerror)
  (progn
    (yas/load-directory "~/.emacs.d/plugins/yasnippet/snippets")))

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
(setq powerline-color1 "grey22")
(setq powerline-color2 "grey40")

;; Save here instead of littering current directory with emacs backup files
(setq backup-directory-alist `(("." . "~/.saves")))
