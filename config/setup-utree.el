(require 'undo-tree)

(defun my-utree-mode-hook()
  (define-key undo-tree-visualizer-mode-map (kbd "<home>") 'undo-tree-visualize-undo-to-x)
  (define-key undo-tree-visualizer-mode-map (kbd "<end>") 'undo-tree-visualize-redo-to-x)
  (define-key undo-tree-visualizer-mode-map (kbd "<C-up>") 'windmove-up)
  (define-key undo-tree-visualizer-mode-map (kbd "<C-down>") 'windmove-down)
  )


(add-hook 'undo-tree-visualizer-mode-hook 'my-utree-mode-hook)

(global-undo-tree-mode)


(provide 'setup-utree)
