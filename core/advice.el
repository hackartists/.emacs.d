(advice-add 'spacemacs-buffer//choose-banner :override #'hackartist-buffer//choose-banner)
(advice-add 'spacemacs-buffer//notes-insert-note :override #'hackartist-buffer//notes-insert-note)
(advice-add 'spacemacs-buffer//insert-buttons :override #'hackartist-buffer//insert-buttons)
(advice-add 'spacemacs-buffer//insert-footer :override #'hackartist-buffer//insert-footer)
(advice-add 'spacemacs-buffer//insert-projects :override #'hackartist-buffer//insert-projects)

(defun hackartist-buffer//choose-banner ()
  (concat emacs-start-directory "/banner.txt"))

(defun hackartist-buffer//notes-insert-note
    (file topcaption botcaption &optional additional-widgets)
  "Insert the release note just under the banner.
FILE: the file that contains the content to show.
TOPCAPTION: the title of the note.
BOTCAPTION: a text to be encrusted at the bottom of the frame.
ADDITIONAL-WIDGETS: a function for inserting a widget under the frame."
  (save-excursion
    (goto-char (point-min))
    (search-forward "Search in Hackartist Emacs\]")
    (forward-line)
    (let* ((buffer-read-only nil)
           (note (concat "\n"
                         (spacemacs-buffer//notes-render-framed-text file
                                                                     topcaption
                                                                     botcaption
                                                                     2
                                                                     nil
                                                                     80))))
      (save-restriction
        (narrow-to-region (point) (point))
        (add-to-list 'spacemacs-buffer--note-widgets (widget-create 'text :format "%v" note))
        (let* ((width (spacemacs-buffer//get-buffer-width))
               (padding (max 0 (floor (/ (- spacemacs-buffer--window-width
                                            width) 2)))))
          (goto-char (point-min))
          (while (not (eobp))
            (beginning-of-line)
            (insert (make-string padding ?\s))
            (forward-line))))
      (save-excursion
        (while (re-search-backward "\\[\\[\\(.*\\)\\]\\]" nil t)
          (make-text-button (match-beginning 1)
                            (match-end 1)
                            'type 'help-url
                            'help-args (list (match-string 1)))))
      (funcall additional-widgets)
      (spacemacs-buffer//center-line)
      (delete-trailing-whitespace (line-beginning-position)
                                  (line-end-position)))))


(defun hackartist-buffer//insert-buttons ()
  "Create and insert the interactive buttons under Spacemacs banner."
  (goto-char (point-max))
  (spacemacs-buffer||add-shortcut "m" "[?]" t)
  (widget-create 'url-link
                 :tag (propertize "?" 'face 'font-lock-doc-face)
                 :help-echo "Open the quickhelp."
                 :action (lambda (&rest ignore)
                           (spacemacs-buffer/toggle-note 'quickhelp))
                 :mouse-face 'highlight
                 :follow-link "\C-m")
  (insert " ")
  (widget-create 'url-link
                 :tag (propertize "Homepage" 'face 'font-lock-keyword-face)
                 :help-echo "Open the Hackartist Emacs GitHub page in your browser."
                 :mouse-face 'highlight
                 :follow-link "\C-m"
                 "http://github.com/hackartist/.emacs.d")
  (insert " ")
  (widget-create 'push-button
                 :help-echo "Update all ELPA packages to the latest versions."
                 :action (lambda (&rest ignore)
                           (configuration-layer/update-packages))
                 :mouse-face 'highlight
                 :follow-link "\C-m"
                 (propertize "Update Packages" 'face 'font-lock-keyword-face))
  (insert " ")
  (widget-create 'push-button
                 :help-echo
                 "Rollback ELPA package updates if something got borked."
                 :action (lambda (&rest ignore)
                           (call-interactively 'configuration-layer/rollback))
                 :mouse-face 'highlight
                 :follow-link "\C-m"
                 (propertize "Rollback Package Update"
                             'face 'font-lock-keyword-face))
  (let ((len (- (line-end-position)
                (line-beginning-position))))
    (spacemacs-buffer//center-line)
    (setq spacemacs-buffer--buttons-position (- (line-end-position)
                                                (line-beginning-position)
                                                len)))
  (insert "\n")
  (widget-create 'url-link
                 :tag (propertize "Search in Hackartist Emacs"
                                  'face 'font-lock-function-name-face)
                 :help-echo "Search Hackartist Emacs contents."
                 :action
                 (lambda (&rest ignore)
                   (let ((comp-frontend
                          (cond
                           ((configuration-layer/layer-used-p 'helm)
                            'helm-spacemacs-help)
                           ((configuration-layer/layer-used-p 'ivy)
                            'ivy-spacemacs-help))))
                     (call-interactively comp-frontend)))
                 :mouse-face 'highlight
                 :follow-link "\C-m")
  (spacemacs-buffer//center-line)
  (insert "\n"))

(defun hackartist-buffer//insert-footer ()
  "Insert the footer of the home buffer."
  (save-excursion
    (let* (
           (develop "Developed by Hackartist and based on Spacemacs")
           (thanks "Thanks to Spacemacs community")
           (buffer-read-only nil))
        (goto-char (point-max))
        (spacemacs-buffer/insert-page-break)
        (insert "\n")
        (insert develop)
        (spacemacs-buffer//center-line (length develop))
        (insert "\n\n")
        (insert thanks)
        (spacemacs-buffer//center-line (length thanks))
        (insert "\n"))))

(defun hackartist-buffer//insert-projects-list (list-display-name list)
    (when (car list)
    (insert list-display-name)
    (let ((list-nr 1))
      (mapc (lambda (el)
              (insert "\n    ")
              (let ((button-text (concat (abbreviate-file-name el))))
                (widget-create 'push-button
                               :action `(lambda (&rest ignore)
                                          (hackartist//helm-projectile-find-file-on-project ,el))
                               :mouse-face 'highlight
                               :follow-link "\C-m"
                               :button-prefix ""
                               :button-suffix ""
                               :format "%[%t%]"
                               button-text))
              (setq list-nr (1+ list-nr)))
            list))))


(defun hackartist//helm-projectile-find-file-on-project (root)
  "Find file at point based on context."
  (interactive)
  (let* ((project-root (projectile-project-root root))
         (project-files (projectile-project-files (projectile-acquire-root root)))
         (files (projectile-select-files project-files)))
    (if (= (length files) 1)
        (find-file (expand-file-name (car files) (projectile-project-root)))
      (helm :sources (helm-build-sync-source "Projectile files"
                       :candidates (if (> (length files) 1)
                                       (helm-projectile--files-display-real files project-root)
                                     (helm-projectile--files-display-real project-files project-root))
                       :fuzzy-match helm-projectile-fuzzy-match
                       :action-transformer 'helm-find-files-action-transformer
                       :keymap helm-projectile-find-file-map
                       :help-message helm-ff-help-message
                       :mode-line helm-read-file-name-mode-line-string
                       :action helm-projectile-file-actions
                       :persistent-action #'helm-projectile-file-persistent-action
                       :persistent-help "Preview file")
            :buffer "*helm projectile*"
            :truncate-lines helm-projectile-truncate-lines
            :prompt (projectile-prepend-project-name "Find file: ")))))

(defun hackartist-buffer//insert-projects (list-size)
  (unless projectile-mode (projectile-mode))
  (when (hackartist-buffer//insert-projects-list
         "Projects:"
         (spacemacs//subseq (projectile-relevant-known-projects)
                            0 list-size))
    (spacemacs-buffer||add-shortcut "p" "Projects:")
    (insert spacemacs-buffer-list-separator)))
