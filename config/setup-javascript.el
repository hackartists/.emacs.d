(add-hook 'js-mode-hook 'js2-minor-mode)
(add-hook 'js-mode-hook
          (lambda()
            (local-set-key (kbd "M-.") 'find-tag)
            ))
(provide 'setup-javascript)
