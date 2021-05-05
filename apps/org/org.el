(setq hackartist-org-layers
      '(
        (restclient :variables restclient-use-org t)
        (org :variables org-enable-github-support t org-enable-bootstrap-support t org-projectile-file "TODOs.org" org-enable-hugo-support t org-enable-epub-support t  org-enable-reveal-js-support t org-enable-jira-support t org-enable-org-journal-support t org-enable-roam-server t org-enable-roam-protocol t))
      )

(setq org-src-lang-modes '())

(setq hackartist-org-packages
      '(
        ob-async
        ob-go
        ob-mongo
        html2org
        plantuml-mode
        helm-org
        ))

(setq hackartist-org-osc '())

(defun hackartist/ide/advice-before/org-export-to-file (backend file &optional async subtreep visible-only body-only ext-plist post-process)
  (delete-file file))

(defun hackartist/ide/advice-before/org-hugo-export-wim-to-md (&optional all-subtrees async visible-only noerror)
  (advice-add 'org-export-to-file :before #'hackartist/ide/advice-before/org-export-to-file))

(defun hackartist/ide/advice-after/org-hugo-export-wim-to-md (&optional all-subtrees async visible-only noerror)
  (advice-remove 'org-export-to-file #'hackartist/ide/org-hugo-export-wim-to-md-before-hook))

(defun hackartist/org/init ()
  "initialization code"
  ;; (add-hook 'org-mode-hook
  ;;           (lambda ()
  ;;             (git-auto-commit-mode 1)))
  (advice-add 'org-hugo-export-wim-to-md :before #'hackartist/ide/advice-before/org-hugo-export-wim-to-md)
  (advice-add 'org-hugo-export-wim-to-md :after #'hackartist/ide/advice-after/org-hugo-export-wim-to-md)
  (org-add-link-type
   "image-url"
   (lambda (path)
     (let ((img (expand-file-name
                 (concat (md5 path) "." (file-name-extension path))
                 temporary-file-directory)))
       (if (file-exists-p img)
           (find-file img)
         (url-copy-file path img)
         (find-file img)))))
  )

(defun hackartist/org/config/darwin ()
  (setq org-ditaa-jar-path "/usr/local/Cellar/ditaa/0.11.0_1/libexec/ditaa-0.11.0-standalone.jar"))

(defun hackartist/org/config/linux ()
  (setq org-ditaa-jar-path "/usr/share/java/ditaa/ditaa-0.11.jar"))


(defun hackartist/org/config ()
  "configuration code"
  (if (eq system-type 'darwin)
      (hackartist/org/config/darwin)
    (hackartist/org/config/linux))

  (add-hook 'org-mode-hook 'toc-org-mode)
  (add-to-list 'org-tag-alist '("TOC" . ?T))
  (require 'ob-api)
  (require 'ob-api-mode)
  (require 'ob-async)
  (require 'ob-go)

  (set-face-attribute 'org-table nil
                      :family "D2Coding"
                      :weight 'normal
                      :width 'normal)
  (org-babel-do-load-languages
   'org-babel-load-languages
   `(,@org-babel-load-languages (plantuml . t) (ditaa . t) (api . t)))

  (add-to-list 'org-src-lang-modes '("plantuml" . plantuml))
  (add-hook 'plantuml-mode (lambda ()  (auto-complete-mode t)))

  (setq org-enable-github-support t
        org-enable-bootstrap-support t
        org-enable-bootstrap-support t
        org-projectile-file "TODOs.org"
        org-image-actual-width t
        org-plantuml-exec-mode 'jar
        plantuml-exec-mode 'jar
        plantuml-jar-path (expand-file-name "~/plantuml.jar")
        org-plantuml-jar-path (expand-file-name "~/plantuml.jar"))

  (setq doc-view-resolution 200
        org-confirm-babel-evaluate nil
        org-export-use-babel t
        org-export-with-sub-superscripts '{}
        org-src-window-setup 'current-window
        org-latex-listings t
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
        org-support-shift-select t
        org-download-image-dir "./images"
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
        lsp-enable-file-watchers nil
        org-re-reveal-root "https://cdn.jsdelivr.net/npm/reveal.js@4.1.0"
        org-re-reveal-revealjs-version "4"
        org-re-reveal-plugins '(markdown highlight zoom notes search math)
        )

  )

(defun hackartist/org/bindings ()
  "setting for org-hydra"
  (defhydra org-hydra
    (:color pink)
    "ORG hydra mode
"
    ("f" org-previous-visible-heading "previous visible heading")
    ("F" org-next-visible-heading "next visible heading")
    ("j" org-forward-heading-same-level "next same-level heading")
    ("k" org-backward-heading-same-level "previous same-level heading")
    ("h" outline-up-heading "go to parent heading")
    ("l" org-next-visible-heading "next visible heading")
    ("q" nil "quit" :color blue))
  (spacemacs/set-leader-keys-for-minor-mode
    'org-mode "." 'org-hydra/body)
  (define-key org-mode-map (kbd "<M-return>") nil)
  (define-key org-mode-map (kbd "<M-S-up>") nil)
  (define-key org-mode-map (kbd "<M-S-down>") nil)
  (define-key org-mode-map (kbd "<M-up>") nil)
  (define-key org-mode-map (kbd "<M-down>") nil)
  (define-key org-mode-map (kbd "<M-S-left>") nil)
  (define-key org-mode-map (kbd "<M-S-right>") nil)
  (define-key org-mode-map (kbd "<M-left>") nil)
  (define-key org-mode-map (kbd "<S-left>") nil)
  (define-key org-mode-map (kbd "<S-right>") nil)
  (define-key org-mode-map (kbd "<S-up>") nil)
  (define-key org-mode-map (kbd "<S-down>") nil)
  (define-key org-mode-map (kbd "<M-right>") nil)
  (define-key org-mode-map (kbd "C-<tab>") nil)
  (define-key org-mode-map (kbd "C-S-<tab>") nil)
  (define-key org-mode-map (kbd "<C-up>") nil)
  (define-key org-mode-map (kbd "<C-down>") nil)
  (define-key org-mode-map (kbd "RET") nil))

(defun image-url-overlays ()
"Put image overlays on remote image urls."
(interactive)
(loop for image-url in (org-element-map (org-element-parse-buffer) 'link
                         (lambda (link)
                           (when (string= "image-url" (org-element-property :type link))
                             link)))
      do
      (let* ((path (org-element-property :path image-url))
             (ov (make-overlay (org-element-property :begin image-url)
                               (org-element-property :end image-url)))
             (img (create-image (expand-file-name
                                 (concat (md5 path)
                                         "."
                                         (file-name-extension
                                          path))
                                 temporary-file-directory))))
        (overlay-put ov 'display img)
        (overlay-put ov 'image-url t))))

(defun image-url-clear-overlays ()
  "Reove overlays on image-urls."
  (interactive)
  (require 'ov)
  (ov-clear 'image-url))
