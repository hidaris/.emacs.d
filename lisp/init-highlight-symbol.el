;; Highlighting and commands for symbols

(use-package highlight-symbol
  :ensure t
  :defer t
  :bind
  (("C-c s %" . highlight-symbol-query-replace)
   ("C-c s n" . highlight-symbol-next-in-defun)
   ("C-c s p" . highlight-symbol-prev-in-defun)
   ("C-c s o" . highlight-symbol-occur))
  ;; Navigate occurrences of the symbol under point with M-n and M-p, and
  ;; highlight symbol occurrences
  :init
  (dolist (fn '(highlight-symbol-nav-mode highlight-symbol-mode))
    (add-hook 'prog-mode-hook fn))
  :config
  (validate-setq
   highlight-symbol-idle-delay 0.4      ; Highlight almost immediately
   highlight-symbol-on-navigation-p t)  ; Highlight immediately after navigation
  )

(provide 'init-highlight-symbol)
;;; init-highlight-symbol.el ends here
