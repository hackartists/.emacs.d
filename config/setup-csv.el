(require 'csv-mode)

(add-hook 'csv-mode-hook
          (lambda ()
            (csv-align-fields)
            (define-key csv-mode-map (kbd "<M-right>") 'csv-forward-field)
            (define-key csv-mode-map (kbd "<M-left>") 'csv-backward-field)
            )
          )

(provide 'setup-csv)
