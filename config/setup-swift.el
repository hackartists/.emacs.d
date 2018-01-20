(add-hook 'swift-mode-hook
          (lambda ()
            (push "~/.emacs.d/refs/company-sourcekit" load-path)
            (require 'company-sourcekit)
            (add-to-list 'company-backends 'company-sourcekit)
            ))

(provide 'setup-swift)
