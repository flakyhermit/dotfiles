;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;; Add MELPA repo
(require 'package)
;; (add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)
(require 'use-package)
;; (require 'use-package-ensure)
;; (setq use-package-always-ensure t)
;; Set custom theme directory
(setq custom-theme-directory "~/.emacs.d/themes")
(setq backup-directory-alist `(("." . "~/.saves")))
;; Disable all GUI crap
(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)
;; enable basic minor modes
(global-visual-line-mode t)
(column-number-mode t)
;; set theme
(load-theme 'doom-nord t)
;; Disable the ugly Emacs bull and the info
(setq inhibit-startup-message t)
;; set custom face settings
(set-face-attribute 'variable-pitch nil :family "IBM Plex Mono" :height 120 :weight 'regular)
(set-face-attribute 'fixed-pitch nil :family "IBM Plex Mono" :height 90 :weight 'regular)
(set-face-attribute 'default nil :family "IBM Plex Mono" :height 110 :weight 'medium)

;; Global keybindings
(global-set-key (kbd "<backtab>") 'next-buffer)
(global-set-key (kbd "C-x C-t") 'eshell)
(global-set-key (kbd "<f9>") 'ansi-term)
(global-set-key (kbd "C-x K") 'kill-this-buffer)

;; Enable minor modes
;; (ivy-mode)
;; Enable line numbers by default
;; (global-display-line-numbers-mode)

;; Major-mode visual hooks
(add-hook 'prog-mode-hook
	  (lambda ()
	    (display-line-numbers-mode)))
(add-hook 'text-mode-hook
	  (lambda ()
	    (display-line-numbers-mode -1)
;;	    (flyspell-mode)
	    (variable-pitch-mode 'toggle)))

;; Package configurationsx
(require 'use-package)

;; crux ---------------------------
(use-package crux
  :bind ("C-x C-r" . crux-recentf-find-file)
        ("C-x C-K" . crux-kill-other-buffers))

;; ivy ----------------------------
(use-package ivy)

;; projectile ---------------------
(use-package projectile
  :bind (("C-x p" . projectile-mode)
	 :map projectile-mode-map
	 ("C-x p n" . projectile-add-known-project)
	 ("C-x p p" . projectile-switch-project))
  :config (setq projectile-completion-system 'ivy)
          (setq projectile-mode-line-function '(lambda () (format " [%s]" (projectile-project-name)))))

;; magit --------------------------
(use-package magit
  :bind ("C-x g" . magit-status))

;; org-mode -----------------------
;; define "C-c o" as a global prefix for org-related commands
(define-prefix-command 'org-related-map)
(global-set-key (kbd "C-c o") 'org-related-map)
(use-package org
  :bind
  ("C-c o a" . org-agenda)
  ("C-c o c". org-capture)
  :config
  (setq org-directory "~/Dropbox/Notes/org")
  (setq org-return-follows-link t)
  (setq org-agenda-files '("~/Dropbox/Notes/org" "~/Dropbox/Notes/org/knowledgebase"))
  (setq org-default-notes-file (concat org-directory "/notes.org"))
  (setq org-capture-templates
	`(("t" "Add a TODO" entry
	   (file ,(concat org-directory "/todo.org")) 
	   "* TODO %?\n")
	  ("b" "Add a BOOK to the 'considering' list" item
	   (file+olp ,(concat org-directory "/lists/books.org") "Non-fiction" "Considering")
	   "+  %?\n")
	  ("r" "Add an ARTICLE to read later" checkitem
	   (file+datetree ,(concat org-directory "/lists/read-later.org"))
	   "- [ ] %:annotation %?\n")
	   ("e" "An Emacs customization idea" entry
	   (file+headline ,(concat org-directory "/emacs.org") "To-do")
	   "* TODO %?\n")))
  (set-face-attribute 'org-document-title nil :family "IBM Plex Mono" :height 160 :weight 'semi-bold)
  (set-face-attribute 'org-code 'default))

;; org-mode enhancements
(defun custom-readability()
	    (setq line-spacing 3)
	    (setq left-margin-width 2)
	    (setq right-margin-width 2))
(add-hook 'org-mode-hook #'custom-readability)
(use-package org-indent
  :init (add-hook 'org-mode-hook #'org-indent-mode))
(use-package mixed-pitch
  :init (add-hook 'org-mode-hook #'mixed-pitch-mode))

;; org-roam -----------------------
 (use-package org-roam
       :hook 
       (after-init . org-roam-mode)
       :custom
       (org-roam-directory "~/Dropbox/Notes/org/knowledgebase")
       :config
       (setq org-roam-capture-templates `(("d" "default" plain #'org-roam-capture--get-point "\n* Meta\n - References: \n - Keywords: %?\n\n* Notes\n" :file-name "%<%Y%m%d%H%M%S>-${slug}" :head "#+TITLE: ${title}
" :unnarrowed t)))

       :bind (:map org-roam-mode-map
               (("C-c n l" . org-roam)
                ("C-c n f" . org-roam-find-file)
                ("C-c n g" . org-roam-show-graph))
               :map org-mode-map
               (("C-c n i" . org-roam-insert))))
 

;; deft --------------------------
(use-package deft
  :bind
  ("<f8>" . deft)
  ("C-c o f" . deft-find-file)
  :commands (deft)
  :config (setq deft-directory org-directory
		deft-recursive t
                deft-extensions '("org")
		deft-default-extension "org"))

(add-hook 'deft-mode-hook #'custom-readability)

;; markdown-mode -----------------
(use-package markdown-mode
  :init
  (add-hook 'markdown-mode-hook 'yas-minor-mode))
;; evil-snipe --------------------
(use-package evil-snipe
  :config (setq evil-snipe-scope 'buffer)
  :init (evil-snipe-mode 1))
;; evil-snipe causes problems with magit buffers; override
;; (add-hook 'magit-mode-hook 'turn-off-evil-snipe-override-mode)

;; delight -----------------------
(use-package delight
  :init (delight '((org-roam-mode " roam" org-roam)
		   (emacs-lisp-mode "elisp" :major)
		   (eldoc-mode nil "eldoc")
		   (visual-line-mode nil t)
		   (undo-tree-mode nil undo-tree))))

;; olivetti ----------------------
(use-package olivetti
  :bind ("C-x t o" . olivetti-mode)
  :custom (olivetti-body-width 120))

;; start modes
(evil-mode 1)
(recentf-mode 1)
(ivy-mode 1)
(projectile-mode 1)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("9b01a258b57067426cc3c8155330b0381ae0d8dd41d5345b5eddac69f40d409b" "bf387180109d222aee6bb089db48ed38403a1e330c9ec69fe1f52460a8936b66" "3577ee091e1d318c49889574a31175970472f6f182a9789f1a3e9e4513641d86" "a92e9da0fab90cbec4af4a2035602208cebf3d071ea547157b2bfc5d9bd4d48d" "3d3807f1070bb91a68d6638a708ee09e63c0825ad21809c87138e676a60bda5d" "bc836bf29eab22d7e5b4c142d201bcce351806b7c1f94955ccafab8ce5b20208" default)))
 '(olivetti-body-width 120 t)
 '(org-roam-directory "~/Dropbox/Notes/org/knowledgebase")
 '(package-selected-packages
   (quote
    (yatemplate yasnippet-snippets yasnippet olivetti org-evil evil-org use-package projectile org-roam mixed-pitch markdown-mode magit ivy evil-snipe doom-themes delight deft crux))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
