;; Added by Package.el.  This must come before configurations of
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
;; load
(load-theme 'nord t)
;; Disable the ugly Emacs bull and the info
(setq inhibit-startup-message t)
;; set global face settings
(set-face-attribute 'variable-pitch nil :family "IBM Plex Sans" :height 105 :weight 'semi-bold)
(set-face-attribute 'fixed-pitch nil :family "JetBrains Mono" :height 90 :weight 'semi-bold)
(set-face-attribute 'default nil :family "JetBrains Mono" :height 90 :weight 'semi-bold)
;; Global keybindings
(global-set-key (kbd "C-x C-t") 'eshell)
(global-set-key (kbd "<f9>") 'eshell)
(global-set-key (kbd "C-x K") 'kill-this-buffer)

;; Enable minor modes
;; (ivy-mode)
;; Enable line numbers by default
;; (global-display-line-numbers-mode)

;; Package configurationsx
;; 1. projectile
(projectile-mode +1)
(setq projectile-completion-system 'ivy)
(define-key projectile-mode-map (kbd "C-x p") 'projectile-command-map)
(global-set-key (kbd "C-x p n") 'projectile-add-known-project)  ;; overrides find-other-file
;; 2. magit
(global-set-key (kbd "C-x g") 'magit-status)
;; 3. olivetti
;; use-package
(require 'use-package)
;; org-mode
(use-package org
  :config
  (set-face-attribute 'org-document-title nil :family "IBM Plex Serif" :height 140 :weight 'semi-bold)
  (set-face-attribute 'org-document-title nil :family "IBM Plex Serif" :height 140 :weight 'semi-bold)
  (org-indent-mode))

(use-package org-superstar
  :hook org-mode)

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
          (set-face-attribute 'deft-title-face nil :family "JetBrains Mono" :height 105 :weight 'bold)
	  (set-face-attribute 'deft-summary-face nil :family "JetBrains Mono" :height 90 :weight 'regular)
	  (set-face-attribute 'deft-header-face nil :family "JetBrains Mono" :height 105 :weight 'bold)
    
	  
  :init (add-hook 'deft-mode-hook #'xaf-deft-mode-settings))

;; olivetti
(defun xaf-olivetti-mode-setup()
  (display-line-numbers-mode 'toggle)
  (variable-pitch-mode 'toggle))
(use-package olivetti
  :bind ("C-x t o" . olivetti-mode)
  :config (setq olivetti-body-width 120)
  :init (add-hook 'olivetti-mode-hook #'xaf-olivetti-mode-setup))

(evil-mode)
