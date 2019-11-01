(use-package meghanada)

(add-hook 'java-mode-hook
          '(lambda ()
			 (require 'jdibug)
             ;; meghanada-mode on
             (meghanada-mode t)
             (jdecomp-mode t)
			 (flycheck-mode t)
             (customize-set-variable 'jdecomp-decompiler-paths
                                     '((cfr . "~/.emacs.d/refs/cfr/cfr-0.146.jar")))

			 (add-to-list 'load-path "~/.emacs.d/refs/jdibug")
             (setq c-basic-offset 4)
			 (setq jdibug-connect-hosts '("localhost:5005"))
			 (setq jdibug-use-jde-source-paths nil)
			 (setq jdibug-source-paths '(concat (projectile-project-root) "src"))
			 (setq jdee-jdk "/usr/local/Cellar/atlassian-plugin-sdk/6.3.12/libexec/repository")
			 (setq jdee-maven-build-phase "com.atlassian.maven.plugins:maven-amps-dispatcher-plugin:6.3.21:debug -gs /usr/local/Cellar/atlassian-plugin-sdk/6.3.12/libexec/apache-maven-3.2.1/conf/settings.xml")
			 (setq jdee-server-dir "~/.emacs.d/refs/jdee-server")
			 (setq gud-jdb-command-name "jdb -attach 5005")
             ;; use code format
			 (add-hook 'before-save-hook 'meghanada-code-beautify)))

(cond
 ((eq system-type 'windows-nt)
  (setq meghanada-java-path (expand-file-name "bin/java.exe" (getenv "JAVA_HOME")))
  (setq meghanada-maven-path "mvn.cmd"))
 (t
  (setq meghanada-java-path "java")
  (setq meghanada-maven-path "mvn")))

(provide 'setup-java)
