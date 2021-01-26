(defun hackartist/golang/bindings ()
  (spacemacs/declare-prefix-for-mode 'go-mode "mm" "movement")
  (spacemacs/set-leader-keys-for-minor-mode 'go-mode
    "rt" 'go-add-tags
    "mf" 'go-goto-function-name
    "mr" 'go-goto-return-values
    "mh" 'go-goto-opening-parenthesis
    )
  (add-hook 'go-playground-mode-hook 'hackartist/golang/playground-keymap))

(defun hackartist/golang/playground-keymap ()
  (define-key go-playground-mode-map (kbd "C-c C-c") 'go-playground-exec)
  )
