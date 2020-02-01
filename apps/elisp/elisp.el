(core/package/install
 '(
        auto-compile
        company
        eldoc
        elisp-slime-nav
        evil
        evil-cleverparens
        eval-sexp-fu
        flycheck
        flycheck-elsa
        flycheck-package
        ggtags
        counsel-gtags
        helm-gtags
        macrostep
        nameless
        overseer
        parinfer
        rainbow-identifiers
        semantic
        smartparens
        srefactor
   ))

(defun elisp/init ()
  (add-hook 'emacs-lisp-mode-hook
	    (lambda ()
	      (flycheck-mode +1)
	      (eldoc-mode +1))))

(defun elisp/config ())
(defun elisp/bindings ())
