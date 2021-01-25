(defun hackartist/golang/init ()
  (add-hook #'lsp-deferred)
  (add-hook 'go-mode-hook
            (lambda ()
              (require 'dap-go)
              ;; (dap-register-debug-template "Go Debug Integration Configuration"
              ;;                              (list :type "go"
              ;;                                    :request "launch"
              ;;                                    :name "Launch File"
              ;;                                    :mode "auto"
              ;;                                    :program nil
              ;;                                    :buildFlags "-tags integration"
              ;;                                    :args nil
              ;;                                    :env nil
              ;;                                    :envFile nil))
              )))

(defun go/pre-init-dap-mode ()
  (add-to-list 'spacemacs--dap-supported-modes 'go-mode))
