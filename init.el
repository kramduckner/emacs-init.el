(require 'package)
;; (add-to-list 'exec-path "/usr/local/bin/")


;; Just checking that you can do shit over https
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  (when no-ssl (warn "\
Your version of Emacs does not support SSL connections,
which is unsafe because it allows man-in-the-middle attacks.
There are two things you can do about this warning:
1. Install an Emacs version that does support SSL and be safe.
2. Remove this warning from your init file so you won't see it againx."))
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
  ;; and `package-pinned-packages`. Most users will not need or want to do this.
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  )

;; is supposed to find all the installed packages and activate them a la npm install
(package-initialize)
(package-install 'exec-path-from-shell)
(exec-path-from-shell-initialize)

;;(require 'prettier-js)
;; this is setting the custom variable settings for emacs, like faces and shit
;; it gets written by selecting things in dropdown menus
;; which is probably why they don't want you to edit it

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(company-idle-delay 0.2)
 '(custom-enabled-themes (quote (wombat)))
 '(js-indent-level 2)
 '(package-selected-packages
   (quote
    (react-snippets shr-tag-pre-highlight magit helm-projectile prettier-js helm lsp-ui company-lsp exec-path-from-shell flycheck lsp-python-ms dap-mode which-key ## company-tern xref-js2 js2-refactor js2-mode use-package lsp-mode)))
 '(show-paren-mode t))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(lsp-ui-doc-header ((t (:inherit (font-lock-string-face italic))))))


;;here
(use-package company-lsp :commands company-lsp)
(add-hook 'after-init-hook 'global-company-mode)


;;;;;;;;;(add-hook 'after-init-hook 'js-mode)
;; if you are helm user

;;(use-package helm-lsp :commands helm-lsp-workspace-symbol)
;; if you are ivy user
;;(use-package lsp-ivy :commands lsp-ivy-workspace-symbol)
;;(use-package lsp-treemacs :commands lsp-treemacs-errors-list)

;; optionally if you want to use debugger
;;(use-package dap-mode)
;; (use-package dap-LANGUAGE) to load the dap adapter for your language

;; optional if you want which-key integration

 (use-package which-key
   :ensure t
   :init
   (which-key-mode))

(use-package helm)


 (use-package flycheck
   :ensure t
   )


(add-hook 'after-init-hook #'global-flycheck-mode)

;; set transparency
(set-frame-parameter (selected-frame) 'alpha '(90 90))
(add-to-list 'default-frame-alist '(alpha 90 90))

(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)

(global-set-key (kbd "C-x b") 'helm-buffers-list)
(global-set-key (kbd "C-x r b") 'helm-bookmarks)
(global-set-key (kbd "C-x m") 'helm-M-x)
(global-set-key (kbd "M-y") 'helm-buffers-persistent-kill)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
;;(global-set-key (kbd "<ret>") 'company-complete)

(use-package prettier-js)
(add-hook 'js-mode-hook 'prettier-js-mode)
(add-to-list 'auto-mode-alist '("\\.jsx$" . web-mode))

;;global-display-line-numbers-mode
 (add-hook 'after-init-hook #'global-display-line-numbers-mode)

(require 'projectile)
(define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
(projectile-mode +1)



;; remove this line of file searches take too long.
(setq projectile-indexing-method 'hybrid)


(require 'yasnippet)
(yas-global-mode 1)


(global-set-key (kbd "C-x g") 'magit-status)

; Show suggestions after entering one character.
(setq company-minimum-prefix-length 1)
(setq backup-directory-alist '(("" . "~/.emacs.d/backup")))
