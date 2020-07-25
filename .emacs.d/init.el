;; ADDED by Package.el. This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
; You may delete these explanatory comments.
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
(setq initial-scratch-message nil)

;; Set custom face settings
(set-face-attribute 'variable-pitch nil :family "Dejavu Sans Mono" :height 115)
(set-face-font 'fixed-pitch "IBM Plex Mono 11")
(set-face-attribute 'default nil :family "IBM Plex Mono" :height 115)
(set-face-attribute 'font-lock-comment-face nil :family "IBM Plex Mono" :height 110 :weight 'regular :italic t)

;; Global keybindings
(global-set-key (kbd "<backtab>") 'next-buffer)
(global-set-key (kbd "C-x C-t") 'eshell)
(global-set-key (kbd "C-x k") 'kill-this-buffer)
(global-set-key (kbd "C-9") 'evil-switch-to-windows-last-buffer)
(global-set-key (kbd "C-x d") (lambda() (interactive) (dired ".")))
(global-set-key (kbd "C-x C-d") 'dired)

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
(add-hook 'text-mode-hook (lambda ()
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
(add-hook 'ivy-mode-hook #'ivy-rich-mode)

;; amx ----------------------------
(setq amx-backend 'auto)
(amx-mode 1)

;; counsel ------------------------
(define-key ctl-x-map (kbd "C-b") 'persp-switch-to-buffer)
(counsel-mode)

;; avy ----------------------------
(define-key global-map (kbd "C-;") 'avy-goto-line)
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

;; persp-mode ---------------------
(setq persp-nil-name "-")
(persp-mode 1)

;; magit --------------------------
(define-key ctl-x-map (kbd "g") 'magit-status)

;; evil-snipe ---------------------
(setq evil-snipe-scope 'buffer)
(evil-snipe-mode 1)

;; olivetti -----------------------
(setq olivetti-body-width 120)
(define-key ctl-x-map (kbd "t o") 'olivetti-mode)

;; markdown-mode ------------------
(require 'markdown-mode)
(setq wc-modeline-format "%tw")
(add-hook 'markdown-mode-hook 'wc-mode)

;; org ----------------------------
(setq org-directory "~/Dropbox/Notes/org"
      org-return-follows-link t
      org-todo-keywords '((sequence "TODO(t)" "ACTV(a)" "REFL(r)" "HOLD(h)" "|" "DONE(d)"))
      org-inbox-file "~/Dropbox/Notes/org/inbox.org"
      org-agenda-files '("~/Dropbox/Notes/org")
      org-refile-targets '((org-inbox-file :maxlevel . 1)
			   ("~/Dropbox/Notes/org/emacs.org" :maxlevel . 1)
			   ("~/Dropbox/Notes/org/todo.org" :maxlevel . 1)
			   ("~/Dropbox/Notes/org/lists/books.org" :maxlevel . 3))
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
	("B" "Add a BOOK to the 'considering' list" entry
	(file+olp ,(concat org-directory "/lists/books.org") "Considering")
	"* %?\n")
	("r" "Add an ARTICLE to read later" checkitem
	(file+olp+datetree ,(concat org-directory "/lists/read-later.org"))
	"- [ ] %:annotation %?\n")
	("e" "An Emacs customization idea" entry
	(file+headline ,(concat org-directory "/emacs.org") "To-do")
	"* TODO %? \n\n")))
(define-key mode-specific-map (kbd "a") 'org-agenda)
(define-key mode-specific-map (kbd "c") 'org-capture)
(add-hook 'org-mode-hook #'org-indent-mode)
(add-hook 'org-mode-hook #'org-bullets-mode)
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
(setq org-ref-completion-library 'org-ref-ivy-cite)
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
(add-hook 'org-roam-mode-hook 'org-roam-bibtex-mode)
(add-hook 'org-roam-backlinks-mode-hook 'org-shifttab)

;; org-roam-bibtex ----------------
(org-roam-bibtex-mode 1)
(add-to-list 'orb-preformat-keywords "abstract")
(setq orb-templates
  '(("r" "ref" plain (function org-roam-capture--get-point) ""
     :file-name "${citekey}"
     :head "#+title: ${citekey}: ${title}\n#+roam_key: ${ref}\n\n" ; <--
     :unnarrowed t)))


;; delight ------------------------
(delight '((emacs-lisp-mode "elisp" :major)
	   (org-indent-mode nil org-indent)
	   (buffer-face-mode nil t)
	   (mixed-pitch-mode nil mixed-pitch)
	   (eldoc-mode nil "eldoc")
	   (ivy-mode nil ivy)
	   (org-roam-bibtex-mode nil org-roam-bibtex)
	   (org-roam-mode nil org-roam)
	   (counsel-mode nil counsel)
	   (evil-snipe-local-mode nil evil-snipe)
	   (visual-line-mode nil t)
	   (undo-tree-mode nil undo-tree)))

(load "my-faces.el")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" default)))
 '(elfeed-feeds
   (quote
    ("https://feeds.feedburner.com/TechCrunch/" "https://www.theverge.com/" "https://longreads.com/")))
 '(eyebrowse-mode nil)
 '(ivy-rich-mode t)
 '(nrepl-message-colors
   (quote
    ("#ee11dd" "#8584ae" "#b4f5fe" "#4c406d" "#ffe000" "#ffa500" "#ffa500" "#DC8CC3")))
 '(org-agenda-files
   (quote
    ("~/Dropbox/Notes/org/knowledgebase/20200528154104-outside_view.org" "/home/monk/Dropbox/Notes/org/archlinux.org" "/home/monk/Dropbox/Notes/org/blog-post-ideas.org" "/home/monk/Dropbox/Notes/org/events.org" "/home/monk/Dropbox/Notes/org/inbox.org" "/home/monk/Dropbox/Notes/org/observations.org" "/home/monk/Dropbox/Notes/org/podcasting_gear.org" "/home/monk/Dropbox/Notes/org/quotes.org" "/home/monk/Dropbox/Notes/org/r4r.org" "/home/monk/Dropbox/Notes/org/studies.org" "/home/monk/Dropbox/Notes/org/templates-for-dilemmas.org" "/home/monk/Dropbox/Notes/org/test.org" "/home/monk/Dropbox/Notes/org/thoughts.org" "/home/monk/Dropbox/Notes/org/todo.org")))
 '(package-selected-packages
   (quote
    (elfeed elfeed-score org-bullets org-beautify-theme org-super-agenda hl-sentence evil-goggles evil-magit zotelo ivy-rich neotree zweilight-theme command-log-mode persp-mode persp-mode-projectile-bridge zeno-theme yasnippet-snippets winum white-theme wc-mode use-package spacemacs-theme shrink-path request rebecca-theme projectile org-roam-server org-roam-bibtex org-ref org-evil olivetti mixed-pitch markdown-mode magit ivy-bibtex hl-todo evil-snipe evil-org emacsql-sqlite doom-themes dictionary delight deft crux counsel company-org-roam avy amx all-the-icons)))
 '(persp-mode t nil (persp-mode))
 '(safe-local-variable-values
   (quote
    ((display-line-numbers . t)
     (org-log-refile . time)
     (org-log-done-with-time . t)
     (org-log-done . time)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

