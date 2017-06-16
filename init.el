;;; init.el --- Emacs configuration of hidaris  -*- lexical-binding: t; -*-

;;; Code:

;; increase GC threshold to reduce the frequency of garbage collection
(setq gc-cons-threshold 50000000)

;;; initialization
(when (version< emacs-version "25")
  (warn "This configuration needs Emacs trunk, but this is %s!" emacs-version))

;; always load newest byte code
(setq load-prefer-newer t)

(require 'package)
(setq package-enable-at-startup nil)
(setq package-archives
      ;; Package archives, the usual suspects
      '(("melpa-cn" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")
        ("org-cn"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/org/")
        ("gnu-cn"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")))

;; keep the installed packages in .emacs.d/elpa/
(setq package-user-dir (expand-file-name "elpa" user-emacs-directory))
(package-initialize)

;; bootstrap `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))


(eval-when-compile
  (require 'use-package))
(require 'diminish)       ;; if you use :diminish
(require 'bind-key)
(setq use-package-verbose t)

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
(add-to-list 'load-path (expand-file-name "modules" user-emacs-directory))

;; warn when opening files bigger than 100MB
(setq large-file-warning-threshold 100000000)

(defconst hidaris-savefile-dir (expand-file-name "savefile" user-emacs-directory))
;; create the savefile dir if it doesn't exist
(unless (file-exists-p hidaris-savefile-dir)
  (make-directory hidaris-savefile-dir))

(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))
      mouse-wheel-progressive-speed nil
      mouse-wheel-follow-mouse 't)

(setq user-full-name "hidaris"
      user-mail-address "izuo@outlook.com")

;; Package manager and init file
(use-package paradox                    ; Better package menu
  :ensure t
  :bind (("C-c a p" . paradox-list-packages)
         ("C-c a P" . paradox-upgrade-packages))
  :config
  (validate-setq
   paradox-execute-asynchronously nil   ; No async update, please
   paradox-spinner-type 'moon           ; Fancy spinner
   ;; Show all possible counts
   paradox-display-download-count t
   paradox-display-star-count t
   ;; Don't star automatically
   paradox-automatically-star nil
   ;; Hide download button, and wiki packages
   paradox-use-homepage-buttons nil     ; Can type v instead
   paradox-hide-wiki-packages t))

(use-package bug-hunter                 ; Search init file for bugs
  :ensure t)

(use-package validate                   ; Validate options
  :ensure t)

;; requires
(require 'init-core)
(require 'init-ui)
(require 'init-editor)

(use-package lisp-mode
  :config
  (defun hidaris-visit-ielm ()
    "Switch to default `ielm' buffer.
Start `ielm' if it's not already running."
    (interactive)
    (crux-start-or-switch-to 'ielm "*ielm*"))

  (add-hook 'emacs-lisp-mode-hook #'eldoc-mode)
  (add-hook 'emacs-lisp-mode-hook #'rainbow-delimiters-mode)
  (define-key emacs-lisp-mode-map (kbd "C-c C-z") #'hidaris-visit-ielm)
  (define-key emacs-lisp-mode-map (kbd "C-c C-c") #'eval-defun)
  (define-key emacs-lisp-mode-map (kbd "C-c C-b") #'eval-buffer)
  (add-hook 'lisp-interaction-mode-hook #'eldoc-mode)
  (add-hook 'eval-expression-minibuffer-setup-hook #'eldoc-mode))

(use-package ielm
  :config
  (add-hook 'ielm-mode-hook #'eldoc-mode)
  (add-hook 'ielm-mode-hook #'rainbow-delimiters-mode))

;;; Git
(use-package magit
  :ensure t
  :bind (("C-x g" . magit-status)))

(use-package diff-hl
  :ensure t
  :defer t
  :config
  (global-diff-hl-mode +1)
  (add-hook 'dired-mode-hook 'diff-hl-dired-mode)
  (add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh))

(use-package projectile
  :ensure t
  :defer 1
  :bind ("s-p" . projectile-command-map)
  :config
  (projectile-mode +1))

(use-package counsel-projectile         ; Counsel interface to projectile
  :ensure t
  :after projectile
  :config
  (counsel-projectile-on))

(use-package adaptive-wrap              ; Choose wrap prefix automatically
  :ensure t
  :defer t
  :init (add-hook 'visual-line-mode-hook #'adaptive-wrap-prefix-mode))

(use-package visual-fill-column         ; Fill column wrapping for Visual Line
                                        ; Mode
  :ensure t
  :defer t
  :bind (("C-c v v" . visual-fill-column-mode))
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

(use-package pt
  :ensure t)

(use-package image-file                 ; Visit images as images
  :init (auto-image-file-mode))

(use-package elisp-slime-nav
  :ensure t
  :config
  (dolist (hook '(emacs-lisp-mode-hook ielm-mode-hook))
    (add-hook hook #'elisp-slime-nav-mode)))

(use-package markdown-mode
  :ensure t
  :defer t)

(use-package yaml-mode
  :ensure t
  :defer t)


(require 'init-python)
(require 'init-racket)
(require 'init-web)

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file)

;;; init.el ends here
