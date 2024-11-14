;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq user-full-name "Hayden Curfman"
      user-mail-address "hcurfman@keemail.me")

(setq doom-theme 'doom-moonfly)
(add-hook! '+doom-dashboard-functions (hide-mode-line-mode 1))

(setq display-line-numbers-type 'relative)


(windmove-default-keybindings)

(defun split-and-follow-horizontally()
  (interactive)
  (split-window-below)
  (balance-windows)
  (other-window 1))

(defun split-and-follow-vertically ()
  (interactive)
  (split-window-right)
  (balance-windows)
  (other-window 1))

(global-set-key (kbd "C-x 2") 'split-and-follow-horizontally)
(global-set-key (kbd "C-x 3") 'split-and-follow-vertically)


;; org-mode configuration

(setq org-directory "~/Org/")
(setq org-agenda-current-time-string ""
      org-agenda-time-grid '((daily) () "" "")
      org-agenda-skip-timestamp-if-done t
      org-agenda-skip-deadline-if-done t
      org-agenda-skip-scheduled-if-done t
      org-agenda-skip-scheduled-if-deadline-is-shown t
      org-agenda-skip-timestamp-if-deadline-is-shown t)
;; https://zzamboni.org/post/beautifying-org-mode-in-emacs/
(font-lock-add-keywords 'org-mode
                          '(("^ *\\([-]\\) "
                             (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))

(add-hook 'org-mode-hook 'variable-pitch-mode)
(custom-theme-set-faces
 'user
 '(variable-pitch ((t (:family "iA Writer Quattro V" :height 140 ))))
 '(fixed-pitch ((t ( :family "Hack Nerd Font Mono" :height 140 ))))
 )
(add-hook 'org-mode-hook 'visual-line-mode)

;; =====================

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; Note: This is here because it made LaTeX compiliation work on macOS
(after! exec-path-from-shell
  (exec-path-from-shell-initialize))

(after! org-modern
  (add-hook 'org-omde-hook #'org-modern-mode)
  (add-hook 'org-agenda-finalize-hook #'org-modern-agenda))

(after! tex
  (add-hook 'TeX-after-compilation-finished-functions
            #'TeX-revert-document-buffer)

  (setq +latex-viewers '(pdf-tools))

  (setq TeX-view-program-selection
        '( (output-pdf "PDF Tools")))

  (add-hook 'LaTeX-mode-hook (lambda ()
                               (push
                                '("latexmk" "latexmk -pvc -pdf --synctex=1 %s" TeX-run-TeX nil t
                                  :help "Run latexmk on file")
                                TeX-command-list)))
  ;(add-hook 'TeX-mode-hook '(lambda () (setq TeX-command-default "latexmk")))
  )
