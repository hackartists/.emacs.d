(defun hackartist/elixir/init ())


(setq hackartist-elixir-layers
      '(
        (elixir :variables elixir-backend 'alchemist)
        phoenix
        dap
        ))


(defun hackartist/golang/config ()
  (setq flycheck-elxir-credo-strict t)
  )
