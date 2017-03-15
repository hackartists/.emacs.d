
(when (memq window-system '(mac ns))
  (exec-path-from-shell-copy-env "GOROOT")
  (exec-path-from-shell-copy-env "GOPATH")
  (exec-path-from-shell-copy-env "ERLPATH")
  (exec-path-from-shell-initialize))

(provide 'setup-path)
