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


(defun hackartist/ide/config ()
  (setq shell-file-name "/bin/zsh")
  (setq global-mark-ring-max 50000
        mark-ring-max 50000
        kill-ring-max 50000
        mode-require-final-newline t
        tab-width 4 
        kill-whole-line t
        recentf-max-menu-items 100
        )

  (setq org-enable-github-support t
        org-enable-bootstrap-support t
        org-enable-bootstrap-support t
        org-projectile-file "TODOs.org")

  (add-to-list 'auto-mode-alist '("\\.profile\\'" . shell-script-mode))
  (add-to-list 'auto-mode-alist '("\\.gradle\\'" . gradle-mode))
  (add-to-list 'auto-mode-alist'("README\\.md\\'" . gfm-mode))
  (add-to-list 'auto-mode-alist '("\\<BUILD\\'" . bazel-mode))
  (add-to-list 'auto-mode-alist '("\\<WORKSPACE\\'" . bazel-mode))
  
  (add-hook 'gfm-mode-hook (lambda ()
                             (visual-line-mode 1)))

  (add-hook 'sh-mode-hook (lambda () 
                            (setq tab-width 4)))

  (set-terminal-coding-system 'utf-8)
  (set-keyboard-coding-system 'utf-8)
  (set-language-environment "UTF-8")
  (prefer-coding-system 'utf-8)

  (global-set-key (kbd "RET") 'newline-and-indent)
  (global-set-key "\C-x\ \C-r" 'recentf-open-files)


  (setq custom-safe-themes t)

  (setq company-minimum-prefix-length 1)
  (setq company-idle-delay 0)
  (setq company-require-match nil)
  (setq company-lsp-cache-candidates t)

  (setq helm-multi-swoop-edit-save t)
  (setq helm-swoop-split-with-multiple-windows t)
  (setq helm-swoop-split-direction 'split-window-vertically)
  (setq helm-swoop-speed-or-color t)
  ;; (setq helm-display-function 'ide/display-helm-miniwindow)
  ;; (setq helm-swoop-split-window-function 'ide/display-helm-miniwindow)

  (setq projectile-completion-system 'helm)
  (setq projectile-indexing-method 'alien)
  (setq projectile-git-submodule-command nil)
  (setq projectile-project-root-files '("rebar.config" "project.clj" "build.boot" "SConstruct" "pom.xml" "build.sbt" "gradlew" "build.gradle" ".ensime" "Gemfile" "requirements.txt" "setup.py" "tox.ini" "composer.json" "Cargo.toml" "mix.exs" "stack.yaml" "info.rkt" "DESCRIPTION" "TAGS" "GTAGS" ".dropbox" ".projectile"))
  ;; (setq flycheck-display-errors-function 'ide/display-bottom-window)
  
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
        (tramp-make-tramp-file-name method user domain host port dir))) 
    (defun git-gutter+-remote-file-path (dir file) 
      (let ((file (tramp-file-name-localname (tramp-dissect-file-name file)))) 
        (replace-regexp-in-string (concat "\\`" dir) "" file))))

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

  (add-hook 'diff-mode-hook (lambda () 
                              (setq-local whitespace-style '(face tabs tab-mark spaces space-mark
                                                                  trailing indentation: 
                                                                  :space indentation: 
                                                                  :tab newline newline-mark)) 
                              (whitespace-mode 1)))

  (add-hook 'term-mode-hook (lambda() 
                              (setq yas-dont-activate t)))


  ;; (customize-set-variable 'helm-ff-lynx-style-map t)
  ;; (customize-set-variable 'helm-imenu-lynx-style-map t)
  ;; (customize-set-variable 'helm-semantic-lynx-style-map t)
  ;; (customize-set-variable 'helm-occur-use-ioccur-style-keys t)
  ;; (customize-set-variable 'helm-grep-use-ioccur-style-keys t)
  ;; (when (executable-find "curl")
  ;;   (setq helm-google-suggest-use-curl-p t))

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

  (custom-set-variables
   '(doc-view-resolution 200)
   '(org-latex-listings t)
   '(org-latex-listings-langs
     (quote
      ((emacs-lisp "Lisp")
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
       (gnuplot "Gnuplot")
       (ocaml "Caml")
       (caml "Caml")
       (sql "SQL")
       (sqlite "sql")
       (makefile "make")
       (R "r")
       (js "JavaScript"))))
   '(org-latex-listings-options
     (quote
      (("aboveskip" "0.2\\baselineskip")
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
       ("tabsize" "4"))))
   '(org-support-shift-select t)
   '(lsp-file-watch-threshold 10000)
   ))

(defun ide/display-helm-miniwindow (buffer &optional resume)
  "Display the Helm window respecting `helm-position'."
  (let ((display-buffer-alist
         (list ;; ide-helm-display-help-buffer-regexp
          ;; this or any specialized case of Helm buffer must be
          ;; added AFTER `spacemacs-helm-display-buffer-regexp'.
          ;; Otherwise, `spacemacs-helm-display-buffer-regexp' will
          ;; be used before
          ;; `spacemacs-helm-display-help-buffer-regexp' and display
          ;; configuration for normal Helm buffer is applied for helm
          ;; help buffer, making the help buffer unable to be
          ;; displayed.
          ide-helm-display-buffer-regexp)))
    (helm-default-display-buffer buffer)))
