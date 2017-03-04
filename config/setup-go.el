(add-to-list 'load-path "~/go/src/github.com/dougm/goflymake")
(require 'go-flycheck)
(require 'go-autocomplete)
(require 'auto-complete-config)
(ac-config-default)


(defun my-go-mode-hook()
  (add-hook 'before-save-hook 'gofmt-before-save)
  (setq gofmt-command "goimports")
  (if (not (string-match "go" compile-command))
      (set (make-local-variable 'compile-command)
                      "go build -v && go test -v && go vet"))
  (local-set-key (kbd "M-.") 'godef-jump)
  (local-set-key (kbd "M-*") 'pop-tag-mark)
  )

(add-hook 'go-mode-hook 'my-go-mode-hook)

(provide 'setup-go)
