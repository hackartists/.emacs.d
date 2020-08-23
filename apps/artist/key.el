(defun hackartist/artist/bindings ()
  "artist mode key bindings"
  (spacemacs/set-leader-keys-for-minor-mode 'artist-mode
    "RET" 'hackartist/artist/select-tool
    "C" 'hackartist/artist/select-setting))

(defun hackartist/artist/select-tool (type)
  "Use ido to select a drawing operation in artist-mode"
  (interactive (list (ido-completing-read "Drawing operation: " 
                                          (list "Pen" "Pen Line" "line" "straight line" "rectangle" 
                                                "square" "poly-line" "straight poly-line" "ellipse" 
                                                "circle" "text see-thru" "text overwrite" "spray-can" 
                                                "spray set size"
                                                "erase char" "erase rectangle" "vaporize line" "vaporize lines" 
                                                "cut rectangle" "cut square" "copy rectangle" "copy square" 
                                                "paste" "flood-fill"))))
  (artist-select-operation type))

(defun hackartist/artist/select-setting (type)
  "Use ido to select a setting to change in artist-mode"
  (interactive (list (ido-completing-read "Setting: " 
                                          (list "Set Fill" "Set Line" "Set Erase" "Spray-size" "Spray-chars" 
                                                "Rubber-banding" "Trimming" "Borders"))))
  (if (equal type "Spray-size") 
      (artist-select-operation "spray set size")
    (call-interactively (artist-fc-get-fn-from-symbol 
			                   (cdr (assoc type '(("Set Fill" . set-fill)
					                                  ("Set Line" . set-line)
					                                  ("Set Erase" . set-erase)
					                                  ("Rubber-banding" . rubber-band)
					                                  ("Trimming" . trimming)
					                                  ("Borders" . borders)
					                                  ("Spray-chars" . spray-chars))))))))
