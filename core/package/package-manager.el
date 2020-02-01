(setq package-archives '(
                         ("melpa" . "https://melpa.org/packages/")
			                   ("gnu" . "https://elpa.gnu.org/packages/")))
(package-initialize)
(package-refresh-contents)

(defun hackartist/core/package/package-install (pkgs)
  (let (res)
    (dolist (el pkgs res)
      (when (not (package-installed-p el))
	(package-install el )))))
