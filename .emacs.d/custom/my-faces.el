;;; my-faces.el --- Customizations on top of the native theme  -*- lexical-binding: t; -*-

;; Copyright (C) 2020  Jewel

;; Author: Jewel <monk@thinkpad>
;; Keywords: elisp, extensions, 


(deftheme my-faces "Custom face preferences")

(let ((font-family-serif "IBM Plex Serif")
      (font-family-sans "IBM Plex Sans")
      (font-family-mono "IBM Plex Mono")
      (font-family-mono-prose "Dejavu Sans Mono"))
  
(set-face-attribute 'org-document-title nil :family font-family-serif :height 170 :weight 'semi-bold)
(set-face-attribute 'org-document-info-keyword nil :foreground "#bbbbbb")
(set-face-attribute 'org-meta-line nil :family font-family-mono :foreground "#bbbbbb")
(set-face-attribute 'org-link nil :weight 'semi-bold)
(set-face-attribute 'org-level-1 nil :height 115 :weight 'semi-bold)
(set-face-attribute 'org-level-2 nil :height 115 :weight 'semi-bold)
(set-face-attribute 'org-level-3 nil :height 115 :weight 'semi-bold)
(set-face-attribute 'org-list-dt nil :family font-family-mono)
(set-face-attribute 'org-code 'default))
(set-face-attribute 'markdown-header-face nil :family "IBM Plex Serif" :height 150)

(provide-theme 'my-faces)
 
