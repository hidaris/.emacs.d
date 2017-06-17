;;; HTML & Javascript
(use-package web-mode
  :ensure t
  :defer t
  :mode (("\\.html\\'" . web-mode))
  :config
  (setq web-mode-markup-indent-offset 2))

(use-package css-mode                   ; CSS
  :defer t
  :config (validate-setq css-indent-offset 2))

(use-package js2-mode                   ; Powerful Javascript mode
  :ensure t
  :defer t
  :mode (("\\.js\\'" . js2-mode))
  :config
  ;; Disable parser errors and strict warnings.  We have Flycheck 8)
  (validate-setq js2-mode-show-parse-errors nil
                 js2-mode-show-strict-warnings nil
                 js2-highlight-level 3
                 js2-basic-offset 2))  ; Try to highlight most ECMA built-ins

(use-package js2-refactor               ; Refactor Javascript
  :ensure t
  :defer t
  :init
  (add-hook 'js2-mode-hook 'js2-refactor-mode)
  :config
  (js2r-add-keybindings-with-prefix "C-c m r"))

;;; Misc programming languages
(use-package sh-script                  ; Shell scripts
  :defer t
  :mode ("\\.zsh\\'" . sh-mode)
  :config
  ;; Use two spaces in shell scripts.
  (validate-setq
   sh-indentation 2                     ; The basic indentation
   sh-basic-offset 2))                    ; The offset for nested indentation

(use-package nginx-mode
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("/nginx/sites-\\(?:available\\|enabled\\)/" . nginx-mode))
  )

(provide 'init-web)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-web.el ends here
