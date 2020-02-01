(core/package/install
 '(
   add-node-modules-path
   company
   eldoc
   emmet-mode
   flycheck
   smartparens
   tide
   typescript-mode
   import-js
   web-mode
   yasnippet
   ))

(defun typescript/init ()
  (add-hook 'add-node-modules-path '(typescript-mode-hook
				     typescript-tsx-mode-hook))
  (add-hook 'typescript-mode-hook #'lsp)
  (add-hook 'typescript-mode-hook
	    (lambda ()
	      (flycheck-mode +1))))

(defun typescript/config ())
(defun typescript/bindings ())
