;;; Ocaml

(use-package tuareg
  :ensure t
  :defer t
  :config
  (progn
    ;; See README
    (setq tuareg-indent-align-with-first-arg nil)
    (add-hook
     'tuareg-mode-hook
     (lambda()
       (setq show-trailing-whitespace t)
       (setq indicate-empty-lines t)

       ;; Enable the representation of some keywords using fonts
       (when (functionp 'prettify-symbols-mode)
         (prettify-symbols-mode))

       ;; See README
       ;;(setq tuareg-match-patterns-aligned t)
       ;;(electric-indent-mode 0)
       ))

    ;; Easy keys to navigate errors after compilation:
    (define-key tuareg-mode-map [(f12)] 'next-error)
    (define-key tuareg-mode-map [(shift f12)] 'previous-error)


    ;; Use Merlin if available
    (when (require 'merlin nil t)
      (setq merlin-command 'opam)
      (add-to-list 'auto-mode-alist '("/\\.merlin\\'" . conf-mode))

      (when (functionp 'merlin-document)
        (define-key tuareg-mode-map (kbd "\C-c\C-h") 'merlin-document))

      ;; Run Merlin if a .merlin file in the parent dirs is detected
      (add-hook 'tuareg-mode-hook
                (lambda()
                  (let ((fn (buffer-file-name)))
                    (if (and fn (locate-dominating-file fn ".merlin"))
                        (merlin-mode)))))))
  )

;; (use-package lsp-ocaml
;;   :ensure t
;;   :config
;;   (progn
;;     (add-hook 'ocaml-mode-hook #'lsp-ocaml-enable)
;;     ))

(provide 'init-ocaml)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-ocaml.el ends here
