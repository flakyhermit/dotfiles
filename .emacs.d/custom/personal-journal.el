;;; personal-journal.el --- A module for generating journal files for recording my thoughts  -*- lexical-binding: t; -*-

;; Copyright (C) 2020  Jewel

;; Author: Jewel <flakyhermit@protonmail.ch>
;; Keywords: lisp, emacs, custom 

(defvar file-name-format)
(defvar journal-directory)

;; Configuration
(setq file-name-format 1
      journal-directory "~/Dropbox/Personal/Journal/")
  
(defun my/journal-daily()
  "Create a new 6-PM journal entry"
  (interactive)
  (setq filepath (concat "~/Dropbox/Notes/6_PMs/" (format-time-string "%F")))
  (with-temp-file filepath
    (insert "\n# " (format-time-string "%A, %d %B %Y") "\n\n"))
  (find-file filepath)
  (markdown-mode)
  (goto-char (point-max)))
(global-set-key (kbd "C-c j s") #'my/journal-daily)

(defun my/journal-new-entry()
  "Create a titled personal journal entry"
  (interactive)

  ;; Read the title 
  (setq-local journal-title (read-string "Title: "))
  (setq-local journal-timestamp (format-time-string "%I:%M %p, %d %B %Y"))

  ;; Generate the filename
  (setq-local journal-filename-date (format-time-string "%Y-%m-%d"))
  (setq-local journal-filename-title (mapconcat 'identity (split-string journal-title " ") "_"))
  (setq-local journal-filename (concat journal-filename-date "_" journal-filename-title ".md"))
  (setq-local filepath (concat journal-directory journal-filename))

  ;; Create template string
  (setq-local journal-text-template
	(concat "\n" journal-timestamp "\n\n# " journal-title "\n\n"))
  
  ;; Create new buffer, insert template, then write to file at filepath
  (with-temp-file filepath)
  (write-region journal-text-template nil filepath)
  (find-file filepath)
  (goto-char (point-max))
  (evil-insert-state))

(defun my/clip-snippets ()
  (kill-new "FUCK"))
  

(provide 'personal-journal)
