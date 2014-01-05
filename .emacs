;; basic setup
(add-to-list 'load-path "~/.emacs.d/")
(add-to-list 'load-path "~/.emacs.d/color-theme-6.6.0")
(add-to-list 'load-path "~/.emacs.d/auto-complete")
(add-to-list 'load-path "~/.emacs.d/ecb-2.40/")

(set-keyboard-coding-system nil)
(when (eq system-type 'darwin)
 (setq mac-option-key-is-meta nil
       mac-command-key-is-meta t
       mac-command-modifier 'meta
       mac-option-modifier 'none))
(setq visible-bell t)
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
(setq default-fill-column 80)
(show-paren-mode t)
(setq frame-title-format "%b@Emacs")
(menu-bar-mode -1)
(tool-bar-mode -1)
(setq scroll-margin 3
      scroll-conservatively 10000)
(setq kill-ring-max 200)
(global-set-key "\M-g" 'goto-line)
(transient-mark-mode t)
(global-set-key (kbd "M-n") (lambda (&optional n) (interactive "p")
(scroll-up (or n 1))))
(global-set-key (kbd "M-p") (lambda (&optional n) (interactive "p")
(scroll-down (or n 1))))

(global-set-key (kbd "C-c C-;") 'comment-or-uncomment-region)
(global-set-key (kbd "M-w") 'copy-region-as-kill)
(global-set-key [C-backspace] 'backward-kill-word)
(global-set-key (kbd "C-;") 'backward-kill-word)
;; plugins
;; maxframe
(require 'maxframe)
(setq mf-max-width 1018)
(setq mf-max-height 730)
(add-hook 'window-setup-hook 'maximize-frame t)
;; color-theme
(require 'color-theme)
(eval-after-load "color-theme"
 '(progn
         (color-theme-initialize)
         (color-theme-classic)))

;; auto-complete
;;(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(require 'auto-complete-config)
(ac-config-default)
;; cc-mode
(setq-default c-basic-offset 4)
(setq c-default-style "linux" c-basic-offset 4)
(setq c-default-style '((java-mode . "java")
			(other . "linux")))

(require 'cedet)
(require 'semantic/bovine/gcc)
(require 'semantic/ia)
(require 'semantic/analyze)
(provide 'semantic-analyze)
(provide 'semantic-ctxt)
(provide 'semanticdb)
(provide 'semanticdb-find)
(provide 'semanticdb-mode)
(provide 'semantic-load)
(semantic-mode 1)

(setq semantic-highlight-func-mode t)
(unless (boundp 'xmax-tooltip-size)
(setq x-max-tooltip-size '(80 . 40)))
(semantic-add-system-include "~/program/boost/" 'c++-mode)
(semantic-add-system-include "/usr/include/" 'c++-mode)

(defun my-cedet-hook ()
  (local-set-key [(control return)] 'semantic-ia-complete-symbol)
  (local-set-key "\C-c?" 'semantic-ia-complete-symbol-menu)
  (local-set-key "\C-c>" 'semantic-complete-analyze-inline)
  (local-set-key "\C-cp" 'semantic-analyze-proto-impl-toggle)
  (local-set-key "\C-c,d" 'semantic-ia-fast-jump)
  (local-set-key "\C-c,c" 'semantic-symref-symbol)
  (setq buffer-read-only t))

(add-hook 'c-mode-common-hook 'my-cedet-hook)
(setq auto-mode-alist 
      (append '(("\\.cc$" . c++-mode)
	       ("\\.tcc$" . c++-mode)
	       ("\\.hpp$" . c++-mode))
	      auto-mode-alist))

;; ecb
(setq ecb-source-path '("~/source/nginx-1.5.6/" "~/source/boost-trunk"))
(setq stack-trace-on-error t)
(setq ecb-tip-of-the-day nil)
(require 'ecb)
(ecb-activate)
(setq ecb-primary-secondary-mouse-buttons 'mouse-1--mouse-2)

