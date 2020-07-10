(defun hackartist/golang/bindings ()
  (add-hook 'go-playground-mode-hook 'hackartist/golang/playground-keymap))

(defun hackartist/golang/playground-keymap ()
  (define-key go-playground-mode-map (kbd "C-c C-c") 'go-playground-exec)
  )
