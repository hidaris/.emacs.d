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
                    :family "Monaco" :height 146)
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
(add-to-list 'default-frame-alist '(width . 100))
(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
(add-to-list 'default-frame-alist '(ns-appearance . light))

(use-package visual-fill-column         ; Fill column wrapping for Visual Line
                                        ; Mode
  :ensure t
  :defer t
  :bind (("C-c t v" . visual-fill-column-mode))
  :init
  ;; Turn on whenever visual line mode is on, and in all text or prog mode
  ;; buffers to get centered text
  (dolist (hook '(visual-line-mode-hook
                  prog-mode-hook
                  text-mode-hook))
    (add-hook hook #'visual-fill-column-mode))
  ;; Center text by default, and move the fringes close to the text.
  :config
  (setq-default visual-fill-column-center-text t
                visual-fill-column-fringes-outside-margins nil)
  ;; Split windows vertically despite large margins, because Emacs otherwise
  ;; refuses to vertically split windows with large margins
  (validate-setq split-window-preferred-function
                 #'visual-fill-column-split-window-sensibly))


;; highlight the current line
(use-package hl-line
  :init (global-hl-line-mode 1))

(use-package which-key
  :ensure t
  :config
  (which-key-mode +1))

(use-package doom-modeline
  :ensure t
  :defer t
  :hook (after-init . doom-modeline-mode)
  :config
  (setq doom-modeline-github nil)
  (setq doom-modeline-buffer-file-name-style 'file-name))

(use-package all-the-icons
  :ensure t)

(provide 'init-ui)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-ui.el ends here
