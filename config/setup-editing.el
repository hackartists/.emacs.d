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

(setq global-mark-ring-max 50000
      mark-ring-max 50000
      mode-require-final-newline t
      tab-width 4 
      kill-whole-line t
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

;; (global-linum-mode)
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
(setq yas-prompt-functions '(yas/ido-prompt yas/completing-prompt))
(setq yas-verbosity 1)
(setq yas-wrap-around-region t)

(add-hook 'term-mode-hook (lambda() 
                            (setq yas-dont-activate t)))


(provide 'setup-editing)
