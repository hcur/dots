(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(winner-mode 1)
(pixel-scroll-mode 1)
(fringe-mode '(1 . 1))

(setq
  ring-bell-function 'ignore
  vc-follow-symlinks t
  load-prefer-newer t
  delete-old-versions t
  use-short-answers t
  make-backup-files nil
  create-lockfiles nil
  )

(setq display-line-numbers 'relative)
(add-hook 'prog-mode-hook 'display-line-numbers-mode)

(defun split-and-follow-horizontally ()
  (interactive)
  (split-window-below)
  (balance-windows)
  (other-window 1))

(defun split-and-follow-vertically ()
  (interactive)
  (split-window-right)
  (balance-windows)
  (other-window 1))

(setq custom-safe-themes t)

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

(use-package cyberpunk-theme
  :ensure t)
(use-package catppuccin-theme
  :ensure t
  :init
  (setq catppuccin-flavor 'frappe))
(use-package doom-themes
  :ensure t)
(load-theme 'doom-xcode t)

(use-package evil
  :ensure t
  :init
  (setq evil-want-keybinding nil)
  :config
  (evil-mode 1))

(use-package magit
  :ensure t)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(magit nordic-night-theme evil doom-themes cyberpunk-theme catppuccin-theme)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
