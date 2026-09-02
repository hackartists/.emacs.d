(setq hackartist-ai-layers
      '(
        github-copilot
        ))

(setq hackartist-ai-packages
      '(
        copilot-chat
        eat
        gptel
        claudemacs
        ellama
        acp
        agent-shell
        ))


(setq hackartist-ai-osc
      '(
        "https://github.com/cpoile/claudemacs.git"
        ))

(defun hackartist/ai/init ()
  (require 'claudemacs)

  (use-package claudemacs
    :vc (:url "https://github.com/cpoile/claudemacs.git"
              :rev :newest
              :branch "main"))

  (use-package eat
    :vc (:url "https://codeberg.org/akib/emacs-eat"
              :rev :newest
              :branch "master"))

  ;; agent-shell + Hermes (ACP): Hermes → LiteLLM(:4000) → Ollama/Claude
  ;; 실행: M-x agent-shell-hermes-start-agent (또는 leader ", h")
  (use-package acp)
  (use-package agent-shell
    :config
    ;; Emacs 가 ~/.local/bin 을 PATH 에 못 찾는 경우를 대비해 절대경로 사용
    (setq agent-shell-hermes-acp-command
          (list (expand-file-name "~/.local/bin/hermes") "acp"))
    ;; 편집 승인 정책: nil = 매번 물음 (기본). 자동 승인을 원하면 아래 주석 해제
    ;; (setq agent-shell-hermes-default-session-mode-id "accept_edits")

    ;; OpenCode over ACP: `opencode acp' speaks the Agent Client Protocol
    ;; natively, so agent-shell drives it in a normal Emacs buffer
    ;; (inline diffs, edit approvals) instead of a terminal TUI.
    ;; Start with: M-x agent-shell-opencode-start-agent (leader ", o")
    ;; Resolve the absolute path so GUI Emacs finds it even without a login PATH.
    (setq agent-shell-opencode-acp-command
          (list (or (executable-find "opencode") "opencode") "acp"))
    ;; Credentials come from `opencode auth login', not from an env var.
    (setq agent-shell-opencode-authentication
          (agent-shell-opencode-make-authentication :none t))
    ;; nil = pick interactively from the model list shown on session start.
    ;; Pin one here once you settle, e.g. "github-copilot/claude-sonnet-5"
    ;; or "ollama/muse-glimmer:30b-mlx".
    (setq agent-shell-opencode-default-model-id nil)
    )

  (require 'llm-ollama)
  (setopt ellama-provider
          (make-llm-ollama
           ;; this model should be pulled to use it
           ;; value should be the same as you print in terminal during pull
           :chat-model "muse-glimmer:30b-mlx"
           :embedding-model "muse-glimmer:30b-mlx"))

  (setopt ellama-providers
          '(
            ("muse-glimmer" . (make-llm-ollama
                               :chat-model "muse-glimmer:30b-mlx"
                               :embedding-model "muse-glimmer:30b-mlx"))
            ("gemma4" . (make-llm-ollama
                         :chat-model "gemma4:31b-mlx"
                         :embedding-model "gemma4:31b-mlx"))

            ("qwen3" . (make-llm-ollama
                        :chat-model "qwen3.8:35b-mlx"
                        :embedding-model "qwen3.8:27b-mlx"))))

  (setopt ellama-naming-provider
          (make-llm-ollama
           :chat-model "muse-glimmer:30b-mlx"
           :embedding-model "muse-glimmer:30b-mlx"))
  (setopt ellama-naming-scheme 'ellama-generate-name-by-llm)
  )

(defun hackartist/ai/bindings ()
  (spacemacs/declare-prefix "," "AI")
  (spacemacs/set-leader-keys
    ", C" 'copilot-chat
    ", ." 'copilot-chat-transient
    ", c" 'copilot-chat-custom-prompt
    ", RET" 'copilot-chat-custom-prompt-selection
    ", ," 'claudemacs-transient-menu
    ", h" 'agent-shell-hermes-start-agent
    ", o" 'agent-shell-opencode-start-agent

    ;; ", ." 'ellama-chat
    ", a" 'ellama-code-add
    ", e" 'ellama-code-edit
    ", r" 'ellama-code-review
    ", i" 'ellama-code-improve
    ", l" 'ellama-ask-line
    ", s" 'ellama-ask-summerize
    ", SPC" 'ellama-ask-about
    ;; ", RET" 'ellama-ask-selection
    ", TAB" 'ellama-code-complete

    )

  (with-eval-after-load 'copilot
    (define-key copilot-mode-map (kbd "C-c C-c") 'copilot-accept-completion)
    (define-key copilot-mode-map (kbd "C-<return>") 'copilot-accept-completion)
    (define-key copilot-completion-map (kbd "C-l") 'copilot-next-completion)
    (define-key copilot-completion-map (kbd "C-h") 'copilot-prev-completion)
    (define-key copilot-completion-map (kbd "<right>") 'copilot-next-completion)
    (define-key copilot-completion-map (kbd "<left>") 'copilot-prev-completion))
  )

(defun hackartist/create-claude-ollama ()
  (interactive)
  (let ((claude-ollama-path "~/.local/bin/claude-ollama"))
    (unless (file-exists-p claude-ollama-path)
      (with-temp-file claude-ollama-path
        (insert "#!/bin/bash\n")
        (insert "ANTHROPIC_AUTH_TOKEN=ollama ANTHROPIC_BASE_URL=http://localhost:11434 ANTHROPIC_API_KEY=\"\" claude --model qwen3-coder-next \"$@\"\n"))
      (set-file-modes claude-ollama-path #o755)
      (message "Created %s" claude-ollama-path))))

(defun hackartist/create-claude-admin ()
  (interactive)
  (let ((claude-admin-path "~/.local/bin/claude-admin"))
    (unless (file-exists-p claude-admin-path)
      (with-temp-file claude-admin-path
        (insert "#!/bin/bash\n")
        (insert "CLAUDE_CONFIG_DIR=~/data/claude-admin claude \"$@\"\n"))
      (set-file-modes claude-admin-path #o755)
      (message "Created %s" claude-admin-path))))

(defun hackartist/ai/config ()
  (add-to-list 'display-buffer-alist
               '("^\\*claudemacs"
                 (display-buffer-in-side-window)
                 (side . right)
                 (window-width . 0.33)))
  (add-to-list 'display-buffer-alist
               '("^\\*Hermes"
                 (display-buffer-in-side-window)
                 (side . right)
                 (window-width . 0.33)))
  (add-to-list 'display-buffer-alist
               '("^\\*OpenCode"
                 (display-buffer-in-side-window)
                 (side . right)
                 (window-width . 0.33)))
  (global-auto-revert-mode t)
  (hackartist/create-claude-ollama)
  (hackartist/create-claude-admin)

  (setq claudemacs-tool-registry
        '((claude :program "claude" :switches nil)
          (claude-admin :program "claude-admin" :switches nil)
          (ollama :program "claude-ollama" :switches nil)
          ;; OpenCode TUI inside eat; gives claudemacs' file@line references
          ;; and per-project session handling for the terminal workflow.
          (opencode :program "opencode" :switches nil)))

  (setq claudemacs-notification-auto-dismiss-linux nil)
  (setq claudemacs-notification-sound-linux "message-new-instant")
  ;; (setq claudemacs-program-switches '("--dangerously-skip-permissions"))
  ;; (setq claudemacs-prefer-projectile-root t)

  (with-eval-after-load 'eat
    (setq eat-term-scrollback-size 400000))

  (setq gptel-backend (gptel-make-gh-copilot "Copilot")
        gptel-model 'claude-sonnet-5)
  (setq copilot-chat-default-model "claude-sonnet-5")
  (setq copilot-chat-commit-model "claude-sonnet-5")
  (add-hook 'prog-mode-hook 'copilot-mode)
  (add-hook 'git-commit-setup-hook 'copilot-chat-insert-commit-message)
  )
