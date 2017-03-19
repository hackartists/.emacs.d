;;(set-face-background 'mode-line "red")

(set-face-attribute 'default
                    nil
                    :background "black"
                    :foreground "white"
                    )

(set-face-attribute  'mode-line
                     nil 
                     :foreground "gray80"
                     :background "red" 
                     :box '(:line-width 1 :style released-button))

(set-face-attribute  'mode-line-inactive
                     nil 
                     :foreground "gray80"
                     :background "gray30" 
                     :box '(:line-width 1 :style released-button))

(provide 'setup-face)
