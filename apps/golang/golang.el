(defun hackartist/golang/init ()
  (add-hook 'go-mode-hook (lambda ()  (require 'dap-go))))

(defun go/pre-init-dap-mode ()
  (add-to-list 'spacemacs--dap-supported-modes 'go-mode))
