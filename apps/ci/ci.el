(setq hackartist-ci-layers '())

(setq hackartist-ci-packages
      '(
        magit-circleci
        ))

(setq hackartist-ci-commands '())

(defun hackartist/ci/init ()
  (hackartist/javascript/dap-react-native-init))

(defun hackartist/ci/config ()
  (add-hook 'js2-mode-hook 'eslintd-fix-mode))

(defun hackartist/ci/bindings () )

(defun hackartist/ci/circle-golog-beautify ()
  (interactive)
  (beginning-of-buffer)
  (replace-string "?" "
?")
  (beginning-of-buffer)
  (replace-string "go: " "
go: ")
  (beginning-of-buffer)
  (replace-string "warning: " "
warning: ")
  (beginning-of-buffer)
  (replace-string "ok " "
ok ")
  (beginning-of-buffer)
  (replace-string "

" "
")
  )
