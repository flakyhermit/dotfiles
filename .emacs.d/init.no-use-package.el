;; ADDED by Package.el. This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(require 'package)

;; Add MELPA repo
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(setq package-load-list '(all))
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
(load-theme 'spacemacs-dark t)

;; Disable the ugly Emacs bull and the info
(setq inhibit-startup-message t)

;; Set custom face settings
(set-face-attribute 'variable-pitch nil :family "Dejavu Sans Mono" :height 115)
(set-face-font 'fixed-pitch "IBM Plex Mono 11")
(set-face-attribute 'default nil :family "IBM Plex Mono" :height 115)
(set-face-attribute 'font-lock-comment-face nil :family "IBM Plex Mono" :height 110 :weight 'regular :italic t)

;; Global keybindings
(global-set-key (kbd "<backtab>") 'next-buffer)
(global-set-key (kbd "C-x C-t") 'eshell)
(global-set-key (kbd "C-x k") 'kill-this-buffer)

;; Enable line numbers by default
;; (global-display-line-numbers-mode)

;; Custom function definitions
(defun custom/editing-mode()
  (variable-pitch-mode 1)
  (setq-local line-spacing 3)
  (setq-local left-margin-width 2)
  (setq-local right-margin-width 2))

;; Major-mode visual hooks
(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(add-hook 'text-mode-hook
	  (lambda ()
	    (custom/editing-mode)
	    (display-line-numbers-mode -1)))

;; Custom extensions
(add-to-list 'load-path "~/.emacs.d/custom")
(require 'personal-journal)

;; Package configurations
;; recentf ------------------------
(setq recentf-max-saved-items 100)
(recentf-mode 1)

;; evil ---------------------------
(evil-mode 1)

;; crux ---------------------------
(define-key ctl-x-map (kbd "C-r") 'crux-recentf-find-file)
(define-key ctl-x-map (kbd "C-_") 'crux-delete-file-and-buffer)
(define-key global-map (kbd "<f9>") 'crux-visit-term-buffer)

;; ivy ----------------------------
(ivy-mode 1)

;; amx ----------------------------
(setq amx-backend 'auto)
(amx-mode 1)

;; counsel ------------------------
(define-key ctl-x-map (kbd "C-b") 'counsel-switch-to-buffer)
(counsel-mode)

;; avy ----------------------------
(define-key global-map (kbd "C-;") 'avy-goto-word-1)
(avy-setup-default)

;; dired --------------------------
(add-hook 'dired-mode-hook #'dired-hide-details-mode)
(define-key dired-mode-map "-" 'dired-up-directory)

;; projectile ---------------------
(setq projectile-completion-system 'ivy
      projectile-mode-line-function '(lambda () (format " [%s]" (projectile-project-name))))
(projectile-mode 1)
(define-key global-map (kbd "C-x p p") 'projectile-switch-project)
(define-key global-map (kbd "C-x p n") 'projectile-add-known-project)

;; magit --------------------------
(define-key ctl-x-map (kbd "g") 'magit-status)

;; evil-snipe ---------------------
(setq evil-snipe-scope 'buffer)
(evil-snipe-mode 1)

;; olivetti -----------------------
(setq olivetti-mode-width 120)
(define-key ctl-x-map (kbd "t o") 'olivetti-mode)

;; markdown-mode ------------------
(add-hook 'markdown-mode-hook 'wc-mode)

;; org ----------------------------
(setq org-directory "~/Dropbox/Notes/org"
      org-return-follows-link t
      org-todo-keywords '((sequence "TODO" "ACTIVE" "REFILE" "HOLD" "|" "DONE"))
      org-inbox-file "~/Dropbox/Notes/org/inbox.org"
      org-agenda-files '("~/Dropbox/Notes/org")
      org-refile-targets '((org-inbox-file :maxlevel . 1)
			   ("~/Dropbox/Notes/org/emacs.org" :maxlevel . 1))
      org-startup-with-inline-images t
      org-capture-templates
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
(define-key mode-specific-map (kbd "a") 'org-agenda)
(define-key mode-specific-map (kbd "c") 'org-capture)
(add-hook 'org-mode-hook #'org-indent-mode)
(add-hook 'org-mode-hook #'mixed-pitch-mode)

;; deft ---------------------------
(setq deft-directory org-directory
      deft-recursive t
      deft-auto-save-interval -1.0
      deft-extensions '("org")
      deft-default-extension "org")
(define-key global-map (kbd "<f8>") 'deft)
(define-key mode-specific-map (kbd "f") 'deft-find-file)
(add-hook 'deft-mode-hook #'custom/editing-mode)

;; org-ref ------------------------
(setq reftex-default-bibliography '("~/Dropbox/Notes/org/bibliography/references.bib"))
(setq org-ref-bibliography-notes "~/Dropbox/bibliography/notes.org"
      org-ref-default-bibliography '("~/Dropbox/Notes/org/bibliography/references.bib")
      org-ref-pdf-directory "~/Dropbox/Notes/org/bibliography/bibtex-pdfs/")

;; org-roam -----------------------
(setq org-roam-directory (concat org-directory "/knowledgebase")
      org-roam-capture-templates `(("d" "default" plain #'org-roam-capture--get-point "\n- refs :: \n- tags :: %?\n\n" :file-name "%<%Y%m%d%H%M%S>-${slug}" :head "#+title: ${title}\n#+created: %U\n" :unnarrowed t)))
(org-roam-mode 1)
(define-key mode-specific-map (kbd "n l") 'org-roam-buffer-toggle-display)
(define-key mode-specific-map (kbd "n f") 'org-roam-find-file)
(define-key mode-specific-map (kbd "n g") 'org-roam-show-graph)
(define-key mode-specific-map (kbd "n i") 'org-roam-insert)

;; delight ------------------------
(delight '((org-roam-mode " roam" org-roam)
	   (emacs-lisp-mode "elisp" :major)
	   (org-indent-mode nil org-indent)
	   (buffer-face-mode nil t)
	   (eldoc-mode nil "eldoc")
	   (ivy-mode nil ivy)
	   (org-roam-mode nil org-roam)
	   (counsel-mode nil counsel)
	   (evil-snipe-mode nil snipe)
	   (visual-line-mode nil t)
	   (undo-tree-mode nil undo-tree)))

(load "my-faces.el")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(safe-local-variable-values (quote ((org-log-done . time)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
