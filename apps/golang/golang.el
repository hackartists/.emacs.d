(defun hackartist/golang/init ())

(defun go/pre-init-dap-mode ()
  (add-to-list 'spacemacs--dap-supported-modes 'go-mode))
