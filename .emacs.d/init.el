; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;; Add MELPA repo
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://www.mirrorservice.org/sites/melpa.org/packages/") t)
(package-initialize)

;; Set custom theme directory
(setq custom-theme-directory "~/.emacs.d/themes")
;; Disable all GUI crap
(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)
(global-visual-line-mode t)
;; set theme
(load-theme 'doom-one t)
;; Disable the ugly Emacs bull and the info
(setq inhibit-startup-message t)
;; set global face settings
(set-face-attribute 'variable-pitch nil :family "Comic Mono" :height 110 :weight 'regular)
(set-face-attribute 'fixed-pitch nil :family "JetBrains Mono" :height 85 :weight 'semi-bold)
(set-face-attribute 'default nil :family "JetBrains Mono" :height 90 :weight 'semi-bold)
;; Global keybindings
(global-set-key (kbd "C-x C-t") 'eshell)
(global-set-key (kbd "<f9>") 'eshell)
(global-set-key (kbd "C-x K") 'kill-this-buffer)

;; Enable minor modes
;; (ivy-mode)
;; Enable line numbers by default
;; (global-display-line-numbers-mode)

(require 'use-package)
;; Package configurationsx
;; 1. projectile
(use-package projectile
  :bind (("C-x p" . projectile-mode)
	 :map projectile-mode-map
	 ("C-x p n" . projectile-add-known-project)
	 ("C-x p p" . projectile-switch-project))
  :config (setq projectile-completion-system 'ivy)
          (setq projectile-mode-line-function '(lambda () (format " [%s]" (projectile-project-name)))))

;; 2. magit
(use-package magit
  :bind ("C-x g" . magit-status))
;; org-mode
(use-package org
   :config
    (set-face-attribute 'org-document-title nil :family "Comic Mono" :height 140 :weight 'regular))
;;   (set-face-attribute 'org-verbatim nil :family "JetBrains Mono" :height 90 :weight 'semi-bold)
;;    (set-face-attribute 'org-code nil :family "JetBrains Mono" :height 90 :weight 'semi-bold))

(add-hook 'org-mode-hook
	  (lambda ()
	    (setq line-spacing 3)
	    (setq left-margin-width 2)
	    (setq right-margin-width 2)))
(use-package org-indent
  :init (add-hook 'org-mode-hook #'org-indent-mode))
(use-package mixed-pitch
  :init (add-hook 'org-mode-hook #'mixed-pitch-mode))

;; org-roam
(use-package org-roam
      :hook 
      (after-init . org-roam-mode)
      :custom
      (org-roam-directory "~/Documents/org")
      :bind (:map org-roam-mode-map
              (("C-c n l" . org-roam)
               ("C-c n f" . org-roam-find-file)
               ("C-c n g" . org-roam-show-graph))
              :map org-mode-map
              (("C-c n i" . org-roam-insert))))

(add-hook 'prog-mode-hook
	  (lambda ()
	    (display-line-numbers-mode)))
(add-hook 'text-mode-hook
	  (lambda ()
	    (display-line-numbers-mode -1)
	    (variable-pitch-mode 'toggle)))

;; deft
(defun xaf-deft-mode-settings()
  (display-line-numbers-mode -1))
(use-package deft
  :bind ("<f8>" . deft)
  :commands (deft)
  :config (setq deft-directory "~/Documents/org"
                deft-extensions '("org")
		deft-default-extension "org")
  :init (add-hook 'deft-mode-hook #'xaf-deft-mode-settings))

;; evil-snipe
(use-package evil-snipe
  :config (setq evil-snipe-scope 'buffer)
  :init (evil-snipe-mode 1))
;; evil-snipe causes problems with magit buffers; override
(add-hook 'magit-mode-hook 'turn-off-evil-snipe-override-mode)

;; delight
(use-package delight
  :init (delight '((org-roam-mode " roam" org-roam)
		   (emacs-lisp-mode "elisp" :major)
		   (eldoc-mode nil "eldoc")
		   (visual-line-mode "" t)
		   (undo-tree-mode "" undo-tree))))

;; olivetti
(defun xaf-olivetti-mode-setup()
  (display-line-numbers-mode 'toggle)
  (variable-pitch-mode 'toggle))
(use-package olivetti
  :bind ("C-x t o" . olivetti-mode)
  :config (setq olivetti-body-width 120)
  :init (add-hook 'olivetti-mode-hook #'xaf-olivetti-mode-setup))

;; start modes
(evil-mode 1)
(projectile-mode 1)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("b11699e28cc2f6c34fa6336e67d443be89fadb6a9b60de0b1594f31340ea87e4" "6973f93f55e4a6ef99aa34e10cd476bc59e2f0c192b46ec00032fe5771afd9ad" default)))
 '(ivy-mode t)
 '(org-roam-directory "~/Documents/org")
 '(package-selected-packages
   (quote
    (delight markdown-mode use-package sexy-monochrome-theme projectile org-superstar olivetti nord-theme mixed-pitch magit ivy evil-snipe elpy doom-themes deft company-org-roam color-theme-sanityinc-tomorrow busybee-theme))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
