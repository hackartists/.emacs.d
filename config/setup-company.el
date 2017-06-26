
(require 'company)
(eval-after-load 'company
  '(progn
;;     (define-key company-active-map (kbd "TAB") 'company-select-next)
     ;;     (define-key company-active-map [tab] 'company-select-next)))
     (define-key company-active-map (kbd "TAB") 'company-complete)
     (define-key company-active-map [tab] 'company-complete)))
;; (add-hook 'after-init-hook 'global-company-mode)
(global-company-mode t)

;;(set 'company-auto-complete t)
(setq company-idle-delay 0)
(setq company-require-match nil)

;;(define-key company-active-map (kbd "TAB") 'company-complete)
;;(local-set-key [(tab)] 'company-complete)



;; (add-hook 'org-mode-hook
;;           (lambda ()
;;             (setq-local company-backends '((company-files company-dabbrev)))))

;; (add-hook 'emacs-lisp-mode-hook
;;           (lambda ()
;;             (setq-local company-backends '((company-capf company-dabbrev-code)))))
;;(define-key )

;; auto-comple
;; (defun company-complete-common-or-cycle ()
;;   (interactive)
;;   (when (company-manual-begin)
;;     (if (eq last-command 'company-complete-common-or-cycle)
;;         (let ((company-selection-wrap-around t))
;;           (call-interactively 'company-select-next))
;;       (call-interactively 'company-complete-common))))

;; (define-key company-active-map [tab] 'company-complete-common-or-cycle)
;; (define-key company-active-map (kbd "TAB") 'company-complete-common-or-cycle)
;;(delete 'company-semantic company-backends)
;;(define-key c-mode-map  [(tab)] 'company-complete)
;;(define-key c++-mode-map  [(tab)] 'company-complete)
;;(define-key css-mode-map [(tab)] 'company-complete)
;;(define-key python-mode-map [(tab)] 'company-complete)
;(define-key jade-mode [(tab)] 'company-complete)
;; (add-to-list 'company-backends 'company-jedi)

(provide 'setup-company)
