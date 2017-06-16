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
                    :family "Source Code Pro" :height 120)
(set-face-attribute 'variable-pitch nil
                    :family "Fira Sans" :height 130 :weight 'regular)

(use-package face-remap                 ; Face remapping
  :bind (("C-c w z" . text-scale-adjust)))

(use-package zenburn-theme
  :ensure t
  :config
  (load-theme 'zenburn t))

;; Configure a reasonable fill column, indicate it in the buffer and enable
;; automatic filling
(setq-default fill-column 80)
(add-hook 'text-mode-hook #'auto-fill-mode)
(diminish 'auto-fill-function " Ⓕ")

(bind-key "C-c x i" #'indent-region)

(use-package frame                      ; Frames
  :bind (("C-c w F" . toggle-frame-fullscreen))
  :init (progn
          ;; Kill `suspend-frame'
          (global-set-key (kbd "C-z") nil)
          (global-set-key (kbd "C-x C-z") nil))
  :config (add-to-list 'initial-frame-alist '(fullscreen . maximized)))

;;; Buffer, Windows and Frames
(validate-setq
 frame-resize-pixelwise t               ; Resize by pixels
 frame-title-format
 '(:eval (if (buffer-file-name)
             (abbreviate-file-name (buffer-file-name)) "%b"))
 ;; Size new windows proportionally wrt other windows
 window-combination-resize t)

(setq-default line-spacing 0.2)         ; A bit more spacing between lines

(use-package spaceline-config           ; A beautiful mode line
  :ensure spaceline
  :defer 0.5
  :config
  (spaceline-compile
    'lunaryorn
    ;; Left side of the mode line (all the important stuff)
    '(((buffer-modified buffer-size input-method) :face highlight-face)
      anzu
      '(buffer-id remote-host buffer-encoding-abbrev)
      ((point-position line-column buffer-position selection-info)
       :separator " | ")
      major-mode
      process
      (flycheck-error flycheck-warning flycheck-info)
      (python-pyvenv :fallback python-pyenv)
      ((which-function projectile-root) :separator " @ ")
      ((minor-modes :separator spaceline-minor-modes-separator) :when active))
    ;; Right segment (the unimportant stuff)
    '((version-control :when active)))

  (setq-default mode-line-format '("%e" (:eval (spaceline-ml-lunaryorn)))))

(use-package powerline                  ; The work-horse of Spaceline
  :ensure t
  :after spaceline-config
  :config (validate-setq
           powerline-height (truncate (* 1.0 (frame-char-height)))
           powerline-default-separator 'utf-8))

(use-package which-func                 ; Current function name
  :defer 1
  :config
  (which-function-mode)
  (validate-setq
   which-func-unknown "⊥"               ; The default is really boring…
   which-func-format
   `((:propertize (" ➤ " which-func-current)
                  local-map ,which-func-keymap
                  face which-func
                  mouse-face mode-line-highlight
                  help-echo "mouse-1: go to beginning\n\
mouse-2: toggle rest visibility\n\
mouse-3: go to end"))))

;; highlight the current line
(use-package hl-line
  :init (global-hl-line-mode 1))

(use-package which-key
  :ensure t
  :config
  (which-key-mode +1))

(provide 'init-ui)
