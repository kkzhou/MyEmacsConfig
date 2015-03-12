;; PATH
;;(setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin"))
;;(setq exec-path (append exec-path '("/usr/local/bin")))

;; el-get
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-user/recipes")
(el-get 'sync)

(setq el-get-sources
      '(
        (:name ecb
               :description "Emacs code browser"
               :type github
               :pkgname "alexott/ecb"
               :load "ecb.el"
               :compile ("ecb.el"))
        ))
(setq my-packages
      (append '(el-get)
	      '(color-theme)
	      '(maxframe)
	      (mapcar 'el-get-source-name el-get-sources))) 
(el-get 'sync my-packages)

;; basic setup
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

;; mode hook
(setq auto-mode-alist 
      (append '(("\\.cc$" . c++-mode)
	       ("\\.tcc$" . c++-mode)
	       ("\\.cpp$" . c++-mode)
	       ("\\.hpp$" . c++-mode)
	      ("\\.js$" . js2-mode))
	      auto-mode-alist))
;; ede
(global-ede-mode 1)
;; semantic
(semantic-mode 1)
(setq semantic-highlight-func-mode t)
(defun my-cedet-hook ()
  (local-set-key [(control return)] 'semantic-ia-complete-symbol)
  (local-set-key "\C-c?" 'semantic-ia-complete-symbol-menu)
  (local-set-key "\C-c>" 'semantic-complete-analyze-inline)
  (local-set-key "\C-cp" 'semantic-analyze-proto-impl-toggle)
  (local-set-key "\C-c,d" 'semantic-ia-fast-jump)
  (local-set-key "\C-c,c" 'semantic-symref-symbol)

  (local-set-key (kbd "<f4>") 'semantic-complete-analyze-inline)
  (local-set-key (kbd "<f5>") 'semantic-analyze-proto-impl-toggle)
  (local-set-key (kbd "<f6>") 'semantic-ia-fast-jump)
  (local-set-key (kbd "<f7>") 'semantic-symref-symbol)
  (setq buffer-read-only t))

(add-hook 'c-mode-common-hook 'my-cedet-hook)

(semantic-add-system-include "~/source/boost-trunk/" 'c++-mode)
(semantic-add-system-include "/usr/include/" 'c++-mode)
;;ecb
(setq ecb-tip-of-the-day nil)
;;(ecb-activate)
(setq ecb-source-path '("~/source/nginx/"
			"~/source/boost/"
			"~/source/linux/"
			"~/source/libuv/"))
(put 'narrow-to-region 'disabled nil)
