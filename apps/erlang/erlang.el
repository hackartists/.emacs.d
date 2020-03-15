(setq hackartist-erlang-layers '(erlang))
(setq hackartist-erlang-packages '(company-distel))
(setq hackartist-erlang-osc '(
                              "https://github.com/massemanet/distel.git"
                              ))

(defun hackartist/erlang/init ( )
  (add-hook 'erlang-mode-hook
          (lambda ()
            (setq load-path (cons "/usr/local/opt/erl/lib/tools/emacs" load-path))
            (require 'erlang-start)
            (setq erlang-root-dir "/usr/local/opt/erl/")
            (setq exec-path (cons "/usr/local/opt/erl/bin" exec-path))
            (setq erlang-man-root-dir "/usr/local/opt/erl/man")

            (require 'flycheck)
            (require 'flycheck-tip)

            ;;(flycheck-tip-use-timer 'verbose)

            (setq flycheck-display-errors-function 'ignore)
            (push (concat hackartist-vendor-dir "/distel/elisp/")  load-path)
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
              :command ("erlc" "-o" temporary-directory "-Wall" "-pa" "../deps/lager/ebin"
                        "-pa" "../deps/fast_xml/ebin" "-pa" "../deps/social_thrift/ebin" "-I" "../include" source-original)
              :error-patterns
              (
               (warning line-start (file-name) ":" line ": Warning:" (message) line-end)
               (error line-start (file-name) ":" line ": " (message) line-end)
               ;;(info line-start (file-name) ":" (message) line-end)
               )
              :modes (erlang-mode))


            (add-to-list 'company-backends 'company-distel)
            (local-set-key (kbd "RET") 'newline-and-indent)
            ;;(add-to-list 'flycheck-erlang-include-path "../include")
            ;;(setq company-distel-popup-help t)
            ;;(setq company-distel-popup-height 30)
            ;;(setq inferior-erlang-machine-options '("-sname" "emacs@localhost"))
            (imenu-add-to-menubar "imenu")
            (flycheck-select-checker 'erlang-otp)
            (flycheck-mode)
            ))
  )
