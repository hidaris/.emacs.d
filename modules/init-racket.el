;; Racket
(use-package racket-mode
  :ensure t
  :defer t
  :mode "\\.scm\\'"
  :config
  (add-hook 'racket-mode-hook      #'racket-unicode-input-method-enable)
  (add-hook 'racket-repl-mode-hook #'racket-unicode-input-method-enable)
  ;; (remove-hook 'racket-mode-hook #'company-box-mode t)
  ;; (remove-hook 'racket-repl-mode-hook #'company-box-mode t)
  (mapc (lambda (pr) (put (car pr) 'racket-indent-function (cdr pr)))
        '(;; eopl
          (extend-env . 0)
          (procedure . 1)
          (extend-env* . 1)
          (apply-cont . 1)
          ;; minikanren
          (conde . 0) (fresh . 1)
          (run . 1) (run* . 1) (run . 2)
          (lambdag@ . 1) (pmatch . 1)
          ;; J-Bob
          (dethm . 2) (J-Bob/step . 1)
          (J-Bob/prove . 1) (J-Bob/define . 1)
          ;; monad
          (mybegin . 1) (mylet . 1)
          (bind_identity . 1) (bind_state . 0)
          (remberevensXcountevens_cps . 1)
          (do*_state . 1) (letrec . 0)))
  )

(use-package paren-face
  :ensure t
  :defer t
  :init
  ;; (add-hook 'racket-mode-hook (lambda () (rainbow-delimiters-mode -1)) t)
  (add-hook 'racket-mode-hook 'paren-face-mode)
  (add-hook 'racket-repl-mode-hook 'paren-face-mode)
  )

;; (use-package agda2-mode
;;   ;; This declaration depends on the load-path established by agda-input.
;;   :mode "\\.agda\\'"
;;   :bind (:map agda2-mode-map
;;               ("C-c C-i" . agda2-insert-helper-function))
;;   :defer t
;;   :preface
;;   (defun agda2-insert-helper-function (&optional prefix)
;;     (interactive "P")
;;     (let ((func-def (with-current-buffer "*Agda information*"
;;                       (buffer-string))))
;;       (save-excursion
;;         (forward-paragraph)
;;         (let ((name (car (split-string func-def " "))))
;;           (insert "  where\n    " func-def "    " name " x = ?\n")))))
;;   :init
;;   (load-file (let ((coding-system-for-read 'utf-8))
;;                (shell-command-to-string "/usr/local/bin/agda-mode locate"))))


(provide 'init-racket)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-racket.el ends here
