(defun hackartist/bard/init ()
  (add-to-list 'auto-mode-alist '("\\.bard\\'" . bard-mode)))

(defun hackartist/bard/config ()
  (add-hook
   'bard-mode-hook
   (lambda ()
     (advice-add 'bard-finish-answer :after
                 (lambda (buffer) (save-buffer))))))

(defun hackartist/bard/bindings ()
  (spacemacs/declare-prefix "ab" "Bard")
  (spacemacs/set-leader-keys
    "ab RET" 'bard-chat
    "ab SPC" 'bard-generate-code
    "ab TAB" 'bard-refactory-code
    "abc" 'bard-generate-commit-message)

  (spacemacs/set-leader-keys-for-major-mode 'bard-mode
    "RET" 'bard-chat))
