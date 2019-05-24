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
;;(add-to-list 'load-path "~/.emacs.d/custom")


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

(require 'sr-speedbar)
(setq sr-speedbar-skip-other-window-p t)
(setq sr-speedbar-max-width 20)
;;(global-hl-line-mode 1)
(semantic-mode 0)

(require 'cc-mode)
(require 'function-args)
(require 'company)
(require 'ggtags)
(require 'dired)

(add-hook 'c-mode-common-hook
          (lambda ()
            (when (derived-mode-p 'c-mode 'c++-mode 'java-mode 'asm-mode)
              (ggtags-mode 1)
	      (company-mode 1)
	      (fa-config-default))))
(define-key c-mode-map  [(tab)] 'company-complete)
(define-key c++-mode-map  [(tab)] 'company-complete)

(dolist (map (list ggtags-mode-map dired-mode-map))
  (define-key map (kbd "C-c g s") 'ggtags-find-other-symbol)
  (define-key map (kbd "C-c g h") 'ggtags-view-tag-history)
  (define-key map (kbd "C-c g r") 'ggtags-find-reference)
  (define-key map (kbd "<f5>") 'ggtags-find-reference)
  (define-key map (kbd "C-c g f") 'ggtags-find-file)
  (define-key map (kbd "C-c g c") 'ggtags-create-tags)
  (define-key map (kbd "C-c g u") 'ggtags-update-tags)
  (define-key map (kbd "C-c g d") 'ggtags-find-definition)
  (define-key map (kbd "<f6>") 'ggtags-find-definition)
  (define-key map (kbd "<f8>") 'ggtags-find-tag-dwim)
  (define-key map (kbd "<f7>") 'pop-tag-mark)
  (define-key map (kbd "C-c <") 'ggtags-prev-mark)
  (define-key map (kbd "C-c >") 'ggtags-next-mark))



;; plugins
;; maxframe
(require 'maxframe)
;;(setq mf-max-width 1018)
;;(setq mf-max-height 730)
(add-hook 'window-setup-hook 'maximize-frame t)
;; color-theme
(require 'color-theme)
(color-theme-initialize)
(color-theme-classic)


;; golang
(require 'go-autocomplete)
(require 'go-eldoc)
(require 'go-mode)
(require 'auto-complete-config)
(require 'golint)
(require 'go-guru)

(defun go-mode-setup()
  (go-eldoc-setup)
  (setq gofmt-command "goimports")
  (add-hook 'before-save-hook 'gofmt-before-save)
  (local-set-key (kbd "<f2>") 'godef-jump)
  (local-set-key (kbd "<f3>") 'pop-tag-mark)
  (auto-complete-mode 1))

(add-hook 'go-mode-hook 'go-mode-setup)
(with-eval-after-load 'go-mode
  (require 'go-autocomplete))



;;(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
;; '(package-selected-packages
;;   (quote
;;    (sr-speedbar maxframe git ggtags function-args company-go company-c-headers color-theme))))
;;(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
;; )
