;; elpy
(elpy-enable)

;; flycheck
(require 'flycheck)
(require 'py-autopep8)
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)
(add-hook 'elpy-mode-hook 'remove-keys-set-by-global)
(add-hook 'elpy-mode-hook 'flycheck-mode)
(elpy-use-ipython)

;;pdb setup, note the python version
(setq pdb-path '/usr/lib/python2.7/pdb.py
      gud-pdb-command-name (symbol-name pdb-path))
(defadvice pdb (before gud-query-cmdline activate)
  "Provide a better default command line when called interactively."
  (interactive
   (list (gud-query-cmdline pdb-path
                                (file-name-nondirectory buffer-file-name)))))

(provide 'setup-py)
