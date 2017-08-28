(require 'fixmee)
;; (require 'rfringe)
 
;;(global-fixmee-mode 1)

(defvar myfixme--timer nil
  "a timer object. For internal use only. Don't set this.")

(defvar myfixme-overlays nil
  "a list of overlays that represent FIXME spots in the buffer.

Applications should not set this value directly. It is intended
for use internally by myfixme.el .
" )

(defcustom myfixme-bg-color "black"
  "A string, the name of a color to use for the background of FIXME
found in buffers with the myfixme minor mode enabled."
  :type 'string
  :group 'myfixme)


(mapc 'make-variable-buffer-local '(myfixme-overlays myfixme--timer))

(defvar myfixme-keyword-re "\\<\\(FIXME\\|TODO\\)\\>"
  "regex for fixme keywords.")

(defun myfixme-clear ()
  "clear highlights and fringe indicators for FIXME notes."
  (interactive)
  (if myfixme-overlays
      (progn
        (mapc (lambda (item)
                (delete-overlay (cdr item)))
               myfixme-overlays)
        (setf myfixme-overlays nil)))
  (if (fboundp 'rfringe-remove-managed-indicators)
      (rfringe-remove-managed-indicators)))


(defun myfixme--place-rfringe-ovlys ()
  "place rfringe overlay bitmaps for each FIXME text overlay."
    (if (and myfixme-overlays
             (fboundp 'rfringe-create-relative-indicator))
      (progn
        (mapc (lambda (item)
                (rfringe-create-relative-indicator (car item)))
               myfixme-overlays))))


(defun myfixme-highlight-fixme-comments-in-region (beg end)
  "highlight FIXME notes in the current buffer.

"
  (if myfixme-mode
      (save-excursion
        (save-match-data
          ;; remove overlays in the changed region.
          ;; we'll scan and recreate them as necessary, next.
          (mapc (lambda (item)
                  (let ((beginning (car item)))
                    ;;(message "examine ovly at %d" beginning)
                    (if (and (>= beginning beg)
                             (<= beginning end))
                        (progn
                          ;;(message "delete ovly at %d" beginning)
                          (setq myfixme-overlays (delq item myfixme-overlays))
                          (delete-overlay (cdr item))))))
                myfixme-overlays)

          ;; remove all fringe overlays unconditionally - will re-add later
          (if (fboundp 'rfringe-remove-managed-indicators)
                (rfringe-remove-managed-indicators))

          (goto-char beg)
          (beginning-of-line)
          (setq case-fold-search nil)
          (let ((pos (re-search-forward myfixme-keyword-re end t)))
            (while pos
              (let* ((m-beg (match-beginning 0))
                     (m-end (match-end 0))
                     (ov (make-overlay m-beg m-end)))
                (overlay-put ov 'face (cons 'background-color myfixme-bg-color))
                (overlay-put ov 'myfixme-overlay t)
                (push (cons m-beg ov) myfixme-overlays)
                (goto-char m-end))
              (setq pos (re-search-forward myfixme-keyword-re end t))))

          ;; Create and display the fringe overlays
          ;; asynchronously. Doing them in a changed event apparently
          ;; doesn't work very well.  Sometimes they get displayed, and
          ;; sometimes not. A timer works out pretty well.
          (run-with-idle-timer 0.5  nil 'myfixme--place-rfringe-ovlys)

          ;; calling this directly from within a change fn apparently
          ;; does not work.
          ;; (myfixme--place-rfringe-ovlys)
          ))))


(defun myfixme-font-lock-after-change-fn (beg end old-length)
  "runs after each change in a buffer with font-lock mode."
  (if myfixme-mode
      (myfixme-highlight-fixme-comments-in-region beg end)))


(defun myfixme--scan-all ()
  "a fn that runs on a timer, it scans the entire buffer for FIXME comments."
  (myfixme-highlight-fixme-comments-in-region (point-min) (point-max)))


;;;###autoload
(define-minor-mode myfixme-mode
  "minor mode to highlight FIXME text in the buffer.
When called interactively, toggles the minor mode.
With arg, turn Flymake mode on if and only if arg is positive."
  :group 'myfixme :lighter " fx"
  (cond

   ;; Turn the mode ON.
   (myfixme-mode
    (myfixme-highlight-fixme-comments-in-region (point-min) (point-max))
    (add-hook 'after-change-functions
              'myfixme-font-lock-after-change-fn)
    (setq myfixme--timer
          (run-with-idle-timer 1.25 t 'myfixme--scan-all)))

   ;; Turn the mode off
   (t
    (myfixme-clear)
    (remove-hook 'after-change-functions
                 'myfixme-font-lock-after-change-fn)
    (if myfixme--timer
        (progn
          (cancel-timer myfixme--timer)
          (setq myfixme--timer nil))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(provide 'setup-todo)
