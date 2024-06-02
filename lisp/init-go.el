;;; init-go.el --- Golang emacs support

(when (maybe-require-package 'go-mode)
  (when (maybe-require-package 'flycheck-golandci)
    (with-eval-after-load 'go-mode
      (add-hook 'flycheck-mode-hook #'flycheck-golangci-lint-setup))))


(provide 'init-go)
