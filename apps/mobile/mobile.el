(setq hackartist-mobile-layers
      '(
        java
        dart
        react
        major-modes
        swift
        ))

(setq hackartist-mobile-packages
      '(
        android-mode
        ))

(defun hackartist/mobile/init ()
  (hackartist/mobile/android-init)
  )
