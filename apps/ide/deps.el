(setq hackartist-ide-layers
      '(
        multiple-cursors
        ivy
        restclient
        git
        version-control
        unicode-fonts
        systemd
        markdown
        (org :variables org-enable-github-support t org-enable-bootstrap-support t org-enable-bootstrap-support t org-projectile-file "TODOs.org")
        confluence
        yaml
        smex spell-checking
        semantic shell
        ibuffer imenu-list
        nginx
        syntax-checking treemacs
        sql osx
        bm chrome cmake
        better-defaults
        command-log  csv
        emacs-lisp
        debug
        gpu graphviz typography
        asm  bibtex groovy kotlin latex php rust
        (python :variables python-format-on-save t python-sort-imports-on-save t python-test-runner 'pytest python-test-runner '(pytest nose))
        (ruby :variables ruby-enable-enh-ruby-mode t ruby-backend 'robe ruby-version-manager 'rvm ruby-test-runner 'rspec)
        ))

(setq hackartist-ide-packages
      '(
        helm
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

(setq hackartist-ide-osc
      '(
        "https://github.com/magoyette/openapi-yaml-mode.git"
        ))
