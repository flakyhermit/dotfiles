;; This is only needed once, near the top of the file
(eval-when-compile
  ;; Following line is not needed if use-package.el is in ~/.emacs.d
  (add-to-list 'load-path "/home/monk/.emacs.d/elpa/use-package-20200629.1856")
  (add-to-list 'load-path "~/.emacs.d/custom")
  (require 'use-package))

;; Add MELPA to package archives
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)

;; Set backup directory
(setq backup-directory-alist `(("." . "~/.saves")))

;; Set default frame size
(add-to-list 'default-frame-alist '(height . 34))
(add-to-list 'default-frame-alist '(width . 110))

;; Disable all GUI crap
(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)

;; Disable the ugly Emacs bull and the info
(setq inhibit-startup-message t)
(setq initial-scratch-message nil)

;; Enable basic minor modes
(global-visual-line-mode t)

;; Set theme
(load-theme 'doom-tomorrow-night t)

;; Set custom face settings
(set-face-font 'default "Jetbrains Mono-11.5")
(set-face-attribute 'variable-pitch nil :inherit 'default)
(set-face-attribute 'fixed-pitch nil :inherit 'default)
(set-face-attribute 'font-lock-comment-face nil :inherit 'default)

;; TODO Global keybindings
(global-set-key (kbd "<backtab>") 'next-buffer)
(global-set-key (kbd "C-x C-t") 'eshell)
(global-set-key (kbd "C-x k") 'kill-this-buffer)
(global-set-key (kbd "C-9") 'evil-switch-to-windows-last-buffer)
(global-set-key (kbd "C-x d") (lambda() (interactive) (dired ".")))
(global-set-key (kbd "C-x C-d") 'dired)

;; Custom extensions (from $EMACS_HOME/custom)
(require 'personal-journal)

;; Package configuartions
(require 'use-package)

;; recentf ------------------------
(use-package recentf
  :config
  (setq recentf-max-saved-items 100)
  (recentf-mode t))

;; evil ---------------------------
(use-package evil
  :config
  (evil-mode t))

;; crux ---------------------------
(use-package crux
  :bind
  (:map ctl-x-map
	("C-r" . crux-recentf-find-file)))
