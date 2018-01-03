(defun my-command-error-function (data context caller)
  "Ignore the buffer-read-only signal; pass the rest to the default handler."
  (when (not (eq (car data) 'buffer-read-only))
    (command-error-default-function data context caller)))

(setq command-error-function #'my-command-error-function)
(provide 'setup-misc)
