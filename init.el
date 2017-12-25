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
"---------------------------------------------------------------------------"
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ace-isearch-function (quote avy-goto-char) t)
 '(ace-isearch-input-length 7 t)
 '(ace-isearch-jump-delay 0.25 t)
 '(ace-isearch-use-jump (quote printing-char) t)
 '(column-number-mode t)
 '(custom-safe-themes
   (quote
    ("9411de5aabbace500460f5544187ee4bccff90d2eaad04c308de4e5f5863eed8" default)))
 '(display-time-mode t)
 '(ecb-layout-name "peck")
 '(ecb-options-version "2.50")
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
 '(neo-theme (quote icons))
 '(ns-command-modifier (quote meta))
 '(package-selected-packages
   (quote
    (helm-xref org smartparens virtualenvwrapper markdown-mode try paredit exec-path-from-shell projectile evil helm js2-mode php-mode company yasnippet airline-themes powerline all-the-icons-dired company-irony-c-headers flycheck-irony flycheck company-irony ace-window ecb neotree chinese-wbim ag ace-isearch rjsx-mode youdao-dictionary xref-js2 which-key web-mode use-package swift-mode sourcemap skewer-mode shackle python-environment org-pomodoro org-bullets nodejs-repl mew magit json-mode js2-refactor indium helm-swoop helm-projectile helm-gtags helm-flyspell helm-ag gorepl-mode gore-mode go-autocomplete ggtags erlang emmet-mode elpy doom-themes concurrent composer company-tern company-php company-lua company-go column-enforce-mode benchmark-init ace-jump-mode ac-php)))
 '(projectile-globally-ignored-files (quote ("GPATH" "TAGS" "GRTAGS" "GTAGS")))
 '(safe-local-variable-values (quote ((eval c-set-offset (quote innamespace) 0))))
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
