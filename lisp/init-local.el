(require-package 'spacemacs-theme)
(require-package 'leuven-theme)
(require-package 'catppuccin-theme)
;(require-package 'tree-sitter)
(require-package 'use-package)
(require-package 'pyvenv)
(require-package 'mermaid-mode)

(setq warning-minimum-level :emergency)

;;;(load-theme 'spacemacs-dark t t)
;;;(load-theme 'catppuccin t t)

(load-theme 'leuven-dark t t)
(enable-theme 'leuven-dark)

;;;(dired-sidebar-show-sidebar)

(use-package csharp-mode
  :mode "\\.cs$"
  :hook
  (csharp-mode-hook . subword-mode))

(use-package tree-sitter :ensure t)
(use-package tree-sitter-langs :ensure t)
(use-package tree-sitter-indent :ensure t)

(require-package 'xclip)

;(add-to-list 'load-path "~/.emacs.d/site-lisp/emacs-application-framework/")
;(require 'eaf)
;(require 'eaf-browser)
;(require 'eaf-pdf-viewer)

(use-package pyvenv
  :ensure t
  :config
  ;; Set the Python path when activating a virtualenv
  (defun my-pyvenv-set-pythonpath ()
    "Set PYTHONPATH to include custom directories."
    (setenv "PYTHONPATH"
            (concat (getenv "PYTHONPATH") ":/home/nadzeya/hexr/apps")))

  (add-hook 'pyvenv-post-activate-hooks 'my-pyvenv-set-pythonpath)
  (add-hook 'pyvenv-post-deactivate-hooks (lambda () (setenv "PYTHONPATH" nil))))
(provide 'init-local)
