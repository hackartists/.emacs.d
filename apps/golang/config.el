(setq hackartist-golang-envs
      '("GOPATH" "GOROOT"))

(defun hackartist/golang/config ()
  (setq
   go-add-tags-style 'snake-case
   go-tag-args '("-transform" "camelcase"))
  )
