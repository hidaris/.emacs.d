;;; Git
;;; Code:
(use-package magit
  :ensure t
  :bind (("C-x g" . magit-status)))

(use-package diff-hl
  :ensure t
  :defer t
  :after visual-fill-column
  :config
  (global-diff-hl-mode +1)
  (add-hook 'dired-mode-hook 'diff-hl-dired-mode)
  (add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh))

(use-package projectile
  :ensure t
  :defer 0.3
  :bind ("s-p" . projectile-command-map)
  :config
  (projectile-mode +1)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  (setq projectile-completion-system 'ivy))

(use-package counsel-projectile         ; Counsel interface to projectile
  :ensure t
  :after projectile
  :config
  (counsel-projectile-mode))

(provide 'init-project)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-project.el ends here
