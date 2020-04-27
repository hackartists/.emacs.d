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

(defun hackartist/ci/circle-golog-beautify/el (el)
  (beginning-of-buffer)
  (replace-string el (concat "
" el)))

(defun hackartist/ci/circle-golog-beautify ()
  (interactive)
  (dolist (el '("?" "go: ""warning: " "ok " "FAIL " " --- "))
    (hackartist/ci/circle-golog-beautify/el el))
  (beginning-of-buffer)
  (replace-string "

" "
"))
