(setq hackartist-solidity-layers
      '(
        (solidity :variables solidity-flycheck-solc-checker-active t)
        ))

(setq hackartist-solidity-packages '())

(defun hackartist/solidity/init ()
  (with-eval-after-load 'lsp-mode
    (add-to-list 'lsp-language-id-configuration
                 '(solidity-mode . "solidity-language-server"))

    (defgroup lsp-solidity nil
      "LSP support for solidityl using solidity-language-server."
      :group 'lsp-mode
      :link '(url-link "https://www.npmjs.com/package/solidity-language-server"))

    (defcustom lsp-clients-solidity-executable '("solidity-language-server"  "--stdio")
      "Command to start the solidity language server."
      :group 'lsp-solidity
      :risky t
      :type 'file)

    (defcustom lsp-clients-solidity-initialization-options '()
      "Initialization options for solidity language server."
      :group 'lsp-solidity
      :type 'alist)

    (lsp-dependency 'solidity-language-server
                    '(:system "solidity-language-server")
                    '(:npm :package "solidity-language-server"
                           :path "solidity-language-server"))

    (lsp-register-client
     (make-lsp-client :new-connection (lsp-stdio-connection
                                       (lambda ()
                                         `(,(or (executable-find (cl-first lsp-clients-solidity-executable))
                                                (lsp-package-path 'solidity-language-server))
                                           ,@(cl-rest lsp-clients-solidity-executable))))
                      :major-modes '(solidity-mode)
                      :priority -1
                      :server-id 'solidity-language-server
                      :initialization-options (lambda () lsp-clients-solidity-initialization-options)
                      :download-server-fn (lambda (_client callback error-callback _update?)
                                            (lsp-package-ensure 'solidity-language-server
                                                                callback error-callback))))
    ;; (add-hook 'solidity-mode-hook #'lsp)
    ))

(defun hackartist/solidity/config ())

(defun hackartist/solidity/bindings ())
