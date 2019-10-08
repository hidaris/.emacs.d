;; init-rust.el --- Initialize Rust configurations.	-*- lexical-binding: t -*-

;; Copyright (C) 2019 hidaris

;; Author: hidaris <zuocool@gmail.com>
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
;; Rust configurations.
;;

;;; Code:

;; Rust
(use-package rust-mode
  :ensure t
  :init (setq rust-format-on-save t)
  :hook (rust-mode . (lambda ()
                       (lsp-deferred)
                       (push '(company-lsp :with company-tabnine :separate)
                             company-backends)))
  :config
  (use-package cargo
    :ensure t
    :hook (rust-mode . cargo-minor-mode)
    :config
    ;; To render buttons correctly, keep it at the last
    (setq compilation-filter-hook
          (append compilation-filter-hook '(cargo-process--add-errno-buttons))))
  )

(use-package rust-playground :ensure t)

(provide 'init-rust)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-rust.el ends here
