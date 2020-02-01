(global-hl-line-mode 1)

(scroll-bar-mode -1)
(load-theme 'spacemacs-dark t)

(clm/toggle-command-log-buffer)
(global-command-log-mode +1)

(split-window-horizontally)
(windmove-right)
(switch-to-buffer "*Messages*")
(windmove-left)
(switch-to-buffer "*scratch*")

(set-face-attribute 'hl-line nil ;; :height (+ (face-attribute 'default :height) 30)
                    :bold t 
                    :underline t 
                    :inherit nil 
                    :background nil)
