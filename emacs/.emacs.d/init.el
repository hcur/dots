;; init.el

(setq gc-cons-threshold (* 50 1000 1000))


;; visual things

(menu-bar-mode -1)
(tool-bar-mode -1)
(fringe-mode 0)
(pixel-scroll-mode 1)
(set-face-attribute 'default nil :font "FiraCode Nerd Font-12")


;; general settings

(auto-save-mode -1)


;; packages

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
(add-to-list 'load-path "~/.emacs.d/lisp")

(use-package catppuccin-theme
  :ensure t
  :config
  (setq cattppuccin-flavor 'macchiato)
  (load-theme 'catppuccin :no-confirm))

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))

(use-package nerd-icons
  :ensure t)

(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-center-content t)
  (setq dashboard-vertically-center-content t)
  (setq dashboard-display-icons-p t)
  (setq dashboard-icon-type 'nerd-icons)
  (setq dashboard-set-file-icons t)
  (setq dashboard-items '((recents . 5)
			  (bookmarks . 5)
			  ))
  )

(use-package evil
  :ensure t
  :config
  (evil-set-initial-state 'dashboard-mode 'emacs)
  (evil-mode 1))

(use-package vertico
  :ensure t
  :config
  (vertico-mode))

(use-package vertico-posframe
  :ensure t
  :after vertico
  :config
  (vertico-posframe-mode 1))

(use-package marginalia
  :ensure t
  :config
  (marginalia-mode))

(use-package swift-mode
  :ensure t
  :mode "\\.swift\\'"
  :interpreter "swift")
(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
	       '(swift-mode . ("xcrun" "sourcekit-lsp"))))

(use-package company
  :ensure t
  :config
  (global-company-mode +1))

(use-package dart-mode
  :ensure t
  :hook (dart-mode . flutter-test-mode))

(use-package flutter
  :ensure t
  :after dart-mode
  :bind (:map dart-mode-map
	      ("C-M-x" . #'flutter-run-or-hot-reload))

  :custom
  (flutter-sdk-path "/opt/homebrew/Caskroom/flutter/3.29.2/flutter"))

;; TODO: highlight todos


;; keybindings

(global-unset-key (kbd "M-q"))
(global-set-key (kbd "M-q") 'kill-emacs)

(setq mac-command-modifier 'meta)
(setq mac-option-modifier 'super)


(setq gc-cons-threshold (* 2 1000 1000))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(lsp-sourcekit lsp-ui lsp-mode company swift-mode vertico-posframe marginalia evil doom-modeline dashboard all-the-icons)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
