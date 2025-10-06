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

(defun hackartist/docker/config ())

(defun hackartist/docker/bindings ())
