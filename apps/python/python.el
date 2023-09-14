(setq hackartist-python-layers
      '((python :variables python-format-on-save nil python-sort-imports-on-save nil python-test-runner 'pytest python-test-runner '(pytest nose))
        (ipython-notebook :variables ein-backend 'jupyter)))

(setq hackartist-python-packages '())

(defun hackartist/python/init ())

(defun hackartist/python/config ())

(defun hackartist/python/bindings ()
  (add-hook 'python-mode-hook
            (lambda ()
              (spacemacs/set-leader-keys-for-minor-mode 'ein:notebook-mode
                "RET" 'hackartist/python/execute-cell))))

(defun hackartist/python/execute-cell ()
  (interactive)
  (ein:notebook-save-notebook-command-km)
  (ein:worksheet-execute-cell-and-goto-next-km)
  (ein:notebook-save-notebook-command-km))
