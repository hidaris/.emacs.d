(use-package markdown-mode
  :ensure t
  :defer t
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.txt\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown")
  )

(use-package deft
  :ensure t
  :config
  (setq deft-directory "~/notes"
        deft-extensions '("org" "md" "tex")
        deft-recursive t
        deft-use-filename-as-title t
        deft-use-filter-string-for-filename t
        deft-file-naming-rules '((noslash . "-")
                                 (nospace . "-")
                                 (case-fn . downcase))))

(use-package yaml-mode
  :ensure t
  :defer t
  )

(provide 'init-markup)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-markup.el ends here
