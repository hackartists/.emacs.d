(add-hook 'emacs-lisp-mode-hook
		  '(lambda ()
			 (show-smartparens-mode t)
			 ))

(provide 'setup-elisp)
