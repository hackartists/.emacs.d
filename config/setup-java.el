(require 'meghanada)

(add-hook 'java-mode-hook
          (lambda ()
            ;; meghanada-mode on
            (meghanada-mode t)
            (flycheck-mode +1)
			(add-to-list 'load-path "~/.emacs.d/refs/jdibug")
			(require 'jdibug)
            (setq c-basic-offset 2)
			(setq jdibug-connect-hosts '("localhost:5005"))
			(setq jdibug-use-jde-source-paths nil)
			(setq jdibug-source-paths '(concat (projectile-project-root) "src"))
            ;; use code format
            (add-hook 'before-save-hook 'meghanada-code-beautify-before-save)))
(cond
 ((eq system-type 'windows-nt)
  (setq meghanada-java-path (expand-file-name "bin/java.exe" (getenv "JAVA_HOME")))
  (setq meghanada-maven-path "mvn.cmd"))
 (t
  (setq meghanada-java-path "java")
  (setq meghanada-maven-path "mvn")))

(provide 'setup-java)
