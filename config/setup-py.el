
;; (elpy-use-ipython)

;; ;;pdb setup, note the python version
;; (setq pdb-path '/usr/lib/python2.7/pdb.py
;;       gud-pdb-command-name (symbol-name pdb-path))
;; (defadvice pdb (before gud-query-cmdline activate)
;;   "Provide a better default command line when called interactively."
;;   (interactive
;;    (list (gud-query-cmdline pdb-path
;;                                 (file-name-nondirectory buffer-file-name)))))


(add-hook 'python-mode-hook (lambda ()
                              (require 'py-autopep8)
                              (require 'flycheck)
                              (setq elpy-rpc-python-command "python3")
                              (elpy-mode)
                              (flycheck-mode)
                              (py-autopep8-enable-on-save)
                              (define-key elpy-mode-map (kbd "<C-up>") 'windmove-up)
                              (define-key elpy-mode-map (kbd "<C-down>") 'windmove-down)
                              (define-key elpy-mode-map (kbd "<C-left>") 'windmove-left)
                              (define-key elpy-mode-map (kbd "<C-right>") 'windmove-right)
                              ))

;; IPython
(require 'ein)
(require 'ein-loaddefs)
(require 'ein-notebook)
(require 'ein-subpackages)

(provide 'setup-py)
