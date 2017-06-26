(require 'cc-mode)

(font-lock-add-keywords
 'c-mode
 '(("\\<\\(\\sw+\\) ?(" 1 'font-lock-function-name-face)))

(defun my-c-mode-hook()
  (add-to-list 'company-backends 'company-c-headers)
  ;;(add-to-list 'company-c-headers-path-system "/usr/include/c++/4.2.1/")
  (local-set-key "\C-c\C-j" 'semantic-ia-fast-jump)
  (local-set-key "\C-c\C-s" 'semantic-ia-show-summary)
  (setq-default c-basic-offset 4
                tab-width 4
                indent-tabs-mode t)
  (setq c-default-style "linux")
  )

(add-hook 'c-mode-common-hook 'my-cedet-hook)
(add-hook 'c-mode-hook 'my-c-mode-hook)
(add-hook 'c++-mode-hook 'my-c-mode-hook)


(provide 'setup-c)
