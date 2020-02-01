(defun core/ui/init ()
    (let ((res)
	(ui-dir (concat emacs-start-directory "/ui")))
      (let ((ui-files (directory-files-recursively ui-dir ".*\.el$")))
	(dolist (el ui-files res)	      
	  (load-file el)))))
      
