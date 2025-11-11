(defun hackartist/ide-before-save-hook()
  (when (or (derived-mode-p 'go-mode)
            (derived-mode-p 'dart-mode))
    (lsp-organize-imports)
    (lsp-format-buffer)))

(defun hackartist/ide/init ()
  (require 'impostman)
  (require 'ox-moderncv)
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
  ;;              (when minibuffer-completion-table
  ;;          (with-current-buffer "*Messages*"
  ;;            (print minibuffer-completion-table)))))
  (helm-projectile-on)

  (setq shrface-toggle-bullets t)
  (savehist-mode -1)
  (shrface-basic)
  (shrface-trial)
  ;; (github-notifier)

  ;; (shrface-default-keybindings) ; setup default keybindings
  (advice-add 'forge-visit-pullreq :override 'advice-override/forge-visit-pullreq)
  (advice-add 'plantuml-preview-string :override 'advice-override/plantuml-preview-string)

  (setq shrface-href-versatile t))

(defun advice-after/windmove-do-window-select (dir &optional arg window)
  (treemacs-display-current-project-exclusively))

(defun advice-override/forge-visit-pullreq (pullreq)
  (code-review-forge-pr-at-point))

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


(defun hackartist/call-env-fn ()
  "Use Helm to select a zsh function, run it, and apply its exported env vars to Emacs."
  (interactive)
  (let* ((fn-list (split-string
                   (shell-command-to-string "zsh -i -c 'cat ~/.config/oh-my-profiles/private.profile| grep \"^function\" | awk \"{print \\$2}\"'")
                   "\n" t))
         (selected-fn (helm :sources (helm-build-sync-source "Zsh Functions"
                                       :candidates fn-list)
                            :buffer "*helm zsh functions*")))
    (when selected-fn
      (hackartist/load-env-from-sh selected-fn)
      (message "Loaded environment from function: %s" selected-fn))))

(defun hackartist/load-env-from-sh (selected-fn)
  (let* ((command (format "zsh -i -c '%s && env'" selected-fn))
         (env-output (shell-command-to-string command)))
    (dolist (line (split-string env-output "\n"))
      (when (string-match "^\\([^=]+\\)=\\(.*\\)$" line)
        (let ((key (match-string 1 line))
              (val (match-string 2 line)))
          (setenv key val)
          (message "Set %s=%s" key val))))))

(defvar hackartist--env-loaded (make-hash-table :test 'equal))

(defun hackartist/load-env-once (name)
  "Load environment variables from a zsh function NAME only once per project root."
  (let* ((root (or
                (when (fboundp 'project-current)
                  (when-let ((pr (project-current nil)))
                    (expand-file-name (if (fboundp 'project-root)
                                          (project-root pr)
                                        (car (project-roots pr))))))
                (locate-dominating-file default-directory ".git")
                (expand-file-name default-directory)))
         (key (cons root name)))
    (unless (gethash key hackartist--env-loaded)
      (hackartist/load-env-from-sh name)
      (puthash key t hackartist--env-loaded))))
