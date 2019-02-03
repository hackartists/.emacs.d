(require 'android-mode)

(add-hook 'android-mode-hook
		  (lambda ()
			(custom-set-variables '(android-mode-sdk-dir "~/Data/sdks/android"))
			))

(add-hook 'gud-mode-hook
          (lambda ()
            (add-to-list 'gud-jdb-classpath "~/Data/sdks/android/android-24/android.jar")
            ))

(provide 'setup-android)
