;;; init-core.el --- hidaris's Emacs : Core configuration.

;;; Commentary:

;; Basic configuration for Emacs Core.

;;; Code:

(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)

(use-package uniquify
  :config
  (setq uniquify-buffer-name-style 'forward)
  (setq uniquify-separator "/")
  ;; rename after killing uniquified
  (setq uniquify-after-kill-buffer-p t)
  ;; don't muck with special buffers
  (setq uniquify-ignore-buffers-re "^\\*"))

(use-package saveplace                  ; Save point position in files
  :init (save-place-mode 1)
  :config
  (setq save-place-file (expand-file-name "saveplace" hidaris-savefile-dir)))

(use-package savehist
  :config
  (setq savehist-additional-variables
        ;; search entries
        '(search-ring regexp-search-ring)
        ;; save every minute
        savehist-autosave-interval 60
        history-length 1000
        ;; keep the home clean
        savehist-file (expand-file-name "savehist" hidaris-savefile-dir))
  (savehist-mode +1))

(use-package recentf
  :config
  (validate-setq
   recentf-save-file (expand-file-name "recentf" hidaris-savefile-dir)
   recentf-max-saved-items 200
   recentf-max-menu-items 15
   ;; Cleanup recent files only when Emacs is idle, but not when the mode
   ;; is enabled, because that unnecessarily slows down Emacs.
   recentf-auto-cleanup 300
   recentf-exclude (list "/\\.git/.*\\'"     ; Git contents
                         "/elpa/.*\\'"       ; Package files
                         "/itsalltext/"      ; It's all text temp files
                         ))
  (recentf-mode +1))

(use-package dired
  :defer t
  :config
  ;; dired - reuse current buffer by pressing 'a'
  (put 'dired-find-alternate-file 'disabled nil)

  ;; always delete and copy recursively
  (setq dired-recursive-deletes 'always)
  (setq dired-recursive-copies 'always)

  ;; if there is a dired buffer displayed in the next window, use its
  ;; current subdir, instead of the current subdir of this dired buffer
  (setq dired-dwim-target t)

  ;; enable some really cool extensions like C-x C-j(dired-jump)
  (require 'dired-x))

(use-package sudo-edit                  ; Edit files as root, through Tramp
  :ensure t
  :defer t
  :bind (("C-c f s" . sudo-edit)))

(use-package exec-path-from-shell
  :ensure t
  :defer 0.3
  :config
  (when (memq window-system '(mac ns x))
    ;; (setq exec-path-from-shell-arguments '("-l"))
    (exec-path-from-shell-initialize)))

;; (use-package flyspell
;;   :config
;;   (setq ispell-program-name "aspell" ; use aspell instead of ispell
;;         ispell-extra-args '("--sug-mode=ultra"))
;;   (add-hook 'text-mode-hook #'flyspell-mode)
;;   (add-hook 'prog-mode-hook #'flyspell-prog-mode))

(use-package flycheck
  :ensure t
  :defer 0.2
  :config
  (global-flycheck-mode t))

(use-package super-save
  :ensure t
  :config
  (super-save-mode +1)
  :diminish super-save-mode)

(use-package undo-tree
  :ensure t
  :config
  ;; autosave the undo-tree history
  (setq undo-tree-history-directory-alist
        `((".*" . ,temporary-file-directory)))
  (setq undo-tree-auto-save-history t))

(provide 'init-core)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-core.el ends here
