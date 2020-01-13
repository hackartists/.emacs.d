(use-package go-dlv          :ensure t) 
(use-package go-errcheck     :ensure t) 
(use-package go-guru         :ensure t) 
(use-package go-playground   :ensure t) 
(use-package go-snippets     :ensure t) 
(use-package go-rename       :ensure t) 
(use-package gorepl-mode     :ensure t) 
(use-package gotest          :ensure t) 
(use-package go-imenu        :ensure t) 
(use-package go-fill-struct  :ensure t) 
(use-package go-direx        :ensure t) 
(use-package go-add-tags     :ensure t) 
(use-package go-projectile   :ensure t) 
(use-package go-tag          :ensure t) 
(use-package go-stacktracer  :ensure t) 
(use-package go-gen-test     :ensure t) 
(use-package go-imports      :ensure t) 
(use-package go-impl         :ensure t) 
(use-package govet           :ensure t) 

;; (use-package eglot
;;   :ensure t
;;   :after go-mode
;;   :config
;;   (add-to-list 'eglot-server-programs '(go-mode . ("go-langserver"))))

;; (use-package lsp-go
;;   :ensure t
;;   :ensure-system-package (go-langserver . "go get -u github.com/sourcegraph/go-langserver")
;;   :after go-mode)

(defun my-go-mode-hook()
  (add-hook 'before-save-hook 'gofmt-before-save)
  ;; (add-hook 'completion-at-point-functions 'go-complete-at-point)
  (flycheck-select-checker 'go-golint)
  (setq gofmt-command "goimports")
  (setq go-tab-width 4)
  (require 'dap-go)
  (setq flycheck-disabled-checkers '(lsp-ui))
  ;; (if (not (string-match "go" compile-command))
  ;;     (set (make-local-variable 'compile-command)
  ;;          "go build -v && go test -v && go vet"))
  ;; (local-set-key (kbd "M-.") 'godef-jump)
  ;; (local-set-key (kbd "M-*") 'pop-tag-mark)
  ;; (add-to-list 'company-backends 'company-go)
  ;; (flycheck-select-checker 'go-golint)
  ;; (flycheck-mode)
  ;; ;; (require 'go-autocomplete)
  ;; ;; (require 'auto-complete-config)
  ;; ;; (ac-config-default)

  ;; (setq company-tooltip-limit 20)                      ; bigger popup window
  ;; (setq company-idle-delay 0)                         ; decrease delay before autocompletion popup shows
  ;; (setq company-echo-delay 0)                          ; remove annoying blinking
  ;; (setq company-begin-commands '(self-insert-command)) ; start autocompletion only after typing

  ;; (gorepl-mode)
  ;; (yas-minor-mode)
  )

(add-hook 'go-mode-hook 'my-go-mode-hook)


(defun my-go-playground-mode-hook ()
  (define-key go-playground-mode-map (kbd "<M-return>") 'go-playground-exec)
  (define-key go-playground-mode-map (kbd "<s-return>") 'yas-insert-snippet)
  )

(add-hook 'go-playground-mode-hook 'my-go-playground-mode-hook)

(provide 'setup-go)
