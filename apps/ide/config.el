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
  (add-to-list 'default-frame-alist
               '(ns-transparent-titlebar . t))
  (add-to-list 'default-frame-alist
               '(ns-appearance . dark))
  (setq ns-command-modifier 'ctrl mac-command-modifier
        'ctrl ns-control-modifier 'super mac-control-modifier
        'super)
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

(defvar hackartist/ide/gc-timer (run-with-idle-timer 600
                                                     t
                                                     (lambda ()
                                                       (message "Garbage Collector has run for %.06fsec"
                                                                (k-time (garbage-collect)))))
  "Timer for `hackartist/ide/gc-timer' to reschedule itself, or nil.")

(defun hackartist/ide/config ()
  (require 'multi-eshell)
  (require 'helm-mt)
  (setq doom-modeline-buffer-file-name-style 'truncate-with-project)
  (setq org-re-reveal-extra-css (concat emacs-start-directory "/metadata/reveal-extra.css"))
  (setq org-plantuml-jar-path (expand-file-name "~/plantuml.jar"))
  (setq evil-want-fine-undo t)
  (setq helm-hackartist-buffers-list (make-hackartist-helm-source (helm-make-source "Buffers" 'helm-source-buffers)))
  (setq helm-hackartist-projectile-files-list (make-hackartist-helm-source helm-source-projectile-files-list))
  ;; (setq helm-hackartist-recentf-list (helm-make-source "Recentf" 'helm-recentf-source :fuzzy-match helm-recentf-fuzzy-match))
  (if (eq system-type 'darwin)
      (hackartist/ide/config/darwin)
    (hackartist/ide/config/linux))
  (setq shell-file-name "/bin/zsh")
  (setq global-mark-ring-max 50000 mark-ring-max
        50000 kill-ring-max 50000 mode-require-final-newline
        t tab-width 4 kill-whole-line t recentf-max-menu-items
        100)
  (add-to-list 'org-src-lang-modes
               '("plantuml" . plantuml))

  (org-babel-do-load-languages
   'org-babel-load-languages
   `(,@org-babel-load-languages (plantuml . t)))
  (setq org-enable-github-support t org-enable-bootstrap-support
        t org-enable-bootstrap-support t org-projectile-file
        "TODOs.org")
  (setq org-image-actual-width 800)
  (setq tab-always-indent t)
  (add-to-list 'auto-mode-alist
               '("\\profile\\'" . shell-script-mode))
  (add-to-list 'auto-mode-alist
               '("\\.profile\\'" . shell-script-mode))
  (add-to-list 'auto-mode-alist
               '("\\.gradle\\'" . gradle-mode))
  (add-to-list 'auto-mode-alist
               '("README\\.md\\'" . gfm-mode))
  (add-to-list 'auto-mode-alist
               '("\\<BUILD\\'" . bazel-mode))
  (add-to-list 'auto-mode-alist
               '("\\<WORKSPACE\\'" . bazel-mode))
  (spacemacs/toggle-visual-line-navigation-globally-on)
  (add-hook 'gfm-mode-hook
            (lambda ()
              (visual-line-mode 1)))
  (add-hook 'sh-mode-hook
            (lambda ()
              (setq tab-width 4)))
  (require 'projectile-git-autofetch)
  (projectile-git-autofetch-mode 1)
  (setq-default gac-automatically-push-p t)
  (add-hook 'org-mode-hook
            (lambda ()
              (git-auto-commit-mode 1)))
  (prefer-coding-system 'utf-8)
  (set-default-coding-systems 'utf-8)
  (set-terminal-coding-system 'utf-8-unix)
  (set-keyboard-coding-system 'utf-8)
  (setq default-process-coding-system '(utf-8-unix . utf-8-unix))
  (setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))
  (set-language-environment "UTF-8")
  (prefer-coding-system 'utf-8)
  (add-hook 'term-exec-hook
            (function (lambda ()
                        (set-buffer-process-coding-system 'utf-8-unix
                                                          'utf-8-unix))))
  (global-set-key (kbd "RET")
                  'newline-and-indent)
  (global-set-key "\C-x\ \C-r" 'recentf-open-files)
  (setq custom-safe-themes t)
  (setq company-minimum-prefix-length 1)
  (setq company-idle-delay 0)
  (setq company-require-match nil)
  (setq company-lsp-cache-candidates t)
  (setq helm-multi-swoop-edit-save t)
  (setq helm-swoop-split-with-multiple-windows
        t)
  (setq helm-swoop-split-direction 'split-window-vertically)
  (setq helm-swoop-speed-or-color t)
  (setq xref-show-xrefs-function 'helm-xref-show-defs-27)
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
                                        "TAGS" "GTAGS" ".dropbox" ".projectile"))
  ;; (setq flycheck-display-errors-function 'ide/display-bottom-window)
  (setq mu4e-view-show-images t mu4e-view-show-addresses
        t mu4e-hide-index-messages t)
  ;; (transient-append-suffix 'magit-dispatch "F" '("o" "Fotingo" fotingo-dispatch))
  (set-face-attribute 'hl-line nil ;; :height (+ (face-attribute 'default :height) 30)
                      :bold t
                      :underline t
                      :inherit nil
                      :background nil)
  (with-eval-after-load 'git-gutter+
    (defun git-gutter+-remote-default-directory (dir file)
      (let* ((vec (tramp-dissect-file-name file))
             (method (tramp-file-name-method vec))
             (user (tramp-file-name-user vec))
             (domain (tramp-file-name-domain vec))
             (host (tramp-file-name-host vec))
             (port (tramp-file-name-port vec)))
        (tramp-make-tramp-file-name method user domain
                                    host port dir)))
    (defun git-gutter+-remote-file-path (dir file)
      (let ((file (tramp-file-name-localname (tramp-dissect-file-name file))))
        (replace-regexp-in-string (concat "\\`" dir)
                                  ""
                                  file))))
  (with-eval-after-load 'doom-modeline
    (add-hook 'doom-modeline-mode-hook
              (lambda ()
                (display-time))))
  (define-key yas-keymap (kbd "<return>") 'yas/exit-all-snippets)
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
  ;; (customize-set-variable 'helm-ff-lynx-style-map t)
  ;; (customize-set-variable 'helm-imenu-lynx-style-map t)
  ;; (customize-set-variable 'helm-semantic-lynx-style-map t)
  ;; (customize-set-variable 'helm-occur-use-ioccur-style-keys t)
  ;; (customize-set-variable 'helm-grep-use-ioccur-style-keys t)
  (when (executable-find "curl")
    (setq helm-google-suggest-use-curl-p t))
  (delete-dups extended-command-history)
  (setq history-delete-duplicates t)
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
   ;; custom-set-faces was added by Custom.
   ;; If you edit it by hand, you could mess it up, so be careful.
   ;; Your init file should contain only one such instance.
   ;; If there is more than one, they won't work right.
   '(mode-line ((t (:background "#222226"
                                :foreground "#b2b2b2"
                                :box (:line-width 1 :color "#5d4d7a")))))
   '(mode-line-inactive ((t (:background "gray42"
                                         :foreground "#b2b2b2"
                                         :box (:line-width 1 :color "#5d4d7a"))))))
  ;; (add-hook 'text-mode-hook (lambda ()
  ;;                             (spacemacs/toggle-relative-line-numbers-on)))

  ;; (add-hook 'prog-mode-hook (lambda ()
  ;;                             (spacemacs/toggle-relative-line-numbers-on)))
  (set doom-modeline-buffer-file-name-style 'file-name)
  (setq doc-view-resolution 200
        org-confirm-babel-evaluate
        nil
        org-export-use-babel
        t
        org-export-with-sub-superscripts
        '{}
        org-src-window-setup
        'current-window
        org-latex-listings
        t
        org-latex-listings-langs
        (quote ((emacs-lisp "Lisp")
                (lisp "Lisp")
                (clojure "Lisp")
                (c "C")
                (cc "C++")
                (fortran "fortran")
                (perl "Perl")
                (cperl "Perl")
                (python "Python")
                (ruby "Ruby")
                (html "HTML")
                (xml "XML")
                (tex "TeX")
                (latex "[LaTeX]TeX")
                (shell-script "bash")
                (shell "bash")
                (gnuplot "Gnuplot")
                (ocaml "Caml")
                (caml "Caml")
                (sql "SQL")
                (sqlite "sql")
                (makefile "make")
                (R "r")
                (js "JavaScript")))
        org-latex-listings-options
        (quote (("aboveskip" "0.2\\baselineskip")
                ("frame" "top")
                ("frame" "bottom")
                ("captionpos" "b")
                ("abovecaptionskip" "0.2\\baselineskip")
                ("numbers" "left")
                ("numbersep" "8pt")
                ("numberstyle" "\\tiny\\color{black}")
                ("stepnumber" "1")
                ("breaklines" "true")
                ("framexleftmargin" "5mm")
                ("xleftmargin" "15pt")
                ("showstringspaces" "false")
                ("basicstyle" "\\linespread{0.8}\\tiny\\ttfamily")
                ("keywordstyle" "\\bfseries\\color{mykeywords}")
                ("commentstyle" "\\itshape\\color{purple}")
                ("identifierstyle" "\\color{blue}")
                ("stringstyle" "\\color{orange}")
                ("tabsize" "4")))
        org-support-shift-select
        t
        org-download-image-dir
        "./images"
        ivy-initial-inputs-alist
        '((counsel-minor . "^+")
          (counsel-package . "^+")
          (counsel-org-capture . "")
          (counsel-M-x . "")
          (counsel-describe-symbol . "^")
          (org-refile . "")
          (org-agenda-refile . "")
          (org-capture-refile . "")
          (Man-completion-table . "^")
          (woman . "^"))
        evil-want-Y-yank-to-eol nil
        lsp-enable-file-watchers
        nil
        org-re-reveal-root
        "https://cdn.jsdelivr.net/npm/reveal.js@4.1.0"
        org-re-reveal-revealjs-version
        "4"
        org-re-reveal-plugins
        '(markdown highlight zoom notes search math)
        )
  ;; (custom-set-variables
  ;;  '(doc-view-resolution 200)
  ;;  '(org-confirm-babel-evaluate nil)
  ;;  '(org-export-use-babel nil)
  ;;  '(org-export-with-sub-superscripts '{})
  ;;  '(org-src-window-setup 'split-window-below)
  ;;  '(org-latex-listings t)
  ;;  '(org-latex-listings-langs
  ;;    (quote
  ;;     ((emacs-lisp "Lisp")
  ;;      (lisp "Lisp")
  ;;      (clojure "Lisp")
  ;;      (c "C")
  ;;      (cc "C++")
  ;;      (fortran "fortran")
  ;;      (perl "Perl")
  ;;      (cperl "Perl")
  ;;      (python "Python")
  ;;      (ruby "Ruby")
  ;;      (html "HTML")
  ;;      (xml "XML")
  ;;      (tex "TeX")
  ;;      (latex "[LaTeX]TeX")
  ;;      (shell-script "bash")
  ;;      (shell "bash")
  ;;      (gnuplot "Gnuplot")
  ;;      (ocaml "Caml")
  ;;      (caml "Caml")
  ;;      (sql "SQL")
  ;;      (sqlite "sql")
  ;;      (makefile "make")
  ;;      (R "r")
  ;;      (js "JavaScript"))))
  ;;  '(org-latex-listings-options
  ;;    (quote
  ;;     (("aboveskip" "0.2\\baselineskip")
  ;;      ("frame" "top")
  ;;      ("frame" "bottom")
  ;;      ("captionpos" "b")
  ;;      ("abovecaptionskip" "0.2\\baselineskip")
  ;;      ("numbers" "left")
  ;;      ("numbersep" "8pt")
  ;;      ("numberstyle" "\\tiny\\color{black}")
  ;;      ("stepnumber" "1")
  ;;      ("breaklines" "true")
  ;;      ("framexleftmargin" "5mm")
  ;;      ("xleftmargin" "15pt")
  ;;      ("showstringspaces" "false")
  ;;      ("basicstyle" "\\linespread{0.8}\\tiny\\ttfamily")
  ;;      ("keywordstyle" "\\bfseries\\color{mykeywords}")
  ;;      ("commentstyle" "\\itshape\\color{purple}")
  ;;      ("identifierstyle" "\\color{blue}")
  ;;      ("stringstyle" "\\color{orange}")
  ;;      ("tabsize" "4"))))
  ;;  '(org-support-shift-select t)
  ;;  '(org-download-image-dir "./images")
  ;;  '(dap-ui-controls-mode nil nil (dap-ui))
  ;;  '(ivy-initial-inputs-alist
  ;;    '((counsel-minor . "^+")
  ;;      (counsel-package . "^+")
  ;;      (counsel-org-capture . "")
  ;;      (counsel-M-x . "")
  ;;      (counsel-describe-symbol . "^")
  ;;      (org-refile . "")
  ;;      (org-agenda-refile . "")
  ;;      (org-capture-refile . "")
  ;;      (Man-completion-table . "^")
  ;;      (woman . "^")))
  ;;  '(lsp-enable-file-watchers nil))

  (setq calendar-month-name-array ["January" "February" "March" "April" "May"
                                   "June" "July" "August" "September" "October"
                                   "November" "December"])
  ;; Week days

  (setq calendar-day-name-array ["Sunday" "Monday" "Tuesday" "Wednesday" "Thursday"
                                 "Friday" "Saturday"])
  ;; First day of the week

  (setq calendar-week-start-day 1) ; 0:Sunday, 1:Monday
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

(defun my-org-screenshot ()
  "Take a screenshot into a time stamped unique-named file in the
same directory as the org-buffer and insert a link to this file."
  (interactive)
  (org-display-inline-images)
  (setq filename (concat (make-temp-name (concat (file-name-nondirectory (buffer-file-name))
                                                 "_imgs/"
                                                 (format-time-string "%Y%m%d_%H%M%S_")))
                         ".png"))
  (unless (file-exists-p (file-name-directory filename))
    (make-directory (file-name-directory filename)))
                                        ; take screenshot
  (if (eq system-type 'darwin)
      (call-process "screencapture" nil nil nil
                    "-i" filename))
  (if (eq system-type 'gnu/linux)
      (call-process "import" nil nil nil filename))
                                        ; insert into file if correctly taken
  (if (file-exists-p filename)
      (insert (concat "[[file:" filename "]]"))))
