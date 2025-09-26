(setq hackartist-ide-layers
      '(
        (haskell :variables haskell-enable-hindent t)
        protobuf
        multiple-cursors
        (helm :variables
              history-delete-duplicates t
              history-length 10)
        (git :variables
             git-enable-magit-gitflow-plugin t)
        version-control
        (auto-completion :variables
                         auto-completion-return-key-behavior nil
                         auto-completion-tab-key-behavior nil
                         auto-completion-complete-with-key-sequence nil
                         auto-completion-complete-with-key-sequence-delay 0
                         auto-completion-minimum-prefix-length 0
                         auto-completion-idle-delay 0.2
                         auto-completion-private-snippets-directory nil
                         auto-completion-enable-snippets-in-popup nil
                         auto-completion-enable-help-tooltip nil
                         auto-completion-use-company-box nil
                         auto-completion-use-company-posframe t
                         auto-completion-enable-sort-by-usage nil)
        unicode-fonts
        (markdown :variables markdown-live-preview-engine 'vmd)
        yaml
        (spell-checking :variables enable-flyspell-auto-completion nil)
        shell
        ibuffer imenu-list
        syntax-checking
        sql osx
        bm chrome cmake
        better-defaults
        command-log  csv
        emacs-lisp
        debug
        gpu graphviz typography
        asm  bibtex groovy kotlin
        (latex :variables latex-build-engine 'xetex) ;;php
        (rust :variables rust-format-on-save t cargo-process-reload-on-modify t)
        (shell-scripts :variables shell-scripts-backend 'lsp)
        themes-megapack
        kubernetes
        pass
        calendar
        pdf
        docker
        copy-as-format
        plantuml
        ;; (translate :variables gts-translate-list '(("en" "ko") ("ko" "en")))
        (lsp :variables lsp-ui-doc-enable t lsp-ui-sideline-enable t lsp-auto-guess-root t)
        (dap :variables dap-enable-ui-controls nil)
        ))

(setq hackartist-ide-packages
      '(
        helm-mt
        auto-highlight-symbol
        ox-clip
        git-auto-commit-mode
        exec-path-from-shell

        ;; ace-jump-helm-line
        ;; bazel
        ;; bookmark
        ;; counsel
        ;; direx
        ;; elisp-format
        ;; format-all
        ;; ghub
        ;; gradle-mode
        ;; helm
        ;; helm-ag
        ;; helm-descbinds
        ;; helm-flx
        ;; helm-gtags
        ;; helm-ls-git
        ;; helm-make
        ;; helm-mode-manager
        ;; helm-projectile
        ;; helm-swoop
        ;; helm-tramp
        ;; helm-xref
        ;; helm-wordnet
        ;; helm-dictionary
        ;; highlight2clipboard
        ;; imenu
        ;; magit-find-file
        ;; magit-gh-pulls
        ;; multi-vterm
        ;; persp-mode
        ;; pkg-info
        ;; popup
        ;; popwin
        ;; projectile
        ;; projectile-git-autofetch
        ;; toml-mode
        ;; vdiff
        ;; magit-todos
        ;; shrface
        ;; github-review
        ;; dictionary
        ;; mermaid-mode
        ;; ob-mermaid
        ;; lsp-grammarly
        ;; code-review
        ;; jiralib2
        ;; sqlite3
        ;; greader
        ;; lsp-tailwindcss
        ;; adoc-mode
        ))

(setq hackartist-ide-osc
      '(
        "https://github.com/hackartists/org-api-mode.git"
        "https://github.com/tecosaur/emacs-everywhere.git"
        ))
