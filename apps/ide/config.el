(defvar ide-load-env-pre-hook nil)
;; (defvar miniwindow-position 'bottom)

;; (add-to-list 'display-buffer-alist
;;              `(,(rx bos "*Flycheck errors*" eos)
;;               (display-buffer-reuse-window
;;                display-buffer-in-side-window)
;;               (side            . bottom)
;;               (reusable-frames . visible)
;;               (window-height   . 0.25)))

;; (defvar ide-helm-display-buffer-regexp
;;   `("**"
;;     (display-buffer-in-side-window)
;;     (inhibit-same-window . t)
;;     (side . ,miniwindow-position)
;;     (window-width . 0.6)
;;     (window-height . 0.4)))

;; (defvar ide-display-buffer-regexp
;;   `("**"
;;     (window-height . 0.4)))

(defun hackartist/ide/config/darwin ()
  (add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
  (add-to-list 'default-frame-alist '(ns-appearance . dark))
  (setq ns-command-modifier 'ctrl
        mac-command-modifier 'ctrl
        ns-control-modifier 'super
        mac-control-modifier 'super)
  (cua-mode 1)
  (global-set-key (kbd "s-c") 'cua-copy-region)
  (global-set-key (kbd "s-v") 'cua-paste)
  (global-set-key (kbd "s-x") 'cua-cut-region)
  (global-set-key (kbd "s-a") 'mark-whole-buffer)
  (global-set-key (kbd "s-z") 'undo)

  (highlight2clipboard-mode +1))

(defun hackartist/ide/config/linux ()
  ;; (setq x-ctrl-keysym 'super)
  ;; (setq x-super-keysym 'ctrl)
  )

(defmacro k-time (&rest body)
  "Measure and return the time it takes evaluating BODY."
  `(let ((time (current-time)))
     ,@body
     (float-time (time-since time))))

;; (defvar hackartist/ide/gc-timer (run-with-idle-timer 600
;;                                                      t
;;                                                      (lambda ()
;;                                                        (message "Garbage Collector has run for %.06fsec"
;;                                                                 (k-time (garbage-collect)))))
;;   "Timer for `hackartist/ide/gc-timer' to reschedule itself, or nil.")

(defun hackartist/ide/config ()
  (require 'multi-eshell)
  (require 'helm-mt)
  (require 'emacs-everywhere)
  (require 'bard)
  (require 'copilot)
  (setq read-process-output-max (* (* 1024 1024) 10)) ;; 10mb
  (setq lsp-session-folders-blocklist (list (expand-file-name "~")))
  (setq shell-file-name "/bin/zsh")
  (setq global-mark-ring-max 50000
        mark-ring-max 50000
        kill-ring-max 50000
        mode-require-final-newline t
        tab-width 2
        kill-whole-line t
        recentf-filename-handlers '(file-truename)
        recentf-max-menu-items 100)
  (set-fontset-font t 'hangul (font-spec :name "D2Coding"))

  (add-hook 'prog-mode-hook 'copilot-mode)

  (setq user-full-name "hackartist")
  (setq completion-styles `(flex))
  (setq doom-modeline-buffer-file-name-style 'truncate-with-project)
  (setq evil-want-fine-undo t)
  (setq auto-save-default nil)
  (global-evil-mc-mode t)

  (hackartist/openwith)
  (if (eq system-type 'darwin)
      (hackartist/ide/config/darwin)
    (hackartist/ide/config/linux))

  (setq tab-always-indent t)
  (add-to-list 'auto-mode-alist '("\\profile\\'" . shell-script-mode))
  (add-to-list 'auto-mode-alist '("\\.profile\\'" . shell-script-mode))
  (add-to-list 'auto-mode-alist '("\\.gradle\\'" . gradle-mode))
  (add-to-list 'auto-mode-alist '("README\\.md\\'" . gfm-mode))
  (add-to-list 'auto-mode-alist '("\\<BUILD\\'" . bazel-mode))
  (add-to-list 'auto-mode-alist '("\\<WORKSPACE\\'" . bazel-mode))
  (add-to-list 'auto-mode-alist '("\\.pdf\\'" . pdf-view-mode))
  (add-hook 'sh-mode-hook
            (lambda ()
              (setq tab-width 2)))
  (add-hook 'yaml-mode-hook
            (lambda ()
              (yas-minor-mode 1)
              (setq yas/indent-line nil)
              (spacemacs/toggle-line-numbers-on)))

  (add-hook 'makefile-mode-hook
            (lambda()
              (indent-tabs-mode 1)))

  ;; code review configuration
  ;; (add-hook 'code-review-mode-hook #'emojify-mode)
  (setq code-review-auth-login-marker 'forge
        code-review-new-buffer-window-strategy #'switch-to-buffer
        code-review-fill-column 80)

  (setq magit-repository-directories '(("~/data/devel" . 3)))

  (add-hook 'jiralib2-post-login-hook #'ejira-guess-epic-sprint-fields)

  ;; They can also be set manually if autoconfigure is not used.
  ;; (setq ejira-sprint-field       'customfield_10001
  ;;       ejira-epic-field         'customfield_10002
  ;;       ejira-epic-summary-field 'customfield_10004)

  (require 'ejira-agenda)

  ;; Add an agenda view to browse the issues that
  (org-add-agenda-custom-command
   '("j" "My JIRA issues"
     ((ejira-jql "resolution = unresolved and assignee = currentUser()"
                 ((org-agenda-overriding-header "Assigned to me"))))))

  ;; (require 'projectile-git-autofetch)
  ;; (projectile-git-autofetch-mode 1)
  ;; (setq-default gac-automatically-push-p t)
  ;; (prefer-coding-system 'utf-8)
  ;; (set-default-coding-systems 'utf-8)
  ;; (set-terminal-coding-system 'utf-8-unix)
  ;; (set-keyboard-coding-system 'utf-8)
  ;; (setq default-process-coding-system '(utf-8-unix . utf-8-unix))
  ;; (setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))
  ;; (set-language-environment "UTF-8")
  (setq browse-url-browser-function 'browse-url-chrome)
  (add-hook 'term-exec-hook
            (function (lambda ()
                        (set-buffer-process-coding-system 'utf-8-unix
                                                          'utf-8-unix))))
  ;; (add-hook 'eww-after-render-hook #'shrface-mode)
  (global-set-key (kbd "RET") 'newline-and-indent)
  ;; (global-set-key "\C-x\ \C-r" 'recentf-open-files)
  (setq custom-safe-themes t)
  (setq company-require-match nil)
  ;; (setq company-lsp-cache-candidates t)
  (setq helm-multi-swoop-edit-save nil)
  (setq helm-swoop-split-with-multiple-windows t)
  (setq helm-swoop-split-direction 'split-window-vertically)
  (setq helm-swoop-speed-or-color t)
  ;; (setq xref-show-xrefs-function 'helm-xref-show-defs-27)
  ;; (setq helm-display-function 'ide/display-helm-miniwindow)
  ;; (setq helm-swoop-split-window-function 'ide/display-helm-miniwindow)
  (setq projectile-completion-system 'helm)
  (setq projectile-indexing-method 'alien)
  (setq projectile-git-submodule-command nil)
  (setq projectile-project-root-files '("rebar.config" "project.clj" "build.boot"
                                        "SConstruct" "pom.xml" "build.sbt" "gradlew"
                                        "build.gradle" ".ensime" "Gemfile" "requirements.txt"
                                        "setup.py" "tox.ini" "composer.json" "Cargo.toml"
                                        "mix.exs" "stack.yaml" "info.rkt" "DESCRIPTION"
                                        "TAGS" "GTAGS" ".dropbox" ".projectile" "package.json"
                                        "go.mod" "pubspec.yaml" "Makefile"))
  ;; (setq flycheck-display-errors-function 'ide/display-bottom-window)
  ;; (setq mu4e-view-show-images t mu4e-view-show-addresses t mu4e-hide-index-messages t)
  ;; (transient-append-suffix 'magit-dispatch "F" '("o" "Fotingo" fotingo-dispatch))
  (set-face-attribute 'hl-line nil ;; :height (+ (face-attribute 'default :height) 30)
                      :underline t
                      :inherit nil
                      :background nil)
  ;; (evil-avy-mode)
  ;; (with-eval-after-load 'git-gutter+
  ;;   (defun git-gutter+-remote-default-directory (dir file)
  ;;     (let* ((vec (tramp-dissect-file-name file))
  ;;            (method (tramp-file-name-method vec))
  ;;            (user (tramp-file-name-user vec))
  ;;            (domain (tramp-file-name-domain vec))
  ;;            (host (tramp-file-name-host vec))
  ;;            (port (tramp-file-name-port vec)))
  ;;       (tramp-make-tramp-file-name method user domain
  ;;                                   host port dir)))
  ;;   (defun git-gutter+-remote-file-path (dir file)
  ;;     (let ((file (tramp-file-name-localname (tramp-dissect-file-name file))))
  ;;       (replace-regexp-in-string (concat "\\`" dir)
  ;;                                 ""
  ;;                                 file))))
  ;; (with-eval-after-load 'doom-modeline
  ;;   (add-hook 'doom-modeline-mode-hook
  ;;             (lambda ()
  ;;               (display-time))))
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
  (define-key yas-keymap (kbd "<return>") 'yas/exit-all-snippets)
  (define-key yas-keymap (kbd "C-e") 'yas/goto-end-of-active-field)
  (define-key yas-keymap (kbd "C-a") 'yas/goto-start-of-active-field)

  (custom-set-variables
   '(create-lockfiles nil))

  (setq yas-prompt-functions '(yas/ido-prompt yas/completing-prompt))
  (setq yas-verbosity 1)
  (setq yas-wrap-around-region t)
  (setq org-format-latex-options (plist-put org-format-latex-options :scale 2.0))

  ;; (add-hook 'yas-before-expand-snippet-hook (lambda ()
  ;;                                             (company-mode -1)))
  ;; (add-hook 'yas-after-exit-snippet-hook (lambda ()
  ;;                                          (company-mode 1)))
  (add-hook 'slack-mode-hook
            (lambda ()
              (company-mode -1)))
  (add-hook 'diff-mode-hook
            (lambda ()
              (setq-local whitespace-style
                          '(face tabs tab-mark spaces space-mark trailing
                                 indentation: :space
                                 indentation: :tab
                                 newline newline-mark))
              (whitespace-mode 1)))
  (add-hook 'protobuf-mode-hook
            (lambda ()
              (interactive "")
              (format-all-mode +1)))
  (add-hook 'term-mode-hook
            (lambda ()
              (setq yas-dont-activate t)))
  (add-hook 'shell-mode-hook
            (lambda ()
              (company-mode -1)))
  (add-hook 'gfm-mode (lambda ()
                        (require 'lsp-grammarly)
                        (lsp)))
  ;; (add-hook 'focus-out-hook (lambda ()
  ;;                             (interactive)
  ;;                             (save-some-buffers t)))

  ;; (customize-set-variable 'helm-ff-lynx-style-map t)
  ;; (customize-set-variable 'helm-imenu-lynx-style-map t)
  ;; (customize-set-variable 'helm-semantic-lynx-style-map t)
  ;; (customize-set-variable 'helm-occur-use-ioccur-style-keys t)
  ;; (customize-set-variable 'helm-grep-use-ioccur-style-keys t)
  (when (executable-find "curl")
    (setq helm-google-suggest-use-curl-p t))
  (delete-dups extended-command-history)
  ;; (setq history-delete-duplicates t)
  ;; (setq history-length 10)
  ;; (setq
  ;;  helm-scroll-amount 4
  ;;  helm-ff-search-library-in-sexp t
  ;;  helm-split-window-in-side-p t
  ;;  helm-candidate-number-limit 500
  ;;  helm-ff-file-name-history-use-recentf t
  ;;  helm-move-to-line-cycle-in-source t
  ;;  helm-buffers-fuzzy-matching t
  ;;  helm-ff-lynx-style-map t
  ;;  helm-imenu-lynx-style-map t
  ;;  helm-semantic-lynx-style-map t
  ;;  helm-occur-use-ioccur-style-keys t
  ;;  helm-grep-use-ioccur-style-keys t)
  (custom-set-faces
   '(default ((t (:inherit nil :extend nil :stipple nil :background "#292b2e" :foreground "#b2b2b2" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 1 :width normal :foundry "default" :family "default"))))
   '(font-lock-comment-face ((t (:background "#292b2e" :foreground "#2aa1ae" :slant normal))))
   '(header-line ((t (:background "#222226"))))
   '(hl-line ((t (:extend t :background "#292b2e" :underline t))))
   '(line-number ((t (:inherit default :background "#222226" :foreground "#44505c"))))
   '(line-number-current-line ((t (:inherit line-number :background "#222226" :foreground "#b2b2b2" :underline t))))
   '(mode-line ((t (:background "#222226" :foreground "#b2b2b2" :box (:line-width (1 . 1) :color "#5d4d7a")))))
   ;; '(font-lock-comment-face ((t (:background "color-236" :foreground "#2aa1ae" :slant normal))))
   ;; '(hl-line ((t (:inherit nil :extend t :background "color-235" :underline t))))
   ;; '(line-number ((t (:inherit default :background "color-237" :foreground "#44505c"))))
   ;; '(line-number-current-line ((t (:inherit line-number :background "color-235" :foreground "#b2b2b2"))))
   ;; '(mode-line ((t (:background "#222226" :foreground "#b2b2b2" :box (:line-width 1 :color "#5d4d7a")))))
   '(mode-line-inactive ((t (:background "gray42" :foreground "#b2b2b2" :box (:line-width 1 :color "#5d4d7a"))))))

  ;; (add-hook 'text-mode-hook (lambda () (spacemacs/toggle-relative-line-numbers-on)))
  ;; (add-hook 'prog-mode-hook 'spacemacs/toggle-relative-line-numbers-on)

  (setq doom-modeline-buffer-file-name-style 'file-name)
  (setq calendar-month-name-array ["January" "February" "March" "April" "May"
                                   "June" "July" "August" "September" "October"
                                   "November" "December"])
  ;; Week days

  (setq calendar-day-name-array ["Sunday" "Monday" "Tuesday" "Wednesday" "Thursday"
                                 "Friday" "Saturday"])
  ;; First day of the week

  (setq calendar-week-start-day 1) ; 0:Sunday, 1:Monday

  (setq gts-default-translator (gts-translator
                                :picker
                                ;;(gts-noprompt-picker)
                                ;;(gts-noprompt-picker :texter (gts-whole-buffer-texter))
                                (gts-prompt-picker)
                                ;;(gts-prompt-picker :single t)
                                ;;(gts-prompt-picker :texter (gts-current-or-selection-texter) :single t)

                                :engines
                                (list
                                 (gts-bing-engine)
                                 ;;(gts-google-engine)
                                 ;;(gts-google-rpc-engine)
                                 (gts-deepl-engine :auth-key (getenv "DEEPL_KEY") :pro nil)
                                 (gts-google-engine)
                                 ;; (gts-google-engine :parser (gts-google-summary-parser))
                                 ;;(gts-google-engine :parser (gts-google-parser))
                                 ;;(gts-google-rpc-engine :parser (gts-google-rpc-summary-parser) :url "https://translate.google.com")
                                 ;; (gts-google-rpc-engine :parser (gts-google-rpc-parser) :url "https://translate.google.com")
                                 )

                                :render
                                (gts-buffer-render)
                                ;;(gts-posframe-pop-render)
                                ;;(gts-posframe-pop-render :backcolor "#333333" :forecolor "#ffffff")
                                ;;(gts-posframe-pin-render)
                                ;;(gts-posframe-pin-render :position (cons 1200 20))
                                ;;(gts-posframe-pin-render :width 80 :height 25 :position (cons 1000 20) :forecolor "#ffffff" :backcolor "#111111")
                                ;;(gts-kill-ring-render)

                                :splitter
                                (gts-paragraph-splitter)))

  )

;; (defun ide/display-helm-miniwindow (buffer &optional resume)
;;   "Display the Helm window respecting `helm-position'."
;;   (let ((display-buffer-alist
;;          (list ;; ide-helm-display-help-buffer-regexp
;;           ;; this or any specialized case of Helm buffer must be
;;           ;; added AFTER `spacemacs-helm-display-buffer-regexp'.
;;           ;; Otherwise, `spacemacs-helm-display-buffer-regexp' will
;;           ;; be used before
;;           ;; `spacemacs-helm-display-help-buffer-regexp' and display
;;           ;; configuration for normal Helm buffer is applied for helm
;;           ;; help buffer, making the help buffer unable to be
;;           ;; displayed.
;;           ide-helm-display-buffer-regexp)))
;;     (helm-default-display-buffer buffer)))

;; (defun my-org-screenshot ()
;;   "Take a screenshot into a time stamped unique-named file in the
;; same directory as the org-buffer and insert a link to this file."
;;   (interactive)
;;   (org-display-inline-images)
;;   (setq filename (concat (make-temp-name (concat (file-name-nondirectory (buffer-file-name))
;;                                                  "_imgs/"
;;                                                  (format-time-string "%Y%m%d_%H%M%S_")))
;;                          ".png"))
;;   (unless (file-exists-p (file-name-directory filename))
;;     (make-directory (file-name-directory filename)))
;;                                         ; take screenshot
;;   (if (eq system-type 'darwin)
;;       (call-process "screencapture" nil nil nil
;;                     "-i" filename))
;;   (if (eq system-type 'gnu/linux)
;;       (call-process "import" nil nil nil filename))
;;                                         ; insert into file if correctly taken
;;   (if (file-exists-p filename)
;;       (insert (concat "[[file:" filename "]]"))))
(defun hackartist/openwith ()
  "dired openwith setup"
  (require 'openwith)
  (openwith-mode t)
  (setq openwith-associations
        '(
          ;; ("\\.pdf\\'" "okular" (file))
          ("\\.ppt\\'" "libreoffice" (file))
          ("\\.pptx\\'" "libreoffice" (file))
          ("\\.doc\\'" "libreoffice" (file))
          ("\\.docx\\'" "libreoffice" (file))
          ("\\.hwp\\'" "/opt/hnc/hoffice11/Bin/hwp" (file))
          ("\\.hwpx\\'" "/opt/hnc/hoffice11/Bin/hwp" (file))
          ;; ("\\.svg\\'" "inkscape" (file))
          ("\\.eps\\'" "inkscape" (file))
          ))
  )

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(create-lockfiles nil)
 '(google-translate-default-source-language "ko" t)
 '(google-translate-default-target-language "en")
 ;; '(google-translate-output-destination '(kill-ring))
 '(google-translate-translation-to-kill-ring t)
 '(org-image-actual-width '(700))
 '(plantuml-indent-level 2)
 '(safe-local-variable-values
   '((eval org-hugo-auto-export-mode t)
     (typescript-backend . tide)
     (typescript-backend . lsp)
     (javascript-backend . tide)
     (javascript-backend . tern)
     (javascript-backend . lsp)))
 '(send-mail-function 'mailclient-send-it)
 '(solidity-comment-style 'slash)
 '(typescript-indent-level 2)
 '(warning-suppress-types
   '((org-element-cache)
     (org-element-cache)
     (emacsql)
     (lsp-mode))))
