(use-package docker
  :ensure t
  :requires (dockerfile-mode docker-tramp docker-api docker-cli docker-compose-mode))

(require 'docker-tramp-compat)

(provide 'setup-docker)
