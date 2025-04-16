(setq hackartist-docker-layers
      '(docker))

(setq hackartist-docker-packages
      '(
        docker
        tramp-container
        dockerfile-mode
        flycheck
        yaml-mode
        ))

(defun hackartist/docker/init ()
  (add-hook 'yaml-mode-hook #'lsp)
  (add-hook 'yaml-mode-hook (lambda ()
                              (flycheck-mode +1)
                              (company-mode +1)
                              (define-key yaml-mode-map "\C-m" 'newline-and-indent))))

(defun hackartist/docker/config ())

(defun hackartist/docker/bindings ())
