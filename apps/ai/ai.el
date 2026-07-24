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

  (require 'llm-ollama)
  (setopt ellama-provider
          (make-llm-ollama
           ;; this model should be pulled to use it
           ;; value should be the same as you print in terminal during pull
           :chat-model "codellama"
           :embedding-model "codellama"))

  (setopt ellama-providers
          '(("codellama" . (make-llm-ollama
                            :chat-model "codellama"
                            :embedding-model "codellama"))
            ("wizrdcoder" . (make-llm-ollama
                             :chat-model "wizardcoder:33b-v1.1"
                             :embedding-model "wizardcoder:33b-v1.1"))
            ("zephyr" . (make-llm-ollama
                         :chat-model "zephyr:7b-beta-q6_K"
                         :embedding-model "zephyr:7b-beta-q6_K"))
            ("mistral" . (make-llm-ollama
                          :chat-model "mistral:7b-instruct-v0.2-q6_K"
                          :embedding-model "mistral:7b-instruct-v0.2-q6_K"))
            ("mixtral" . (make-llm-ollama
                          :chat-model "mixtral:8x7b-instruct-v0.1-q3_K_M-4k"
                          :embedding-model "mixtral:8x7b-instruct-v0.1-q3_K_M-4k"))))

  (setopt ellama-naming-provider
          (make-llm-ollama
           :chat-model "codellama"
           :embedding-model "codellama"))
  (setopt ellama-naming-scheme 'ellama-generate-name-by-llm)
  )

(defun hackartist/ai/bindings ()
  (spacemacs/declare-prefix "," "AI")
  (spacemacs/set-leader-keys-for-minor-mode 'copilot-mode
    ", C" 'copilot-chat
    ", ." 'copilot-chat-transient
    ", c" 'copilot-chat-custom-prompt
    ", RET" 'copilot-chat-custom-prompt-selection
    ", ," 'claudemacs-transient-menu

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

(defun hackartist/ai/config ()
  (add-to-list 'display-buffer-alist
               '("^\\*claudemacs"
                 (display-buffer-in-side-window)
                 (side . right)
                 (window-width . 0.33)))
  (global-auto-revert-mode t)
  (setq claudemacs-tool-registry
        '((claude :program "claude" :switches nil)
          (codex :program "codex" :switches nil)
          (gemini :program "gemini" :switches nil)))


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
