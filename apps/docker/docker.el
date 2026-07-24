(setq hackartist-docker-layers
      '(docker))

(setq hackartist-docker-packages
      '(
        docker
        dockerfile-mode
        yaml-mode
        ))

(defun hackartist/docker/init ()
  (add-hook 'yaml-mode-hook #'lsp)
  (add-hook 'yaml-mode-hook (lambda ()
                              (define-key yaml-mode-map "\C-m" 'newline-and-indent))))

(defun hackartist/docker/config ()
  (custom-set-variables
   '(docker-container-default-sort-key '("Names"))
   '(docker-container-columns
     '(("Names" 40 "{{ json .Names }}" nil nil) ("Id" 16 "{{ json .ID }}" nil nil)
       ("Status" 40 "{{ json .Status }}" nil nil)
       ("Image" 20 "{{ json .Image }}" nil nil)
       ("Command" 30 "{{ json .Command }}" nil nil)
       ("Created" 23 "{{ json .CreatedAt }}" nil
        (lambda (x) (format-time-string "%F %T" (date-to-time x))))
       ("Ports" 10 "{{ json .Ports }}" nil nil)))
   )
  )

(defun hackartist/docker/bindings ())
