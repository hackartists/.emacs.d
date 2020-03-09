(defun hackartist/golang/init ()
  (let ((res)
	(go-envs '("GOPATH" "GOROOT")))
    (dolist (el go-envs res)
      (add-to-list 'ide-environments el)))

  (add-hook 'go-mode-hook
	    (lambda ()
	      (add-hook 'before-save-hook 'gofmt-before-save)
	      (flycheck-mode +1))))
