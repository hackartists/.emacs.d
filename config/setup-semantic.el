(require 'cc-mode)
(require 'semantic)
(require 'semantic/senator)
(require 'semantic/ia)
(require 'semantic/wisent)
(require 'semantic/wisent/java-tags)

(global-semanticdb-minor-mode 1)
(global-semantic-idle-scheduler-mode 1)
(setq semantic-load-turn-everything-on t)
(setq semantic-default-submodes '(;;global-semantic-idle-scheduler-mode
                                  global-semanticdb-minor-mode
                                  global-semantic-idle-summary-mode
                                  global-semantic-decoration-mode
                                  global-semantic-highlight-func-mode
                                  ;;global-semantic-stickyfunc-mode
                                  global-semantic-mru-bookmark-mode))

(semantic-mode 1)
(semantic-add-system-include "/usr/include")
(semantic-add-system-include "/opt/local/include")

(autoload 'wisent-java-default-setup "wisent" "Hook run to setup Semantic in 'java-mode'." nil nil)

(provide 'setup-semantic)
