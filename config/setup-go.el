;;(add-to-list 'load-path "~/go/src/github.com/dougm/goflymake")
;;(require 'go-flycheck)

(require 'flycheck)
(flycheck-define-checker go-checker
  "A Go syntax checker."
  :command ("go" "build")
  :error-patterns
  ((error line-start (file-name) ":" line ": " (message) line-end))
  :modes go-mode
  )

(defun my-go-mode-hook()
  (require 'company-go)
  (add-hook 'before-save-hook 'gofmt-before-save)

  (setq gofmt-command "goimports")
  (if (not (string-match "go" compile-command))
      (set (make-local-variable 'compile-command)
           "go build -v && go test -v && go vet"))
  (local-set-key (kbd "M-.") 'godef-jump)
  (local-set-key (kbd "M-*") 'pop-tag-mark)
  (add-to-list 'company-backends 'company-go)
  (flycheck-select-checker 'go-golint)
  (flycheck-mode)

  ;; (require 'go-autocomplete)
  ;; (require 'auto-complete-config)
  ;; (ac-config-default)

  (setq company-tooltip-limit 20)                      ; bigger popup window
  (setq company-idle-delay 0)                         ; decrease delay before autocompletion popup shows
  (setq company-echo-delay 0)                          ; remove annoying blinking
  (setq company-begin-commands '(self-insert-command)) ; start autocompletion only after typing

  (gorepl-mode)
  )

(add-hook 'go-mode-hook 'my-go-mode-hook)

(provide 'setup-go)
