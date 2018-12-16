(add-hook 'typescript-mode-hook
          (lambda ()
            (setq typescript-indent-level 2)
            (tide-setup)
            (tide-mode)
            (flycheck-mode)
            ))

(provide 'setup-ts)
