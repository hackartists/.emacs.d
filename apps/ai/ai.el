(setq hackartist-ai-layers
      '(
        github-copilot
        ))

(setq hackartist-ai-packages
      '(copilot-chat
        eat
        gptel
        claudemacs
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
  )

(defun hackartist/ai/bindings ()
  (spacemacs/declare-prefix "," "AI")
  (spacemacs/set-leader-keys
    ", C" 'copilot-chat
    ", ." 'copilot-chat-transient
    ", c" 'copilot-chat-custom-prompt
    ", RET" 'copilot-chat-custom-prompt-selection
    ", ," 'claudemacs-transient-menu
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

  (setq claudemacs-notification-auto-dismiss-linux nil)
  (setq claudemacs-notification-sound-linux "message-new-instant")
  (setq claudemacs-program-switches '("--dangerously-skip-permissions", "--chrome"))
  ;; (setq claudemacs-prefer-projectile-root t)

  (with-eval-after-load 'eat
    (setq eat-term-scrollback-size 400000))

  (setq gptel-model  'gpt-4o
        gptel-backend
        (gptel-make-openai "Github Models"
          :host "models.inference.ai.azure.com"
          :endpoint "/chat/completions?api-version=2024-05-01-preview"
          :stream t
          :key (getenv "GPTEL_GITHUB")
          :models '(gpt-4o gpt-5)))
  (setq copilot-chat-default-model "gpt-4o")
  ;; (add-hook 'prog-mode-hook 'copilot-mode)
  (add-hook 'git-commit-setup-hook 'copilot-chat-insert-commit-message)
  )
