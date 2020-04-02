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
  (global-set-key (kbd "M-m o s h") 'helm-slack))
