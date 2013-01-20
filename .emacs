;; load -path
(add-to-list 'load-path "~/.emacs.d/")
(add-to-list 'load-path "~/.emacs.d/color-theme-6.6.0/")
(add-to-list 'load-path "~/.emacs.d/ecb-2.40/")
;;meta
(set-keyboard-coding-system nil)
(when (eq system-type 'darwin)
 (setq mac-option-key-is-meta nil
       mac-command-key-is-meta t
       mac-command-modifier 'meta
       mac-option-modifier 'none))
;; bell
;;(setq visible-bell t)
(setq ring-bell-function 'ignore)
;; configure el-get
;; used for simple plugins, but not large ones like cedet/ecb
;; (defun install-el-get ()
;;  (interactive)
;;  (url-retrieve 
;;   "https://raw.github.com/dimitri/el-get/master/el-get-install.el" 
;;   (lambda (s) 
;;     (end-of-buffer) 
;;     (eval-print-last-sexp))))
;; make ~/.emacs.d and its subdirectries in load-path
;;(let* ((my-lisp-dir "~/.emacs.d/")
;;       (default-directory my-lisp-dir)
;;       (orig-load-path load-path))
;;  (setq load-path (cons my-lisp-dir nil))
;;  (normal-top-level-add-subdirs-to-load-path)
;;  (nconc load-path orig-load-path))
;;(require 'el-get)
;;don't show the message when startup
(setq inhibit-startup-message t)
;;show both column and row number
(setq column-number-mode t)
(setq backup-directory-alist '(("" . "~/backup/emacs/backup")))
(setq-default make-backup-file t)
(setq version-control t)
(setq kept-old-versions 2)
(setq kept-new-versions 10)
(setq delete-old-versions t)
;;set the widest column
(auto-fill-mode 1)
(setq default-fill-column 80)

;;set color
(require 'color-theme)
(color-theme-initialize)
(color-theme-classic)
;;bracket not jump back
(show-paren-mode t)
;;set frame title
(setq frame-title-format "%b@Emacs")
;;no menu such as "file", "edit"
(menu-bar-mode t)
;; maximize when startup
(require 'maxframe)
(setq mf-max-width 1018)
(setq mf-max-height 730)
(add-hook 'window-setup-hook 'maximize-frame t)
;;don't scroll half page up or down when the cursor is near the bottom or top
(setq scroll-margin 3
      scroll-conservatively 10000)
;;set kill ring
(setq kill-ring-max 200)
;;goto a line
(global-set-key "\M-g" 'goto-line)
;;backspace
;;(global-set-key (kbd "C-;") 'backward-kill-word)
;;highlight the region when marked
(transient-mark-mode t)
;;scroll line-by-line without move the cursor
(global-set-key (kbd "M-n") (lambda (&optional n) (interactive "p")
(scroll-up (or n 1))))
(global-set-key (kbd "M-p") (lambda (&optional n) (interactive "p")
(scroll-down (or n 1))))

(global-set-key (kbd "C-c C-;") 'comment-or-uncomment-region)
(global-set-key (kbd "M-w") 'copy-region-as-kill)
(global-set-key [C-backspace] 'backward-kill-word)
;;(global-set-key [backspace] 'c-hungry-backspace)

(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "/Users/zhouxiaobo/.emacs.d//ac-dict")
(ac-config-default)
;; cc-mode
(require 'google-c-style)
;;(add-hook 'c-mode-common-hook 'google-set-c-style)
(setq-default c-basic-offset 4)
(setq c-default-style "linux" c-basic-offset 4)
(setq c-default-style '((java-mode . "java")
			(other . "linux")))

;; python mode
(require 'python-mode)

;; cscope
(load-library "xcscope.el")
(require 'xcscope)
;; global
(autoload 'gtags-mode "gtags" "" t)
;; cedet
(load-file "~/.emacs.d/cedet-1.1/common/cedet.el")
(require 'cedet)
(require 'eieio-opt)
(require 'semantic-ia)
(require 'semantic-gcc)
(require 'gdb-mi)
(setq stack-trace-on-error nil)
(semantic-load-enable-code-helpers)
(setq semantic-highlight-func-mode t)
(unless (boundp 'xmax-tooltip-size)
 (setq x-max-tooltip-size '(80 . 40)))

(defun my-cedet-hook ()
  (local-set-key [(control return)] 'semantic-ia-complete-symbol)
  (local-set-key "\C-c?" 'semantic-ia-complete-symbol-menu)
  (local-set-key "\C-c>" 'semantic-complete-analyze-inline)
  (local-set-key "\C-cp" 'semantic-analyze-proto-impl-toggle)
  (local-set-key "\C-c,d" 'semantic-ia-fast-jump)
  (setq buffer-read-only t))
(add-hook 'c-mode-common-hook 'my-cedet-hook)
(setq auto-mode-alist 
      (append '(("\\.cc$" . c++-mode)
	       ("\\.tcc$" . c++-mode)
	       ("\\.hpp$" . c++-mode))
	      auto-mode-alist))

;; ecb
;;(setq stack-trace-on-error t)
(require 'ecb)
;;(ecb-activate)
;;(ecb-byte-compile)
(setq sys-include-dir "/usr/include")

(semantic-add-system-include sys-include-dir 'c++-mode)
(add-to-list 'auto-mode-alist (cons sys-include-dir 'c++-mode))
(add-to-list 'semantic-lex-c-preprocessor-symbol-file (concat sys-include-dir "stdlib.h"))

(setq ecb-tip-of-the-day nil)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ecb-source-path (quote ("~/source/kknf/" "~/source/nginx-1.3.4" "~/source/leveldb" "~/source/tmp/" "~/source/boost-trunk/" "/Users/zhouxiaobo/source/linux-3.6.11" "~/source/go/")))
 '(gdb-many-windows t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
