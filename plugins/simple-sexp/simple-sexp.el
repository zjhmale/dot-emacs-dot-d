
(provide 'simple-sexp)

(add-hook 'emacs-lisp-mode-hook 'simple-sexp-setup)
(add-hook 'lisp-mode-hook 'simple-sexp-setup)
(add-hook 'scheme-mode-hook 'simple-sexp-setup)

(defun put-indent (f names)
  (cond
    ((null names) f)
    (t (progn (put (car names) 'simple-sexp-indent-function f)
	      (put-indent f (cdr names))))))

(defvar simple-sexp-hook)

(defun simple-sexp-setup ()
  (dotimes (ch 256)
    (let* ((pair (assq (char-syntax ch) simple-sexp-syntax-class-commands)))
      (when pair
        (local-set-key (vector ch) (cdr pair)))))
  (add-hook 'post-command-hook 'simple-sexp-complete-escape nil t)
  (local-set-key "\"" 'simple-sexp-balanced-string)
  (local-set-key "\d" 'simple-sexp-balanced-backspace)
  (local-set-key "\b" 'simple-sexp-balanced-backspace)
  (local-set-key "\n" 'newline)
  (local-set-key "\r" 'newline-and-indent)
  (local-set-key "\M-(" 'simple-sexp-delimit-with-parens)
  (local-set-key "\M-[" 'simple-sexp-delimit-with-brackets)
  (local-set-key "\M-{" 'simple-sexp-delimit-with-braces)
  (setq lisp-indent-function 'sexp-indent-function)
  (put 'simple-sexp-balanced-backspace 'delete-selection 'supersede)
  (put 'simple-sexp-balanced-string 'delete-selection t)
  (put 'simple-sexp-balanced-open 'delete-selection t)
  (put 'simple-sexp-balanced-close 'delete-selection t)
  (put 'simple-sexp-balanced-escape 'delete-selection t)
  (run-hooks 'simple-sexp-hook))

(defvar simple-sexp-syntax-class-commands
  '((?\( . simple-sexp-balanced-open)
    (?\) . simple-sexp-balanced-close)
    (?\\ . simple-sexp-balanced-escape)))

(defun simple-sexp-delimit-with-parens ()
  (interactive)
  (simple-sexp-delimit "(" ")"))

(defun simple-sexp-delimit-with-brackets ()
  (interactive)
  (simple-sexp-delimit "[" "]"))

(defun simple-sexp-delimit-with-braces ()
  (interactive)
  (simple-sexp-delimit "{" "}"))

(defun simple-sexp-delimit (l r)
  (let* ((last (progn (forward-sexp)
                 (char-syntax (preceding-char))))
         (first (progn (backward-sexp)
                  (char-syntax (following-char)))))
    (if (and (= first ?\( ) (= last ?\) ))
      (progn
        (delete-char 1) (insert l) (backward-char)
        (forward-sexp)
        (backward-char) (delete-char 1) (insert r))
      (forward-sexp))))

(defun simple-sexp-complete-escape ()
  (when (and (memq this-command
               (list 'self-insert-command 'quoted-insert))
          (my-mid-escape-p (1- (point))))
    (delete-char 1)))

(defun simple-sexp-balanced-open (arg)
  (interactive "P")
  (let* ((arg (if arg (prefix-numeric-value arg) 0))
         (ch last-input-event)
         (endch (cdr (aref (syntax-table) ch))))
    (cond
      ((my-mid-escape-p (point)) (insert ch) (delete-char 1))
      ((zerop arg) (insert ch) (insert endch) (backward-char))
      (t (skip-chars-forward " \t")
         (insert ch)
         (save-excursion
           (forward-sexp arg)
           (insert endch))))))

(defun simple-sexp-balanced-close ()
  (interactive)
  (cond
    ((my-mid-escape-p (point)) (insert last-input-event) (delete-char 1))
    (t (up-list 1) (blink-matching-open))))

(defun simple-sexp-balanced-string ()
  (interactive)
  (let* ((ch last-input-event))
    (cond
      ((my-mid-escape-p (point)) (insert ch) (delete-char 1))
      ((= (following-char) ch) (forward-char))
      (t (insert ch ch) (backward-char)))))

(defun simple-sexp-balanced-escape ()
  (interactive)
  (cond
    ((my-mid-escape-p (point)) (insert "\\") (delete-char 1))
    (t (insert "\\ ") (backward-char 1))))

(defun simple-sexp-balanced-backspace (arg)
  (interactive "P")
  (cond
    (arg (backward-delete-char-untabify 1))
    ((my-mid-escape-p (point)) (backward-char 1) (delete-char 2))
    ((my-mid-escape-p (1- (point))) (backward-char 1))
    (t (let* ((prev (char-syntax (preceding-char)))
              (next (char-syntax (following-char))))
         (cond
           ((not prev) (backward-delete-char-untabify 1))
           ((= prev ?\)) (backward-char 1))
           ((not next) (backward-delete-char-untabify 1))
           ((= prev ?\()
            (cond
              ((= next ?\)) (backward-char 1) (delete-char 2))
              (t (error "Can't delete a non-empty or unclosed list!"))))
           ((= (preceding-char) ?\")
            (cond
              ((= (preceding-char) (following-char))
               (backward-char 1) (delete-char 2))
              (t (backward-char 1))))
           (t (backward-delete-char-untabify 1)))))))

(defun my-mid-escape-p (pos)
  (let* ((mid? nil))
    (while (and (> pos 1)
             (= (char-syntax (char-before pos)) ?\\))
      (setq mid? (not mid?))
      (setq pos (1- pos)))
    mid?))

(defun sexp-indent-function (indent-point state)
  (simple-sexp-indent-function 'sexp-indent-function indent-point state))

(defun simple-sexp-indent-function (name indent-point state)
  (let* ((start (elt state 1))
	 (stop indent-point)
	 (prev (sexp-positions (1+ start) stop))
	 (str (and prev (buffer-substring (caar prev) (cdar prev))))
	 (sym (and str (intern-soft str)))
	 (f (cond
	      ((and str (or sym (string= (downcase str) "nil")))
	       (or (get sym name) 'default-sexp-indent))
	      (t 'default-sexp-indent))))
    (list
      (if (numberp f)
        (progn (goto-char start) (+ (current-column) f))
        (funcall f sym start prev stop))
      start)))

(defun default-sexp-indent (name start prev stop)
  (goto-char start)
  (+ (current-column)
     (cond
       ((looking-at "\\[\\|{") 1)
       ((progn (goto-char stop) (skip-chars-forward "[:blank:]")
          (looking-at "{"))
        4)
       ((and prev
          (progn (goto-char (caar prev))
            (looking-at "\\sw\\|\\s_")))
        (if (= (cdar prev) (1+ (caar prev))) 3 2))
       (t 1))))

(defun sexp-positions (start stop)
  (let* ((results nil))
    (while (and (< start stop)
                (condition-case ()
		  (let* (left right)
                    (parse-partial-sexp start stop 1 t)
		    (setq left (point))
		    (forward-sexp 1)
		    (setq right (point))
		    (setq start (point))
		    (if (<= start stop)
		      (setq results (list* (cons left right) results)))
		    t)
                  (error nil))))
    (reverse results)))

(defun varargs-indent (name start prev stop)
  (if (> (length prev) 1)
    (let* ((loc (find-indentation-precedent (cadr prev) (cddr prev))))
      (goto-char (car loc))
      (current-column))
    (progn (goto-char start)
           (+ (current-column) 2))))

(defun find-indentation-precedent (loc locs)
  (if (null locs)
    loc
    (progn (goto-char (caar locs))
           (skip-chars-backward " \t")
           (find-indentation-precedent
	     (if (bolp) (car locs) loc)
	     (cdr locs)))))
