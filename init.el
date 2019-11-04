;; (setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
;;                          ("melpa" . "https://melpa.org/packages/")
;;                          ("org" . "http://orgmode.org/elpa/")))

;; (condition-case nil
;;     (require 'use-package)
;;   (file-error
;;    (require 'package)
;;    (add-to-list 'package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
;;                                     ("melpa" . "https://melpa.org/packages/")
;;                                     ("org" . "http://orgmode.org/elpa/")))
;;    (package-initialize)
;;    (package-refresh-contents)
;;    (package-install 'use-package)
;;    (require 'use-package)))

;; (setq package-list '(realgud-jdb helm-directory jdecomp jdee jenkins java-imports java-snippets kotlin-mode groovy-mode gradle-mode json-navigator ng2-mode bats-mode hackernews go-imenu go-fill-struct go-direx go-add-tags go-projectile go-tag go-stacktracer go-gen-test go-imports go-impl docker dropbox company-tern helm-xref lsp-java eclim meghanada company-lsp dap-mode hydra treemacs lsp-ui lsp-mode helm-jira org-jira web-mode golint go-snippets go-complete govet rustic highlight-blocks rainbow-blocks react-snippets flycheck-swift company-sourcekit cargo racer flycheck-rust rust-mode tide gulp-task-runner typescript-mode nodejs-repl helm-xref helm-ag gorepl-mode project-explorer typo visual-regexp bm rainbow-delimiters helm-mt elscreen tabbar multi-term toml-mode dockerfile-mode helm-core helm swift-mode flycheck-swiftlint flycheck-swift3 bazel-mode protobuf-mode ecb mvn csv-mode flycheck flymake-shell docker-tramp highlight-symbol pyenv-mode realgud ein-mumamo flymake-json diff-hl vdiff go-playground go-rename markdown-mode+ android-mode fixmee go-dlv company-go flymake flymake-yaml yaml-mode company-auctex auctex find-temp-file company-distel zygospore xcscope ws-butler volatile-highlights undo-tree tabbar-ruler sws-mode sr-speedbar smartparens py-autopep8 magit jedi jade-mode iedit helm-swoop helm-projectile helm-gtags go-guru go-errcheck go-autocomplete ggtags function-args flycheck-tip exec-path-from-shell elpy ein duplicate-thing dtrt-indent company-jedi company-c-headers comment-dwim-2 clean-aindent-mode auto-complete-distel anzu use-package ))

;;(package-initialize)
;; (unless package-archive-contents
;;   (package-refresh-contents))

;; (dolist (package package-list)
;;   (unless (package-installed-p package)
;;     (package-install package)))

;; (setq gc-cons-threshold 100000000)
;; (setq inhibit-startup-message t)

(defalias 'yes-or-no-p 'y-or-n-p)
(switch-to-buffer "*scratch*")

(add-to-list 'load-path "~/.emacs.d.hackartists/config")
(add-to-list 'load-path "~/.emacs.d.hackartists/refs/jdibug")
(set-frame-parameter nil 'fullscreen 'fullboth)
(setq 'browse-url-chrome-program "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome")

;;(require 'setup-dev)
(require 'setup-docker)
(require 'setup-path)
(require 'setup-helm)
;;(require 'setup-helm-gtags)
;;(require 'setup-cedet)
(require 'setup-editing)
;;(require 'setup-ecb)
(require 'setup-key)
(require 'setup-company)
;;(require 'xcscope)
;;(require 'setup-semantic)
;;(require 'setup-highlight-line)
(require 'setup-projectile)
;; (require 'setup-fa)
;; (require 'setup-py)
;; (require 'setup-jade)
(require 'setup-go)
;; (require 'setup-erlang)
;; (require 'setup-tex)
;; (require 'setup-face)
;; (require 'setup-utree)
;; (require 'setup-c)
;; (require 'setup-yaml)
;; (require 'setup-android)
;; (require 'android)
;; (require 'setup-markdown)
;; (require 'setup-path)
;; (require 'setup-todo)
;; (require 'setup-json)
;; (require 'setup-javascript)
(require 'setup-java)
;; (require 'setup-misc)
;; (require 'setup-swift)
;; (require 'setup-csv)
;; (require 'setup-mode)
;; (require 'setup-html)
;; (require 'docker-tramp-compat)
;; (require 'openapi-yaml-mode)
;; (require 'setup-ext)
;; (require 'setup-ts)
;; (require 'setup-rust)
;; (require 'setup-gradle)
;; (require 'setup-magit)
;; (require 'setup-global)
;; (require 'setup-elisp)

(setq warning-minimum-level :emergency)
(add-hook 'c-mode-common-hook 'hs-minor-mode)
(add-hook 'prog-mode-hook (lambda () (interactive) (setq show-trailing-whitespace 1)))

(setq make-backup-files nil)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

(setq
 gdb-many-windows t
 gdb-show-main t
 )

(cua-mode 1)
(server-start)
(split-window-horizontally)
(windmove-right)
(clm/toggle-command-log-buffer)
(global-command-log-mode)
(windmove-left)
 ;; '(projectile-project-root-files
 ;;   '("rebar.config" "project.clj" "build.boot" "SConstruct" "pom.xml" "build.sbt" "gradlew" "build.gradle" ".ensime" "Gemfile" "requirements.txt" "setup.py" "tox.ini" "composer.json" "Cargo.toml" "mix.exs" "stack.yaml" "info.rkt" "DESCRIPTION" "TAGS" "GTAGS" ".dropbox")))

;; (custom-set-faces
;;  ;; custom-set-faces was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(default ((t (:inherit nil :stipple nil :background "black" :foreground "white" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 140 :width normal :foundry "nil" :family "GulimChe")))))
