;;; init-ui.el --- hidaris's Emacs : UI configuration.

;;; Commentary:

;; Basic configuration for Emacs UI.

;;; Code:

;; the toolbar is just a waste of valuable screen estate
;; in a tty tool-bar-mode does not properly auto-load, and is
;; already disabled anyway
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))

;; the blinking cursor is nothing, but an annoyance
(blink-cursor-mode -1)

;; disable the annoying bell ring
(setq ring-bell-function 'ignore)

;; disable startup screen
(setq inhibit-startup-screen t)

;; disable mode-line mouseovers
(setq mode-line-default-help-echo nil)

;; nice scrolling
(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))

;; mode line settings
(line-number-mode t)
(column-number-mode t)
(size-indication-mode t)

;; enable y/n answers
(fset 'yes-or-no-p 'y-or-n-p)

;; more useful frame title, that show either a file or a
;; buffer name (if the buffer isn't visiting a file)
(setq frame-title-format
      '((:eval (if (buffer-file-name)
                   (abbreviate-file-name (buffer-file-name))
                 "%b"))))

;;; Fonts
(set-face-attribute 'default nil
                    :family "Monaco" :height 180)
(set-face-attribute 'variable-pitch nil
                    :family "Fira Sans" :height 146 :weight 'regular)

(use-package face-remap                 ; Face remapping
  :bind (("C-c w z" . text-scale-adjust)))

(use-package doom-themes
  :ensure t
  :config
  (load-theme 'doom-solarized-light t)
  (let ((line (face-attribute 'mode-line :underline)))
    (set-face-attribute 'mode-line          nil :overline   line)
    (set-face-attribute 'mode-line-inactive nil :overline   line)
    (set-face-attribute 'mode-line-inactive nil :underline  line)
    (set-face-attribute 'mode-line          nil :box        nil)
    (set-face-attribute 'mode-line-inactive nil :box        nil)
    (set-face-attribute 'mode-line-inactive nil :background "#f9f2d9"))
  )


;; Configure a reasonable fill column, indicate it in the buffer and enable
;; automatic filling
(setq-default fill-column 80)
;; (add-hook 'text-mode-hook #'auto-fill-mode)
;; (diminish 'auto-fill-function " Ⓕ")

(bind-key "C-c x i" #'indent-region)

;;; Buffer, Windows and Frames
(validate-setq
 frame-resize-pixelwise t               ; Resize by pixels
 frame-title-format
 '(:eval (if (buffer-file-name)
             (abbreviate-file-name (buffer-file-name)) "%b"))
 ;; Size new windows proportionally wrt other windows
 window-combination-resize t)

(setq-default line-spacing 0.2)         ; A bit more spacing between lines
(add-to-list 'default-frame-alist '(fullscreen . fullheight))
(add-to-list 'default-frame-alist '(width . 90))
(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
(add-to-list 'default-frame-alist '(ns-appearance . light))

(use-package olivetti
  :ensure t
  :defer t
  :init
  (dolist (hook '(text-mode-hook
                  racket-mode-hook))
    (add-hook hook #'olivetti-mode)))

;; highlight the current line
(use-package hl-line
  :defer t
  :init (global-hl-line-mode 1))

(use-package which-key
  :ensure t
  :defer t
  :config
  (which-key-mode +1))

(use-package doom-modeline
  :ensure t
  :defer t
  :hook (after-init . doom-modeline-mode)
  :config
  (setq doom-modeline-github nil)
  (setq doom-modeline-buffer-file-name-style 'file-name)
  (setq doom-modeline-height 1)
  (set-face-attribute 'mode-line nil :height 160)
  (set-face-attribute 'mode-line-inactive nil :height 160))

(use-package all-the-icons
  :ensure t
  :defer t)

(provide 'init-ui)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-ui.el ends here
