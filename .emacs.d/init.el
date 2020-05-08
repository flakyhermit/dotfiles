;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;; Add MELPA repo
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://www.mirrorservice.org/sites/melpa.org/packages/") t)
(package-initialize)

;; WILD TERRITORY - NO CUSTOMIZATION POST THIS POINT
;; ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector
   (vector "#002451" "#ff9da4" "#d1f1a9" "#ffeead" "#bbdaff" "#ebbbff" "#99ffff" "#ffffff"))
 '(beacon-color "#ff9da4")
 '(custom-safe-themes
   (quote
    ("ac2ca460db1668a48c35c4d0fd842e5d2ce2d4e8567a7903b76438f2750826cd" "b11699e28cc2f6c34fa6336e67d443be89fadb6a9b60de0b1594f31340ea87e4" "4555bf2b98f0ffef52bc4870f3014304b0e2ed22549c395dffc10af88d577791" "c19e5291471680e72d8bd98f8d6e84f781754a9e8fc089536cda3f0b7c3550e3" "6973f93f55e4a6ef99aa34e10cd476bc59e2f0c192b46ec00032fe5771afd9ad" "628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "ab98c7f7a58add58293ac67bec05ae163b5d3f35cddf18753b2b073c3fcd8841" "7f6d4aebcc44c264a64e714c3d9d1e903284305fd7e319e7cb73345a9994f5ef" "82d2cac368ccdec2fcc7573f24c3f79654b78bf133096f9b40c20d97ec1d8016" default)))
 '(fci-rule-color "#003f8e")
 '(flycheck-color-mode-line-face-to-color (quote mode-line-buffer-id))
 '(frame-background-mode (quote dark))
 '(ivy-mode t)
 '(package-selected-packages
   (quote
    (org-superstar company-org-roam deft org-roam-bibtex use-package sexy-monochrome-theme nord-theme projectile olivetti magit ivy color-theme-sanityinc-tomorrow busybee-theme)))
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#ff9da4")
     (40 . "#ffc58f")
     (60 . "#ffeead")
     (80 . "#d1f1a9")
     (100 . "#99ffff")
     (120 . "#bbdaff")
     (140 . "#ebbbff")
     (160 . "#ff9da4")
     (180 . "#ffc58f")
     (200 . "#ffeead")
     (220 . "#d1f1a9")
     (240 . "#99ffff")
     (260 . "#bbdaff")
     (280 . "#ebbbff")
     (300 . "#ff9da4")
     (320 . "#ffc58f")
     (340 . "#ffeead")
     (360 . "#d1f1a9"))))
 '(vc-annotate-very-old-color nil)
 '(window-divider-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
;; Set custom theme directory
(setq custom-theme-directory "~/.emacs.d/themes")
;; Disable all GUI crap
(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)
;; load
(load-theme 'nord)
;; Disable the ugly Emacs bull and the info
(setq inhibit-startup-message t)
;; set global face settings
(set-face-attribute 'variable-pitch nil :family "iA Writer DuoV" :height 105 :weight 'regular)
(set-face-attribute 'fixed-pitch nil :family "JetBrains Mono" :height 90 :weight 'semi-bold)
(set-face-attribute 'default nil :family "JetBrains Mono" :height 90 :weight 'semi-bold)
(require 'org)
(set-face-attribute 'org-default nil :family "JetBrains Mono" :height 120 :weight 'semi-bold)
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
;; 4. org-roam
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
