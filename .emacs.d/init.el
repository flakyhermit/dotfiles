;; ADDED by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;; Add MELPA repo
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)

;; Set custom theme directory
(setq custom-theme-directory "~/.emacs.d/themes")
(setq backup-directory-alist `(("." . "~/.saves")))

;; Set default frame size
(add-to-list 'default-frame-alist '(height . 34))
(add-to-list 'default-frame-alist '(width . 110))

;; Disable all GUI crap
(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)

;; Enable basic minor modes
(global-visual-line-mode t)
(column-number-mode t)

;; Set theme
(load-theme 'doom-acario-light t)

;; Disable the ugly Emacs bull and the info
(setq inhibit-startup-message t)

;; Set custom face settings
(set-face-attribute 'variable-pitch nil :family "Dejavu Sans Mono" :height 115)
(set-face-font 'fixed-pitch "IBM Plex Mono 11") (set-face-attribute 'default nil :family "IBM Plex Mono" :height 115)
(set-face-attribute 'font-lock-comment-face nil :family "IBM Plex Mono" :height 110 :weight 'regular :foreground "#777777")

;; Global keybindings
(global-set-key (kbd "<backtab>") 'next-buffer)
(global-set-key (kbd "C-x C-t") 'eshell)
(global-set-key (kbd "<f9>") 'ansi-term)
(global-set-key (kbd "C-x k") 'kill-this-buffer)

;; Enable minor modes
;; Enable line numbers by default
;; (global-display-line-numbers-mode)

;; Major-mode visual hooks
(add-hook 'prog-mode-hook
	  (lambda ()
	    (display-line-numbers-mode)))
(add-hook 'text-mode-hook
	  (lambda ()
	    (display-line-numbers-mode -1)
;;   (flyspell-mode)
;;	    (variable-pitch-mode 'toggle)
	    ))

(add-hook 'dired-mode-hook
	  (lambda ()
	    (dired-hide-details-mode)
	    (define-key dired-mode-map "-" 'dired-up-directory)))

;; Custom extensions
(add-to-list 'load-path "~/.emacs.d/custom")
(require 'personal-journal)

;; Package configurations
;; Additional packages to install
;; evil, evil-snipe, crux, ivy, magit, projectile,
;; org-roam, markdown-mode, org-ref, org-roam-bibtex
;; deft, olivetti, delight
(require 'use-package)
;; (set-face-attribute 'term nil :family "IBM Plex Mono" :height 90))

;; recentf ------------------------
(use-package recentf
  :custom
  (recentf-max-saved-items 100)
  :init
  (recentf-mode 1))

;; crux ---------------------------
(use-package crux
  :bind
  ("C-x C-r" . crux-recentf-find-file)
  ("C-x C-a" . crux-sudo-edit)
  ("<f9>" . crux-visit-term-buffer)
  ("C-x _" . crux-delete-file-and-buffer)
  ("C-x C-K" . crux-kill-other-buffers))

;; ivy ----------------------------
(use-package ivy
  :config
  (set-face-attribute 'ivy-minibuffer-match-face-2 nil :underline t)
  (ivy-mode 1))

;; avy ----------------------------
(use-package avy
  :bind
  ("C-;" . avy-goto-word-1)
  :config
  (avy-setup-default))

;; amx ----------------------------
(use-package amx
  :ensure t
  :after ivy
  :custom
  (amx-backend 'auto)
  :config
  (amx-mode 1))

;; counsel -------------------------
(use-package counsel
  :ensure t
  :after (ivy amx)
  :bind
  ("C-x b" . switch-to-buffer)
  :init
  (counsel-mode 1))

;; projectile ---------------------
(use-package projectile
  :bind
  (("C-x p" . projectile-mode)
    :map projectile-mode-map
    ("C-x p n" . projectile-add-known-project)
    ("C-x p p" . projectile-switch-project))
  :custom
  (projectile-completion-system 'ivy)
  :config
  (setq projectile-mode-line-function '(lambda () (format " [%s]" (projectile-project-name))))
  :init
  (projectile-mode 1))

;; magit --------------------------
(use-package magit
  :bind
  ("C-x g" . magit-status))

;; yas-- --------------------------
(use-package yasnippet
  :init
  (yas-global-mode 0))

;; org-mode -----------------------
;; define "C-c o" as a global prefix for org-related commands
(define-prefix-command 'org-related-map)
(global-set-key (kbd "C-c o") 'org-related-map)
(use-package org
  :bind
  ("C-c a" . org-agenda)
  ("C-c c". org-capture)
  :custom
  (org-startup-with-inline-images t)
  :config
  (setq org-directory "~/Dropbox/Notes/org")
  (setq org-return-follows-link t)
  (setq org-agenda-files '("~/Dropbox/Notes/org"))
  (setq org-default-notes-file (concat org-directory "/notes.org"))
  (setq org-todo-keywords
           '((sequence "TODO" "ACTIVE" "HOLD" "|" "DONE")))
  (setq org-capture-templates
	`(("t" "Add a TODO" entry
	   (file ,(concat org-directory "/todo.org")) 
	   "* TODO %?\n")
	  ("T" "Just a THOUGHT" entry
	   (file ,(concat org-directory "/inbox.org"))
	   "* %?\n")
	  ("Q" "A QUOTE" entry
	   (file ,(concat org-directory "/quotes.org"))
	   "* %?\n\n")
	  ("b" "Add a BLOG post IDEA" entry
	   (file ,(concat org-directory "/blog-post-ideas.org")) 
	   "* %?\n")
	  ("b" "Add a BOOK to the 'considering' list" item
	   (file+olp ,(concat org-directory "/lists/books.org") "Non-fiction" "Considering")
	   "+  %?\n")
	  ("r" "Add an ARTICLE to read later" checkitem
	   (file+olp+datetree ,(concat org-directory "/lists/read-later.org"))
	   "- [ ] %:annotation %?\n")
	   ("e" "An Emacs customization idea" entry
	   (file+headline ,(concat org-directory "/emacs.org") "To-do")
	   "* TODO %?\n")))
  ;; (set-face-attribute 'org-document-title nil :family "IBM Plex Serif" :height 170 :weight 'semi-bold)
  ;; (set-face-attribute 'org-document-info-keyword nil :family "IBM Plex Mono" :foreground "#bbbbbb")
  (set-face-attribute 'org-meta-line nil :family "IBM Plex Mono" :foreground "#bbbbbb")
  (set-face-attribute 'org-link nil :weight 'semi-bold)
  (set-face-attribute 'org-list-dt nil :family "IBM Plex Mono")
  (set-face-attribute 'org-code 'default))

(use-package mixed-pitch)
;; org-mode enhancements
(defun xstom/editing-mode()
  (variable-pitch-mode 1)
  (setq-local line-spacing 3)
  (setq-local left-margin-width 2)
  (setq-local right-margin-width 2))

(defun xstom/org-mode()
  (xstom/editing-mode)
  (mixed-pitch-mode 1))

(defun xstom/markdown-mode()
  (xstom/editing-mode)
  (setq-local line-spacing 4))

(defun xstom/deft-mode()
  (xstom/editing-mode))

(add-hook 'text-mode-hook #'xstom/editing-mode)
(add-hook 'org-mode-hook #'xstom/org-mode)

(use-package org-indent
  :init (add-hook 'org-mode-hook #'org-indent-mode))

;; org-ref ------------------------
(use-package org-ref
  :config
  (setq reftex-default-bibliography '("~/Dropbox/Notes/org/bibliography/references.bib"))
  ;; see org-ref for use of these variables
  (setq org-ref-bibliography-notes "~/Dropbox/bibliography/notes.org"
	org-ref-default-bibliography '("~/Dropbox/Notes/org/bibliography/references.bib")
	org-ref-pdf-directory "~/Dropbox/Notes/org/bibliography/bibtex-pdfs/")
  (set-face-attribute 'org-ref-cite-face nil :weight 'semi-bold))

;; org-roam -----------------------
(use-package org-roam
  :hook 
  (after-init . org-roam-mode)
  :custom
  (org-roam-directory "~/Dropbox/Notes/org/knowledgebase")
  :config
  (setq org-roam-capture-templates `(("d" "default" plain #'org-roam-capture--get-point "\n- refs :: \n- tags :: %?\n\n" :file-name "%<%Y%m%d%H%M%S>-${slug}" :head "#+title: ${title}\n#+created: %U\n" :unnarrowed t)))
  :bind (:map org-roam-mode-map
          (("C-c n l" . org-roam)
           ("C-c n f" . org-roam-find-file)
           ("C-c n g" . org-roam-show-graph))
          :map org-mode-map
          (("C-c n i" . org-roam-insert))))
 
;; org-roam-bibtex --------------
(use-package org-roam-bibtex
  :after org-roam
;; :hook
;; (org-roam-mode . org-roam-bibtex-mode)
  :bind (:map org-mode-map
         (("C-c n a" . orb-note-actions))))

;; deft --------------------------
(use-package deft
  :bind
  ("<f8>" . deft)
  ("C-c f" . deft-find-file)
  :commands (deft)
  :config
  (setq deft-directory org-directory 
	deft-recursive t
        deft-auto-save-interval -1.0
	deft-extensions '("org")
	deft-default-extension "org")
  :init 
  (add-hook 'deft-mode-hook #'xstom/deft-mode))

;; markdown-mode -----------------
(use-package markdown-mode
  :init
  (add-hook 'markdown-mode-hook #'xstom/markdown-mode)
  (add-hook 'markdown-mode-hook 'wc-mode))

;; evil-snipe --------------------
(use-package evil-snipe
  ;; :custom
  ;; (evil-snipe-scope ')
  :init
  (evil-snipe-mode 1))

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

(load "my-faces.el")
;; start modes
(evil-mode 1)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(amx-backend (quote auto))
 '(custom-safe-themes
   (quote
    ("99ea831ca79a916f1bd789de366b639d09811501e8c092c85b2cb7d697777f93" "9b01a258b57067426cc3c8155330b0381ae0d8dd41d5345b5eddac69f40d409b" "bf387180109d222aee6bb089db48ed38403a1e330c9ec69fe1f52460a8936b66" "3577ee091e1d318c49889574a31175970472f6f182a9789f1a3e9e4513641d86" "a92e9da0fab90cbec4af4a2035602208cebf3d071ea547157b2bfc5d9bd4d48d" "3d3807f1070bb91a68d6638a708ee09e63c0825ad21809c87138e676a60bda5d" "bc836bf29eab22d7e5b4c142d201bcce351806b7c1f94955ccafab8ce5b20208" default)))
 '(evil-snipe-scope (quote buffer))
 '(fancy-splash-image "/home/monk/.local/share/icons/emacs.svg")
 '(fci-rule-color "#4E4E4E")
 '(hl-todo-keyword-faces
   (quote
    (("TODO" . "#dc752f")
     ("NEXT" . "#dc752f")
     ("THEM" . "#2d9574")
     ("PROG" . "#4f97d7")
     ("OKAY" . "#4f97d7")
     ("DONT" . "#f2241f")
     ("FAIL" . "#f2241f")
     ("DONE" . "#86dc2f")
     ("NOTE" . "#b1951d")
     ("KLUDGE" . "#b1951d")
     ("HACK" . "#b1951d")
     ("TEMP" . "#b1951d")
     ("FIXME" . "#dc752f")
     ("XXX+" . "#dc752f")
     ("\\?\\?\\?+" . "#dc752f"))))
 '(jdee-db-active-breakpoint-face-colors (cons "#D0D0E3" "#009B7C"))
 '(jdee-db-requested-breakpoint-face-colors (cons "#D0D0E3" "#005F00"))
 '(jdee-db-spec-breakpoint-face-colors (cons "#D0D0E3" "#4E4E4E"))
 '(objed-cursor-color "#D70000")
 '(olivetti-body-width 120 t)
 '(org-roam-directory "~/Dropbox/Notes/org/knowledgebase")
 '(package-selected-packages
   (quote
    (avy dictionary rebecca-theme white-theme spacemacs-theme zen-and-art-theme wc-mode yasnippet-lean hl-todo zeno-theme winum amx ivy-bibtex bibtex-completion org-roam-server org-roam-bibtex company-org-roam org-ref org-superstar yasnippet-snippets yasnippet olivetti org-evil evil-org use-package projectile org-roam mixed-pitch markdown-mode magit ivy evil-snipe doom-themes delight deft crux)))
 '(pdf-view-midnight-colors (quote ("#b2b2b2" . "#292b2e")))
 '(projectile-completion-system (quote ivy))
 '(recentf-max-saved-items 100)
 '(rustic-ansi-faces
   ["#F5F5F9" "#D70000" "#005F00" "#AF8700" "#1F55A0" "#AF005F" "#007687" "#0F1019"])
 '(safe-local-variable-values (quote ((org-log-done . time)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
