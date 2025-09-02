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

(use-package mu4e
  :ensure nil   ;; mu4e comes with mu in Debian
  :config
  ;; base maildir
  (setq mu4e-maildir "~/Maildir"
        mu4e-get-mail-command "mbsync -Va"
        mu4e-update-interval 300
        mu4e-headers-auto-update t)

  ;; Gmail folders
  (setq mu4e-sent-folder   "/gmail/[Gmail]/Sent Mail"
        mu4e-drafts-folder "/gmail/[Gmail]/Drafts"
        mu4e-trash-folder  "/gmail/[Gmail]/Trash"
        mu4e-refile-folder "/gmail/[Gmail]/All Mail")

  ;; sending via system nullmailer
  (setq message-send-mail-function 'message-send-mail-with-sendmail
        sendmail-program "/usr/sbin/sendmail"
        message-sendmail-envelope-from 'header
        mail-specify-envelope-from t
        mail-envelope-from 'header)

  ;; compose settings
  (setq user-mail-address "nadzya.info@gmail.com"
        user-full-name "Nadzeya Hutsko"
        mu4e-compose-format-flowed t
        mu4e-headers-show-threads t)

  (setq message-send-mail-function #'message-send-mail-with-sendmail
      sendmail-program "/usr/sbin/sendmail"  ; nullmailer’s sendmail wrapper
      message-sendmail-envelope-from 'header
      mail-specify-envelope-from t
      mail-envelope-from 'header)

  ;; PGP/MIME signing
  (require 'mml-sec)
  (setq mml-secure-openpgp-key-id "5975E885385EAC626E67EF9E1AF4A75FE769BC68")
  (add-hook 'message-setup-hook #'mml-secure-message-sign-pgpmime))
 
(setq mu4e-compose-in-new-frame nil)

(provide 'init-local)
