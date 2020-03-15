(defun hackartist/golang/bindings ()
  (add-hook 'go-playground-mode-hook 'hackartist/golang/playground-keymap))

(defun hackartist/golang/playground-keymap ()
  (define-key go-playground-mode-map (kbd "<M-return>") 'go-playground-exec)
  (define-key go-playground-mode-map (kbd "<s-return>") 'yas-insert-snippet)
  )
