"---------------------------------------------------------------------------"
;; initialize package.el
(require 'package)
(setq package-enable-at-startup nil)

;; repo lists
(setq package-archives '(("melpa" . "http://melpa.milkbox.net/packages/")
                         ("gnu" . "http://elpa.gnu.org/packages/")
                        ;;("marmalade" . "http://marmalade-repo.org/packages/")
                         ;;("melpa-stable" . "http://melpa-stable.milkbox.net/packages/")
                         ("elpy" . "http://jorgenschaefer.github.io/packages/")))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package)
  (setq use-package-always-ensure t))
"---------------------------------------------------------------------------"
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(display-time-mode t)
 '(ecb-layout-name "peck")
 '(ecb-options-version "2.40")
 '(ecb-tip-of-the-day nil)
 '(ediff-split-window-function (quote split-window-horizontally))
 '(exec-path
   (quote
    ("/usr/local/bin" "/opt/local/bin/" "/usr/bin" "/bin" "/usr/sbin" "/sbin" "/Applications/Emacs.app/Contents/MacOS/libexec" "/Applications/Emacs.app/Contents/MacOS/bin")))
 '(helm-boring-buffer-regexp-list
   (quote
    ("\\` " "\\`\\*helm" "\\`\\*Echo Area" "\\`\\*Minibuf" "\\`*magit" "\\`*Ediff")))
 '(helm-boring-file-regexp-list
   (quote
    ("\\.o$" "~$" "\\.bin$" "\\.lbin$" "\\.so$" "\\.a$" "\\.ln$" "\\.blg$" "\\.bbl$" "\\.elc$" "\\.lof$" "\\.glo$" "\\.idx$" "\\.lot$" "\\.svn/\\|\\.svn$" "\\.hg/\\|\\.hg$" "\\.git/\\|\\.git$" "\\.bzr/\\|\\.bzr$" "CVS/\\|CVS$" "_darcs/\\|_darcs$" "_MTN/\\|_MTN$" "\\.fmt$" "\\.tfm$" "\\.class$" "\\.fas$" "\\.lib$" "\\.mem$" "\\.x86f$" "\\.sparcf$" "\\.dfsl$" "\\.pfsl$" "\\.d64fsl$" "\\.p64fsl$" "\\.lx64fsl$" "\\.lx32fsl$" "\\.dx64fsl$" "\\.dx32fsl$" "\\.fx64fsl$" "\\.fx32fsl$" "\\.sx64fsl$" "\\.sx32fsl$" "\\.wx64fsl$" "\\.wx32fsl$" "\\.fasl$" "\\.ufsl$" "\\.fsl$" "\\.dxl$" "\\.lo$" "\\.la$" "\\.gmo$" "\\.mo$" "\\.toc$" "\\.aux$" "\\.cp$" "\\.fn$" "\\.ky$" "\\.pg$" "\\.tp$" "\\.vr$" "\\.cps$" "\\.fns$" "\\.kys$" "\\.pgs$" "\\.tps$" "\\.vrs$" "\\.pyc$" "\\.pyo$")))
 '(helm-ff-skip-boring-files t)
 '(helm-gtags-suggested-key-mapping t)
 '(ns-command-modifier (quote meta))
 '(projectile-globally-ignored-files (quote ("GPATH" "TAGS" "GRTAGS" "GTAGS")))
 '(scroll-bar-mode nil)
 '(show-paren-mode t)
 '(tool-bar-mode nil))
"---------------------------------------------------------------------------"
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
"---------------------------------------------------------------------------"
;; calc startup time
(defvar peck-emacs/invokation-time
  (current-time))

;; load configuration files
(load-file "~/.emacs.d/peck-emacs/packages.el")
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
