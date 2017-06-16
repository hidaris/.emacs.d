;; Racket
(use-package racket-mode
  :ensure t
  :defer t
  :config
  (add-hook 'racket-mode-hook 'parinfer-mode)
  (add-hook 'racket-repl-mode-hook 'parinfer-mode)
  (add-hook 'racket-mode-hook      #'racket-unicode-input-method-enable)
  (add-hook 'racket-repl-mode-hook #'racket-unicode-input-method-enable)
  (mapc (lambda (pr) (put (car pr) 'racket-indent-function (cdr pr)))
        '(;; eopl
          (cases . 2) (extend-env . 1)
          (extend-env-rec* . 1) (proc-val . 1)
          (procedure . 1) (letrec-exp . 1)
          (extend-env* . 1)
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
          (do*_state . 1) (letrec . 0))))

(use-package paren-face
  :ensure t
  :defer t
  :init
  ;; (add-hook 'racket-mode-hook (lambda () (rainbow-delimiters-mode -1)) t)
  (add-hook 'racket-mode-hook 'paren-face-mode)
  :config
  (custom-set-faces
   ;; custom-set-faces was added by Custom.
   '(parentheses ((t (:foreground "dim gray"))))
   '(parenthesis ((t (:foreground "dim gray"))))))

(provide 'init-racket)
