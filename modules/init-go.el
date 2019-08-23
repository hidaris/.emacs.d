;; init-go.el --- Initialize Golang configurations.	-*- lexical-binding: t -*-

;; Copyright (C) 2019 Hidaris

;; Author: Hidaris <zuocool@gmail.com>
;; URL: https://github.com/hidaris/.emacs.d

;; This file is not part of GNU Emacs.
;;
;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 2, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth
;; Floor, Boston, MA 02110-1301, USA.
;;

;;; Commentary:
;;
;; Golang configurations.
;;

;;; Code:
(use-package go-mode
  :ensure t
  :mode (("\\.go\\'" . go-mode))
  :config
  (add-hook 'go-mode-hook
          (lambda ()
            (add-hook 'before-save-hook 'gofmt-before-save)
            (setq tab-width 4)
            (setq indent-tabs-mode t)
            (lsp-deferred)
            ;; (push '(company-lsp :with company-tabnine :separate)
            ;;       company-backends)
            ))

  ;; Format with `goimports' if possible, otherwise using `gofmt'
  (when (executable-find "goimports")
    (setq gofmt-command "goimports"))

  (use-package go-eldoc
    :ensure t
    :hook (go-mode . go-eldoc-setup))

  (use-package go-guru
    :ensure t
    :hook (go-mode . go-guru-hl-identifier-mode))

  (use-package go-rename
    :ensure t)
  )

(provide 'init-go)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-go.el ends here
