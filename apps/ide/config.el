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

(defun hackartist/ide/config ()
  (require 'helm-mt)
  (require 'emacs-everywhere)
  (require 'copilot)
  (setq gptel-model  'gpt-4o
        gptel-backend
        (gptel-make-openai "Github Models"
          :host "models.inference.ai.azure.com"
          :endpoint "/chat/completions?api-version=2024-05-01-preview"
          :stream t
          :key (getenv "GPTEL_GITHUB")
          :models '(gpt-4o)))

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
  (add-hook 'git-commit-setup-hook 'copilot-chat-insert-commit-message)

  (setq user-full-name "hackartist")
  (setq completion-styles `(flex))
  (setq doom-modeline-buffer-file-name-style 'truncate-with-project)
  (setq evil-want-fine-undo t)
  (setq auto-save-default nil)
  (global-evil-mc-mode t)

  ;; (hackartist/openwith)
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

  (setq code-review-auth-login-marker 'forge
        code-review-new-buffer-window-strategy #'switch-to-buffer
        code-review-fill-column 80)

  (setq magit-repository-directories '(("~/data/devel" . 3)))

  (add-hook 'jiralib2-post-login-hook #'ejira-guess-epic-sprint-fields)

  (require 'ejira-agenda)
  (org-add-agenda-custom-command
   '("j" "My JIRA issues"
     ((ejira-jql "resolution = unresolved and assignee = currentUser()"
                 ((org-agenda-overriding-header "Assigned to me"))))))

  (setq browse-url-browser-function 'browse-url-chrome)
  (add-hook 'term-exec-hook
            (function (lambda ()
                        (set-buffer-process-coding-system 'utf-8-unix
                                                          'utf-8-unix))))
  (global-set-key (kbd "RET") 'newline-and-indent)
  (setq custom-safe-themes t)
  ;; (setq company-require-match nil)
  (setq helm-multi-swoop-edit-save nil)
  (setq helm-swoop-split-with-multiple-windows t)
  (setq helm-swoop-split-direction 'split-window-vertically)
  (setq helm-swoop-speed-or-color t)
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
  (set-face-attribute 'hl-line nil ;; :height (+ (face-attribute 'default :height) 30)
                      :underline t
                      :inherit nil
                      :background nil)
  (define-key yas-keymap (kbd "<return>") 'yas/exit-all-snippets)

  (custom-set-variables
   '(create-lockfiles nil))

  (setq yas-prompt-functions '(yas/ido-prompt yas/completing-prompt))
  (setq yas-verbosity 1)
  (setq yas-wrap-around-region t)
  (setq org-format-latex-options (plist-put org-format-latex-options :scale 2.0))

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
  ;; (add-hook 'gfm-mode (lambda ()
  ;;                       (require 'lsp-grammarly)
  ;;                       (lsp)))
  (when (executable-find "curl")
    (setq helm-google-suggest-use-curl-p t))
  (delete-dups extended-command-history)

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
 '(default ((t (:inherit nil :extend nil :stipple nil :background "#292b2e" :foreground "#b2b2b2" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 1 :width normal :foundry "default" :family "default"))))
 ;; '(font-lock-comment-face ((t (:background "#292b2e" :foreground "#2aa1ae" :slant normal))))
 '(header-line ((t (:background "#222226"))))
 '(hl-line ((t (:extend t :background "#292b2e" :underline t))))
 '(line-number ((t (:inherit default :background "#222226" :foreground "#44505c"))))
 '(line-number-current-line ((t (:inherit line-number :background "#222226" :foreground "#b2b2b2" :underline t))))
 '(mode-line ((t (:background "#222226" :foreground "#b2b2b2" :box (:line-width (1 . 1) :color "#5d4d7a")))))
 '(mode-line-inactive ((t (:background "gray42" :foreground "#b2b2b2" :box (:line-width 1 :color "#5d4d7a")))))
 '(create-lockfiles nil)
 '(google-translate-default-source-language "ko" t)
 '(google-translate-default-target-language "en")
 ;; '(google-translate-output-destination '(kill-ring))
 '(google-translate-translation-to-kill-ring t)
 '(org-image-actual-width '(700))
 '(plantuml-indent-level 2)
 '(typescript-indent-level 2))
