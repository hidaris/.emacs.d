;;; Commentary:
;;
;; Debug Adapter Protocol configurations.
;;

;;; Code:

(use-package dap-mode
  :ensure t
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
