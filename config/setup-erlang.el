(setq load-path (cons "/usr/local/opt/erl/lib/tools-2.8/emacs" load-path))
(require 'erlang-start)
(setq erlang-root-dir "/usr/local/opt/erl/")
(setq exec-path (cons "/usr/local/opt/erl/bin" exec-path))
(setq erlang-man-root-dir "/usr/local/opt/erl/man")

(require 'flycheck)
(require 'flycheck-tip)
;;(flycheck-tip-use-timer 'verbose)

(setq flycheck-display-errors-function 'ignore)
(push "~/.emacs.d/refs/distel/elisp/" load-path)
(require 'distel)
(distel-setup)

;; auto-complete-mode for erlang
;;(require 'auto)
;;(require 'auto-complete-distel)
;;(add-to-list 'ac-sources 'auto-complete-distel)

;; compnay-mode for erlang
;;(require 'company-distel)
(require 'company-distel)

(flycheck-define-checker erlang-otp
  "An Erlang syntax checker using the Erlang interpreter."
  :command ("erlc" "-o" temporary-directory "-Wall"
            "-I" "../include" "-I" "../../include"
            "-I" "../../../include" source)
  :error-patterns
  ((warning line-start (file-name) ":" line ": Warning:" (message) line-end)
   (error line-start (file-name) ":" line ": " (message) line-end)))

(add-hook 'erlang-mode-hook
          (lambda ()
            (add-to-list 'company-backends 'company-distel)
            ;;(setq company-distel-popup-help t)
            ;;(setq company-distel-popup-height 30)
            ;;(setq inferior-erlang-machine-options '("-sname" "emacs@localhost"))
            (imenu-add-to-menubar "imenu")
            ;;(flycheck-select-checker 'erlang-otp)
            (flycheck-mode)
            ))

(provide 'setup-erlang)
