;; init-python.el --- Initialize Python configurations.	-*- lexical-binding: t -*-

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
;; Python configurations.
;;
;;; Code:

(use-package python
  :defer t
  :init
  (setq python-indent-offset 4)
  :config
  ;; PEP 8 compliant filling rules, 79 chars maximum
  (add-hook 'python-mode-hook #'subword-mode))

(use-package pyvenv
  :ensure t
  :after python
  :config
  (setenv "WORKON_HOME" (expand-file-name "~/miniconda3/envs/"))
  )

(eval-when-compile
  (require 'f)
  (require 'subr-x)
  (require 'projectile nil t))

(defun custom-lsp-setup-python ()
  "Setup virtual env for Microsoft Python Language Server."
  (let ((env_file (concat (projectile-project-root) ".conda-env")))
    (if (f-exists? env_file)
        (let ((venv_name (f-read env_file 'utf-8)))
          (pyvenv-workon (string-trim venv_name))
          ;; (message (executable-find lsp-python-executable-cmd))
          )
      (progn
        (message "No conda env file found.")
        (setq lsp-python-executable-cmd "python3")
        (setq doom-modeline-env-python-executable "python3")))
    (lsp-deferred)
    (push '(company-lsp
            :with company-tabnine :separate)
          company-backends)))

(use-package lsp-python-ms
  :ensure t
  :after python
  :hook (python-mode . custom-lsp-setup-python)
  :init
  (setq lsp-python-ms-parse-dot-env-enabled nil)
  :demand)

(provide 'init-python)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-python.el ends here
