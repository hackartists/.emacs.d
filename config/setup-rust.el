(use-package rust-mode
  :requires ( flycheck-rust racer cargo )
  )
(add-hook 'rust-mode-hook
          (lambda ()
            (racer-mode)
            (flycheck-mode)
            ))

(provide 'setup-rust)
