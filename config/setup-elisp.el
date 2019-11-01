(add-hook 'emacs-lisp-mode-hook
		  '(lambda ()
			 (smartparens-mode t)
			 ))

(provide 'setup-elisp)
