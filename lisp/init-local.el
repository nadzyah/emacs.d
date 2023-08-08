(require-package 'ample-theme)
(require-package 'spacemacs-theme)
;(require-package 'tree-sitter)
(require-package 'use-package)

(setq warning-minimum-level :emergency)

;(load-theme 'ample t t)
(load-theme 'spacemacs-dark t t)

;(load-theme 'ample-flat t t)
;(load-theme 'ample-light t t)

(enable-theme 'spacemacs-dark)

;(dired-sidebar-show-sidebar)

(use-package tree-sitter :ensure t)
(use-package tree-sitter-langs :ensure t)
(use-package tree-sitter-indent :ensure t)

(require 'auto-complete-config)
(ac-config-default)
(setq-default ac-sources
          '(
        ac-source-filename
        ac-source-abbrev 
        ac-source-dictionary
        ac-source-words-in-same-mode-buffers))

(provide 'init-local)
