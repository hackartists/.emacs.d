(add-hook 'json-mode
          (lambda ()
            (require flymake-json)
            (flymake-mode)
            ))

(provide 'setup-json)


