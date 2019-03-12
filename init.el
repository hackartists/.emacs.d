(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")
                         ("org" . "http://orgmode.org/elpa/")))
(setq package-list '(
                     gorepl-mode
                     ;;common
                     magit
                     magit-popup

                     ;;setup-android
                     android-mode

                     ;; setup-tex
                     auctex
                     company-auctex

                     ;; setup-ecb
                     ecb

                     ;;setup-company
                     company

                     ;;setup-helm
                     popup
                     helm
                     helm-core
                     helm-swoop

                     ;;setup-helm-gtags
                     helm-gtags

                     ;;setup-projectile
                     pkg-info
                     projectile
                     helm-projectile

                     ;;setup-path
                     exec-path-from-shell

                     ;;setup-erlang
                     flycheck
                     flycheck-tip
                     company-distel

                     ;; setup-go
                     go-dlv
                     go-errcheck
                     go-guru
                     go-mode
                     go-playground
                     go-rename
                     gotest
                     company-go go-imenu go-fill-struct go-direx go-add-tags go-projectile go-tag go-stacktracer go-gen-test go-imports go-impl govet

                     ;;setup-fa
                     function-args

                     ;;setup-cedet
                     semantic
                     cc-mode

                     ;;setup-py
                     elpy
                     py-autopep8
                     realgud

                     ;;setup-jade
                     jade-mode
                     sws-mode

                     ;;setup-utree
                     undo-tree

                     ;;setup-markdown
                     markdown-mode
                     markdown-mode+

                     ;; setup-editing
                     anzu
                     dtrt-indent
                     yasnippet
                     volatile-highlights
                     clean-aindent-mode
                     ws-butler
                     iedit
                     duplicate-thing

                     ;;setup-yaml
                     yaml-mode
                     xcscope

                     ;;setup-fixme
                     fixmee

                     ;; setup-json
                     flymake-json

                     ;; setup-java
                     meghanada
                     
                     ;; setup-javascript
                     xref-js2
                     js2-refactor
                     company-tern
                     helm-xref

                     ;;jdee

                     ;;setup-xcode
                     xcode-mode
                     swift-mode
                     flycheck-swiftlint
                     flycheck-swift3

                     ;; rtags
                     rtags
                     company-rtags

                     ;; jupiter
                     ein
                     ein-mumamo

                     ;; angular
                     angular-mode
                     angular-snippets

                     ;;highlight
                     highlight-symbol

                     ;;etc
                     vdiff
                     diff-hl

                     ;;rfringe

                     ;;docker
                     docker-tramp

                     ;;protobuf
                     protobuf-mode

                     ;;others
                     csv-mode
                     bazel-mode

                     ;;swift
                     swift-mode flycheck-swift company-sourcekit

                     ;; company-sourcekit ;;manually loaded
                     helm-mt
                     multi-term
                     toml-mode
                     dockerfile-mode
                     tabbar
                     helm-swoop
                     highlight-symbol
                     rainbow-delimiters
                     use-package
                     go-autocomplete helm-ag gorepl-mode project-explorer typo visual-regexp bm
                     ;;rust
                     rust-mode flycheck-rust racer cargo

                     ;;typescript
                     ;;tide typescript typescript-mode

					 ;;convenience
					 highlight-blocks
                     )
      )

(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

(setq gc-cons-threshold 100000000)
(setq inhibit-startup-message t)

(defalias 'yes-or-no-p 'y-or-n-p)

(set-frame-parameter nil 'fullscreen 'fullboth)

(add-to-list 'load-path "~/.emacs.d/config")

(require 'setup-path)
(require 'setup-helm)
(require 'setup-helm-gtags)
(require 'setup-cedet)
(require 'setup-editing)
(require 'setup-ecb)
(require 'setup-key)
(require 'setup-company)
(require 'xcscope)
(require 'setup-semantic)
(require 'setup-highlight-line)
(require 'setup-projectile)
(require 'setup-fa)
(require 'setup-py)
(require 'setup-jade)
(require 'setup-go)
(require 'setup-erlang)
(require 'setup-tex)
(require 'setup-face)
(require 'setup-utree)
(require 'setup-c)
(require 'setup-yaml)
(require 'setup-android)
(require 'android)
(require 'setup-markdown)
(require 'setup-path)
;;(require 'setup-todo)
(require 'setup-json)
(require 'setup-javascript)
(require 'setup-java)
(require 'setup-misc)
(require 'setup-swift)
(require 'setup-csv)
(require 'setup-mode)
(require 'setup-html)
(require 'docker-tramp-compat)
(require 'openapi-yaml-mode)
(require 'setup-ext)
(require 'setup-ts)
;; (require 'setup-ggtags)
;;(require 'setup-ac)
;;(require 'setup-smartparens)
;;(require 'setup-font)
(require 'setup-rust)

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
;;(global-linum-mode 1)

(split-window-horizontally)

;;(custom-set-variables
;; custom-set-variables was added by Custom.
;; If you edit it by hand, you could mess it up, so be careful.
;; Your init file should contain only one such instance.
;; If there is more than one, they won't work right.
;; '(ecb-options-version "2.40")
;; '(ecb-source-path
;;   (quote
;;    ("/sshx:hackartist@lab.artofthings.org#10022:" "lab"))))

;;(custom-set-faces
;; custom-set-faces was added by Custom.
;; If you edit it by hand, you could mess it up, so be careful.
;; Your init file should contain only one such instance.
;; If there is more than one, they won't work right.
;;'(highlight-current-line-face ((t (:background "yellow15" :height 400 :family "Nanum Gothic")))))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ac-auto-show-menu t)
 '(ac-auto-start t)
 '(ac-show-menu-immediately-on-auto-complete t)
 '(android-mode-sdk-dir "/Volumes/Data/Developers/android")
 '(default-input-method "korean-hangul")
 '(diff-hl-draw-borders t)
 '(doc-view-continuous t)
 '(ecb-enlarged-compilation-window-max-height 0.8)
 '(ecb-options-version "2.50")
 '(ecb-source-path
   (quote
    (("/" "/")
     ("~/Data/devel/src" "/Devel")
     ("~/Data" "/Data"))))
 '(ecb-stealthy-tasks-delay 30)
 '(ecb-tree-incremental-search (quote prefix))
 '(ecb-use-speedbar-instead-native-tree-buffer nil)
 '(global-diff-hl-mode t)
 '(gud-jdb-command-name "jdb -attach 5005")
 '(jdee-jdk
   (quote /usr/local/Cellar/atlassian-plugin-sdk/6\.3\.12/libexec/repository))
 '(jdee-maven-build-phase
   "com.atlassian.maven.plugins:maven-amps-dispatcher-plugin:6.3.21:debug -gs /usr/local/Cellar/atlassian-plugin-sdk/6.3.12/libexec/apache-maven-3.2.1/conf/settings.xml")
 '(jdee-server-dir "~/.emacs.d/refs/jdee-server")
 '(jdibug-use-jdee-source-paths nil)
 '(package-selected-packages
   (quote
    (ng2-mode lsp-go bats-mode hackernews go-imenu go-fill-struct go-direx go-add-tags go-projectile go-tag go-stacktracer go-gen-test go-imports go-impl docker dropbox company-tern helm-xref lsp-java eclim meghanada company-lsp dap-mode hydra treemacs lsp-ui lsp-mode helm-jira org-jira jira-markup-mode jira web-mode golint go-snippets go-complete govet rustic highlight-blocks rainbow-blocks typescript react-snippets flycheck-swift company-sourcekit cargo racer flycheck-rust rust-mode tide gulp-task-runner typescript-mode nodejs-repl helm-xref helm-ag gorepl-mode project-explorer typo visual-regexp bm rainbow-delimiters helm-mt elscreen tabbar multi-term toml-mode dockerfile-mode helm-core helm swift-mode flycheck-swiftlint flycheck-swift3 bazel-mode osx-plist xcode-project protobuf-mode ecb mvn csv-mode flycheck ctags flymake-shell docker-tramp highlight-symbol pyenv-mode realgud ein-mumamo flymake-json rfringe diff-hl vdiff go-playground go-rename markdown-mode+ android-mode fixmee fixme-mode go-dlv company-go flymake flymake-yaml yaml-mode company-auctex auctex find-temp-file company-distel zygospore xcscope ws-butler volatile-highlights undo-tree tabbar-ruler sws-mode sr-speedbar smartparens py-autopep8 magit jedi jade-mode iedit highlight-current-line helm-swoop helm-projectile helm-gtags go-guru go-errcheck go-autocomplete ggtags function-args flycheck-tip exec-path-from-shell emacs-eclim elpy ein duplicate-thing dtrt-indent company-jedi company-c-headers comment-dwim-2 clean-aindent-mode auto-complete-distel anzu)))
 '(projectile-project-root-files
   (quote
    ("rebar.config" "project.clj" "build.boot" "SConstruct" "pom.xml" "build.sbt" "gradlew" "build.gradle" ".ensime" "Gemfile" "requirements.txt" "setup.py" "tox.ini" "composer.json" "Cargo.toml" "mix.exs" "stack.yaml" "info.rkt" "DESCRIPTION" "TAGS" "GTAGS" ".dropbox")))
 '(treemacs-position (quote right)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
