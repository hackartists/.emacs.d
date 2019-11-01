;; (require 'cc-mode)

;; (use-package lsp-mode
;;   :init
;;   (setq lsp-prefer-flymake nil)
;;   :demand t
;;   :after jmi-init-platform-paths)

;; (use-package lsp-ui
;;   :config
;;   (setq lsp-ui-doc-enable nil
;;         lsp-ui-sideline-enable nil
;;         lsp-ui-flycheck-enable t)
;;   :after lsp-mode)

;; (use-package dap-mode
;;   :config
;;   (dap-mode t)
;;   (dap-ui-mode t))

;; (use-package lsp-java
;;   :init
;;   (defun jmi/java-mode-config ()
;;     (setq-local tab-width 4
;;                 c-basic-offset 4)
;;     (toggle-truncate-lines 1)
;;     (setq-local tab-width 4)
;;     (setq-local c-basic-offset 4)
;;     (lsp))

;;   :config
;;   ;; Enable dap-java
;;   (require 'dap-java)

;;   ;; Support Lombok in our projects, among other things
;;   (setq lsp-java-vmargs
;;         (list "-noverify"
;;               "-Xmx2G"
;;               "-XX:+UseG1GC"
;;               "-XX:+UseStringDeduplication"
;;               (concat "-javaagent:" jmi/lombok-jar)
;;               (concat "-Xbootclasspath/a:" jmi/lombok-jar))
;;         lsp-file-watch-ignored
;;         '(".idea" ".ensime_cache" ".eunit" "node_modules"
;;           ".git" ".hg" ".fslckout" "_FOSSIL_"
;;           ".bzr" "_darcs" ".tox" ".svn" ".stack-work" ".git"
;;           "build")

;;         lsp-java-import-order '["" "java" "javax" "#"]
;;         ;; Don't organize imports on save
;;         lsp-java-save-action-organize-imports nil

;;         ;; Formatter profile
;;         lsp-java-format-settings-url
;;         (concat "file://" jmi/java-format-settings-file))

;;   :hook (java-mode   . jmi/java-mode-config)

;;   :demand t
;;   :after (lsp lsp-mode dap-mode jmi-init-platform-paths))

(use-package autodisass-java-bytecode
  :ensure t
  :defer t)

(use-package meghanada
  :defer t
  :init
  (add-hook 'java-mode-hook
            (lambda ()
              (add-hook 'before-save-hook 'meghanada-code-beautify-before-save)
              ;;(google-set-c-style)
              ;;(google-make-newline-indent)
              (meghanada-mode t)
              (smartparens-mode t)
              (rainbow-delimiters-mode t)
              (highlight-symbol-mode t)
              (jdecomp-mode t)
              (customize-set-variable 'jdecomp-decompiler-paths
                                      '((cfr . "~/.emacs.d/refs/cfr/cfr-0.146.jar")))
              ;; (meghanada-telemetry-enable t)
              (flycheck-mode +1)))

  :config
  (use-package realgud
    :ensure t)
  (use-package realgud-jdb
    :ensure t)
  (setq indent-tabs-mode nil)
  (setq tab-width 4)
  (setq c-basic-offset 4)
  (setq meghanada-server-remote-debug t)
  (setq meghanada-javac-xlint "-Xlint:all,-processing")
  :bind
  (:map meghanada-mode-map
        ("C-S-t" . meghanada-switch-testcase)
        ("M-RET" . meghanada-local-variable)
        ("C-M-." . helm-imenu)
        ("M-r" . meghanada-reference)
        ("M-t" . meghanada-typeinfo)
        ("C-z" . hydra-meghanada/body))
  :commands
  (meghanada-mode))

(add-hook 'java-mode-hook
          (lambda ()
            (require 'jdibug)
            
                  ))
(defhydra hydra-meghanada (:hint nil :exit t)
"
^Edit^                           ^Tast or Task^
^^^^^^-------------------------------------------------------
_f_: meghanada-compile-file      _m_: meghanada-restart
_c_: meghanada-compile-project   _t_: meghanada-run-task
_o_: meghanada-optimize-import   _j_: meghanada-run-junit-test-case
_s_: meghanada-switch-test-case  _J_: meghanada-run-junit-class
_v_: meghanada-local-variable    _R_: meghanada-run-junit-recent
_i_: meghanada-import-all        _r_: meghanada-reference
_g_: magit-status                _T_: meghanada-typeinfo
_l_: helm-ls-git-ls
_q_: exit
"
  ("f" meghanada-compile-file)
  ("m" meghanada-restart)

  ("c" meghanada-compile-project)
  ("o" meghanada-optimize-import)
  ("s" meghanada-switch-test-case)
  ("v" meghanada-local-variable)
  ("i" meghanada-import-all)

  ("g" magit-status)
  ("l" helm-ls-git-ls)

  ("t" meghanada-run-task)
  ("T" meghanada-typeinfo)
  ("j" meghanada-run-junit-test-case)
  ("J" meghanada-run-junit-class)
  ("R" meghanada-run-junit-recent)
  ("r" meghanada-reference)

  ("q" exit)
  ("z" nil "leave"))

(provide 'setup-java)
