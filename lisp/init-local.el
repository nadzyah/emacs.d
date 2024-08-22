(require-package 'ample-theme)
(require-package 'spacemacs-theme)
;(require-package 'tree-sitter)
(require-package 'use-package)
(require-package 'pyvenv)

(setq warning-minimum-level :emergency)

;(load-theme 'ample t t)
(load-theme 'spacemacs-dark t t)

;(load-theme 'ample-flat t t)
;(load-theme 'ample-light t t)

(enable-theme 'spacemacs-dark)

;(dired-sidebar-show-sidebar)

(use-package csharp-mode
  :mode "\\.cs$"
  :hook
  (csharp-mode-hook . subword-mode))

(use-package tree-sitter :ensure t)
(use-package tree-sitter-langs :ensure t)
(use-package tree-sitter-indent :ensure t)

(require-package 'xclip)

(add-to-list 'load-path "~/.emacs.d/site-lisp/emacs-application-framework/")
(require 'eaf)
(require 'eaf-browser)
(require 'eaf-pdf-viewer)

(provide 'init-local)
