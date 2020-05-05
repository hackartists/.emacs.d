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
        spell-checking
        semantic shell
        ibuffer imenu-list
        nginx
        syntax-checking
        (treemacs :variables treemacs-collapse-dirs 3
          treemacs-deferred-git-apply-delay      0.5
          treemacs-directory-name-transformer    #'identity
          treemacs-display-in-side-window        t
          treemacs-eldoc-display                 t
          treemacs-file-event-delay              5000
          treemacs-file-follow-delay             0.2
          treemacs-file-name-transformer         #'identity
          treemacs-follow-after-init             t
          treemacs-git-command-pipe              ""
          treemacs-goto-tag-strategy             'refetch-index
          treemacs-indentation                   2
          treemacs-indentation-string            " "
          treemacs-is-never-other-window         t
          treemacs-max-git-entries               5000
          treemacs-missing-project-action        'ask
          treemacs-no-png-images                 nil
          treemacs-no-delete-other-windows       nil
          treemacs-project-follow-cleanup        nil
          treemacs-persist-file                  (expand-file-name ".cache/treemacs-persist" user-emacs-directory)
          treemacs-position                      'left
          treemacs-recenter-distance             0.1
          treemacs-recenter-after-file-follow    nil
          treemacs-recenter-after-tag-follow     nil
          treemacs-recenter-after-project-jump   'always
          treemacs-recenter-after-project-expand 'on-distance
          treemacs-show-cursor                   nil
          treemacs-show-hidden-files             t
          treemacs-silent-filewatch              nil
          treemacs-silent-refresh                nil
          treemacs-sorting                       'alphabetic-asc
          treemacs-space-between-root-nodes      t
          treemacs-tag-follow-cleanup            t
          treemacs-tag-follow-delay              1.5
          treemacs-user-mode-line-format         nil
          treemacs-width                         35)
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
        (kubernetes :variables kubernetes-commands-display-buffer-function 'display-buffer)
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
        highlight2clipboard
        format-all
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
