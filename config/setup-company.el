
(require 'company)
(add-hook 'after-init-hook 'global-company-mode)
(delete 'company-semantic company-backends)
(define-key c-mode-map  [(tab)] 'company-complete)
(define-key c++-mode-map  [(tab)] 'company-complete)
;;(define-key python-mode-map [(tab)] 'company-complete)
;; (add-to-list 'company-backends 'company-c-headers)
;; (add-to-list 'company-backends 'company-jedi)

(provide 'setup-company)
