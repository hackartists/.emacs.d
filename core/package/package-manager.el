(defun hackartist/core/package/package-install (pkgs)
  (let (res)
    (dolist (el pkgs res)
      (package-install el ))))
