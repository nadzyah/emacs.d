(require-package 'spacemacs-theme)
(require-package 'leuven-theme)
(require-package 'catppuccin-theme)
;(require-package 'tree-sitter)
(require-package 'use-package)
(require-package 'pyvenv)
(require-package 'mermaid-mode)

(normal-erase-is-backspace-mode 0)

(setq warning-minimum-level :emergency)

;;;(load-theme 'spacemacs-dark t t)
;;;(load-theme 'catppuccin t t)

;;; (load-theme 'leuven-dark t t)
;;; (enable-theme 'leuven-dark)

(load-theme 'spacemacs-dark t t)
(enable-theme 'spacemacs-dark)

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

;; Set up wl-copy and wl-paste in terminal Emacs
(when (and (string= (getenv "XDG_SESSION_TYPE") "wayland")
         (executable-find "wl-copy")
         (executable-find "wl-paste"))
(defun my-wl-copy (text)
  "Copy with wl-copy if in terminal, otherwise use the original value of `interprogram-cut-function'."
  (if (display-graphic-p)
      (gui-select-text text)
    (let ((wl-copy-process
           (make-process :name "wl-copy"
                         :buffer nil
                         :command '("wl-copy")
                         :connection-type 'pipe)))
      (process-send-string wl-copy-process text)
      (process-send-eof wl-copy-process))))
(defun my-wl-paste ()
  "Paste with wl-paste if in terminal, otherwise use the original value of `interprogram-paste-function'."
  (if (display-graphic-p)
      (gui-selection-value)
    (shell-command-to-string "wl-paste --no-newline")))
(setq interprogram-cut-function #'my-wl-copy)
(setq interprogram-paste-function #'my-wl-paste))

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


(normal-erase-is-backspace-mode 0)

(setq your-own-path default-directory)
(if (file-exists-p
     (concat your-own-path ".emacs.desktop"))
    (if (y-or-n-p "Read .emacs.desktop and add hook?")
    (progn
      (desktop-read your-own-path)
      (add-hook 'kill-emacs-hook
            `(lambda ()
               (desktop-save ,your-own-path t))))))

(provide 'init-local)
