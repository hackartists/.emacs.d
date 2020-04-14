(setq hackartist-chat-layers
      '(slack))

(setq hackartist-chat-packages
      '(
        helm
        alert
        ))

(setq hackartist-chat-osc
      '(
        "https://github.com/yuya373/helm-slack.git"
        ))


(defun hackartist/chat/init ()
  (require 'helm-slack))

(defun hackartist/chat/config ()
  (setq slack-thread-also-send-to-room nil)
  (setq alert-default-style 'notifier)
  (setq slack-buffer-function #'switch-to-buffer))

(defun hackartist/chat/bindings ()
  (add-hook 'slack-buffer-mode-hook
            (lambda ()
              (interactive "")
              (local-set-key (kbd "M-RET @") 'slack-message-embed-mention)
              (local-set-key (kbd "M-RET #") 'slack-message-embed-channel)
              (local-set-key (kbd "M-RET RET") 'slack-thread-show-or-create)
              (local-set-key (kbd "M-RET !") 'slack-message-add-reaction)
              ))

  (global-set-key (kbd "M-m o s h") 'helm-slack))
