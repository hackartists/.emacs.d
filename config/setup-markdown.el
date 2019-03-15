(use-package markdown-mode)
(use-package markdown-mode+)

(add-to-list 'auto-mode-alist'("README\\.md\\'" . gfm-mode))

(add-hook 'gfm-mode-hook (lambda ()
                           (visual-line-mode 1)))

(provide 'setup-markdown)
