(add-hook 'rust-mode-hook
          (lambda ()
            (racer-mode)
            (flycheck-mode)
            ))

(provide 'setup-rust)
