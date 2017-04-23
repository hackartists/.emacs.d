(require 'android-mode)
(custom-set-variables '(android-mode-sdk-dir "/Volumes/Data/Developers/android"))

(add-hook 'gud-mode-hook
          (lambda ()
            (add-to-list 'gud-jdb-classpath "/Volumes/Data/Developers/android/android-24/android.jar")
            ))

(provide 'setup-android)
