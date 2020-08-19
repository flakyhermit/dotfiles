; ADDED by Package.el. This must come before configurations of
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
(add-to-list 'default-frame-alist '(height . 36))
(add-to-list 'default-frame-alist '(width . 110))

;; Disable all GUI crap
(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)

; Enable basic minor modes
(global-visual-line-mode t)
(column-number-mode t)
(winner-mode t)

;; Disable the ugly Emacs bull and the info
(setq inhibit-startup-message t)
(setq initial-scratch-message nil)

;; Set theme
(load-theme 'doom-material t)

;; Set custom face settings
(set-face-attribute 'default nil :font "Jetbrains Mono-11" )
(set-face-attribute 'variable-pitch nil :font "Iosevka Sparkle-11.5" :weight 'regular)
(set-face-attribute 'fixed-pitch nil :inherit 'default)

(global-set-key (kbd "C-(") 'evil-prev-buffer)
(global-set-key (kbd "C-)") 'evil-next-buffer)
(global-set-key (kbd "C-x d") (lambda() (interactive) (dired default-directory)))
(global-set-key (kbd "C-x C-d") 'dired)
(global-set-key (kbd "C-x C-k") 'kill-bufFer)
(global-set-key (kbd "C-x k") 'kill-this-buffer)
(global-set-key (kbd "C-c d") 'sdcv-search-pointer)
(global-set-key (kbd "M-`") 'other-window)

;; Enable line numbers by default
;; (global-display-line-numbers-mode)

;; Safe-local variables
(setq safe-local-variable-values '((avy-words . s)
				   (org-num-max-level . 1)
				   (org-num-mode . t)
				   (display-line-numbers . t)
				   (org-log-refile . time)
				   (org-log-done . time)))

;; Custom function definitions
(defun custom/editing-mode()
  (variable-pitch-mode 1)
  (setq-local line-spacing 2)
  (setq-local left-margin-width 2)
  (setq-local right-margin-width 2))

(require 'evil)
;; After init hook
(add-hook 'after-init-hook (lambda()
			     (global-company-mode 1)
			     (recentf-mode 1)
			     (ivy-mode 1)
			     (amx-mode 1)
			     (counsel-mode 1)
			     (projectile-mode 1)
			     (org-roam-mode 1)
			     (evil-snipe-mode 1)
			     (load "./my-faces.el")))

;; Major-mode visual hooks
(add-hook 'fundamental-mode-hook (lambda () 
			    (evil-local-mode 1)))
(add-hook 'prog-mode-hook (lambda ()
			    (display-line-numbers-mode 1)
			    (evil-local-mode 1)
			    (hl-line-mode 1)
			    (hl-todo-mode 1)))
(add-hook 'conf-mode-hook (lambda()
			    (display-line-numbers-mode 1)
			    (evil-local-mode 1)
			    (hl-line-mode 1)
			    (hl-todo-mode 1)))
(add-hook 'text-mode-hook (lambda ()
			    (custom/editing-mode)
			    (flyspell-mode 1)
			    (evil-local-mode 1)
			    (display-line-numbers-mode -1)))
(add-hook 'special-mode-hook (lambda()
			       (evil-local-mode -1)))


;; Custom extensions
(add-to-list 'load-path "~/.emacs.d/custom")
(require 'personal-journal)

;; recentf ------------------------
(setq recentf-max-saved-items 100)
;; (recentf-mode t)

;; evil ---------------------------
;; (evil-mode 1)      Disabled because evil-local-mode is used.

;; crux ---------------------------
(define-key ctl-x-map (kbd "C-r") 'crux-recentf-find-file)
(define-key ctl-x-map (kbd "C-_") 'crux-delete-file-and-buffer)
(define-key global-map (kbd "<f9>") 'crux-visit-term-buffer)

;; ace-window ---------------------
(global-set-key (kbd "M-o") 'ace-window)

;; ivy ----------------------------
(setq ivy-height 13
      ivy-wrap t)
;; (ivy-mode 1)
(add-hook 'ivy-mode-hook #'ivy-rich-mode)

;; amx ----------------------------
(setq amx-backend 'auto)
;; (amx-mode 1)

;; counsel ------------------------
(define-key ctl-x-map (kbd "C-b") 'persp-switch-to-buffer)
;; (counsel-mode)

;; avy ----------------------------
(define-key global-map (kbd "C-;") 'avy-goto-line)
(avy-setup-default)

;; dired --------------------------
(add-hook 'dired-mode-hook #'dired-hide-details-mode)
(add-hook 'dired-mode-hook #'dired-hide-dotfiles-mode)
;; (define-key dired-mode-map "-" 'dired-up-directory)

;; projectile ---------------------
(setq projectile-completion-system 'ivy
      projectile-mode-line-function '(lambda () (format " [%s]" (projectile-project-name))))
;; (projectile-mode 1)
(define-key global-map (kbd "C-x p p") 'projectile-switch-project)
(define-key global-map (kbd "C-x 5 p p") 'projectile-find-file-other-frame)
(define-key global-map (kbd "C-x p f") 'projectile-find-file)
(define-key global-map (kbd "C-x p n") 'projectile-add-known-project)

;; persp-mode ---------------------
(setq persp-nil-name "-")
;; (persp-mode 0)

;; magit --------------------------
(define-key ctl-x-map (kbd "g") 'magit-status)

;; evil-snipe ---------------------
(setq evil-snipe-scope 'buffer)
;; (evil-snipe-mode 1)

;; olivetti -----------------------
(setq olivetti-body-width 120)
(define-key ctl-x-map (kbd "t o") 'olivetti-mode)
(add-hook 'olivetti-mode-hook 'hide-mode-line-mode)

;; markdown-mode ------------------
(require 'markdown-mode)
(setq wc-modeline-format "%tw")
(add-hook 'markdown-mode-hook 'wc-mode)
(add-hook 'markdown-mode-hook 'mixed-pitch-mode)

;; mixed-pitch-mode ---------------
(require 'mixed-pitch)
(add-to-list 'mixed-pitch-fixed-pitch-faces 'org-tag)
(add-to-list 'mixed-pitch-fixed-pitch-faces 'org-done)

;; helpful-mode
(require 'helpful)
(global-set-key (kbd "C-h v") 'helpful-variable)
(global-set-key (kbd "C-h f") 'helpful-function)
(global-set-key (kbd "C-h k") 'helpful-key)

;; sdcv --------------------------

;; yas ---------------------------
(require 'yasnippet)
;; (yas-reload-all)

;; org ----------------------------
(setq org-directory "~/Dropbox/Notes/org"
      org-return-follows-link t
      org-todo-keywords '((sequence "TODO(t)" "ACTV(a)" "REFL(r)" "HOLD(h)" "|" "DONE(d)"))
      org-inbox-file "~/Dropbox/Notes/org/inbox.org"
      org-agenda-files '("~/Dropbox/Notes/org" "~/Dropbox/Notes/org/journal")
      org-refile-targets '((org-inbox-file :maxlevel . 2)
			   ("~/Dropbox/Notes/org/emacs.org" :maxlevel . 1)
			   ("~/Dropbox/Notes/org/todo.org" :maxlevel . 2)
			   ("~/Dropbox/Notes/org/lists/books.org" :maxlevel . 3))
      org-startup-with-inline-images t
    ;; org-indent-indentation-per-level 1
    ;; org-adapt-indentation nil
      org-hide-emphasis-markers t
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
(define-key mode-specific-map (kbd "c") 'counsel-org-capture)
(require 'org)
(define-key org-mode-map (kbd "C-c C-q") 'counsel-org-tag)
(define-key org-mode-map (kbd "C-c C-j") 'counsel-outline)
(add-hook 'org-mode-hook #'org-indent-mode)
(add-hook 'org-mode-hook #'yas-minor-mode)
;; (add-hook 'org-mode-hook #'org-bullets-mode)
(add-hook 'org-mode-hook #'mixed-pitch-mode)

;; org-journal --------------------
(setq org-journal-dir (concat org-directory "/journal")
      org-journal-file-type 'monthly
      org-journal-file-format "%Y-%m"
      org-journal-date-format "%A, %d %B %Y"
      org-journal-prefix-key (kbd "C-c j"))
(global-set-key (kbd "C-c j n") 'org-journal-new-entry)

;; anki-editor --------------------
(require 'anki-editor)
(define-key org-mode-map (kbd "C-c x a") 'anki-editor-insert-note)
(define-key org-mode-map (kbd "C-c x p") 'anki-editor-push-notes)
(setq anki-editor-create-decks t 
      anki-editor-org-tags-as-anki-tags t)
;; (add-hook 'org-mode-hook #'anki-editor-mode)

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
(setq bibtex-completion-bibliography "~/Dropbox/Notes/org/bibliography/references.bib")
(setq org-ref-bibliography-notes "~/Dropbox/bibliography/notes.org"
      org-ref-default-bibliography '("~/Dropbox/Notes/org/bibliography/references.bib")
      org-ref-pdf-directory "~/Dropbox/Notes/org/bibliography/bibtex-pdfs/")

;; org-roam -----------------------
(setq org-roam-directory (concat org-directory "/knowledgebase")
      org-roam-capture-templates `(("d" "default" plain #'org-roam-capture--get-point "\n- refereneces :: \n- tags :: %?\n\n" :file-name "%<%y%m%d%h%m%s>-${slug}" :head "#+title: ${title}\n#+created: %u\n" :unnarrowed t)))
;; (org-roam-mode 1)
(define-key mode-specific-map (kbd "n l") 'org-roam-buffer-toggle-display)
(define-key mode-specific-map (kbd "n f") 'org-roam-find-file)
(define-key mode-specific-map (kbd "n g") 'org-roam-show-graph)
(define-key mode-specific-map (kbd "n i") 'org-roam-insert)
(add-hook 'org-roam-mode-hook 'org-roam-bibtex-mode)

;; company-org-roam
(require 'company-org-roam)
(push 'company-org-roam company-backends)

;; org-roam-bibtex ----------------
(org-roam-bibtex-mode 1)
(add-to-list 'orb-preformat-keywords "abstract")
(setq orb-templates
  '(("r" "ref" plain (function org-roam-capture--get-point) ""
     :file-name "${citekey}"
     :head "#+title: ${title}\n#+roam_key: ${ref}\n\n" ; <--
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

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default bold shadow italic underline success warning error])
 '(ansi-color-names-vector
   ["#1B2B34" "#EC5f67" "#99C794" "#FAC863" "#6699CC" "#E27E8D" "#5FB3B3" "#D8DEE9"])
 '(ansi-term-color-vector
   [unspecified "#FFFFFF" "#d15120" "#5f9411" "#d2ad00" "#6b82a7" "#a66bab" "#6b82a7" "#505050"] t)
 '(beacon-color "#d54e53")
 '(custom-safe-themes
   (quote
    ("a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" default)))
 '(elfeed-feeds
   (quote
    ("https://feeds.feedburner.com/TechCrunch/" "https://www.theverge.com/" "https://longreads.com/")))
 '(fci-rule-character-color "#d9d9d9")
 '(fci-rule-color "#C0C5CE")
 '(flycheck-color-mode-line-face-to-color (quote mode-line-buffer-id))
 '(flymake-error-bitmap
   (quote
    (flymake-double-exclamation-mark modus-theme-fringe-red)))
 '(flymake-note-bitmap (quote (exclamation-mark modus-theme-fringe-cyan)))
 '(flymake-warning-bitmap (quote (exclamation-mark modus-theme-fringe-yellow)))
 '(frame-background-mode (quote dark))
 '(highlight-tail-colors (quote (("#aecf90" . 0) ("#c0efff" . 20))))
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
 '(ibuffer-deletion-face (quote modus-theme-mark-del))
 '(ibuffer-filter-group-name-face (quote modus-theme-mark-symbol))
 '(ibuffer-marked-face (quote modus-theme-mark-sel))
 '(ibuffer-title-face (quote modus-theme-header))
 '(ivy-rich-mode t)
 '(jdee-db-active-breakpoint-face-colors (cons "#1B2B34" "#FAC863"))
 '(jdee-db-requested-breakpoint-face-colors (cons "#1B2B34" "#99C794"))
 '(jdee-db-spec-breakpoint-face-colors (cons "#1B2B34" "#A7ADBA"))
 '(linum-format " %7i ")
 '(nrepl-message-colors
   (quote
    ("#ee11dd" "#8584ae" "#b4f5fe" "#4c406d" "#ffe000" "#ffa500" "#ffa500" "#DC8CC3")))
 '(objed-cursor-color "#EC5f67")
 '(org-agenda-files
   (quote
    ("~/Dropbox/Notes/org/lists/read-later.org" "~/Dropbox/Projects/space-theory/outline.org" "~/Dropbox/Notes/org/vocabulary.org" "/home/monk/Dropbox/Notes/org/anand_podcast.org" "/home/monk/Dropbox/Notes/org/archlinux.org" "/home/monk/Dropbox/Notes/org/blog-post-ideas.org" "/home/monk/Dropbox/Notes/org/emacs-article.org" "/home/monk/Dropbox/Notes/org/emacs.org" "/home/monk/Dropbox/Notes/org/events.org" "/home/monk/Dropbox/Notes/org/higher-studies.org" "/home/monk/Dropbox/Notes/org/inbox.org" "/home/monk/Dropbox/Notes/org/latex.org" "/home/monk/Dropbox/Notes/org/minecraft.org" "/home/monk/Dropbox/Notes/org/music_theory.org" "/home/monk/Dropbox/Notes/org/observations.org" "/home/monk/Dropbox/Notes/org/podcasting_gear.org" "/home/monk/Dropbox/Notes/org/quotes.org" "/home/monk/Dropbox/Notes/org/r4r.org" "/home/monk/Dropbox/Notes/org/studies.org" "/home/monk/Dropbox/Notes/org/templates-for-dilemmas.org" "/home/monk/Dropbox/Notes/org/test.org" "/home/monk/Dropbox/Notes/org/thoughts.org" "/home/monk/Dropbox/Notes/org/todo.org")))
 '(package-selected-packages
   (quote
    (material-theme ace-window evil-collection evil-tutor ox-pandoc kaolin-themes lab-themes zweilight-theme zotelo zeno-theme zen-and-art-theme yasnippet-snippets winum white-theme wc-mode vs-light-theme use-package twilight-theme twilight-bright-theme twilight-anti-bright-theme svg-mode-line-themes spacemacs-theme shrink-path sdcv rebecca-theme python-x projectile poet-theme persp-mode panda-theme org-superstar org-roam-server org-roam-bibtex org-ref org-journal org-evil org-capture-pop-frame org-bullets org-beautify-theme olivetti neotree modus-vivendi-theme modus-operandi-theme mixed-pitch lsp-mode ivy-rich ivy-omni-org ivy-hydra ivy-dired-history ivy-bibtex ivy-avy hl-todo hl-sentence hide-mode-line helpful helm-books golint go-eldoc go-complete flymake-shell flymake-golangci evil-snipe evil-org evil-magit evil-goggles emacsql-sqlite elfeed doom-themes dired-single dired-hide-dotfiles dired-du dictionary delight deft csv-mode crux crontab-mode counsel-org-capture-string company-org-roam company-dict command-log-mode color-theme-sanityinc-tomorrow anki-editor anki-connect amx all-the-icons)))
 '(pdf-view-midnight-colors (cons "#D8DEE9" "#1B2B34"))
 '(rustic-ansi-faces
   ["#1B2B34" "#EC5f67" "#99C794" "#FAC863" "#6699CC" "#E27E8D" "#5FB3B3" "#D8DEE9"])
 '(safe-local-variable-values
   (quote
    ((eval when
	   (require
	    (quote rainbow-mode)
	    nil t)
	   (rainbow-mode 1))
     (avy-words . s)
     (org-num-max-level . 1)
     (org-num-mode . t)
     (display-line-numbers . t)
     (org-log-refile . time)
     (org-log-done . time))))
 '(vc-annotate-background "#1B2B34")
 '(vc-annotate-background-mode nil)
 '(vc-annotate-color-map
   (list
    (cons 20 "#99C794")
    (cons 40 "#b9c783")
    (cons 60 "#d9c773")
    (cons 80 "#FAC863")
    (cons 100 "#f9b55f")
    (cons 120 "#f9a35b")
    (cons 140 "#F99157")
    (cons 160 "#f18a69")
    (cons 180 "#e9847b")
    (cons 200 "#E27E8D")
    (cons 220 "#e57380")
    (cons 240 "#e86973")
    (cons 260 "#EC5f67")
    (cons 280 "#da727b")
    (cons 300 "#c98690")
    (cons 320 "#b899a5")
    (cons 340 "#C0C5CE")
    (cons 360 "#C0C5CE")))
 '(vc-annotate-very-old-color nil)
 '(window-divider-mode nil)
 '(xterm-color-names
   ["#000000" "#a60000" "#005e00" "#813e00" "#0030a6" "#721045" "#00538b" "#f0f0f0"])
 '(xterm-color-names-bright
   ["#505050" "#972500" "#315b00" "#70480f" "#223fbf" "#8f0075" "#30517f" "#ffffff"]))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(border ((t (:background "red")))))





