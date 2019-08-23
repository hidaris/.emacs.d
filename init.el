;;; init.el --- Emacs configuration of hidaris  -*- lexical-binding: t; -*-

;;; Code:

;;; initialization

(when (version< emacs-version "26")
  (warn "This conf needs Emacs version >= 26, but this is %s!" emacs-version))

;; increase GC threshold to reduce the frequency of garbage collection
;; Optimize loading performance
(defvar default-file-name-handler-alist file-name-handler-alist)
(setq file-name-handler-alist nil)
(setq gc-cons-threshold 300000000)
(add-hook 'emacs-startup-hook
          (lambda ()
            "Restore defalut values after init"
            (setq file-name-handler-alist default-file-name-handler-alist)
            (setq gc-cons-threshold 800000)))

;; always load newest byte code
(setq load-prefer-newer t)

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
(add-to-list 'load-path (expand-file-name "modules" user-emacs-directory))

;; warn when opening files bigger than 100MB
(setq large-file-warning-threshold 100000000)

(defconst hidaris-savefile-dir (expand-file-name "savefile" user-emacs-directory))

;; create the savefile dir if it doesn't exist
(unless (file-exists-p hidaris-savefile-dir)
  (make-directory hidaris-savefile-dir))

;; use emacs-mac
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))
      mouse-wheel-progressive-speed nil
      mouse-wheel-follow-mouse 't)

(setq user-full-name "hidaris"
      user-mail-address "izuo@outlook.com")

;; requires
;; Packages
;; Without this comment Emacs25 adds (package-initialize) here
;; (package-initialize)
(require 'init-package)
(require 'init-core)
(require 'init-swiper)
(require 'init-ui)
(require 'init-highlight-symbol)
(require 'init-completion)
(require 'init-editor)
(require 'init-lsp)
(require 'init-dap)

(use-package bug-hunter                 ; Search init file for bugs
  :ensure t)

;; (use-package adaptive-wrap              ; Choose wrap prefix automatically
;;   :ensure t
;;   :defer t
;;   :init (add-hook 'visual-line-mode-hook #'adaptive-wrap-prefix-mode))

(use-package image-file                 ; Visit images as images
  :init (auto-image-file-mode))

(use-package ag
  :ensure t)

(require 'init-elisp)
(require 'init-python)
(require 'init-ruby)
(require 'init-racket)
(require 'init-go)
(require 'init-markup)
(require 'init-web)
(require 'init-project)
(require 'init-ocaml)
(require 'init-coq)
;; (require 'init-agda)

;; config changes made through the customize UI will be stored here
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))


;;; init.el ends here
