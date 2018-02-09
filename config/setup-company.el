(require 'company)
(eval-after-load 'company
  '(progn
     (define-key company-active-map (kbd "TAB") 'company-complete)
     (define-key company-active-map (kbd "<return>") 'company-abort)
     (define-key company-active-map [tab] 'company-complete)))
;; (add-hook 'after-init-hook 'global-company-mode)
(global-company-mode t)
(setq company-minimum-prefix-length 1)
(setq company-auto-complete t)
(setq company-show-numbers t)
(setq company-idle-delay 0)
(setq company-require-match nil)


(provide 'setup-company)
