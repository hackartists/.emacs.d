;;; config-ecb.el ---
(require 'ecb)
                                        ;(defvar stack-trace-on-error
                                        ;  "To be compatible with emacs 24")

(custom-set-variables '(ecb-options-version "2.50"))
(defconst initial-frame-width (frame-width)
  "The width of frame will be changed ,remember the init value.")
(setq ;; ecb-compile-window-height 10
      ;; ecb-compile-window-width 'edit-window
      ;; ecb-compile-window-temporally-enlarge 'both
      ecb-create-layout-file "~/.emacs.d/auto-save-list/.ecb-user-layouts.el"
      ecb-windows-width 0.2
      ecb-fix-window-size 'width
      ecb-layout-name "hackartist"
      ecb-history-make-buckets 'mode
      ecb-kill-buffer-clears-history 'auto
      ecb-tip-of-the-day nil
      ecb-tip-of-the-day-file "~/.emacs/auto-save-list/.ecb-tip-of-day.el"
      ecb-primary-secondary-mouse-buttons 'mouse-1--mouse-2
      semantic-decoration-styles (list '("semantic-decoration-on-includes" . t)
                                       '("semantic-tag-boundary" . t))
      ;;ecb-create-layout-frame-height 40
      ;;ecb-create-layout-frame-width 110
      )

(define-key ecb-mode-map (kbd "<f9>") 'ecb-toggle-ecb-windows)
(define-key ecb-mode-map (kbd "M-1") 'ecb-goto-window-directories)
(define-key ecb-mode-map (kbd "M-2") 'ecb-goto-window-methods)
(define-key ecb-mode-map (kbd "M-3") 'ecb-goto-window-history)
(define-key ecb-mode-map (kbd "M-4") 'ecb-goto-window-compilation)

  ;; Layout jerry -----------------------------------------------------

  (ecb-layout-define "hackartist" left
    "This function creates the following layout:
   ----------------------------------------------------------------------
   |              |                        |                            |
   |  Directories |                                                     |
   |              |                        |                            |
   |              |                        |                            |
   |              |                        |                            |
   |              |                        |                            |
   |--------------|                        |                            |
   |              |   Edit1                |        Edit2               |
   |  Methods     |                        |                            |
   |              |                        |                            |
   |              |                        |                            |
   |--------------|                        |                            |
   |              |                        |                            |
   |  History     |                        |                            |
   |              |                        |                            |
   ----------------------------------------------------------------------
   |                                                                    |
   |                    Compilation                                     |
   |                                                                    |
   ----------------------------------------------------------------------
If you have not set a compilation-window in `ecb-compile-window-height' then
the layout contains no persistent compilation window and the other windows get a
little more place. This layout works best if it is contained in
`ecb-show-sources-in-directories-buffer'!"
    (ecb-set-directories-buffer)
    (ecb-split-ver 0.3)
    (ecb-set-methods-buffer)
    (ecb-split-ver 0.5)
    (ecb-set-history-buffer)
    (select-window (next-window)))
(add-to-list 'ecb-show-sources-in-directories-buffer "hackartist")
(setq dired-omit-files "^\\.?#\\|^\\.$")
(ecb-activate)
(ecb-byte-compile)


(provide 'setup-ecb)

;;; config-ecb.el ends here ---"")
