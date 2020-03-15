(setq hackartist-ide-layers
      '(
        helm
        (multiple-cursors :variables multiple-cursors-backend 'mc)
        ivy
        restclient
        git
        version-control
        unicode-fonts
        systemd
        markdown
        (org :variables org-enable-github-support t org-enable-bootstrap-support t org-enable-bootstrap-support t org-projectile-file "TODOs.org")
        ))

(setq hackartist-ide-packages
      '(
        org-jira
        multi-term
        helm-swoop
        helm-projectile
        helm-mt
        exec-path-from-shell
        direx
        elisp-format
        popup helm-xref helm-mt helm-swoop helm-ag helm-tramp helm-gtags
        pkg-info projectile
        vdiff bazel-mode toml-mode
        gradle-mode
        markdown-mode+
        magit
        ))

(setq hackartist-ide-ocs
      '(
        "https://github.com/magoyette/openapi-yaml-mode.git"
        ))
