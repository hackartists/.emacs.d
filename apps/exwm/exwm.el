(setq hackartist-exwm-layers
      '((exwm :variables exwm-enable-systray t
              exwm-autostart-xdg-applications nil
              exwm-terminal-command "xterm"
              exwm-locking-command nil
              exwm-hide-tiling-modeline nil
              exwm-workspace-switch-wrap t
              exwm-randr-command nil)))

(setq hackartist-exwm-packages '())
(setq hackartist-ide-osc '())

(defun hackartist/ide/init ()
  (with-eval-after-load 'exwm
    (setup-exwm)))

(defun hackartist/ide/bindings ()
    (define-key exwm-mode-map (kbd "<escape>") 'evil-exwm-state)
    (define-key exwm-mode-map (kbd "i") 'evil-exwm-insert-state))

(defun hackartist/ide/config ()
  (setq mouse-autoselect-window t
        focus-follows-mouse t))

(defun setup-exwm ()
  (require 'exwm)
  (require 'exwm-config)
  (setq exwm-input--line-mode-passthrough t)
  ;; Set the initial workspace number.
  (setq exwm-workspace-number 10)
  ;; Make class name the buffer name
  (add-hook 'exwm-update-class-hook
            (lambda ()
              (setq exwm-input--line-mode-passthrough t)
              (exwm-workspace-rename-buffer exwm-class-name)))

  ;; 's-w': Switch workspace
  ; (exwm-input-set-key (kbd "s-w") #'exwm-workspace-switch)
  (exwm-input-set-key (kbd "s-w") #'spacemacs/workspaces-transient-state/body)
  ;; s-h, s-j, s-k, s-l: move around
  (exwm-input-set-key (kbd "s-h") #'evil-window-left)
  (exwm-input-set-key (kbd "s-j") #'evil-window-down)
  (exwm-input-set-key (kbd "s-k") #'evil-window-up)
  (exwm-input-set-key (kbd "s-l") #'evil-window-right)
  ;; lock screen
  (exwm-input-set-key (kbd "C-M-l") #'lock-screen)
  (define-key global-map (kbd "C-M-l") #'lock-screen)
  (push ?\s-\  exwm-input-prefix-keys)

  ;; fn key bindings
  (exwm-input-set-key (kbd "<XF86AudioRaiseVolume>") #'turn-volume-up)
  (exwm-input-set-key (kbd "<XF86AudioLowerVolume>") #'turn-volume-down)
  (exwm-input-set-key (kbd "<XF86AudioMute>") #'toggle-volume-mute)
  (exwm-input-set-key (kbd "<XF86AudioPlay>") #'spotify-playpause)
  (exwm-input-set-key (kbd "<XF86AudioNext>") #'spotify-next)
  (exwm-input-set-key (kbd "<XF86AudioPrev>") #'spotify-previous)
  (exwm-input-set-key (kbd "<XF86KbdBrightnessUp>") #'kbd-brightness-up)
  (exwm-input-set-key (kbd "<XF86KbdBrightnessDown>") #'kbd-brightness-down)
  (exwm-input-set-key (kbd "<XF86LaunchA>") #'lock-screen)
  (exwm-input-set-key (kbd "<XF86LaunchB>") #'spacemacs/toggle-maximize-buffer)

  ;; 's-&': Launch application
  (exwm-input-set-key (kbd "s-&")
                     (lambda (command)
                      (interactive (list (read-shell-command "$ ")))
                     (start-process-shell-command command nil command)))

  ;; Enable EXWM
  (exwm-enable)
  ;; Configure Ido
  (exwm-config-ido)
  ;; Other configurations
  (exwm-config-misc)
)
