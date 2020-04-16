(setq hackartist-ide-layers
      '(
        protobuf
        (multiple-cursors :variables multiple-cursors-backend 'mc)
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
        (typescript :variables typescript-fmt-on-save t typescript-fmt-tool 'typescript-formatter typescript-linter 'tslint)
        (shell-scripts :variables shell-scripts-backend 'lsp)
        themes-megapack
        (mu4e :variables mu4e-installation-path "/usr/local/share/emacs/site-lisp" mu4e-use-maildirs-extension t mu4e-enable-async-operations t mu4e-attachment-dir "~/Downloads" mu4e-enable-notifications t mu4e-enable-mode-line t)
        ))

(setq hackartist-ide-packages
      '(
        helm
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
        ghub
        magit-gh-pulls
        ))

(setq hackartist-ide-osc
      '(
        "https://github.com/magoyette/openapi-yaml-mode.git"
        "https://github.com/emacsmirror/multi-eshell.git"
        "https://github.com/domtronn/all-the-icons.el.git"
        "https://github.com/sebastiencs/icons-in-terminal.git"
        "https://github.com/seagle0128/icons-in-terminal.el.git"
        "https://github.com/fgallina/mu4e-multi.git"
        "https://github.com/mack1070101/fotingo-emacs.git"
        ))
