;; -*- lexical-binding: t -*-

(setq user-full-name "Hayden Curfman"
      user-mail-address "hlc1@williams.edu")

(eval-and-compile
  (setq gc-cons-threshold 402653184
	gc-cons-percentage 0.6))

(setq native-comp-async-report-warnings-errors nil)

(fringe-mode 0)

(set-face-attribute 'default nil :font "FiraCode Nerd Font-12")

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(horizontal-scroll-bar-mode -1)

(pixel-scroll-mode 1)

(setq auto-save-default nil
      ring-bell-function 'ignore ; no bell ring
      create-lockfiles nil       ; lockfiles are annoying
      )

(electric-pair-mode 1)

(auto-save-mode -1)

(setq mac-command-modifier 'meta)
(setq mac-option-modifier 'super)

(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/") t)

(use-package nordic-night-theme
  :ensure t
  )

(use-package nyx-theme
  :ensure t
  )

(use-package sculpture-themes
  :ensure t
  )

(setq org-startup-indented t
      org-hide-leading-stars t)

(setq gc-cons-threshold (* 2 1000 1000))
