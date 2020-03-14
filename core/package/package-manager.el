;; (setq package-archives '(
;;                          ("melpa" . "https://melpa.org/packages/")
;; 			                   ("gnu" . "https://elpa.gnu.org/packages/")))
;; (setq core/package/list '())

;; (package-initialize)
;; (package-refresh-contents)

(defun core/package/install (pkgs)
  (let (res)
    (dolist (el pkgs res)
      (add-to-list 'core/package/list el)
      (when (not (package-installed-p el))
	(package-install el )))))

(defun core/package/deprecated (pkgs)
  (dolist (el pkgs)
    (when (not (package-built-in-p el))
      (when (package-installed-p el)
	(setq desc
	      (catch 'desc
		(dolist (pl package-alist)
		  (when (eq el (car pl))
		    (throw 'desc (nth 1 pl))))))
	(package-delete desc )))))

;; (defun core/package/prune ()
;;   (let ((res)
;; 	(plist (mapcar 'car package-alist))
;; 	(builtins (mapcar 'car package--builtins)))
;;     (dolist (el core/package/list res)
;;       (setq plist (remq el plist)))
    
;;     (dolist (el builtins res)
;;       (setq plist (remq el plist)))
    
;;     (dolist (el plist res)
;;       (when (package-installed-p el)
;; 	(package-delete el)))))
