(require 'package)
(add-to-list 'package-archives
         '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)
(when (not package-archive-contents)
    (package-refresh-contents))
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)
(add-to-list 'load-path "~/.emacs.d/custom")


;; basic setup
(setq default-directory "~/")
;;(set-keyboard-coding-system nil)
(when (eq system-type 'darwin)
  (setq mac-option-key-is-meta nil
        mac-command-key-is-meta t
        mac-command-modifier 'meta
        mac-option-modifier 'none))

(setq visible-bell t)
(setq suggest-key-bindings 5)
(setq ring-bell-function 'ignore)
(setq inhibit-startup-message t)
(setq column-number-mode t)
(setq backup-directory-alist '(("" . "~/.emacs.d/backup/")))
(setq-default make-backup-file t)
(setq version-control t)
(setq kept-old-versions 2)
(setq kept-new-versions 10)
(setq delete-old-versions t)
(auto-fill-mode 1)
(show-paren-mode)
(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)
;;(global-hl-line-mode 1)

(require 'setup-ggtags)
(require 'company)
(add-hook 'after-init-hook 'global-company-mode)

;; plugins
;; maxframe
(require 'maxframe)
;;(setq mf-max-width 1018)
;;(setq mf-max-height 730)
(maximize-frame t)
;;(add-hook 'window-setup-hook 'maximize-frame t)
;; color-theme
(require 'color-theme)
(color-theme-initialize)
(color-theme-classic)

;; function-args
(require 'cc-mode)
(require 'function-args)
(fa-config-default)
(define-key c-mode-map  [(tab)] 'company-complete)
(define-key c++-mode-map  [(tab)] 'company-complete)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (sr-speedbar maxframe git ggtags function-args company-go company-c-headers color-theme))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
