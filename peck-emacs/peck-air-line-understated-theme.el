
;;; Code:

;; change the colors
(deftheme peck-air-line-understated
  "source: https://github.com/bling/vim-airline/blob/master/autoload/airline/themes/understated.vim")

(let ((normal-outer-foreground  "#FFFFFF") (normal-outer-background  "#1B1D1F")
      (normal-inner-foreground  "#AFAF87") (normal-inner-background  "#5F5F5F")
      (normal-center-foreground "#AFAF87") (normal-center-background "#5F5F5F")

      (insert-outer-foreground  "#FFFFFF") (insert-outer-background  "#2E2E2E")
      (insert-inner-foreground  "#AFAF87") (insert-inner-background  "#5F5F5F")
      (insert-center-foreground "#AFAF87") (insert-center-background "#5F5F5F")

      (visual-outer-foreground  "#FFFFFF") (visual-outer-background  "#1B1D1F")
      (visual-inner-foreground  "#AFAF87") (visual-inner-background  "#5F5F5F")
      (visual-center-foreground "#AFAF87") (visual-center-background "#5F5F5F")

      (replace-outer-foreground  "#ff0000") (replace-outer-background  "#870000")
      (replace-inner-foreground  "#AFAF87") (replace-inner-background  "#5F5F5F")
      (replace-center-foreground "#AFAF87") (replace-center-background "#5F5F5F")

      (emacs-outer-foreground  "#d7d7ff") (emacs-outer-background  "#1B1D1F")
      (emacs-inner-foreground  "#AFAF87") (emacs-inner-background  "#5F5F5F")
      (emacs-center-foreground "#AFAF87") (emacs-center-background "#5F5F5F")

      (inactive1-foreground "#4e4e4e") (inactive1-background "#1c1c1c")
      (inactive2-foreground "#4e4e4e") (inactive2-background "#1c1c1c")
      (inactive3-foreground "#4e4e4e") (inactive3-background "#1c1c1c"))

  (airline-themes-set-deftheme 'peck-air-line-understated)

  (when airline-cursor-colors
    (progn
      (setq evil-emacs-state-cursor   "#7cfc00")
      (setq evil-normal-state-cursor  "#7cfc00")
      (setq evil-insert-state-cursor  `(bar ,"#7cfc00"))
      (setq evil-replace-state-cursor "#7cfc00")
      (setq evil-visual-state-cursor  "#7cfc00")))
  )

(airline-themes-set-modeline)

(provide-theme 'peck-air-line-understated)
;;; apeck-air-line-understated.el ends here
