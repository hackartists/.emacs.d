;; GROUP: Editing -> Editing Basics
(use-package 
  treemacs 
  :ensure t 
  :bind (:map treemacs-mode-map
              ("RET" . treemacs-visit-node-in-most-recently-used-windows)))

(set-face-attribute 'hl-line nil ;; :height (+ (face-attribute 'default :height) 30)
                    :bold t 
                    :underline t 
                    :inherit nil 
                    :background nil)

(defun toggle-input-method-custom ()
  (interactive)
  (if (string= default-input-method "korean-hangul")
      (toggle-input-method)
    (set-input-method 'korean-hangul)))  

;; (global-centered-cursor-mode 1)
;; (add-hook 'emacs-lisp-mode-hookgs (lambda ()
;;                                  (add-hook 'before-save-hook 'elisp-format-buffer)))

(setq global-mark-ring-max 50000   ; increase mark ring to contains 5000 entries
      mark-ring-max 50000          ; increase kill ring to contains 5000 entries
      mode-require-final-newline t ; add a newline to end of file
      tab-width 4                 ; default to 4 visible spaces to display a tab
      )

(with-eval-after-load 'git-gutter+ 
  (defun git-gutter+-remote-default-directory (dir file) 
    (let* ((vec (tramp-dissect-file-name file)) 
           (method (tramp-file-name-method vec)) 
           (user (tramp-file-name-user vec)) 
           (domain (tramp-file-name-domain vec)) 
           (host (tramp-file-name-host vec)) 
           (port (tramp-file-name-port vec))) 
      (tramp-make-tramp-file-name method user domain host port dir))) 
  (defun git-gutter+-remote-file-path (dir file) 
    (let ((file (tramp-file-name-localname (tramp-dissect-file-name file)))) 
      (replace-regexp-in-string (concat "\\`" dir) "" file))))

(global-linum-mode)
;; (global-diff-hl-mode)
(yas-minor-mode)
;;(highlight-blocks-mode)

(recentf-mode 1)
(setq recentf-max-menu-items 100)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)

(global-set-key (kbd "M-RET") 'yas-insert-snippet)
(setq make-backup-files nil)
(add-hook 'sh-mode-hook (lambda () 
                          (setq tab-width 4)))

(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-language-environment "UTF-8")
(prefer-coding-system 'utf-8)

(setq-default indent-tabs-mode nil)
(delete-selection-mode)
(global-set-key (kbd "RET") 'newline-and-indent)

;; GROUP: Editing -> Killing
(setq kill-ring-max 50000    ; increase kill-ring capacity
      kill-whole-line t      ; if NIL, kill whole line and move the next line up
      )

;; show whitespace in diff-mode
(add-hook 'diff-mode-hook (lambda () 
                            (setq-local whitespace-style '(face tabs tab-mark spaces space-mark
                                                                trailing indentation: 
                                                                :space indentation: 
                                                                :tab newline newline-mark)) 
                            (whitespace-mode 1)))

;; Jump to end of snippet definition
(define-key yas-keymap (kbd "<return>") 'yas/exit-all-snippets)

;; Inter-field navigation
(defun yas/goto-end-of-active-field () 
  (interactive) 
  (let* ((snippet (car (yas--snippets-at-point))) 
         (position (yas--field-end (yas--snippet-active-field snippet)))) 
    (if (= (point) position) 
        (move-end-of-line 1) 
      (goto-char position))))

(defun yas/goto-start-of-active-field () 
  (interactive) 
  (let* ((snippet (car (yas--snippets-at-point))) 
         (position (yas--field-start (yas--snippet-active-field snippet)))) 
    (if (= (point) position) 
        (move-beginning-of-line 1) 
      (goto-char position))))

(define-key yas-keymap (kbd "C-e") 'yas/goto-end-of-active-field)
(define-key yas-keymap (kbd "C-a") 'yas/goto-start-of-active-field)
;; (define-key yas-minor-mode-map [(tab)] nil)
;; (define-key yas-minor-mode-map (kbd "TAB") nil)
;; (define-key yas-minor-mode-map (kbd "C-<tab>") 'yas-expand)
;; No dropdowns please, yas
(setq yas-prompt-functions '(yas/ido-prompt yas/completing-prompt))

;; No need to be so verbose
(setq yas-verbosity 1)

;; Wrap around region
(setq yas-wrap-around-region t)

(add-hook 'term-mode-hook (lambda() 
                            (setq yas-dont-activate t)))

;; PACKAGE: anzu
;; GROUP: Editing -> Matching -> Isearch -> Anzu
;; (require 'anzu)
;; (global-anzu-mode)
;; (global-set-key (kbd "M-%") 'anzu-query-replace)
;; (global-set-key (kbd "C-M-%") 'anzu-query-replace-regexp)

;; ;; PACKAGE: iedit
;; (setq iedit-toggle-key-default nil)
;; (require 'iedit)
;; (global-set-key (kbd "C-;") 'iedit-mode)

;; ;; PACKAGE: duplicate-thing
;; (require 'duplicate-thing)
;; (global-set-key (kbd "M-c") 'duplicate-thing)

;; (defadvice kill-ring-save (before slick-copy activate compile)
;;   "When called interactively with no active region, copy a single
;; line instead."
;;   (interactive
;;    (if mark-active (list (region-beginning) (region-end))
;;      (message "Copied line")
;;      (list (line-beginning-position)
;;            (line-beginning-position 2)))))

;; (defadvice kill-region (before slick-cut activate compile)
;;   "When called interactively with no active region, kill a single
;;   line instead."
;;   (interactive
;;    (if mark-active (list (region-beginning) (region-end))
;;      (list (line-beginning-position)
;;            (line-beginning-position 2)))))

;; ;; kill a line, including whitespace characters until next non-whiepsace character
;; ;; of next line
;; (defadvice kill-line (before check-position activate)
;;   (if (member major-mode
;;               '(emacs-lisp-mode scheme-mode lisp-mode
;;                                 c-mode c++-mode objc-mode
;;                                 latex-mode plain-tex-mode))
;;       (if (and (eolp) (not (bolp)))
;;           (progn (forward-char 1)
;;                  (just-one-space 0)
;;                  (backward-char 1)))))

;; ;; taken from prelude-editor.el
;; ;; automatically indenting yanked text if in programming-modes
;; (defvar yank-indent-modes
;;   '(LaTeX-mode TeX-mode)
;;   "Modes in which to indent regions that are yanked (or yank-popped).
;; Only modes that don't derive from `prog-mode' should be listed here.")

;; (defvar yank-indent-blacklisted-modes
;;   '(python-mode slim-mode haml-mode)
;;   "Modes for which auto-indenting is suppressed.")

;; (defvar yank-advised-indent-threshold 1000
;;   "Threshold (# chars) over which indentation does not automatically occur.")

;; (defun yank-advised-indent-function (beg end)
;;   "Do indentation, as long as the region isn't too large."
;;   (if (<= (- end beg) yank-advised-indent-threshold)
;;       (indent-region beg end nil)))

;; (defadvice yank (after yank-indent activate)
;;   "If current mode is one of 'yank-indent-modes,
;; indent yanked text (with prefix arg don't indent)."
;;   (if (and (not (ad-get-arg 0))
;;            (not (member major-mode yank-indent-blacklisted-modes))
;;            (or (derived-mode-p 'prog-mode)
;;                (member major-mode yank-indent-modes)))
;;       (let ((transient-mark-mode nil))
;;         (yank-advised-indent-function (region-beginning) (region-end)))))

;; (defadvice yank-pop (after yank-pop-indent activate)
;;   "If current mode is one of `yank-indent-modes',
;; indent yanked text (with prefix arg don't indent)."
;;   (when (and (not (ad-get-arg 0))
;;              (not (member major-mode yank-indent-blacklisted-modes))
;;              (or (derived-mode-p 'prog-mode)
;;                  (member major-mode yank-indent-modes)))
;;     (let ((transient-mark-mode nil))
;;       (yank-advised-indent-function (region-beginning) (region-end)))))

;; ;; prelude-core.el
;; (defun indent-buffer ()
;;   "Indent the currently visited buffer."
;;   (interactive)
;;   (indent-region (point-min) (point-max)))

;; ;; prelude-editing.el
;; (defcustom prelude-indent-sensitive-modes
;;   '(coffee-mode python-mode slim-mode haml-mode yaml-mode)
;;   "Modes for which auto-indenting is suppressed."
;;   :type 'list)

;; (defun indent-region-or-buffer ()
;;   "Indent a region if selected, otherwise the whole buffer."
;;   (interactive)
;;   (unless (member major-mode prelude-indent-sensitive-modes)
;;     (save-excursion
;;       (if (region-active-p)
;;           (progn
;;             (indent-region (region-beginning) (region-end))
;;             (message "Indented selected region."))
;;         (progn
;;           (indent-buffer)
;;           (message "Indented buffer.")))
;;       (whitespace-cleanup))))

;; (global-set-key (kbd "C-c i") 'indent-region-or-buffer)

;; ;; add duplicate line function from Prelude
;; ;; taken from prelude-core.el
;; (defun prelude-get-positions-of-line-or-region ()
;;   "Return positions (beg . end) of the current line
;; or region."
;;   (let (beg end)
;;     (if (and mark-active (> (point) (mark)))
;;         (exchange-point-and-mark))
;;     (setq beg (line-beginning-position))
;;     (if mark-active
;;         (exchange-point-and-mark))
;;     (setq end (line-end-position))
;;     (cons beg end)))

;; ;; smart openline
;; (defun prelude-smart-open-line (arg)
;;   "Insert an empty line after the current line.
;; Position the cursor at its beginning, according to the current mode.
;; With a prefix ARG open line above the current line."
;;   (interactive "P")
;;   (if arg
;;       (prelude-smart-open-line-above)
;;     (progn
;;       (move-end-of-line nil)
;;       (newline-and-indent))))

;; (defun prelude-smart-open-line-above ()
;;   "Insert an empty line above the current line.
;; Position the cursor at it's beginning, according to the current mode."
;;   (interactive)
;;   (move-beginning-of-line nil)
;;   (newline-and-indent)
;;   (forward-line -1)
;;   (indent-according-to-mode))

;;(add-hook 'after-save-hook 'magit-after-save-refresh-status t)
;;(global-set-key (kbd "M-o") 'prelude-smart-open-line)
;;(global-set-key (kbd "M-o") 'open-line)

(add-hook 'flycheck-mode-hook (lambda() 
                                (flycheck-list-errors)))

(provide 'setup-editing)
