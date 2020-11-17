(defun hackartist/elixir/init ())


(setq hackartist-elixir-layers
      '(
        (elixir :variables elixir-backend 'lsp elixir-ls-path "/usr/lib/elixir-ls")
        phoenix
        dap
        ))


(defun hackartist/golang/config ()
  (setq flycheck-elxir-credo-strict t)
  )
