;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
			 ;;("marmalade" . "http://marmalade-repo.org/packages/")
			 ("melpa" . "http://melpa.milkbox.net/packages/")
			 ("melpa-stable" . "http://melpa-stable.milkbox.net/packages/")
			 ("elpy" . "http://jorgenschaefer.github.io/packages/")))
(setq package-enable-at-startup nil)
(package-initialize)
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
    ("/opt/local/bin/" "/usr/bin" "/bin" "/usr/sbin" "/sbin" "/Applications/Emacs.app/Contents/MacOS/libexec" "/Applications/Emacs.app/Contents/MacOS/bin" "/usr/local/bin")))
 '(helm-boring-buffer-regexp-list
   (quote
    ("\\` " "\\`\\*helm" "\\`\\*Echo Area" "\\`\\*Minibuf" "\\`*magit" "\\`*Ediff")))
 '(helm-boring-file-regexp-list
   (quote
    ("\\.o$" "~$" "\\.bin$" "\\.lbin$" "\\.so$" "\\.a$" "\\.ln$" "\\.blg$" "\\.bbl$" "\\.elc$" "\\.lof$" "\\.glo$" "\\.idx$" "\\.lot$" "\\.svn/\\|\\.svn$" "\\.hg/\\|\\.hg$" "\\.git/\\|\\.git$" "\\.bzr/\\|\\.bzr$" "CVS/\\|CVS$" "_darcs/\\|_darcs$" "_MTN/\\|_MTN$" "\\.fmt$" "\\.tfm$" "\\.class$" "\\.fas$" "\\.lib$" "\\.mem$" "\\.x86f$" "\\.sparcf$" "\\.dfsl$" "\\.pfsl$" "\\.d64fsl$" "\\.p64fsl$" "\\.lx64fsl$" "\\.lx32fsl$" "\\.dx64fsl$" "\\.dx32fsl$" "\\.fx64fsl$" "\\.fx32fsl$" "\\.sx64fsl$" "\\.sx32fsl$" "\\.wx64fsl$" "\\.wx32fsl$" "\\.fasl$" "\\.ufsl$" "\\.fsl$" "\\.dxl$" "\\.lo$" "\\.la$" "\\.gmo$" "\\.mo$" "\\.toc$" "\\.aux$" "\\.cp$" "\\.fn$" "\\.ky$" "\\.pg$" "\\.tp$" "\\.vr$" "\\.cps$" "\\.fns$" "\\.kys$" "\\.pgs$" "\\.tps$" "\\.vrs$" "\\.pyc$" "\\.pyo$")))
 '(helm-ff-skip-boring-files t)
 '(helm-gtags-prefix-key "")
 '(helm-gtags-suggested-key-mapping t)
 '(ns-command-modifier (quote meta))
 '(package-selected-packages
   (quote
    (helm-gtags company-php helm-projectile projectile evil magit org-bullets lua-mode shackle ggtags helm-swoop youdao-dictionary org-pomodoro helm jsx-mode ac-php ac-php-core php-mode ctags flycheck-swift swift-mode elpy emmet-mode composer org ac-html epc ctable js2-refactor python-environment concurrent sourcemap memoize mew skewer-mode xref-js2 indium web-mode flycheck-irony company-irony-c-headers company-irony company-tern 0blayout)))
 '(scroll-bar-mode nil)
 '(show-paren-mode t)
 '(tool-bar-mode nil))
"---------------------------------------------------------------------------"
;; 关闭烦人的出错时的提示声。
(setq visible-bell t)
(setq ring-bell-function 'ignore)
;;disable startup splash screen
;;(setq inhibit-startup-screen t)
"---------------------------------------------------------------------------"
;;Insert-current-date
(defun insert-current-date ()
  (interactive "*")
  (insert (format-time-string "[%Y-%m-%d %H:%M:%S]" (current-time))))
;;(insert (format-time-string "%Y-%m-%d" (current-time))))

(setq mac-option-modifier 'super)
(global-set-key (kbd "s-D") 'dired)
(global-set-key "\C-xd" 'insert-current-date)

;; 指针颜色设置为白色
(set-cursor-color "white")
;; 鼠标颜色设置为白色
(set-mouse-color "white")
"---------------------------------------------------------------------------"
;;change directory
(cd "/Users/peck")
"---------------------------------------------------------------------------"
;; delete file and buffer
(defun delete-file-and-buffer()
  "Kill the current buffer and deletes the file is is visiting."
  (interactive)
  (let ((filename (buffer-file-name)))
    (when filename
      (if (vc-backend filename)
	  (vc-delete-file filename)
	(progn
	  (delete-file filename)
	  (message "Deleted file %s" filename)
	  (kill-buffer))))))

(global-set-key (kbd "C-c D") 'delete-file-and-buffer)
"---------------------------------------------------------------------------"
;; 文件编码
;; Default coding system (for new files)
(setq buffer-file-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
"---------------------------------------------------------------------------"
;;不产生备份文件
(setq make-backup-files nil)
;; 语法高亮
(global-font-lock-mode t)
;; 以 y/n代表 yes/no
(fset 'yes-or-no-p 'y-or-n-p)
;; 显示括号匹配
(show-paren-mode t)
(setq show-paren-style 'parentheses)
;; 显示时间，格式如下
(display-time-mode 1)
(setq display-time-24hr-format t) 
(setq display-time-day-and-date t) 
(transient-mark-mode t)
;; 支持emacs和外部程序的粘贴
;; x-select-enable-clipboard is obsolete variable(as of 25.1) use select-enable-clipboard instead
;;(setq x-select-enable-clipboard t)
(setq select-enable-clipboard t)
;; 在标题栏提示你目前在什么位置
(setq frame-title-format "peck%b") 
;; 默认显示 80列就换行
;; obsolete variable:default-fill-column(23.2), use fill-column instead
;; (setq default-fill-column 80)
(setq fill-column 80)
;;显示行号
(global-linum-mode t)
;; 显示列号
(setq column-number-mode t)
(setq line-number-mode t)
;; 使用 C++ mode
(add-to-list 'auto-mode-alist (cons "\\.h$" #'c++-mode))
"---------------------------------------------------------------------------"
;;设置缩进
(setq indent-tabs-mode nil)
;; default-tab-width is obsolete variable, use tab-width instead
;; (setq default-tab-width 4)
(setq tab-width 4)

(defconst my-c-style
  '((c-tab-always-indent        . t)
    (c-comment-only-line-offset . 4)
    (c-hanging-braces-alist     . ((substatement-open after)
                                   (brace-list-open)))
    (c-hanging-colons-alist     . ((member-init-intro before)
                                   (inher-intro)
                                   (case-label after)
                                   (label after)
                                   (access-label after)))
    (c-cleanup-list             . (scope-operator
                                   empty-defun-braces
                                   defun-close-semi))
    (c-offsets-alist            . ((arglist-close . c-lineup-arglist)
                                   (substatement-open . 0)
                                   (case-label        . 4)
                                   (block-open        . 0)
                                   (knr-argdecl-intro . -)))
    (c-echo-syntactic-information-p . t)
    )
  "My C Programming Style")

;; offset customizations not in my-c-style
(setq c-offsets-alist '((member-init-intro . ++)))
(c-set-offset 'comment-intro 0)
;; Customizations for all modes in CC Mode.
(defun my-c-mode-common-hook ()
  ;; add my personal style and set it for the current buffer
  (c-add-style "PERSONAL" my-c-style t)
  ;; other customizations
  (setq tab-width 4
	;; this will make sure spaces are used instead of tabs
	indent-tabs-mode nil)
  ;; we like auto-newline and hungry-delete
  (c-toggle-auto-hungry-state t)
  ;;auto indent while press 'Enter'
  (global-set-key (kbd "RET") 'newline-and-indent)
  ;; key bindings for all supported languages.  We can put these in
  ;; c-mode-base-map because c-mode-map, c++-mode-map, objc-mode-map,
  ;; java-mode-map, idl-mode-map, and pike-mode-map inherit from it.
;;(define-key c-mode-base-map "\C-m" 'c-context-line-break)
  )

(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)
"---------------------------------------------------------------------------"
;;打开图片显示功能
(auto-image-file-mode t)
"---------------------------------------------------------------------------"
;;format while copy
(dolist (command '(yank yank-pop))
  (eval
   `(defadvice ,command (after indent-region activate)
      (and (not current-prefix-arg)
           (member major-mode
                   '(emacs-lisp-mode
                     lisp-mode
                     clojure-mode
                     scheme-mode
                     haskell-mode
                     ruby-mode
                     rspec-mode
                     python-mode
                     c-mode
                     c++-mode
                     objc-mode
                     latex-mode
                     js-mode
                     js2-mode
                     plain-tex-mode))
           (let ((mark-even-if-inactive transient-mark-mode))
             (indent-region (region-beginning) (region-end) nil))))))
"---------------------------------------------------------------------------"
;; Use ediff and not diff 
(setq diff-command "ediff")
(eval-after-load "vc-hooks"
  '(define-key vc-prefix-map "=" 'ediff-revision))
"---------------------------------------------------------------------------"
;;load emacs ecb
;;(add-to-list 'load-path "~/.emacs.d/packages/ecb")
;;(require 'ecb)
;;(global-set-key [(f10)] 'ecb-activate)
;;(global-set-key [(C-f10)] 'ecb-deactivate)
"---------------------------------------------------------------------------"
;; retitle emacs window
(defun frame-retitle (title)
  (modify-frame-parameters 
   nil 
   (list
    (cons
     'name
     title
     ))))

;; set a beautiful title bar
(setq frame-title-format
      '("%S: " (buffer-file-name "%f"
				 (dired-directory dired-directory "%b"))))
"---------------------------------------------------------------------------"
;;emacs welcome logo
(defun use-fancy-splash-screens-p ()
  "Return t if fancy splash screens should be used."
  (when (and (display-graphic-p)
	     (or (and (display-color-p)
		      (image-type-available-p 'xpm))
		 (image-type-available-p 'pbm)))
    (let ((frame (fancy-splash-frame)))
      (when frame
	(let* ((img (create-image (fancy-splash-image-file)))
	       (image-height (and img (cdr (image-size img nil frame))))
	       ;; We test frame-height so that, if the frame is split
	       ;; by displaying a warning, that doesn't cause the normal
	       ;; splash screen to be used.
	       (frame-height (1- (frame-height frame))))
	  ;; The original value added to the `image-height' for the test was 19; however,
	  ;; that causes the test to fail on X11 by about 1.5 -- so use 17 instead.
	  (> frame-height (+ image-height 17)))))))

"---------------------------------------------------------------------------"
;;minibuffer奇怪
(defun switch-to-minibuffer-window ()
  "switch to minibuffer window (if active)"
  (interactive)
  (when (active-minibuffer-window)
    (select-frame-set-input-focus (window-frame (active-minibuffer-window)))
    (select-window (active-minibuffer-window))))
(global-set-key (kbd "<f7>") 'switch-to-minibuffer-window)
"---------------------------------------------------------------------------"
(add-hook 'php-mode-hook
          '(lambda ()
             (require 'company-php)
             (company-mode t)
	     
             (ac-php-core-eldoc-setup) ;; enable eldoc
	     (define-key php-mode-map (kbd "C-]") 'ac-php-find-symbol-at-point) ;; goto define
	     (define-key php-mode-map (kbd "C-t") 'ac-php-location-stack-back)  ;; go back
             (make-local-variable 'company-backends)
             (add-to-list 'company-backends 'company-ac-php-backend)))
"---------------------------------------------------------------------------"
;; php indent
(defun wicked/php-mode-init ()
  "Set some buffer-local variables."
  (setq case-fold-search t) 
  (setq indent-tabs-mode nil)
  (setq fill-column 78)
  (setq c-basic-offset 4)
  (setq tab-width 4)
;;  (setq default-tab-width 4)
  (setq case-fold-search t)
  (c-set-offset 'arglist-close '0)
  (c-set-offset 'arglist-cont 0)
  (c-set-offset 'arglist-intro '+)
  (c-set-offset 'case-label 4)
  (c-set-offset 'inline 0) ; function {} indent
  (c-set-offset 'inline-open 0 )
  (c-set-offset 'arglist-close 0))

(defun my-php-indent-setup ()
  (c-set-offset 'topmost-intro '+) ; Does not affect <?php (but affects ?>)
  (c-set-offset 'inclass 0))       ; Gets the inside of class{} back to normal

;; public function indent;
(add-hook 'php-mode-hook '(lambda ()
			    (setq tab-width 4
				  indent-tabs-mode t)
			    (c-set-style "symfony2")
			    ))

(add-hook 'php-mode-hook 'my-php-indent-setup)
(add-hook 'php-mode-hook 'wicked/php-mode-init)
"---------------------------------------------------------------------------"
;;ac-html补全
(require 'ac-html)
(add-hook 'html-mode-hook 'ac-html-enable)
(add-hook 'web-mode-ac-sources-alist
	  '("html" . (
		      ;; attribute-value better to be first
		      ac-source-html-attribute-value
		      ac-source-html-tag
		      ac-source-html-attribute)))
"---------------------------------------------------------------------------"
;;web mode
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
;;(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

(defun bs-web-mode-hook ()
  (local-set-key '[backtab] 'indent-relative)
  (setq indent-tabs-mode t)
  (setq web-mode-markup-indent-offset 2
	web-mode-css-indent-offset 2
	web-mode-code-indent-offset 4))

(add-hook 'web-mode-hook 'bs-web-mode-hook)

(setq web-mode-style-padding 2)
(setq web-mode-script-padding 2)
(setq web-mode-block-padding 2)
(add-hook 'web-mode-hook (lambda()
			   (emmet-mode)
			   (company-mode)))
"---------------------------------------------------------------------------"
;; irony-mode
(require 'irony)

(defun my-irony-mode-on ()
  ;; avoid enabling irony-mode in modes that inherits c-mode, e.g: php-mode
  (when (member major-mode irony-supported-major-modes)
    (irony-mode 1)))

(add-hook 'c++-mode-hook 'my-irony-mode-on)
(add-hook 'c-mode-hook 'my-irony-mode-on)
(add-hook 'objc-mode-hook 'my-irony-mode-on)

(defun my-irony-mode-hook ()
  (define-key irony-mode-map [remap completion-at-point]
    'irony-completion-at-point-async)
  (define-key irony-mode-map [remap complete-symbol]
    'irony-completion-at-point-async))

(add-hook 'irony-mode-hook 'my-irony-mode-hook)

(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
"---------------------------------------------------------------------------"
;; company-mode
(require 'company)

;;(add-hook 'after-init-hook 'global-company-mode)
;;(setq company-global-modes '(not php-mode))
;;(setq company-global-modes '(not html-mode))
(global-company-mode 1)

(add-hook 'irony-mode-hook 'company-irony-setup-begin-commands)
(setq company-backends (delete 'company-semantic company-backends))

;; enable tab-completion with no delay
(setq company-idle-delay 0)
;;(define-key c-mode-map [(tab)] 'company-complete)
;;(define-key c++-mode-map [(tab)] 'company-complete)
"---------------------------------------------------------------------------"
;; company-tern and company-mode for javascript auto-completion
(require 'company-tern)

(add-to-list 'company-backends 'company-tern)
(add-hook 'js2-mode-hook (lambda ()
			   (tern-mode)
			   (company-mode)))

;; Disable completion keybindings, as we use xref-js2 instead
(define-key tern-mode-keymap (kbd "M-.") nil)
(define-key tern-mode-keymap (kbd "M-,") nil)
"---------------------------------------------------------------------------"
;; header file completion with company-irony-c-headers
(require 'company-irony-c-headers)
(eval-after-load 'company
  '(add-to-list
    'company-backends '(company-irony-c-headers company-irony)))
"---------------------------------------------------------------------------"
;; ggtags
(add-hook 'c-mode-common-hook
	  (lambda ()
	    (when (derived-mode-p 'c-mode 'c++-mode 'java-mode 'asm-mode)
	      (ggtags-mode 1))))
"---------------------------------------------------------------------------"
;;git-emacs use magit instead
(add-to-list 'load-path "~/.emacs.d/packages/git-emacs/")
;(require 'git-emacs)
"---------------------------------------------------------------------------"
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
"---------------------------------------------------------------------------"
;; emacs javascript
(require 'js2-mode)
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

;; Better imenu
(add-hook 'js2-mode-hook #'js2-imenu-extras-mode)

(require 'js2-refactor)
(require 'xref-js2)

(add-hook 'js2-mode-hook #'js2-refactor-mode)
(js2r-add-keybindings-with-prefix "C-c C-r")
(define-key js2-mode-map (kbd "C-k") #'js2r-kill)

;; js-mode (which js2 is based on) binds "M-." which conflicts with xref, so
;; unbind it.
(define-key js-mode-map (kbd "M-.") nil)

(add-hook 'js2-mode-hook (lambda ()
			   (add-hook 'xref-backend-functions #'xref-js2-xref-backend nil t)))

;; js2-mode indent
;;(defun js2-mode-indent-init()
;;  (c-set-offset 'case-label '+)
;;  (setq indent-tabs-mode t)
;;  (setq js-indent-level 4)
;;  (setq js-switch-indent-offset 4)
;;  (setq js2-basic-offset 4)
;;  (setq js2-indent-switch-body t))

;;(add-hook 'js2-mode-hook 'js2-mode-indent-init)

(add-hook 'js2-mode-hook
          (lambda ()
            (c-set-offset 'case-label '+)
            (setq js-indent-level 4)
            (set (make-local-variable 'js2-indent-switch-body) t)
            ))

(add-hook 'js2-mode-hook
          (lambda ()
            (setq my-js-mode-indent-num 4)
            (setq js2-basic-offset my-js-mode-indent-num)
            (setq js-switch-indent-offset my-js-mode-indent-num)
            ))
"---------------------------------------------------------------------------"
;; flycheck
(require 'flycheck)
(require 'flycheck-irony)
(add-hook 'after-init-hook #'global-flycheck-mode)
(setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc))

(eval-after-load 'flycheck
  '(add-hook 'flycheck-mode-hook #'flycheck-irony-setup))
"---------------------------------------------------------------------------"
;; yasnippet
(yas-global-mode t)
"---------------------------------------------------------------------------"
;;(add-to-list 'load-path "~/.emacs.d/packages/color-theme-6.6.0")
;;(require 'color-theme)
;;(eval-after-load "color-theme"
;;  '(progn
;;     (color-theme-initialize)))
;;(color-theme-blackboard)
;;(color-theme-tango)
"---------------------------------------------------------------------------"
;; emacs mew mail client
(require 'mew)
(setq mew-ssl-verify-level 0)
(setq mew-use-cached-passwd t)
(setq mew-prog-ssl "/usr/local/bin/stunnel3")

(autoload 'mew "mew" nil t)
(autoload 'mew-send "mew" nil t)

;; Optional setup (Read Mail menu for Emacs 21):
(if (boundp 'read-mail-command)
    (setq read-mail-command 'mew))

;; Optional setup (e.g. C-xm for sending a message):
(autoload 'mew-user-agent-compose "mew" nil t)
(if (boundp 'mail-user-agent)
    (setq mail-user-agent 'mew-user-agent))
(if (fboundp 'define-mail-user-agent)
    (define-mail-user-agent
      'mew-user-agent
      'mew-user-agent-compose
      'mew-draft-send-message
      'mew-draft-kill
      'mew-send-hook))

(setq mew-config-alist
      '((default
	  (mailbox-type          imap)
	  (proto                 "%")
          (prog-ssl              "/usr/local/bin/stunnel3")
          (imap-auth-list        ("LOGIN" "CRAM-MD5"))
	  (imap-server           "imap.163.com")
          (imap-ssl-port         "993")
	  (imap-user             "chenpoyang")
	  (name                  "陈泼杨")
	  (user                  "chenpoyang")
	  (mail-domain           "163.com")
          (imap-ssl              t)
	  (imap-size             0)
	  (imap-delete           t)
	  (imap-queue-folder     "%queue")
	  (imap-trash-folder     "%Trash")
          (smtp-ssl              t)
	  (smtp-auth-list        ("PLAIN" "LOGIN" "CRAM-MD5")) 
	  (smtp-user             "chenpoyang")
	  (smtp-server           "smtp.163.com")
          (smtp-ssl-port         "465"))))
"---------------------------------------------------------------------------"
(define-key web-mode-map (kbd "C-c t") 'tern-mode)
(define-key web-mode-map (kbd "C-c p") 'php-mode)
(define-key web-mode-map (kbd "C-c w") 'web-mode)
(define-key web-mode-map (kbd "C-c c") 'company-mode)
(define-key web-mode-map (kbd "C-c e") 'emmet-mode)
(global-set-key (kbd "C-h C-f") 'find-function-at-point)
(global-set-key (kbd "C-h C-v") 'find-variable-at-point)
(global-set-key "\C-cV" 'visit-tags-table)
"---------------------------------------------------------------------------"
;; jsx-mode
(add-to-list 'auto-mode-alist '("\\.jsx\\'" . jsx-mode))
(autoload 'jsx-mode "jsx-mode" "JSX mode" t)
(add-hook 'jsx-mode-hook (lambda()
			   (company-mode)
			   (tern-mode)))
"---------------------------------------------------------------------------"
(add-hook 'emacs-lisp-mode-hook (lambda()
				  (company-mode)))

(add-hook 'css-mode-hook (lambda()
			   (company-mode)))

(add-to-list 'auto-mode-alist (cons "\\.c$" #'c++-mode))
(add-hook 'c++-mode-hook (lambda()
			   (company-mode)))

(add-hook 'objc-mode-hook (lambda()
			    (company-mode)))
"---------------------------------------------------------------------------"
"c/c++ opening corresponding header file"
(add-hook 'c-mode-common-hook
	  (lambda()
	    (local-set-key "\C-xz" 'ff-find-other-file)))
"---------------------------------------------------------------------------"
;; python
(require 'python-environment)

(add-hook 'python-mode-hook (lambda()
			      (elpy-mode)
			      (yas-minor-mode)))

;; while C-c C-c in python file, warning occur
(setq python-shell-completion-native-enable nil)
"---------------------------------------------------------------------------"
;; emacs-helm
(require 'helm-config)
(require 'helm)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x b") 'helm-buffers-list)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-c r b") 'helm-bookmarks)
(global-set-key (kbd "C-c r f") 'helm-recentf)
(global-set-key (kbd "C-c d b") 'bookmark-delete)
(global-set-key (kbd "C-c d r") 'recentf-edit-list)
(with-eval-after-load 'helm
  (helm-autoresize-mode t)
  (define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action))
(helm-mode t)

;; when helm buffer appears, don't hide and show other buffer
(require 'shackle)
(setq helm-display-function #'pop-to-buffer)
(setq shackle-rules '(("\\`\\*helm.*?\\*\\'" :regexp t :align t :size 0.4)))
(shackle-mode)
"---------------------------------------------------------------------------"
;; helm-gtags
(add-hook 'c-mode-hook 'helm-gtags-mode)
(add-hook 'c++-mode-hook 'helm-gtags-mode)
(add-hook 'asm-mode-hook 'helm-gtags-mode)



;; M-. and M-, aleady define in global map in xref, rebind it
(with-eval-after-load 'helm-gtags
  (define-key helm-gtags-mode-map (kbd "M-.") 'helm-gtags-find-tag)
  (define-key helm-gtags-mode-map (kbd "M-,") 'helm-gtags-pop-stack)
  "conflict with helm-swool"
  (define-key ggtags-mode-map (kbd "C-c M-i") nil))
"---------------------------------------------------------------------------"
;; helm-swoop
(require 'helm-swoop)
(global-set-key (kbd "M-i") 'helm-swoop)
(global-set-key (kbd "M-I") 'helm-swoop-back-to-last-point)
(global-set-key (kbd "C-c M-i") 'helm-multi-swoop)
(global-set-key (kbd "C-x M-i") 'helm-multi-swoop-all)

;;When doing isearch, hand the word over to helm-swoop
(with-eval-after-load 'helm-swoop
  (define-key isearch-mode-map (kbd "M-i") 'helm-swoop-from-isearch)
  (define-key helm-swoop-map (kbd "M-i") 'helm-multi-swoop-all-from-helm-swoop))

;;Save buffer when helm-multi-swoop-edit complete
(setq helm-multi-swoop-edit-save t)

;;If this value is t, split window inside the current window
(setq helm-swoop-split-with-multiple-windows nil)

;;Split direction. 'split-window-vertically or 'split-window-horizontally
(setq helm-swoop-split-direction 'split-window-vertically)

;;If nil, you can slightly boost invoke speed in exchange for text color
(setq helm-swoop-speed-or-color nil)

;;Go to the opposite side of line from the end or beginning of line
(setq helm-swoop-move-to-line-cycle t)

;;Optional face for line numbers
(setq helm-swoop-use-line-number-face t)
"---------------------------------------------------------------------------"
;; personal config
(defun open-my-init-file()
  (interactive)
  (find-file "~/.emacs.d/init.el"))
(global-set-key (kbd "<f2>") 'open-my-init-file)
"---------------------------------------------------------------------------"
;; org-mode
(require 'org)
(global-set-key (kbd "C-c w") 'org-pomodoro)

(setq org-log-done t)

(add-hook 'org-mode-hook
	  (lambda()
	    (company-mode)
	    (local-set-key "\C-cl" 'org-store-link)
	    (local-set-key "\C-ca" 'org-agenda)))

(setq org-agenda-custom-commands
      '(("h" "Daily habits"
	 ((agenda ""))
	 ((org-agenda-show-log t)
	  (org-agenda-ndays-to-span 7)
	  (org-agenda-log-mode-items '(state))
	  (org-agenda-skip-function '(org-agenda-skip-entry-if 'notregexp ":DAILY:"))))
	("w" . "Task schedule")
	("wa" "Important and urgent task" tags-todo "+PRIORITY=\"A\"")
	("wb" "Important but not urgent task" tags-todo "-Weekly-Monthly-Daily+PRIORITY=\"B\"")
	("wc" "Unimportant and not urgent task" tags-todo "+PRIORITY=\"C\"")
	("p" . "Project schedule")
	("pw" tags-todo "PROJECT+WORK+CATEGORY=\"c/c++/objc\"")
	("pl" tags-todo "PROJECT+DREAM+CATEGORY=\"peckchen\"")
	("W" "Weekly Review"
	 ((stuck "") ;;review stuck project as designated by org-stuck-projects
	  (tags-todo "PROJECT") ;;review all projects(todo keyword)
	  ))))

(setq org-agenda-files (list "~/org/study.org"
			     "~/org/work.org"
			     "~/org/daily.org"
			     "~/org/issue.org"))

;; org-bullets
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
"---------------------------------------------------------------------------"
;; hide minor mode
(defvar hidden-minor-modes ; example, write your own list of hidden
  '(abbrev-mode            ; minor modes
    flycheck-mode
    flyspell-mode
    yas-minor-mode
    emmet-mode
    helm-mode
    irony-mode
    tern-mode
    ggtags-mode
    projectile-mode
    undo-tree-mode
    helm-gtags-mode
    company-mode))

(defun purge-minor-modes ()
  (interactive)
  (dolist (x hidden-minor-modes nil)
    (let ((trg (cdr (assoc x minor-mode-alist))))
      (when trg
        (setcar trg "")))))

(add-hook 'after-change-major-mode-hook 'purge-minor-modes)
"---------------------------------------------------------------------------"
;; youdao-dictionary
(setq url-automatic-caching t)
(global-set-key (kbd "C-c y p") 'youdao-dictionary-search-at-point+)
(global-set-key (kbd "C-c y b") 'youdao-dictionary-search-at-point)
(global-set-key (kbd "C-c y i") 'youdao-dictionary-search-from-input)
(global-set-key (kbd "C-c y v") 'youdao-dictionary-play-voice-at-point)
"---------------------------------------------------------------------------"
;; emacs magit
(require 'magit)
(global-magit-file-mode)
(global-set-key (kbd "C-x g") 'magit-status)
"---------------------------------------------------------------------------"
;; headline in file(show function lists(variables)?)
(global-set-key "\C-xp" 'helm-semantic-or-imenu)
"---------------------------------------------------------------------------"
(defun my-term-mode-hook ()
  (define-key term-raw-map (kbd "C-y") 'term-paste)
  (define-key term-raw-map (kbd "C-k")
    (lambda ()
      (interactive)
      (term-send-raw-string "\C-k")
      (kill-line))))

(add-hook 'term-mode-hook 'my-term-mode-hook)
"---------------------------------------------------------------------------"
;; evil-mode
(require 'evil)
(evil-mode t)
;; always start with state <E>
(setq evil-default-state 'emacs)
"---------------------------------------------------------------------------"
(require 'projectile)
(projectile-global-mode)
(setq projectile-completion-system 'helm)
(helm-projectile-on)
"---------------------------------------------------------------------------"
;; working space, may be conflit with other mode
(add-to-list 'load-path "~/.emacs.d/packages/workspace")
;;(load "objc-init.el")
"---------------------------------------------------------------------------"
