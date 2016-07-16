
(require 'company)
;;(eval-after-load 'company
;;  '(progn
;;     (define-key company-active-map (kbd "TAB") 'company-select-next)
     ;;     (define-key company-active-map [tab] 'company-select-next)))
;;     (define-key company-active-map (kbd "TAB") 'company-complete)
;;     (define-key company-active-map [tab] 'company-complete)))
(add-hook 'after-init-hook 'global-company-mode)
(delete 'company-semantic company-backends)
;;(define-key c-mode-map  [(tab)] 'company-complete)
;;(define-key c++-mode-map  [(tab)] 'company-complete)
;;(define-key css-mode-map [(tab)] 'company-complete)
;;(define-key python-mode-map [(tab)] 'company-complete)
;(define-key jade-mode [(tab)] 'company-complete)
;; (add-to-list 'company-backends 'company-c-headers)
;; (add-to-list 'company-backends 'company-jedi)

(provide 'setup-company)
