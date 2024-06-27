;; llm requires below layers of spacemacs.
(setq hackartist-llm-layers '())

;; llm requires additional packages.
(setq hackartist-llm-packages '(
                                ellama
                                ))

;; llm requires open source code from github
(setq hackartist-llm-osc '())

(defun hackartist/llm/init ()
  "initialization code"
  ;; (setopt ellama-language "Korean")
  
  (require 'llm-ollama)
  (setopt ellama-provider
		      (make-llm-ollama
		       ;; this model should be pulled to use it
		       ;; value should be the same as you print in terminal during pull
		       :chat-model "codellama"
		       :embedding-model "codellama"))

  (setopt ellama-providers
		      '(("codellama" . (make-llm-ollama
				                 :chat-model "codellama"
				                 :embedding-model "codellama"))
            ("wizrdcoder" . (make-llm-ollama
				                     :chat-model "wizardcoder:33b-v1.1"
				                     :embedding-model "wizardcoder:33b-v1.1"))
            ("zephyr" . (make-llm-ollama
				                 :chat-model "zephyr:7b-beta-q6_K"
				                 :embedding-model "zephyr:7b-beta-q6_K"))
		        ("mistral" . (make-llm-ollama
				                  :chat-model "mistral:7b-instruct-v0.2-q6_K"
				                  :embedding-model "mistral:7b-instruct-v0.2-q6_K"))
		        ("mixtral" . (make-llm-ollama
				                  :chat-model "mixtral:8x7b-instruct-v0.1-q3_K_M-4k"
				                  :embedding-model "mixtral:8x7b-instruct-v0.1-q3_K_M-4k"))))
 
  (setopt ellama-naming-provider
	        (make-llm-ollama
				   :chat-model "codellama"
				   :embedding-model "codellama"))
  (setopt ellama-naming-scheme 'ellama-generate-name-by-llm)
  
  ;; (setopt ellama-translation-provider (make-llm-ollama
	;; 				                             :chat-model "llama2:13b-chat"
	;; 				                             :embedding-model "llama2:13b-chat"))
  )

(defun hackartist/llm/config ()
  "configuration code")

(defun hackartist/llm/bindings ()
  "configuration code"
  (spacemacs/declare-prefix "L" "llm")
  (spacemacs/set-leader-keys
    "L." 'ellama-chat
    "La" 'ellama-code-add
    "Le" 'ellama-code-edit
    "Lr" 'ellama-code-review
    "Li" 'ellama-code-improve
    "Ll" 'ellama-ask-line
    "Ls" 'ellama-ask-summerize
    "L SPC" 'ellama-ask-about
    "L RET" 'ellama-ask-selection
    "L TAB" 'ellama-code-complete
    ))
