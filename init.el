"---------------------------------------------------------------------------"
;; initialize package.el
(require 'package)
(setq package-enable-at-startup nil)

;; repo lists
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/") t)
(add-to-list 'package-archives '("elpy" . "http://jorgenschaefer.github.io/packages/") t)
;;("marmalade" . "http://marmalade-repo.org/packages/")
;;("melpa-stable" . "http://melpa-stable.milkbox.net/packages/")

(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package)
  (setq use-package-always-ensure t))

;;(setq debug-on-error t)

(setq custom-file "~/.emacs.d/peck-emacs/custom-settings.el")
(load custom-file t)
"---------------------------------------------------------------------------"
;; calc startup time
(defvar peck-emacs/invokation-time
  (current-time))

;; load configuration files
(load-file "~/.emacs.d/peck-emacs/loadpkgs.el")
(load-file "~/.emacs.d/peck-emacs/config.el")
(load-file "~/.emacs.d/peck-emacs/key-bindings.el")

(print (cl-concatenate 'string
                       "Startup complete in "
                       (number-to-string (cadr (time-subtract(current-time)
                                                             peck-emacs/invokation-time)))
                       " seconds\n\n"
                       "Welcome to Emacs!\n\n"
                       "Today's date: "
                       (format-time-string "%B %d %Y"))
       (get-buffer-create (current-buffer)))
"---------------------------------------------------------------------------"
