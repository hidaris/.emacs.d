;;; init-swiper.el --- hidaris's Emacs : Swiper configuration.

;;; Commentary:

;; Basic configuration for Emacs Swiper.

;;; Code:

;;; Minibuffer completion
(use-package ivy
  :ensure t
  :init (ivy-mode 1)
  :bind (("C-c C-r" . ivy-resume))
  :config
  ;; Include recentf and bookmarks to switch buffer, and tune the count format.
  (validate-setq ivy-use-virtual-buffers t
                 ivy-count-format "(%d/%d) ")
  :diminish ivy-mode)

(use-package counsel                    ; Ivy-powered commands
  :ensure t
  :init (counsel-mode)
  :bind (([remap execute-extended-command] . counsel-M-x)
         ([remap find-file]                . counsel-find-file)
         ([remap describe-function]        . counsel-describe-function)
         ([remap describe-variable]        . counsel-describe-variable)
         ([remap info-lookup-symbol]       . counsel-info-lookup-symbol)
         ([remap completion-at-point]      . counsel-company)
         ("C-c f L"                        . counsel-load-library)
         ("C-c f r"                        . counsel-recentf)
         ("C-c i 8"                        . counsel-unicode-char)
         ("C-c s a"                        . counsel-ag)
         ("C-c j t"                        . counsel-imenu)
         ("C-c g L"                        . counsel-git-log))
  :diminish counsel-mode
  )

; isearch with overview
(use-package swiper
  :ensure t
  :bind (([remap isearch-forward] . swiper)))

(use-package smex
  :ensure t
  :defer t)

(use-package anzu
  :ensure t
  :bind (("M-%" . anzu-query-replace)
         ("C-M-%" . anzu-query-replace-regexp))
  :config
  (global-anzu-mode))

(use-package avy
  :ensure t
  :bind (("s-." . avy-goto-word-or-subword-1)
         ("s-," . avy-goto-char))
  :config
  (setq avy-background t))

(provide 'init-swiper)
;;; init-swiper.el ends here
