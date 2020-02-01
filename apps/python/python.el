(core/package/install
 '(
   company
   dap-mode
   flycheck
   smartparens
   blacken
   cython-mode
   evil-matchit

   lsp-python-ms
   helm-cscope
   importmagic
   live-py-mode
   nose
   py-isort
   stickyfunc-enhance
   xcscope
   yapfify
   
   company-anaconda
   anaconda-mode
   pip-requirements
   pipenv
   pippel
   helm-pydoc

   counsel-gtags
   ggtags
   helm-gtags
   eldoc

   org
   pyenv-mode
   pytest
   pyvenv
   ))

(defun python/init ()
  (add-hook 'python-mode-hook #'lsp)
  (add-hook 'python-mode-hook
	    (lambda ()
	      (flycheck-mode +1))))

(defun python/config ())
(defun python/bindings ())
