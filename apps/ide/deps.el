(setq hackartist-ide-layers
      '(
        (haskell :variables haskell-enable-hindent t)
        eww
        protobuf
        multiple-cursors
        ;; (keyboard-layout :variables kl-layout 'dvp)
        ;; ivy
        (helm :variables
              history-delete-duplicates t
              history-length 10)
        (git :variables
             ;; git-enable-magit-delta-plugin t
             ;; git-enable-magit-todos-plugin t
             git-enable-magit-gitflow-plugin t)
        version-control
        ;; github
        (auto-completion :variables
                         auto-completion-return-key-behavior nil
                         auto-completion-tab-key-behavior nil
                         auto-completion-complete-with-key-sequence nil
                         auto-completion-complete-with-key-sequence-delay 0.1
                         auto-completion-minimum-prefix-length 0
                         auto-completion-idle-delay 0.2
                         auto-completion-private-snippets-directory nil
                         auto-completion-enable-snippets-in-popup nil
                         auto-completion-enable-help-tooltip t
                         auto-completion-use-company-box nil
                         auto-completion-use-company-posframe t
                         auto-completion-enable-sort-by-usage nil)
        ;; unicode-fonts
        ;;systemd
        (markdown :variables markdown-live-preview-engine 'vmd)
        ;; confluence
        yaml
        (spell-checking :variables enable-flyspell-auto-completion nil)
        ;; semantic
        shell
        ibuffer imenu-list
        nginx
        syntax-checking
        (treemacs :variables treemacs-use-follow-mode 'tag
                  treemacs-use-git-mode 'deferred
                  treemacs-use-all-the-icons-theme t
                  treemacs-use-filewatch-mode t )
        sql osx
        bm chrome cmake
        better-defaults
        command-log  csv
        emacs-lisp
        debug
        gpu graphviz typography
        asm  bibtex groovy kotlin latex ;;php
        (rust :variables rust-format-on-save t cargo-process-reload-on-modify t)
        (ruby :variables ruby-enable-enh-ruby-mode t ruby-backend 'robe ruby-version-manager 'rvm ruby-test-runner 'rspec)
        (typescript :variables typescript-fmt-on-save t typescript-fmt-tool 'prettier typescript-linter 'eslint)
        (shell-scripts :variables shell-scripts-backend 'lsp)
        themes-megapack
        ;; (mu4e :variables mu4e-installation-path "/usr/local/share/emacs/site-lisp" mu4e-use-maildirs-extension t mu4e-enable-async-operations t mu4e-attachment-dir "~/data/email" mu4e-enable-notifications nil mu4e-enable-mode-line t  mu4e-spacemacs-layout-name "@Mu4e" mu4e-spacemacs-layout-binding "m" mu4e-spacemacs-kill-layout-on-exit t mu4e-org-link-support t mu4e-org-compose-support t)
        kubernetes
        pass
        calendar
        pdf
        copy-as-format
        plantuml
        (translate :variables gts-translate-list '(("en" "ko") ("ko" "en")))
        (lsp :variables lsp-ui-doc-enable nil lsp-ui-sideline-enable t lsp-auto-guess-root t)
        (dap :variables dap-enable-ui-controls nil)
        (ess :variables ess-r-backend 'lsp)))

(setq hackartist-ide-packages
      '(
        ;; magit
        ace-jump-helm-line
        auto-highlight-symbol
        bazel
        bookmark
        counsel
        direx
        elisp-format
        exec-path-from-shell
        format-all
        ghub
        git-auto-commit-mode
        gradle-mode
        helm
        helm-ag
        helm-descbinds
        helm-flx
        helm-gtags
        helm-ls-git
        helm-make
        helm-mode-manager
        helm-mt
        helm-projectile
        helm-swoop
        helm-themes
        helm-tramp
        helm-xref
        highlight2clipboard
        imenu
        magit-find-file
        magit-gh-pulls
        multi-term
        multi-vterm
        ox-clip
        persp-mode
        pkg-info
        popup
        popwin
        projectile
        projectile-git-autofetch
        toml-mode
        vdiff
        docker-compose-mode
        dockerfile-mode
        magit-todos
        helm-eww
	      shrface
        github-notifier
        github-review
        dictionary
        helm-wordnet
        helm-dictionary
        ;; elcord
        ;; evil-avy
        mermaid-mode
        ob-mermaid
        lsp-grammarly
        code-review
        jiralib2
        org-ai
        gptel
        sqlite3
        openwith
	      ))

(setq hackartist-ide-osc
      '(
        "https://github.com/magoyette/openapi-yaml-mode.git"
        "https://github.com/emacsmirror/multi-eshell.git"
        ;; "https://github.com/hackartists/helm-mt.git"
        ;; "https://github.com/domtronn/all-the-icons.el.git"
        ;; "https://github.com/sebastiencs/icons-in-terminal.git"
        ;; "https://github.com/seagle0128/icons-in-terminal.el.git"
        ;; "https://github.com/fgallina/mu4e-multi.git"
        "https://github.com/mack1070101/fotingo-emacs.git"
        "git@github.com:hackartists/org-api-mode.git"
        "https://github.com/flashcode/impostman.git"
        "https://gitgud.io/sakura-chan/discord-emacs-el.git"
        "https://git.savannah.gnu.org/git/elim.git"
        "https://gitlab.com/Titan-C/org-cv.git"
        "https://github.com/nyyManni/ejira.git"
        "https://github.com/tecosaur/emacs-everywhere.git"
        "https://github.com/AllTheLife/Bard.el.git"
        "https://github.com/zerolfx/copilot.el.git"
        ))
