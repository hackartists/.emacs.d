;; (require 'cc-mode)


;;   :demand t
;;   :after (lsp lsp-mode dap-mode jmi-init-platform-paths))

;; (use-package autodisass-java-bytecode
;;   :ensure t
;;   :defer t)

;; (use-package meghanada
;;   :defer t
;;   :init
;;   (add-hook 'java-mode-hook
;;             (lambda ()
;;               (add-hook 'before-save-hook 'meghanada-code-beautify-before-save)

;;               ;;(google-set-c-style)
;;               ;;(google-make-newline-indent)
;;               (meghanada-mode t)
;;               (smartparens-mode t)
;;               (rainbow-delimiters-mode t)
;;               (highlight-symbol-mode t)
;;               (jdecomp-mode t)
;;               (customize-set-variable 'jdecomp-decompiler-paths
;;                                       '((cfr . "~/.emacs.d.hackartists/refs/cfr/cfr-0.146.jar")))
;;               ;; (meghanada-telemetry-enable t)
;;               (flycheck-mode +1)

;;               (require 'jdibug)
;;               (require 'jdibug-ui)

;;               (setq jdibug-connect-hosts (quote ("localhost:5005"))
;;                     jdibug-use-jdee-source-paths nil
;;                     jdibug-source-paths (directory-files-recursively (projectile-project-root) "\\.java$"))
;;               ))

;;   :config
;;   (use-package realgud
;;     :ensure t)
;;   (use-package realgud-jdb
;;     :ensure t)
;;   (setq indent-tabs-mode nil)
;;   (setq tab-width 4)
;;   (setq c-basic-offset 4)
;;   (setq meghanada-server-remote-debug nil)
;;   (setq meghanada-javac-xlint "-Xlint:all,-processing")
;;   :bind
;;   (:map meghanada-mode-map
;;         ("C-S-t" . meghanada-switch-testcase)
;;         ("M-RET" . meghanada-local-variable)
;;         ("C-M-." . helm-imenu)
;;         ("M-r" . meghanada-reference)
;;         ("M-t" . meghanada-typeinfo)
;;         ("C-z" . hydra-meghanada/body))
;;   :commands
;;   (meghanada-mode))

;; (defhydra hydra-meghanada (:hint nil :exit t)
;;   "
;; ^Edit^                           ^Tast or Task^
;; ^^^^^^-------------------------------------------------------
;; _f_: meghanada-compile-file      _m_: meghanada-restart
;; _c_: meghanada-compile-project   _t_: meghanada-run-task
;; _o_: meghanada-optimize-import   _j_: meghanada-run-junit-test-case
;; _s_: meghanada-switch-test-case  _J_: meghanada-run-junit-class
;; _v_: meghanada-local-variable    _R_: meghanada-run-junit-recent
;; _i_: meghanada-import-all        _r_: meghanada-reference
;; _g_: magit-status                _T_: meghanada-typeinfo
;; _l_: helm-ls-git-ls
;; _q_: exit
;; "
;;   ("f" meghanada-compile-file)
;;   ("m" meghanada-restart)

;;   ("c" meghanada-compile-project)
;;   ("o" meghanada-optimize-import)
;;   ("s" meghanada-switch-test-case)
;;   ("v" meghanada-local-variable)
;;   ("i" meghanada-import-all)

;;   ("g" magit-status)
;;   ("l" helm-ls-git-ls)

;;   ("t" meghanada-run-task)
;;   ("T" meghanada-typeinfo)
;;   ("j" meghanada-run-junit-test-case)
;;   ("J" meghanada-run-junit-class)
;;   ("R" meghanada-run-junit-recent)
;;   ("r" meghanada-reference)

;;   ("q" exit)
;;   ("z" nil "leave"))

;; (ignore-errors (wrong-type-argument stringp spacemacs/helm-navigation-transient-state/params

;; (use-package lsp-javacomp
;;   :ensure t
;;   :hook (java-mode #'lsp-javacomp-enable))

;; (require 'lsp-java)
;; (require 'dap-java)

;; (add-hook 'java-mode-hook #'lsp)
(defun spacemacs//init-jump-handlers-java-mode ()
  (interactive)
  (require 'lsp-java)
  (require 'dap-java)

  (setq lsp-ui-doc-enable nil
        lsp-ui-sideline-enable t
        lsp-ui-flycheck-enable nil)

  (add-hook 'before-save-hook (lambda ()
                                (lsp-format-buffer)
                                (lsp-java-organize-imports)
                                ))
  )

(defun java/pre-init-dap-mode ()
  (add-to-list 'spacemacs--dap-supported-modes 'java-mode))

(provide 'setup-java)
