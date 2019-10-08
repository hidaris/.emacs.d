;;; Commentary:
;;
;; Debug Adapter Protocol configurations.
;;

;;; Code:

(use-package dap-mode
  :ensure t
  :bind (:map lsp-mode-map
              ("<f5>" . dap-debug))
  :hook ((after-init . dap-mode)
         (dap-mode . dap-ui-mode)
         (python-mode . (lambda () (require 'dap-python)))
         ;; (go-mode . (lambda () (require 'dap-go)))
         ;; (rust-mode . (lambda () (require 'dap-rust)))
         )
  )

(provide 'init-dap)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-dap.el ends here
