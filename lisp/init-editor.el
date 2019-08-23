;;; init-editor.el --- hidaris's Emacs : Editor configuration.

;;; Commentary:

;; Basic configuration for Emacs Editor.

;;; Code:

;; Emacs modes typically provide a standard means to change the
;; indentation width -- eg. c-basic-offset: use that to adjust your
;; personal indentation width, while maintaining the style (and
;; meaning) of any files you load.
(setq-default indent-tabs-mode nil)   ;; don't use tabs to indent
(setq-default tab-width 4)            ;; but maintain correct appearance

;; Newline at end of file
(setq require-final-newline t)

;; delete the selection with a keypress
(delete-selection-mode t)

;; store all backup and autosave files in the tmp dir
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; revert buffers automatically when underlying files are changed externally
(global-auto-revert-mode t)

;; hippie expand is dabbrev expand on steroids
(setq hippie-expand-try-functions-list
      '(try-expand-dabbrev
        try-expand-dabbrev-all-buffers
        try-expand-dabbrev-from-kill
        try-complete-file-name-partially
        try-complete-file-name
        try-expand-all-abbrevs
        try-expand-list
        try-expand-line
        try-complete-lisp-symbol-partially
        try-complete-lisp-symbol))

;; use hippie-expand instead of dabbrev
(global-set-key (kbd "M-/") #'hippie-expand)
(global-set-key (kbd "s-/") #'hippie-expand)

;; replace buffer-menu with ibuffer
(global-set-key (kbd "C-x C-b") #'ibuffer)

;; align code in a pretty way
(global-set-key (kbd "C-x \\") #'align-regexp)

;; extend the help commands

(define-key 'help-command (kbd "C-i") #'info-display-manual)

;; smart tab behavior - indent or complete
(setq tab-always-indent 'complete)

(use-package easy-kill
  :ensure t
  :defer t
  :config
  (global-set-key [remap kill-ring-save] 'easy-kill))

(use-package move-text
  :ensure t
  :bind
  (([(meta shift up)] . move-text-up)
   ([(meta shift down)] . move-text-down)))

(use-package rainbow-mode
  :defer t
  :ensure t
  :config
  (add-hook 'prog-mode-hook #'rainbow-mode))

(use-package whitespace
  :defer t
  :init
  (dolist (hook '(prog-mode-hook text-mode-hook))
    (add-hook hook #'whitespace-mode))
  (add-hook 'before-save-hook #'whitespace-cleanup)
  :config
  (setq whitespace-line-column 80) ;; limit line length
  (setq whitespace-style '(face tabs empty trailing lines-tail))
  :diminish (whitespace-mode . " ⓦ"))

(use-package editorconfig
  :ensure t
  :defer t
  :config
  (editorconfig-mode 1))

(use-package paredit
  :ensure t
  :defer t
  :init
  (progn
    (add-hook 'emacs-lisp-mode-hook #'paredit-mode)
    (add-hook 'scheme-mode-hook #'paredit-mode)
    (add-hook 'racket-mode-hook #'paredit-mode)
    (add-hook 'racket-repl-mode-hook #'paredit-mode)
    (add-hook 'lisp-mode-hook #'paredit-mode)
    (add-hook 'lisp-interaction-mode-hook #'paredit-mode)
    (add-hook 'ielm-mode-hook #'paredit-mode)
    (add-hook 'eval-expression-minibuffer-setup-hook #'paredit-mode)))

(use-package smartparens
  :ensure t
  :bind (;; A fill paragraph in strict mode
         ("M-q"       . sp-indent-defun)
         ("C-<left>"  . sp-backward-barf-sexp)
         ("C-<right>" . sp-backward-slurp-sexp))
  :init
  (add-hook 'web-mode-hook #'smartparens-mode)
  (add-hook 'restclient-mode #'smartparens-mode)
  (add-hook 'python-mode-hook #'smartparens-mode)
  (add-hook 'go-mode-hook #'smartparens-mode)
  (add-hook 'ruby-mode-hook #'smartparens-mode)
  (add-hook 'idris-mode-hook #'smartparens-mode)
  (add-hook 'idris-repl-mode-hook #'smartparens-mode)
  (add-hook 'inferior-python-mode #'smartparens-mode)
  :config
  (require 'smartparens-config))

(use-package paren
  :config
  (show-paren-mode +1))

(use-package abbrev
  :config
  (setq save-abbrevs 'silently)
  (setq-default abbrev-mode t))

(use-package windmove
  :config
  ;; use shift + arrow keys to switch between visible buffers
  (windmove-default-keybindings))

(use-package expand-region
  :ensure t
  :bind ("C-=" . er/expand-region))

(use-package multiple-cursors           ; Edit text with multiple cursors
  :ensure t
  :bind (("C-c m <SPC>" . mc/vertical-align-with-space)
         ("C-c m a"     . mc/vertical-align)
         ("C-c m e"     . mc/mark-more-like-this-extended)
         ("C-c m h"     . mc/mark-all-like-this-dwim)
         ("C-c m i n"   . mc/insert-numbers)
         ("C-c m i l"   . mc/insert-letters)
         ("C-c m l"     . mc/edit-lines)
         ("C-c m n"     . mc/mark-next-like-this)
         ("C-c m p"     . mc/mark-previous-like-this)
         ("C-c m \\"    . mc/skip-to-next-like-this)
         ("C->"         . mc/mark-next-like-this)
         ("C-c \\"      . mc/skip-to-next-like-this)
         ("C-<"         . mc/mark-previous-like-this)
         ("C-c m r"     . vr/mc-mark)
         ("C-c m C-a"   . mc/edit-beginnings-of-lines)
         ("C-c m C-e"   . mc/edit-ends-of-lines)
         ("C-c m C-s"   . mc/mark-all-in-region))
  :config
  (validate-setq
   mc/mode-line
   ;; Simplify the MC mode line indicator
   '(:propertize (:eval (concat " " (number-to-string (mc/num-cursors))))
                 face font-lock-warning-face)))

(use-package crux
  :ensure t
  :bind (("C-c o" . crux-open-with)
         ("M-o" . crux-smart-open-line)
         ("C-c n" . crux-cleanup-buffer-or-region)
         ("C-M-z" . crux-indent-defun)
         ("C-c u" . crux-view-url)
         ("C-c e" . crux-eval-and-replace)
         ("C-c w" . crux-swap-windows)
         ("C-c D" . crux-delete-file-and-buffer)
         ("C-c r" . crux-rename-buffer-and-file)
         ("C-c t" . crux-visit-term-buffer)
         ("C-c k" . crux-kill-other-buffers)
         ("C-c TAB" . crux-indent-rigidly-and-copy-to-clipboard)
         ("C-c I" . crux-find-user-init-file)
         ("C-c S" . crux-find-shell-init-file)
         ("s-j" . crux-top-join-line)
         ("C-^" . crux-top-join-line)
         ("s-k" . crux-kill-whole-line)
         ("C-<backspace>" . crux-kill-line-backwards)
         ("s-o" . crux-smart-open-line-above)
         ;; ([remap move-beginning-of-line] . crux-move-beginning-of-line)
         ("C-a" . crux-move-beginning-of-line)
         ([(shift return)] . crux-smart-open-line)
         ([(control shift return)] . crux-smart-open-line-above)
         ([remap kill-whole-line] . crux-kill-whole-line)))

(provide 'init-editor)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-editor.el ends here
