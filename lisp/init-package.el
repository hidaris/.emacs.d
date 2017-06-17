;; (require 'package)

;; Initialize packages
(unless (bound-and-true-p package--initialized) ; To avoid warnings in 27
  (setq package-enable-at-startup nil)          ; To prevent initializing twice
  (package-initialize))

(setq package-archives
      ;; Package archives, the usual suspects
      '(("melpa" . "http://melpa.org/packages/")
        ("org"   . "http://orgmode.org/elpa/")
        ("gnu"   . "http://elpa.gnu.org/packages/")))


;; keep the installed packages in .emacs.d/elpa/
(setq package-user-dir (expand-file-name "elpa" user-emacs-directory))

;; bootstrap `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

(use-package diminish :ensure t)
(require 'bind-key)
(setq use-package-verbose t)

(use-package validate                   ; Validate options
  :ensure t)

;; Package manager and init file
(use-package paradox                    ; Better package menu
  :ensure t
  :bind (("C-c a p" . paradox-list-packages)
         ("C-c a P" . paradox-upgrade-packages))
  :config
  (validate-setq
   paradox-execute-asynchronously t
   paradox-spinner-type 'moon           ; Fancy spinner
   ;; Show all possible counts
   paradox-display-download-count t
   paradox-display-star-count t
   ;; Don't star automatically
   paradox-automatically-star nil
   ;; Hide download button, and wiki packages
   paradox-use-homepage-buttons nil     ; Can type v instead
   paradox-hide-wiki-packages t
   ))

(provide 'init-package)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-package.el ends here
