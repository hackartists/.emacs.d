(setq make-backup-files nil)
(setq auto-save-default nil)
;; (setq temporary-file-directory (concat emacs-start-directory "/tmp"))

;; (when (not (file-directory-p temporary-file-directory))
;;   (make-directory temporary-file-directory)
;;   (set-file-modes temporary-file-directory #o700))

;; (setq server-socket-dir temporary-file-directory)

;; (server-start)
(add-hook 'focus-out-hook (lambda ()
			    (interactive)
			    (save-some-buffers t )
			    ))

(add-hook 'configuration-layer-pre-load-hook
          (lambda ()
            (dolist (el hackartist-packages) (add-to-list 'dotspacemacs-additional-packages el))
            ))
