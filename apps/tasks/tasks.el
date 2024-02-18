;; Task app requires below layers of spacemacs.
(setq hackartist-ide-layers '())

;; Task app requires additional packages.
(setq hackartist-ide-packages '())

;; Task app requires open source code from github
(setq hackartist-ide-osc '())

(defun hackartist/task/init ()
       "initialization code"
       
       )

(defun hackartist/task/config ()
       "configuration code")

(defun hackartist/task/bindings ()
       "configuration code")

(defun hackartist/task/jira ()
  "interaction with IRA to manage tasks"
  (hackartist/task/jira/projects)
  (hackartist/task/jira/get-issues)
  )

(defun hackartist/task/jira/get-issues (issues)
  (interactive
   (org-jira-get-issue-list hackaritst/task/get-issues-callback))
  (org-jira-log "Fetching issues...")
  (when (> (length issues) 0)
    (org-jira--render-issues-from-issue-list issues)))

(defun hackartist/task/jira/projects ()
  "Get list of projects."
  (interactive)
  (let ((projects-file (expand-file-name "TODOs.org" (org-jira--ensure-working-dir))))
    (or (find-buffer-visiting projects-file)
        (find-file projects-file))
    (org-jira-maybe-activate-mode)
    (save-excursion
      (let* ((oj-projs (jiralib-get-projects)))
        (mapc (lambda (proj)
                (let* ((proj-key (org-jira-find-value proj 'key))
                       (proj-name (org-jira-find-value proj 'name))
                       (proj-url (org-jira-find-value proj 'self))
                       (proj-headline (format "Project: [[%s][%s]]" proj-url proj-name)))
                  (save-restriction
                    (widen)
                    (let (
                          (pmin (org-find-exact-headline-in-buffer "Biyard"))
                           )
                      (goto-char pmin)
                      (org-narrow-to-subtree)
                      (outline-show-all)
                      (setq p (org-find-exact-headline-in-buffer proj-headline))
                      (if (and p (>= p (point-min))
                               (<= p (point-max)))
                          (progn
                            (goto-char p)
                            (org-narrow-to-subtree)
                            (end-of-line))
                        (goto-char (point-max))
                        (unless (looking-at "^")
                          (insert "\n"))
                        (insert "** ")
                        (org-jira-insert proj-headline)
                        (org-narrow-to-subtree))
                      (org-jira-entry-put (point) "name" (org-jira-get-project-name proj))
                      (org-jira-entry-put (point) "key" (org-jira-find-value proj 'key))
                      (org-jira-entry-put (point) "lead" (org-jira-get-project-lead proj))
                      (org-jira-entry-put (point) "ID" (org-jira-find-value proj 'id))
                      (org-jira-entry-put (point) "url" (format "%s/browse/%s" (replace-regexp-in-string "/*$" "" jiralib-url) (org-jira-find-value proj 'key)))))))
              oj-projs)))))

(defvar hackaritst/task/get-issues-callback
  (cl-function
   (lambda (&key data &allow-other-keys)
     "Callback for async, DATA is the response from the request call.

Will send a list of org-jira-sdk-issue objects to the list printer."
     (org-jira-log "Received data for org-jira-get-issue-list-callback.")
     (--> data
          (org-jira-sdk-path it '(issues))
          (append it nil)
          org-jira-sdk-create-issues-from-data-list
          hackartist/task/jira/get-issues))))
