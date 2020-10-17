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
 '(company-idle-delay 0.32)
 '(custom-enabled-themes (quote (wombat)))
 '(js-indent-level 2)
 '(package-selected-packages
   (quote
    (prettier-js helm lsp-ui company-lsp exec-path-from-shell flycheck lsp-python-ms dap-mode which-key ## company-tern xref-js2 js2-refactor js2-mode use-package lsp-mode)))
 '(show-paren-mode t))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(lsp-ui-doc-header ((t (:inherit (font-lock-string-face italic))))))


;; (use-package lsp-mode
;;   :commands (lsp lsp-deferred)
;;   :hook (js-mode . lsp-deferred)	 
;;   :config
;; ;;  (add-hook 'js-mode-hook (lambda () (setq js-indent-level 2)))
;; ;;  (add-hook 'js-mode-hook (lambda () (setq tab-width 2)))

;;   (defun fmt-config-hooks ()
;;     (add-hook 'before-save-hook #'lsp-format-buffer t t)
;;     (add-hook 'before-save-hook #'lsp-organize-imports t t))
;;   (add-hook 'prog-mode-hook #'fmt-config-hooks))

;; optionally

;; (use-package lsp-ui
;;   :ensure t
;;   :hook ((lsp-ui-mode)))

;; (use-package lsp-ui
;;   :after lsp-mode
;;   :diminish
;;   :commands lsp-ui-mode
;;   :custom-face
;;  ;; (lsp-ui-doc-background ((t (:background nil))))
;;   (lsp-ui-doc-header ((t (:inherit (font-lock-string-face italic)))))
;;   :bind (:map lsp-ui-mode-map
;;               ([remap xref-find-definitions] . lsp-ui-peek-find-definitions)
;;               ([remap xref-find-references] . lsp-ui-peek-find-references)
;;               ("C-c u" . lsp-ui-imenu))
;;   :custom
;;   (lsp-ui-doc-enable t)
;;   (lsp-ui-doc-header t)
;;   (lsp-ui-doc-include-signature t)
;;   (lsp-ui-doc-position 'top)
;;   (lsp-ui-doc-border (face-foreground 'default))
;;   (lsp-ui-sideline-enable nil)
;;   (lsp-ui-sideline-ignore-duplicate t)
;;   (lsp-ui-sideline-show-code-actions nil)
;;   :config
;;   ;; Use lsp-ui-doc-webkit only in GUI
;;   (setq lsp-ui-doc-use-webkit t)
;;   ;; WORKAROUND Hide mode-line of the lsp-ui-imenu buffer
;;   ;; https://github.com/emacs-lsp/lsp-ui/issues/243
;;   (defadvice lsp-ui-imenu (after hide-lsp-ui-imenu-mode-line activate)
;;     (setq mode-line-format nil)))

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

;;;; init.el ends here
;; (add-hook 'js2-mode-hook
;;           (defun my-js2-mode-setup ()
;;             (flycheck-mode t)
;;             (when (executable-find "eslint")
;;               (flycheck-select-checker 'javascript-eslint))))


;; set transparency
(set-frame-parameter (selected-frame) 'alpha '(90 90))
(add-to-list 'default-frame-alist '(alpha 90 90))

(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)

(global-set-key (kbd "C-x b") 'helm-buffers-list)
(global-set-key (kbd "C-x r b") 'helm-bookmarks)
(global-set-key (kbd "C-x m") 'helm-M-x)
(global-set-key (kbd "M-y") 'helm-buffers-persistent-kill)
(global-set-key (kbd "C-x C-f") 'helm-find-files)



(use-package prettier-js)
(add-hook 'js-mode-hook 'prettier-js-mode)
(add-to-list 'auto-mode-alist '("\\.jsx$" . web-mode))

;;global-display-line-numbers-mode
 (add-hook 'after-init-hook #'global-display-line-numbers-mode)

