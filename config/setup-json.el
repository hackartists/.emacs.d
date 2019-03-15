(use-package json-mode
  :requires ( flymake-json )
  )

(add-hook 'json-mode
          (lambda ()
            (flymake-mode)
            ))

(provide 'setup-json)


