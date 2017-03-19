(require 'eclim)
;;(global-eclim-mode)

;;(require 'eclimd)
;; regular auto-complete initialization
;;(require 'auto-complete-config)
;;(ac-config-default)

;; add the emacs-eclim source
(require 'ac-emacs-eclim-source)
(ac-emacs-eclim-config)

(require 'company-emacs-eclim)
(company-emacs-eclim-setup)
;;(global-company-mode t)

(provide 'setup-eclim)
