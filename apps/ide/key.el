(defun ide/company-active-return ()
  (interactive)
  (company-abort)
  (newline-and-indent))

(defun hackartist/xdg-open ()
  (interactive)
  (shell-command "xdg-open ."))

(defun hackartist/ide/bindings ()
  (spacemacs/declare-prefix "TAB" "Imenu")
  (spacemacs/declare-prefix "'" "create a snippet")
  (spacemacs/declare-prefix "gT" "tag")
  (spacemacs/set-leader-keys
    "`" 'ace-window
    "=" 'ace-window
    "'" 'hackartist/ide/switch-or-create-other-frame
    "." 'helm-hackartist-buffer
    "'" 'helm-yas-create-snippet-on-region

    "RET" 'yas-insert-snippet
    "SPC" 'helm-mt
    "TAB" 'helm-imenu

    "bk" 'kill-this-buffer
    "bu" 'revert-buffer

    "gd" 'helm-magit-todos
    "gn" 'github-notifier-visit-github
    "gB" 'magit-branch-and-checkout
    "gC" 'magit-branch-checkout
    "gF" 'magit-fetch-all
    "gTc" 'magit-tag-create
    "gTd" 'magit-tag-delete
    "gTr" 'magit-tag-release
    "gTp" 'magit-push-tag

    "pF" 'projectile-find-file-other-window

    "wn" 'minimize-window

    "fO" 'hackartist/xdg-open
    "f." 'treemacs-display-current-project-exclusively
    "ff" 'spacemacs/helm-find-files

    "ss" 'helm-swoop


    "rM" 'helm-global-mark-ring

    "sgP" 'counsel-git-grep

    "xf RET" 'ox-clip-formatted-copy)

  (spacemacs/declare-prefix-for-mode 'term-mode "x" "text")
  (spacemacs/set-leader-keys-for-minor-mode 'term-mode
    "xo" 'browse-url-at-point)

  (spacemacs/set-leader-keys-for-major-mode 'forge-topic-mode
    "RET" 'code-review-forge-pr-at-point)

  (evil-define-key 'motion dictionary-mode-map "." 'dictionary-lookup-definition)
  (evil-define-key 'motion dictionary-mode-map "," 'dictionary-previous)

  (define-key evil-normal-state-map (kbd "+") 'text-scale-increase)
  (define-key evil-normal-state-map (kbd "-") 'text-scale-decrease)
  (define-key evil-normal-state-map (kbd "=") 'text-scale-adjust)
  (define-key evil-normal-state-map (kbd ".") 'spacemacs/jump-to-definition)
  (define-key evil-normal-state-map (kbd ",") 'xref-pop-marker-stack)

  (global-set-key (kbd "S-SPC") 'apps/ide/toggle-input-method-custom)
  ;; (global-set-key (kbd "S-SPC") 'toggle-input-method)
  (global-set-key (kbd "<home>") 'move-beginning-of-line)
  (global-set-key (kbd "<end>") 'move-end-of-line)
  (global-set-key (kbd "RET") 'newline-and-indent)
  (global-set-key (kbd "C-s") 'helm-swoop)
  (global-set-key (kbd "M-k") 'symbol-overlay-jump-prev)
  (global-set-key (kbd "M-j") 'symbol-overlay-jump-next)
  ;; (add-hook 'vterm-mode-hook
  ;;           (lambda ()
  ;;             (define-key evil-normal-state-local-map (kbd "p") 'term-paste)
  ;;             (define-key evil-normal-state-local-map (kbd "w") 'term-send-forward-word)
  ;;             (define-key evil-normal-state-local-map (kbd "b") 'term-send-backward-word)
  ;;             (define-key vterm-mode-map (kbd "C-s") 'helm-swoop)
  ;;             (define-key vterm-mode-map (kbd "M-h") 'term-send-backward-word)
  ;;             (define-key vterm-mode-map (kbd "M-l") 'term-send-forward-word)))
  (add-hook 'term-mode-hook
            (lambda ()
              (define-key evil-normal-state-local-map (kbd "p") 'term-paste)
              ;; (define-key evil-normal-state-local-map (kbd "l") 'term-send-right)
              ;; (define-key evil-normal-state-local-map (kbd "h") 'term-send-left)
              ;; (define-key evil-normal-state-local-map (kbd "^") 'term-send-home)
              ;; (define-key evil-normal-state-local-map (kbd "$") 'term-send-end)
              (define-key evil-normal-state-local-map (kbd "w") 'term-send-forward-word)
              (define-key evil-normal-state-local-map (kbd "b") 'term-send-backward-word)
              (define-key term-mode-map (kbd "C-s") 'helm-swoop)
              (define-key term-mode-map (kbd "M-h") 'term-send-backward-word)
              (define-key term-mode-map (kbd "M-l") 'term-send-forward-word)))

  (add-hook 'company-mode-hook
            (lambda ()
              ;;(define-key company-active-map (kbd "ESC") 'company-abort)
              (define-key company-active-map (kbd "<return>") 'ide/company-active-return)
              (define-key company-active-map (kbd "<tab>") 'company-complete)))
  ;; (with-eval-after-load 'yasnippet
  ;;   (define-key yas-minor-mode-map [(tab)]       (yas-filtered-definition 'yas-next-field))
  ;;   (define-key yas-minor-mode-map (kbd "TAB")   (yas-filtered-definition 'yas-next-field)))
  ;; (ide/keyboard-dvorak)

  (with-eval-after-load 'helm
    (define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebihnd tab to do persistent action
    ;; (define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB works in terminal
    ;; (define-key helm-map (kbd "C-z") 'helm-select-action) ; list actions using C-z

    ;; (global-set-key (kbd "C-x b") 'helm-mini)
    ;; (global-set-key (kbd "C-x C-f") 'helm-find-files)
    ;; (define-key 'help-command (kbd "C-f") 'helm-apropos)
    ;; (define-key 'help-command (kbd "r") 'helm-info-emacs)
    ;; (define-key 'help-command (kbd "C-l") 'helm-locate-library)
    (add-hook 'helm-goto-line-before-hook 'helm-save-current-pos-to-mark-ring)
    (define-key minibuffer-local-map (kbd "M-p") 'helm-minibuffer-history)
    (define-key minibuffer-local-map (kbd "M-n") 'helm-minibuffer-history)
    ;;(define-key global-map [remap find-tag] 'helm-etags-select)
    ;;(define-key global-map [remap list-buffers] 'helm-buffers-list)
    (setq helm-ff-DEL-up-one-level-maybe t)
    ;; (define-key helm-find-files-map (kbd "<backspace>") 'helm-find-files-up-one-level)
    (define-key helm-map (kbd "<left>") 'helm-previous-source)
    (define-key helm-map (kbd "<right>") 'helm-next-source)))

(defun ide/keyboard-dvorak ()
  ;; (advice-add 'hangul2-input-method-internal :override 'advice-override/hangul2-input-method-internal)
  (advice-add 'hangul2-input-method :override 'advice-override/hangul2-input-method)
  (kl/leader-correct-keys
    "wh"
    "wj"
    "wk"
    "wl"
    ;;
    "wH"
    "wJ"
    "wK"
    "wL")
  (with-eval-after-load 'magit
    (evil-define-key 'normal magit-mode-map "h" 'evil-next-visual-line))
  (with-eval-after-load 'org
    (spacemacs/set-leader-keys-for-major-mode 'org-mode
      "Oc" 'org-toggle-checkbox
      "Oe" 'org-toggle-pretty-entities
      "Oi" 'org-toggle-inline-images
      "On" 'org-num-mode
      "Ol" 'org-toggle-link-display
      "Ot" 'org-show-todo-tree
      "OT" 'org-todo
      "OV" 'space-doc-mode
      "Ox" 'org-latex-preview

      "N" 'org-shiftright
      "D" 'org-shiftleft
      "H" 'org-shiftdown
      "T" 'org-shiftup

      "sd" 'org-promote-subtree
      "sh" 'org-move-subtree-down
      "st" 'org-move-subtree-up
      "sn" 'org-demote-subtree
      "sj" 'org-cut-subtree
      "sl" 'org-narrow-to-subtree

      "tD" 'org-table-move-column-left
      "tN" 'org-table-move-column-right
      "tH" 'org-table-move-row-down
      "tT" 'org-table-move-row-up
      "tC" 'org-table-create-with-table.el
      ;; "tj" 'org-table-next-row
      ;; "th" 'org-table-previous-field
      ;; "tl" 'org-table-next-field

      "tn" 'org-table-create

      ))
  (with-eval-after-load 'quail
    (push
     (cons "dvorak"
           (concat
            "                              "
            "`~1!2@3#4$5%6^7&8*9(0)[{]}    "   ; numbers
            "  '\",<.>pPyYfFgGcCrRlL/?=+\\|  " ; qwerty
            "  aAoOeEuUiIdDhHtTnNsS-_      "   ; asdf
            "  ;:qQjJkKxXbBmMwWvVzZ        "   ; zxcv
            "                              "))
     quail-keyboard-layout-alist)

    (quail-set-keyboard-layout "dvorak")))

(defun advice-override/hangul2-input-method-internal (key)
  (setq key (quail-keyboard-translate key))
  (let ((char (+ (aref hangul2-keymap (1- (% key 32)))
                 (cond ((or (= key ?O) (= key ?P)) 2)
                       ((or (= key ?E) (= key ?Q) (= key ?R)
                            (= key ?T) (= key ?W)) 1)
                       (t 0)))))
    (if (< char 31)
        (hangul2-input-method-jaum char)
      (hangul2-input-method-moum char))))

(defun advice-override/hangul2-input-method (key)
  "2-Bulsik input method."
  (setq key (quail-keyboard-translate key))
  (if (or buffer-read-only (not (alphabetp key)))
      (list key)
    (quail-setup-overlays nil)
    (let ((input-method-function nil)
          (echo-keystrokes 0)
          (help-char nil))
      (setq hangul-queue (make-vector 6 0))
      (hangul2-input-method-internal key)
      (unwind-protect
          (catch 'exit-input-loop
            (while t
              (let* ((seq (read-key-sequence nil))
                     (cmd (lookup-key hangul-im-keymap seq))
                     key)
                (cond
                 ((and (stringp seq)
                       (= 1 (length seq))
                       (setq key (quail-keyboard-translate (aref seq 0)))
                       (alphabetp key))
                  (hangul2-input-method-internal key))
                 ((commandp cmd)
                  (call-interactively cmd))
                 (t
                  (setq unread-command-events
                        (nconc (listify-key-sequence seq)
                               unread-command-events))
                  (throw 'exit-input-loop nil))))))
        (quail-delete-overlays)))))


(defun advice-override/hangul3-input-method (key)
  "3-Bulsik final input method."
  (setq key (quail-keyboard-translate key))
  (if (or buffer-read-only (< key 33) (>= key 127))
      (list key)
    (quail-setup-overlays nil)
    (let ((input-method-function nil)
          (echo-keystrokes 0)
          (help-char nil))
      (setq hangul-queue (make-vector 6 0))
      (hangul3-input-method-internal key)
      (unwind-protect
          (catch 'exit-input-loop
            (while t
              (let* ((seq (read-key-sequence nil))
                     (cmd (lookup-key hangul-im-keymap seq))
                     key)
                (cond ((and (stringp seq)
                            (= 1 (length seq))
                            (setq key (quail-keyboard-translate (aref seq 0)))
                            (and (>= key 33) (< key 127)))
                       (hangul3-input-method-internal key))
                      ((commandp cmd)
                       (call-interactively cmd))
                      (t
                       (setq unread-command-events
                             (nconc (listify-key-sequence seq)
                                    unread-command-events))
                       (throw 'exit-input-loop nil))))))
        (quail-delete-overlays)))))

(defun advice-override/hangul390-input-method (key)
  "3-Bulsik 390 input method."
  (setq key (quail-keyboard-translate key))
  (if (or buffer-read-only (< key 33) (>= key 127))
      (list key)
    (quail-setup-overlays nil)
    (let ((input-method-function nil)
          (echo-keystrokes 0)
          (help-char nil))
      (setq hangul-queue (make-vector 6 0))
      (hangul390-input-method-internal key)
      (unwind-protect
          (catch 'exit-input-loop
            (while t
              (let* ((seq (read-key-sequence nil))
                     (cmd (lookup-key hangul-im-keymap seq))
                     key)
                (cond ((and (stringp seq)
                            (= 1 (length seq))
                            (setq key (quail-keyboard-translate (aref seq 0)))
                            (and (>= key 33) (< key 127)))
                       (hangul390-input-method-internal key))
                      ((commandp cmd)
                       (call-interactively cmd))
                      (t
                       (setq unread-command-events
                             (nconc (listify-key-sequence seq)
                                    unread-command-events))
                       (throw 'exit-input-loop nil))))))
        (quail-delete-overlays)))))
