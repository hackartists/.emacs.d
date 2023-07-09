(define-derived-mode bard-mode text-mode "BARD"
  "Major mode for editing .bard files."
  (require 'markdown-mode)

  (when buffer-read-only
    (when (or (not (buffer-file-name)) (file-writable-p (buffer-file-name)))
      (setq-local buffer-read-only nil)))
  ;; Natural Markdown tab width
  (setq tab-width 4)
  ;; Comments
  (setq-local comment-start "<!-- ")
  (setq-local comment-end " -->")
  (setq-local comment-start-skip "<!--[ \t]*")
  (setq-local comment-column 0)
  (setq-local comment-auto-fill-only-comments nil)
  (setq-local comment-use-syntax t)
  ;; Sentence
  (setq-local sentence-end-base "[.?!…‽][]\"'”’)}»›*_`~]*")
  ;; Syntax
  (add-hook 'syntax-propertize-extend-region-functions
            #'markdown-syntax-propertize-extend-region nil t)
  (add-hook 'jit-lock-after-change-extend-region-functions
            #'markdown-font-lock-extend-region-function t t)
  (setq-local syntax-propertize-function #'markdown-syntax-propertize)
  (syntax-propertize (point-max)) ;; Propertize before hooks run, etc.
  ;; Font lock.
  (setq font-lock-defaults
        '(markdown-mode-font-lock-keywords
          nil nil nil nil
          (font-lock-multiline . t)
          (font-lock-syntactic-face-function . markdown-syntactic-face)
          (font-lock-extra-managed-props
           . (composition display invisible rear-nonsticky
                          keymap help-echo mouse-face))))
  (if markdown-hide-markup
      (add-to-invisibility-spec 'markdown-markup)
    (remove-from-invisibility-spec 'markdown-markup))
  ;; Wiki links
  (markdown-setup-wiki-link-hooks)
  ;; Math mode
  (when markdown-enable-math (markdown-toggle-math t))
  ;; Add a buffer-local hook to reload after file-local variables are read
  (add-hook 'hack-local-variables-hook #'markdown-handle-local-variables nil t)
  ;; For imenu support
  (setq imenu-create-index-function
        (if markdown-nested-imenu-heading-index
            #'markdown-imenu-create-nested-index
          #'markdown-imenu-create-flat-index))

  ;; Defun movement
  (setq-local beginning-of-defun-function #'markdown-beginning-of-defun)
  (setq-local end-of-defun-function #'markdown-end-of-defun)
  ;; Paragraph filling
  (setq-local fill-paragraph-function #'markdown-fill-paragraph)
  (setq-local paragraph-start
              ;; Should match start of lines that start or separate paragraphs
              (mapconcat #'identity
                         '(
                           "\f" ; starts with a literal line-feed
                           "[ \t\f]*$" ; space-only line
                           "\\(?:[ \t]*>\\)+[ \t\f]*$"; empty line in blockquote
                           "[ \t]*[*+-][ \t]+" ; unordered list item
                           "[ \t]*\\(?:[0-9]+\\|#\\)\\.[ \t]+" ; ordered list item
                           "[ \t]*\\[\\S-*\\]:[ \t]+" ; link ref def
                           "[ \t]*:[ \t]+" ; definition
                           "^|" ; table or Pandoc line block
                           )
                         "\\|"))
  (setq-local paragraph-separate
              ;; Should match lines that separate paragraphs without being
              ;; part of any paragraph:
              (mapconcat #'identity
                         '("[ \t\f]*$" ; space-only line
                           "\\(?:[ \t]*>\\)+[ \t\f]*$"; empty line in blockquote
                           ;; The following is not ideal, but the Fill customization
                           ;; options really only handle paragraph-starting prefixes,
                           ;; not paragraph-ending suffixes:
                           ".*  $" ; line ending in two spaces
                           "^#+"
                           "^\\(?:   \\)?[-=]+[ \t]*$" ;; setext
                           "[ \t]*\\[\\^\\S-*\\]:[ \t]*$") ; just the start of a footnote def
                         "\\|"))
  (setq-local adaptive-fill-first-line-regexp "\\`[ \t]*[A-Z]?>[ \t]*?\\'")
  (setq-local adaptive-fill-regexp "\\s-*")
  (setq-local adaptive-fill-function #'markdown-adaptive-fill-function)
  (setq-local fill-forward-paragraph-function #'markdown-fill-forward-paragraph)
  ;; Outline mode
  (setq-local outline-regexp markdown-regex-header)
  (setq-local outline-level #'markdown-outline-level)
  ;; Cause use of ellipses for invisible text.
  (add-to-invisibility-spec '(outline . t))
  ;; ElDoc support
  (if (boundp 'eldoc-documentation-functions)
      (add-hook 'eldoc-documentation-functions #'markdown-eldoc-function nil t)
    (add-function :before-until (local 'eldoc-documentation-function)
                  #'markdown-eldoc-function))
  ;; Inhibiting line-breaking:
  ;; Separating out each condition into a separate function so that users can
  ;; override if desired (with remove-hook)
  (add-hook 'fill-nobreak-predicate
            #'markdown-line-is-reference-definition-p nil t)
  (add-hook 'fill-nobreak-predicate
            #'markdown-pipe-at-bol-p nil t)

  ;; Indentation
  (setq-local indent-line-function markdown-indent-function)
  (setq-local indent-region-function #'markdown--indent-region)

  ;; Flyspell
  (setq-local flyspell-generic-check-word-predicate
              #'markdown-flyspell-check-word-p)

  ;; Electric quoting
  (add-hook 'electric-quote-inhibit-functions
            #'markdown--inhibit-electric-quote nil :local)

  ;; Make checkboxes buttons
  (when markdown-make-gfm-checkboxes-buttons
    (markdown-make-gfm-checkboxes-buttons (point-min) (point-max))
    (add-hook 'after-change-functions #'markdown-gfm-checkbox-after-change-function t t)
    (add-hook 'change-major-mode-hook #'markdown-remove-gfm-checkbox-overlays t t))

  ;; edit-indirect
  (add-hook 'edit-indirect-after-commit-functions
            #'markdown--edit-indirect-after-commit-function
            nil 'local)

  ;; Marginalized headings
  (when markdown-marginalize-headers
    (add-hook 'window-configuration-change-hook
              #'markdown-marginalize-update-current nil t))

  ;; add live preview export hook
  (add-hook 'after-save-hook #'markdown-live-preview-if-markdown t t)
  (add-hook 'kill-buffer-hook #'markdown-live-preview-remove-on-kill t t))


(provide 'bard-mode)
