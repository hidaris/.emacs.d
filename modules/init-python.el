;;; Python
(use-package python
  :defer t
  :config
  ;; PEP 8 compliant filling rules, 79 chars maximum
  (add-hook 'python-mode-hook (lambda () (validate-setq fill-column 79)))
  (add-hook 'python-mode-hook #'subword-mode))

(use-package elpy
  :ensure t
  :defer t
  :init (with-eval-after-load 'python (elpy-enable))
  :config
  (setenv "IPY_TEST_SIMPLE_PROMPT" "1")
  (elpy-use-ipython))

(provide 'init-python)
