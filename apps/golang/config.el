(setq hackartist-golang-envs
      '("GOPATH" "GOROOT"))

(defun hackartist/golang/config ()
  (setq
   go-add-tags-style 'snake-case
   go-tag-args '("-transform" "camelcase" "-add-options" "json=omitempty,bson=omitempty,dynamodbav=omitempty,redis=omitempty")
   lsp-go-codelenses '((generate . t)
                       (gc_details . t)
                       (regenerate_cgo . t)
                       (tidy . t)
                       (upgrade_dependency . t)))

  (lsp-register-custom-settings
   '(("gopls.completeUnimported" t t)
     ("gopls.staticcheck" t t))))
