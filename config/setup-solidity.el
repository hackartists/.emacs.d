(require 'solidity-mode)
(require 'flycheck)
(require 'flycheck-tip)

;;(flycheck-tip-use-timer 'verbose)

(setq flycheck-display-errors-function 'ignore)

(flycheck-define-checker solidity-my-checker
 "An solidity syntax checker"
 :command ("solc" source-original)
 :error-patterns
 (
  (warning line-start (file-name) ":" line ":" column ": Warning:" (message) line-end)
  (error line-start (file-name) ":" line ":" column ": Error:" (message) line-end)
  ;;(info line-start (message) line-end)
  )
 :modes (solidity-mode))

(add-hook 'solidity-mode-hook
          (lambda ()
			(flycheck-select-checker 'solidity-my-checker)
            (flycheck-mode)
            ))

(provide 'setup-solidity)
