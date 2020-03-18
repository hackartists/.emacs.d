(setq hackartist-chat-layers
      '(slack))

(setq hackartist-chat-packages
      '(
        helm
        ))

(defun hackartist/chat/init ()
  (hackartist/chat/slack-init)
  (slack-start))

(defun hackartist/chat/config ()
  (setq slack-thread-also-send-to-room nil))

(defun hackartist/chat/bindings ()
  (global-set-key (kbd "M-m o s h") 'helm-slack))
