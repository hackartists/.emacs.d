;; elpy
;; (elpy-enable)

;; ;; flycheck
;; (require 'flycheck)
;; (require 'py-autopep8)
;; (add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)
;; (add-hook 'elpy-mode-hook 'remove-keys-set-by-global)
;; (add-hook 'elpy-mode-hook 'flycheck-mode)
;; (elpy-use-ipython)

;; ;;pdb setup, note the python version
;; (setq pdb-path '/usr/lib/python2.7/pdb.py
;;       gud-pdb-command-name (symbol-name pdb-path))
;; (defadvice pdb (before gud-query-cmdline activate)
;;   "Provide a better default command line when called interactively."
;;   (interactive
;;    (list (gud-query-cmdline pdb-path
;;                                 (file-name-nondirectory buffer-file-name)))))


;;Simple configurations
;; (elpy-enable)
;; (elpy-use-ipython)

;; ;; use flycheck not flymake with elpy
;; (when (require 'flycheck nil t)
;;   (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
;;   (add-hook 'elpy-mode-hook 'flycheck-mode))

;; ;; enable autopep8 formatting on save
;; (require 'py-autopep8)
;; (add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)


;; IPython
(require 'ein)
(require 'ein-loaddefs)
(require 'ein-notebook)
(require 'ein-subpackages)

(provide 'setup-py)
