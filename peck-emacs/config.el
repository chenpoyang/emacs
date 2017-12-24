"---------------------------------------------------------------------------"
;;change directory
(cd "~/")
"---------------------------------------------------------------------------"
(ido-mode 1)
(add-hook 'prog-mode-hook #'hs-minor-mode)
(setq recentf-max-saved-items 10)
"---------------------------------------------------------------------------"
;; global-auto-revert-mode
(global-auto-revert-mode 1)
"---------------------------------------------------------------------------"
;; close the ring bell and warning icon
(setq visible-bell t)
(setq ring-bell-function 'ignore)
;;disable startup splash screen
(setq inhibit-startup-screen t)
"---------------------------------------------------------------------------"
(when (fboundp 'winner-mode)
  (winner-mode 1))
"---------------------------------------------------------------------------"
(setenv "PATH" (concat "/usr/local/bin:" (getenv "PATH")))
"---------------------------------------------------------------------------"
;; maxmize
(add-hook 'window-setup-hook 'toggle-frame-maximized t)
"---------------------------------------------------------------------------"
;; file encoding
(setq buffer-file-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
"---------------------------------------------------------------------------"
(setq mac-option-modifier 'super)
;; 指针颜色设置为白色
(set-cursor-color "white")
;; 鼠标颜色设置为白色
(set-mouse-color "white")
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
;;显示行号(while programming)
(add-hook 'prog-mode-hook #'linum-mode)
;; 显示列号
(setq column-number-mode t)
"---------------------------------------------------------------------------"
;; open image file features on
(auto-image-file-mode t)
"---------------------------------------------------------------------------"
;; Use ediff and not diff 
(setq diff-command "ediff")
(eval-after-load "vc-hooks"
  '(define-key vc-prefix-map "=" 'ediff-revision))
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
(defun sudo-find-file (file-name)
  "Like find file, but opens the file as root."
  (interactive "FSudo Find File: ")
  (let ((tramp-file-name (concat "/sudo::" (expand-file-name file-name))))
    (find-file tramp-file-name)))
(global-set-key (kbd "s-r") 'sudo-find-file)
"---------------------------------------------------------------------------"
;;Insert-current-date
(defun insert-current-date ()
  (interactive "*")
  (insert (format-time-string "[%Y-%m-%d %H:%M:%S]" (current-time))))
;;(insert (format-time-string "%Y-%m-%d" (current-time))))
(global-set-key "\C-xd" 'insert-current-date)
"---------------------------------------------------------------------------"
;; personal config
(defun open-my-init-file()
  (interactive)
  (find-file "~/.emacs.d/peck-emacs/loadpkgs.el"))
(global-set-key (kbd "<f2>") 'open-my-init-file)
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
;; eshell prompt
(defun curr-dir-git-branch-string (pwd)
  "Returns current git branch as a string, or the empty string if
PWD is not in a git repo (or the git command is not found)."
  (interactive)
  (when (and (eshell-search-path "git")
             (locate-dominating-file pwd ".git"))
    (let ((git-output (shell-command-to-string (concat "cd " pwd " && git branch | grep '\\*' | sed -e 's/^\\* //'"))))
      (if (> (length git-output) 0)
          (concat " :" (substring git-output 0 -1))
        "(no branch)"))))

(defun pwd-replace-home (pwd)
  "Replace home in PWD with tilde (~) character."
  (interactive)
  (let* ((home (expand-file-name (getenv "HOME")))
         (home-len (length home)))
    (if (and
         (>= (length pwd) home-len)
         (equal home (substring pwd 0 home-len)))
        (concat "~" (substring pwd home-len))
      pwd)))

(defun pwd-shorten-dirs (pwd)
  "Shorten all directory names in PWD except the last two."
  (let ((p-lst (split-string pwd "/")))
    (if (> (length p-lst) 2)
        (concat
         (mapconcat (lambda (elm) (if (zerop (length elm)) ""
                                    (substring elm 0 1)))
                    (butlast p-lst 2)
                    "/")
         "/"
         (mapconcat (lambda (elm) elm)
                    (last p-lst 2)
                    "/"))
      pwd  ;; Otherwise, we just return the PWD
      )))

(defun split-directory-prompt (directory)
  "Break up the directory into a 'parent' and a 'base'"
  (if (string-match-p ".*/.*" directory)
      (list (file-name-directory directory) (file-name-base directory))
    (list "" directory)))

;; Create a custom prompt using the functions above
(setq eshell-prompt-function
      (lambda ()
        (let* ((directory (split-directory-prompt (pwd-shorten-dirs (pwd-replace-home (eshell/pwd)))))
               (parent (car directory))
               (name (cadr directory))
               (branch (or (curr-dir-git-branch-string (eshell/pwd)) "")))

          (if (eq 'dark (frame-parameter nil 'background-mode))
              (concat   ;; Prompt for Dark Themes
               (propertize parent 'face `(:foreground "#8888FF"))
               (propertize name   'face `(:foreground "#8888FF" :weight bold))
               (propertize branch 'face `(:foreground "green"))
               (propertize " λ"   'face `(:weight ultra-bold))
               (propertize " "    'face `(:weight bold)))

            (concat    ;; Prompt for Light Themes
             (propertize parent 'face `(:foreground "blue"))
             (propertize name   'face `(:foreground "blue" :weight bold))
             (propertize branch 'face `(:foreground "dark green"))
             (propertize " λ"   'face `(:weight ultra-bold))
             (propertize " "    'face `(:weight bold)))))))

;; Set this to match eshell-prompt-function
(setq eshell-prompt-regexp " λ ")

;; Make C-a go to beginning of command instead of line
(add-hook 'eshell-mode-hook '(lambda ()
                               (local-set-key (kbd "C-a")
                                              '(lambda ()
                                                 (interactive)
                                                 (beginning-of-line)
                                                 (search-forward-regexp eshell-prompt-regexp)))))

;; Turn off the default prompt.
(setq eshell-highlight-prompt nil)
"---------------------------------------------------------------------------"
;; enforce spaces for indentation, instead of tabs
(setq-default indent-tabs-mode nil)
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
    auto-revert-mode
    js2-refactor-mode
    column-enforce-mode
    which-key-mode
    ace-isearch-mode
    hs-minor-mode
    elpy-mode
    auto-complete-mode
    paredit-mode
    company-mode))

(defun purge-minor-modes ()
  (interactive)
  (dolist (x hidden-minor-modes nil)
    (let ((trg (cdr (assoc x minor-mode-alist))))
      (when trg
        (setcar trg "")))))

(add-hook 'after-change-major-mode-hook 'purge-minor-modes)
"---------------------------------------------------------------------------"
"c/c++/objc opening corresponding header file"
(add-hook 'c-mode-common-hook
	  (lambda()
	    (local-set-key "\C-xz" 'ff-find-other-file)))
"---------------------------------------------------------------------------"
;; .h .mm files add to objc-mode
(add-to-list 'auto-mode-alist '("\\.mm\\'" . objc-mode))

;;;; header .h add to objc-mode, this cause org unable to export to html file
;;(add-to-list 'magic-mode-alist
;;	     `(,(lambda ()
;;		  (and (string= (file-name-extension buffer-file-name) "h")
;;		       (re-search-forward "@\\<interface\\>"
;;					  magic-mode-regexp-match-limit t)))
;;	       . objc-mode))

;; etags for objc
(defun create-objc-tags (dir-name)
  "Create tags file."
  (interactive "DDirectory: ")
  (eshell-command
   (format "find %s -type f -name \"*.[hm]\" | etags -" dir-name)))

;; key bindings, objc opening corresponding header file
(add-hook 'objc-mode-hook
          (lambda()
	    (local-set-key "\C-cE" 'create-objc-tags)
            (local-set-key "\C-xz" 'ff-find-other-file)))
"---------------------------------------------------------------------------"
;; alpha
;; (set-frame-parameter (selected-frame) 'alpha '(85 50))
;; (add-to-list 'default-frame-alist '(alpha 85 50))
"---------------------------------------------------------------------------"
;; .h use c-mode or cpp-mode or objc-mode
;;(add-to-list 'auto-mode-alist '("\\.h\\'" . c-mode))
;;(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
;;(add-to-list 'auto-mode-alist '("\\.h\\'" . objc-mode))
"---------------------------------------------------------------------------"
