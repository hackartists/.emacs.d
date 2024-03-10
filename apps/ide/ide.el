(defun hackartist/ide-before-save-hook()
  (when (or (derived-mode-p 'go-mode)
            (derived-mode-p 'dart-mode))
    (lsp-organize-imports)
    (lsp-format-buffer)))

(defun hackartist/ide/init ()
  ;; (global-company-mode +1)
  ;; (cua-mode 1)
  ;; (yas-global-mode +1)
  ;; (projectile-mode +1)
  ;; (global-undo-tree-mode +1)
  ;; (helm-projectile-on)
  ;; (recentf-mode +1)
  ;; (global-git-gutter+-mode -1)
  ;; (global-auto-highlight-symbol-mode +1)
  (require 'impostman) 
  (require 'ox-moderncv)
  (require 'codegpt)
  (require 'whisper)
  (setq codegpt-tunnel 'chat            ; The default is 'completion or 'chat
        codegpt-model "gpt-4"
        openai-key (getenv "OPENAPI_KEY")
        )
  ;; (elcord-mode t)
  (autoload 'garak "garak" nil t)
  (setq auth-sources '("~/.authinfo")) 
  (add-hook 'before-save-hook 'hackartist/ide-before-save-hook)
  (add-hook 'minibuffer-setup-hook (lambda () 
                                     (if (string= current-input-method 'korean-hangul) 
                                         (apps/ide/toggle-input-method-custom) 
                                       (setq current-input-method nil)))) 
  (with-eval-after-load 'git-auto-commit-mode 
    (setq gac-automatically-push-p t)) 
  (add-hook 'image-mode-hook (lambda () 
                               (image-transform-fit-to-width)))
  ;;(advice-add 'windmove-do-window-select :after 'advice-after/windmove-do-window-select)
  ;; (add-hook 'minibuffer-setup-hook (lambda ()
  ;; 				      (when minibuffer-completion-table
  ;; 					(with-current-buffer "*Messages*"
  ;; 					  (print minibuffer-completion-table)))))
  (helm-projectile-on) 
  
  (setq shrface-toggle-bullets t) 
  (savehist-mode -1) 
  (shrface-basic) 
  (shrface-trial) 
  (github-notifier) 

  ;; (shrface-default-keybindings) ; setup default keybindings
  (advice-add 'forge-visit-pullreq :override 'advice-override/forge-visit-pullreq)
  (advice-add 'plantuml-preview-string :override 'advice-override/plantuml-preview-string)

  (setq shrface-href-versatile t))

(defun advice-after/windmove-do-window-select (dir &optional arg window) 
  (treemacs-display-current-project-exclusively))

(defun advice-override/forge-visit-pullreq (pullreq)
  (code-review-forge-pr-at-point))

(advice-add 'emacs-lisp/post-init-company 
            :override 'advice-override/emacs-lisp/post-init-company)
(defun advice-override/emacs-lisp/post-init-company () 
  (spacemacs|add-company-backends :backends company-elisp 
                                  :modes emacs-lisp-mode) 
  (spacemacs|add-company-backends :backends (company-files company-elisp) 
                                  :modes ielm-mode))

(defun hackartist-insert-end (text) (goto-char (point-max)) (inser text))
(defun hackartist/string/abbreviation (text)
  (let ((ht (make-hash-table)))
    (puthash 'extension "ext" ht)
    (puthash 'management "mgmt" ht)
    (puthash 'version "ver" ht)
    (puthash 'registry "reg" ht)
    (puthash 'configuration "conf" ht)
    (puthash 'community "comm" ht)
    (puthash 'function "func" ht)
    (puthash 'description "desc" ht)
    (puthash 'statistics "stats" ht)
    (puthash 'state "st" ht)
    (puthash 'component "comp" ht)
    (puthash 'activity "act" ht)
    (puthash 'array "arr" ht)
    (puthash 'index "i" ht)
    (puthash 'string "str" ht)
    (string-join
     (mapcar (lambda (el) (gethash (intern el) ht el))
             (split-string (downcase text) " ")) "")))


(defun advice-override/plantuml-preview-string (prefix string)
  "Preview diagram from PlantUML sources (as STRING), using prefix (as PREFIX)
to choose where to display it."
  (let* ((imagep (and (display-images-p)
                      (plantuml-is-image-output-p)))
         (buf (get-buffer-create plantuml-preview-buffer))
         (coding-system-for-read (and imagep 'binary))
         (coding-system-for-write (and imagep 'binary)))
    (plantuml-exec-mode-preview-string prefix (plantuml-get-exec-mode) string buf)))
