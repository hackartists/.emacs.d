(core/package/install
 '(
    docker
    docker-tramp
    dockerfile-mode
    flycheck
    yaml-mode
   ))

(defun docker/init ()
  (add-hook 'yaml-mode-hook #'lsp)
  (add-hook 'yaml-mode-hook
	    '(lambda ()
	       (flycheck-mode +1)
	       (company-mode +1)
	       (define-key yaml-mode-map "\C-m" 'newline-and-indent))))
(defun docker/config ())
(defun docker/bindings ())
