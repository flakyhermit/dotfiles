;;; my-faces.el --- Customizations on top of the native theme  -*- lexical-binding: t; -*-

;; Copyright (C) 2020  Jewel

;; Author: Jewel <monk@thinkpad>
;; Keywords: elisp, extensions, 


(deftheme my-faces "Custom face preferences")

(let ((font-family-serif "IBM Plex Serif")
      (font-family-sans "IBM Plex Sans")
      (font-family-mono "IBM Plex Mono")
      (font-family-mono-prose "Dejavu Sans Mono"))
  
(set-face-attribute 'org-document-title nil :family font-family-serif :height 170 :weight 'semi-bold))
; (set-face-attribute 'org-document-info-keyword nil :foreground "#bbbbbb")
; (set-face-attribute 'org-meta-line nil :family font-family-mono :foreground "#bbbbbb")
;; (set-face-attribute 'org-link nil :weight 'semi-bold)
(set-face-attribute 'org-level-1 nil :height 115 :weight 'bold)
;; (set-face-attribute 'fringe nil :background "#ffffff")
(set-face-attribute 'org-level-2 nil :height 115 :weight 'bold)
(set-face-attribute 'org-level-3 nil :height 115 :weight 'bold)
(set-face-attribute 'org-tag nil :height 110 :italic nil)
(set-face-attribute 'org-block-begin-line nil :background "#efefef")
(set-face-attribute 'org-block-end-line nil :background "#efefef")
(set-face-attribute 'ivy-current-match nil :inherit 'ivy-grep-info)
(set-face-attribute 'ivy-current-match nil :background "#A8C5EF" :foreground "#111188" :weight 'bold :underline nil :box nil)
(set-face-attribute 'minibuffer-prompt nil :inherit 'highlight :background "#FFF876" :bold t)
;;(set-face-attribute 'org-list-dt nil :fam10 font-family-mono)
;; (set-face-attribute 'org-code 'default))
(set-face-attribute 'markdown-header-face nil :family "Iosevka Etoile")
(set-face-attribute 'markdown-header-face-1 nil :height 160)
(set-face-attribute 'markdown-header-face-2 nil :height 150)
(set-face-attribute 'markdown-header-face-3 nil :height 140 :weight 'bold)

(provide-theme 'my-faces)
 
