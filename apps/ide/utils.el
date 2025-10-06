(defun classify-linux-distribution ()
  "Classify the Linux distribution."
  (cond
   ((file-exists-p "/etc/arch-release") "Arch Linux")
   ((file-exists-p "/etc/os-release")
    (if (string-match-p "Ubuntu" (with-temp-buffer
                                   (insert-file-contents "/etc/os-release")
                                   (buffer-string)))
        "Ubuntu"
      "Unknown Linux distribution"))
   (t "Unknown Linux distribution")))

(defun set-keyboard-en ()
  (let* ((input-method nil))
    (setq hangul-queue nil)
    (activate-input-method input-method)
    (setq default-input-method input-method)
    (customize-mark-as-set 'default-input-method)))

(defun set-keyboard-kr ()
  (let* ((input-method "korean-hangul"))
    (activate-input-method input-method)
    (setq default-input-method input-method)
    (customize-mark-as-set 'default-input-method)))

(defun apps/ide/toggle-input-method-custom ()
  (interactive)
  (deactivate-input-method)
  (if (string= default-input-method "korean-hangul")
      (set-keyboard-en)
    (set-keyboard-kr)))

(defun hackartist/ide/windmove-left ()
  "docstring"
  (interactive "")
  (if (eq (condition-case nil (windmove-left) (error 1)) 1) (hackartist/ide/other-frame-safe)))

(defun hackartist/ide/windmove-right ()
  "docstring"
  (interactive "")
  (if (eq (condition-case nil (windmove-right) (error 1)) 1) (hackartist/ide/other-frame-safe)))

(defun hackartist/ide/other-frame-safe ()
  (select-frame-set-input-focus (next-frame (selected-frame))))

(defun hackartist/ide/switch-or-create-other-frame ()
  (interactive "")
  (if (eq (next-frame (selected-frame)) (selected-frame)) (make-frame) (hackartist/ide/other-frame-safe))
  (set-face-attribute 'hl-line nil
                      :bold t
                      :underline t
                      :inherit nil))

(defun helm-hackartist-buffer ()
  "Select hackartist ide using helm."
  (interactive)
  (require 'helm-for-files)
  (require 'helm-projectile)

  (unless helm-source-buffers-list
    (setq helm-source-buffers-list
          (helm-make-source "Buffers" 'helm-source-buffers)))

  (unless helm-source-recentf
    (setq helm-source-recentf
          (helm-make-source "Recentf" 'helm-recentf-source)))

  (unless helm-source-projectile-projects
    (helm-build-sync-source "Projectile projects"
      :candidates 'projectile-relevant-known-projects
      :action 'projectile-switch-project-by-name))

  (let* (
         (hackartist-shell-buffers '(
                                     helm-source-buffers-list
                                     helm-source-recentf
                                     helm-source-buffer-not-found
                                     ))

         )
    (when helm-source-projectile-projects
      (add-to-list 'hackartist-shell-buffers helm-source-projectile-projects))

    (when helm-source-projectile-files-list
      (add-to-list 'hackartist-shell-buffers helm-source-projectile-files-list))

    (helm
     :prompt "Hackartist Shell : "
     :sources hackartist-shell-buffers
     :buffer "*helm hackartist*"
     )))

(defun helm-hackartist-buffers-candidates ()
  (let (bufs '())
    (dolist (el (buffer-list)) (push (buffer-name el) bufs))
    bufs
    ))

(defun hackartist-focus-on-window (w)
  (when (windowp w)
    (select-frame-set-input-focus (window-frame w))
    (select-window w)
    ))

(defun helm-hackartist-buffers-persistent-action (candidate)
  (let* ((w (get-buffer-window candidate t)))
    (if w (hackartist-focus-on-window w) (switch-to-buffer candidate))
    ))

(defun make-hackartist-helm-source (s)
  (let* ((src (copy-alist s)))
    (setf (alist-get 'action src) 'helm-hackartist-buffers-persistent-action)
    src))

;; spacemacs//display-helm-window
(defun helm-hackartist-switch-to-buffer (buffer &optional resume)
  (helm-hackartist-buffers-persistent-action buffer))

(defun dom-print (dom &optional pretty xml)
  "Print DOM at point as HTML/XML.
If PRETTY, indent the HTML/XML logically.
If XML, generate XML instead of HTML."
  (let ((column (current-column)))
    (insert (format "<%s" (dom-tag dom)))
    (let ((attr (dom-attributes dom)))
      (dolist (elem attr)
        ;; In HTML, these are boolean attributes that should not have
        ;; an = value.
        (if (and (memq (car elem)
                       '(async autofocus autoplay checked
                               contenteditable controls default
                               defer disabled formNoValidate frameborder
                               hidden ismap itemscope loop
                               multiple muted nomodule novalidate open
                               readonly required reversed
                               scoped selected typemustmatch))
                 (cdr elem)
                 (not xml))
            (insert (format " %s" (car elem)))
          (insert (format " %s=%S" (car elem) (cdr elem))))))
    (let* ((children (dom-children dom))
           (non-text nil))
      (if (null children)
          (insert " />")
        (insert ">")
        (dolist (child children)
          (if (stringp child)
              (insert child)
            (setq non-text t)
            (when pretty
              (insert "\n" (make-string (+ column 2) ? )))
            (dom-print child pretty xml)))
        ;; If we inserted non-text child nodes, or a text node that
        ;; ends with a newline, then we indent the end tag.
        (when (and pretty
                   (or (bolp)
                       non-text))
          (unless (bolp)
            (insert "\n"))
          (insert (make-string column ? )))
        (insert (format "</%s>" (dom-tag dom)))))))

(defun term/append-string-to-file ()
  (interactive)
  (term-send-raw-string "rm -rf untitled.txt && touch untitled.txt && cat <<EOF >> untitled.txt"))

(defun hackartist/scratch-buffer-only ()
  (interactive)
  (spacemacs/switch-to-scratch-buffer)
  (delete-other-windows))

(defun markdown-convert-buffer-to-org ()
  "Convert the current buffer's content from markdown to orgmode format and save it with the current buffer's file name but with .org extension."
  (interactive)
  (shell-command-on-region (point-min) (point-max)
                           (format "pandoc -f markdown -t org -o %s"
                                   (concat (file-name-sans-extension (buffer-file-name)) ".org"))))
