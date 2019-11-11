
(use-package exec-path-from-shell
  :ensure t)

(setq shell-file-name "/bin/zsh")

(exec-path-from-shell-initialize)
;; (exec-path-from-shell-copy-env "GOROOT")
;; (exec-path-from-shell-copy-env "GOPATH")
;; (exec-path-from-shell-copy-env "ERLPATH")
;; (exec-path-from-shell-copy-env "PATH")
;; (exec-path-from-shell-copy-env "LD_LIBRARY_PATH")

(provide 'setup-path)
