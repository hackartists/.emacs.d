(use-package swift-mode
  :requires (xcode-mode flycheck-swift flycheck-swiftlint flycheck-swift3 company-sourcekit )
  )

(add-hook 'swift-mode-hook
          (lambda ()
            ;; (push "~/.emacs.d/refs/company-sourcekit" load-path)
            (add-to-list 'company-backends 'company-sourcekit)

            (flycheck-define-checker swift-lint
              "swift-lint will check errors and idiom of swift language."
              :command ("swiftlint" "lint")
              :error-patterns
              (
               (warning line-start (file-name) ":" line ": warning: " (message) line-end)
               (error line-start (file-name) ":" line ": error: " (message) line-end)
               ;;(info line-start (file-name) ":" (message) line-end)
               )
              :modes (swift-mode))

            (flycheck-select-checker 'swift-lint)
            (flycheck-mode)
            )
          )

(provide 'setup-swift)
