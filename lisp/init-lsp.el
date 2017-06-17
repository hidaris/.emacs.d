(use-package lsp-mode
  :ensure t
  :config
  ;; fix pyls problem
  (setq create-lockfiles nil)
  (setq lsp-prefer-flymake nil)
  (setq lsp-message-project-root-warning t)
  (setq lsp-enable-snippet nil)
  )

(use-package lsp-ui
  :ensure t
  :after lsp-mode
  :bind
  (("M-." . lsp-ui-peek-find-definitions)
   ("M-?" . lsp-ui-peek-find-references))
  :init
  (setq lsp-ui-sideline-ignore-duplicate t)
  (setq lsp-ui-sideline-enable nil)
  (setq lsp-ui-doc-enable nil)
  (add-hook 'lsp-mode-hook 'lsp-ui-mode)
  :config
  ;; (setq lsp-enable-completion-at-point t
  ;;       ;; lsp-ui-doc-position 'at-point
  ;;       lsp-ui-doc-header nil
  ;;       lsp-ui-doc-enable t
  ;;       lsp-ui-doc-include-signature t
  ;;       lsp-ui-doc-border (doom-color 'fg))
  )

(use-package company-lsp
  :ensure t
  :after lsp-mode
  :init
  ;; Language servers have better idea filtering and sorting,
  ;; don't filter results on the client side.
  (setq company-transformers nil
        company-lsp-async t
        company-lsp-cache-candidates nil
        company-lsp-enable-snippet nil)
  :config
  (add-to-list 'company-backends #'company-lsp)
  )

(provide 'init-lsp)
;;; init-lsp.el ends here
