(define-key input-decode-map "\e[1;5A" [C-up])
(define-key input-decode-map "\e[1;5B" [C-down])

(global-unset-key [C-left])
(global-unset-key [C-right])
(global-unset-key [C-up])
(global-unset-key [C-down])

(global-set-key [C-up] 'windmove-up)
(global-set-key [C-down] 'windmove-down)
(global-set-key [C-left] 'windmove-left)
(global-set-key [C-right] 'windmove-right)

;; (global-set-key (kbd "M-.") 'sp-forward-slurp-sexp)
;; (global-set-key (kbd "M-,") 'sp-forward-barf-sexp)
(global-set-key (kbd "<home>") 'move-beginning-of-line)
(global-set-key (kbd "<end>") 'move-end-of-line)
(global-set-key (kbd "RET") 'newline-and-indent)  ; automatically indent when press RET
(global-set-key (kbd "M-`") 'ecb-open-source-in-editwin2)
;;(global-set-key [(tab)] 'company-complete)

(global-set-key (kbd "<f5>") (lambda ()
                               (interactive)
                               (setq-local compilation-read-command nil)
                               (call-interactively 'compile)))

(defun remove-keys-set-by-global()
  (local-set-key (kbd "<C-letft>") nil)
  (local-set-key (kbd "<C-right>") nil)
  (local-set-key (kbd "<C-up>") nil)
  (local-set-key (kbd "<C-down>") nil)
  (define-key map (kbd "<C-right>") nil)
  (define-key map (kbd "<C-left>") nil)
  (define-key map (kbd "<C-up>") nil)
  (define-key map (kbd "<C-down>") nil)
  )

(add-hook 'shell-mode-hook (lambda()
                             (local-set-key (kbd "<C-up>") 'windmove-up)
                             (local-set-key (kbd "<C-down>") 'windmove-down)
                             )
          )

(provide 'setup-key)
