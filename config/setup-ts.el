(use-package tide
  :ensure-system-package ((tslint "npm install -g tslint")
                          (tslint-eslint-rules "npm install -g tslint-eslint-rules")
                          (tslint-config-prettier "npm install -g tslint-config-prettier")
                          (tide "npm install -g tide")
                          (typescript "npm install -g typescript"))
  )

(add-hook 'typescript-mode-hook
          (lambda ()
            (setq typescript-indent-level 2)
            (tide-setup)
            (tide-mode)
            (flycheck-mode)
            ))

(provide 'setup-ts)
