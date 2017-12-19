"---------------------------------------------------------------------------"
(use-package all-the-icons)
(use-package all-the-icons-dired
  :after(all-the-icons)
  :config
  (add-hook 'dired-mode-hook 'all-the-icons-dired-mode))
"---------------------------------------------------------------------------"
(use-package neotree
  :defer t
  :bind
  ([f7] . neotree-toggle)
  :config
  (setq neo-theme (if (display-graphic-p) 'icons 'arrow)))
"---------------------------------------------------------------------------"
;; theme
(use-package doom-themes
  :after(all-the-icons)
  :config
  (setq doom-themes-enable-bold t)
  (setq doom-themes-enable-italic t)
  (load-theme 'doom-tomorrow-night t)
  (doom-themes-visual-bell-config)
  (doom-themes-neotree-config)  ; all-the-icons fonts must be installed!
  (doom-themes-org-config))
"---------------------------------------------------------------------------"
;; powerline
(use-package powerline)
(use-package airline-themes
  :config
  (load-theme 'peck-air-line-understated))
"---------------------------------------------------------------------------"
(use-package which-key
  :config
  (which-key-mode 1))
"---------------------------------------------------------------------------"
(use-package benchmark-init
  ;; To disable collection of benchmark data after init is done.
  :config(add-hook 'after-init-hook 'benchmark-init/deactivate))
"---------------------------------------------------------------------------"
(use-package yasnippet
  :config
  (yas-global-mode t))
"---------------------------------------------------------------------------"
(use-package erlang
  :config
  (require 'erlang-start))
"---------------------------------------------------------------------------"
(use-package column-enforce-mode
  :init
  (add-hook 'prog-mode-hook 'column-enforce-mode))
"---------------------------------------------------------------------------"
(use-package ace-jump-mode
  :defer t
  :init
  (autoload 'ace-jump-mode "ace-jump-mode" "Emacs quick move minor mode" t)
  (bind-key "C-c SPC" 'ace-jump-mode)
  (autoload 'ace-jump-mode-pop-mark "ace-jump-mode" "Ace jump back:-)" t)
  (eval-after-load "ace-jump-mode" '(ace-jump-mode-enable-mark-sync))
  (bind-key "C-x SPC" 'ace-jump-mode-pop-mark))
"---------------------------------------------------------------------------"
(use-package ace-isearch
  :init
  (setq ace-isearch-input-length 7)
  (setq ace-isearch-jump-delay 0.25)
  (setq ace-isearch-function 'avy-goto-char)
  (setq ace-isearch-use-jump 'printing-char)
  :config
  (global-ace-isearch-mode 1)
  :bind(:map isearch-mode-map
             ("C-;" . ace-isearch-jump-during-isearch)))
"---------------------------------------------------------------------------"
(use-package emmet-mode
  :bind(:map emmet-mode-keymap
             ("M-j" . emmet-expand-line)))
"---------------------------------------------------------------------------"
(use-package web-mode
  :commands web-mode
  :init
  (add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
  :config
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

  (add-hook 'web-mode-hook
            (lambda()
              (emmet-mode)
              (local-set-key (kbd "C-c m w") 'web-mode)
              (local-set-key (kbd "C-c m t") 'tern-mode)
              (local-set-key (kbd "C-c m p") 'php-mode)
              (local-set-key (kbd "C-c m e") 'emmet-mode))))
"---------------------------------------------------------------------------"
(use-package company
  :config
  ;;(add-hook 'after-init-hook 'global-company-mode)
  ;;(setq company-global-modes '(not php-mode))
  ;;(setq company-global-modes '(not html-mode))
  (global-company-mode)
  (add-hook 'irony-mode-hook 'company-irony-setup-begin-commands)
  (setq company-backends (delete 'company-semantic company-backends))
  ;; enable tab-completion with no delay
  (setq company-idle-delay 0))
;;(define-key c-mode-map [(tab)] 'company-complete)
;;(define-key c++-mode-map [(tab)] 'company-complete)
"---------------------------------------------------------------------------"
;; company-irony; C, C++ and Objective-C  completion backend
(use-package company-irony
  :config
  (eval-after-load 'company
    '(add-to-list 'company-backends 'company-irony)))
"---------------------------------------------------------------------------"
(use-package php-mode
  :defer t
  :config
  (add-hook 'php-mode-hook
            '(lambda ()
               (require 'company-php)
               (company-mode t)
               (ac-php-core-eldoc-setup) ;; enable eldoc
               (define-key php-mode-map (kbd "C-]") 'ac-php-find-symbol-at-point) ;; goto define
               (define-key php-mode-map (kbd "C-t") 'ac-php-location-stack-back)  ;; go back
               (make-local-variable 'company-backends)
               (add-to-list 'company-backends 'company-ac-php-backend)))

  ;; php-indent
  (defun wicked/php-mode-init ()
    "Set some buffer-local variables."
    (setq case-fold-search t) 
    (setq indent-tabs-mode nil)
    (setq fill-column 78)
    (setq c-basic-offset 4)
    (setq tab-width 4)
    ;; (setq default-tab-width 4)
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
  (add-hook 'php-mode-hook 'wicked/php-mode-init))
"---------------------------------------------------------------------------"
;; irony-mode
(use-package irony
  :config
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

  (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options))
"---------------------------------------------------------------------------"
;; flycheck
(use-package flycheck
  :config
  (add-hook 'after-init-hook #'global-flycheck-mode)
  (setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc)))

(use-package flycheck-irony
  :after (flycheck)
  :config
  (add-hook 'flycheck-mode-hook #'flycheck-irony-setup)
  (add-to-list 'flycheck-checkers 'irony)
  ;; using :bind make flycheck-irony not working
  (global-set-key (kbd "<f9>") 'global-flycheck-mode))
"---------------------------------------------------------------------------"
;; company-tern and company-mode for javascript auto-completion
(use-package company-tern
  :config
  (add-to-list 'company-backends 'company-tern)
  (add-hook 'js2-mode-hook (lambda ()
                             (tern-mode)
                             (company-mode)))
  :bind
  ;; Disable completion keybindings, as we use xref-js2 instead
  (:map tern-mode-keymap
        ("M-." . nil)
        ("M-," . nil)))
"---------------------------------------------------------------------------"
;; header file completion with company-irony-c-headers
(use-package company-irony-c-headers
  :config
  (eval-after-load 'company
    '(add-to-list
      'company-backends '(company-irony-c-headers company-irony))))
"---------------------------------------------------------------------------"
;; ggtags
(use-package ggtags
  :config
  (add-hook 'c-mode-common-hook
            (lambda ()
              (when (derived-mode-p 'c-mode 'c++-mode 'java-mode 'asm-mode)
                (ggtags-mode 1)))))
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
;; emacs mew mail client
(use-package mew
  :config
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
            (smtp-ssl-port         "465")))))
"---------------------------------------------------------------------------"
;; rjsx-mode for jsx files
(use-package rjsx-mode
  :defer t
  :init
  (autoload 'rjsx-mode "rjsx-mode" "rjsx mode" t)
  (add-hook 'rjsx-mode-hook (lambda()
                              (company-mode)
                              (tern-mode))))
"---------------------------------------------------------------------------"
;; python
(use-package python-environment
  :config
  (add-hook 'python-mode-hook (lambda()
                                (elpy-mode)
                                (yas-minor-mode)))
  ;; while C-c C-c in python file, warning occur
  (setq python-shell-completion-native-enable nil))
"---------------------------------------------------------------------------"
;; emacs-helm
(use-package helm
  :bind
  ("M-x" . helm-M-x)
  ("C-x b" . helm-mini)
  ("C-x C-b" . helm-buffers-list)
  ("C-x C-f" . helm-find-files)
  ("C-c m b" . helm-bookmarks)
  ("C-c m r" . helm-recentf)
  ("C-x p" . helm-semantic-or-imenu)
  :config
  (helm-mode 1)
  (require 'helm-config)
  (with-eval-after-load 'helm
    (helm-autoresize-mode t)
    (define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)))
"---------------------------------------------------------------------------"
;; when helm buffer appears, don't hide and show other buffer
(use-package shackle
  :config
  (setq helm-display-function #'pop-to-buffer)
  (setq shackle-rules '(("\\`\\*helm.*?\\*\\'" :regexp t :align t :size 0.4)))
  (shackle-mode 1))
"---------------------------------------------------------------------------"
;; helm-gtags
(use-package helm-gtags
  :config
  (add-hook 'c-mode-hook 'helm-gtags-mode)
  (add-hook 'c++-mode-hook 'helm-gtags-mode)
  (add-hook 'asm-mode-hook 'helm-gtags-mode)

  ;; M-. and M-, aleady define in global map in xref, rebind it
  (with-eval-after-load 'helm-gtags
    ;; C-c d b, C-c d r, use as global keybindings, use M-. instread of C-c d
    ;;  (define-key helm-gtags-mode-map (kbd "C-c d") nil)
    (define-key helm-gtags-mode-map (kbd "M-.") 'helm-gtags-find-tag)
    (define-key helm-gtags-mode-map (kbd "M-,") 'helm-gtags-pop-stack)
    "conflict with helm-swool"
    (define-key ggtags-mode-map (kbd "C-c M-i") nil))

  ;; use helm-gtags key binding instread of xref
  (with-eval-after-load 'ggtags
    (define-key ggtags-mode-map (kbd "M-.") 'helm-gtags-find-tag)
    (define-key ggtags-mode-map (kbd "M-,") 'helm-gtags-pop-stack)))
"---------------------------------------------------------------------------"
;; helm-swoop
(use-package helm-swoop
  :bind
  ("M-i" . helm-swoop)
  ("M-I" . helm-swoop-back-to-last-point)
  ("C-c M-i" . helm-multi-swoop)
  ("C-x M-i" . helm-multi-swoop-all)
  :config
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
  (setq helm-swoop-use-line-number-face t))
"---------------------------------------------------------------------------"
;; flyspell
(use-package flyspell
  :config
  (dolist (hook '(text-mode-hook))
    (add-hook hook (lambda () (flyspell-mode 1))))
  (dolist (hook '(change-log-mode-hook log-edit-mode-hook))
    (add-hook hook (lambda () (flyspell-mode -1))))

  (define-key flyspell-mode-map (kbd "<f8>") 'helm-flyspell-correct)

  ;; I highly suggest setting ‘flyspell-issue-message-flag’ to nil,
  ;; as printing messages for every word (when checking the entire buffer)
  ;; causes an enormous slowdown.
  (setq flyspell-issue-message-flag nil)

  ;; Enable flyspell for comments in source code
  ;;(add-hook 'c++-mode-hook
  ;;          (lambda ()
  ;;            (flyspell-prog-mode)))

  ;; add words to flyspell
  (eval-when-compile (require 'cl))

  (defun append-aspell-word (new-word)
    (let ((header "personal_ws-1.1")
          (file-name (substitute-in-file-name "$HOME/.aspell.en.pws"))
          (read-words (lambda (file-name)
                        (let ((all-lines (with-temp-buffer
                                           (insert-file-contents file-name)
                                           (split-string (buffer-string) "\n" t))))
                          (if (null all-lines)
                              ""
                            (split-string (mapconcat 'identity (cdr all-lines) "\n")
                                          nil
                                          t))))))
      (when (file-readable-p file-name)
        (let* ((cur-words (eval (list read-words file-name)))
               (all-words (delq header (cons new-word cur-words)))
               (words (delq nil (remove-duplicates all-words :test 'string=))))
          (with-temp-file file-name
            (insert (concat header
                            " en "
                            (number-to-string (length words))
                            "\n"
                            (mapconcat 'identity (sort words #'string<) "\n"))))))
      (unless (file-readable-p file-name)
        (with-temp-file file-name
          (insert (concat header " en 1\n" new-word "\n")))))
    (ispell-kill-ispell t) ; restart ispell
    (flyspell-mode)
    (flyspell-mode))

  (defun append-aspell-current ()
    "Add current word to aspell dictionary"
    (interactive)
    (append-aspell-word (thing-at-point 'word)))

  (define-key flyspell-mode-map (kbd "C-c C-a") 'append-aspell-current))
"---------------------------------------------------------------------------"
(use-package org
  :config
  (setq org-log-done t)

  (defun custom_org_auto_check()
    (org-update-checkbox-count t))

  (add-hook 'org-mode-hook
            (lambda()
              (company-mode)
              (local-set-key "\C-cl" 'org-store-link)
              (local-set-key "\C-cw" 'org-pomodoro)
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
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))
"---------------------------------------------------------------------------"
(use-package ace-window
  :init
  (setq aw-background nil)
  :bind
  ("M-h" . ace-window)
  :bind(:map org-mode-map
             ("M-h" . nil)))
"---------------------------------------------------------------------------"
(use-package youdao-dictionary
  :init(setq url-automatic-caching t)
  :bind(("C-c y p" . youdao-dictionary-search-at-point+)
        ("C-c y b" . youdao-dictionary-search-at-point)
        ("C-c y i" . youdao-dictionary-search-from-input)
        ("C-c y v" . youdao-dictionary-play-voice-at-point)))
"---------------------------------------------------------------------------"
(use-package magit
  :bind
  ("C-x g" . magit-status)
  :config(global-magit-file-mode))
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
(use-package evil
  :init(setq evil-default-state 'emacs)
  :config
  (evil-mode 1)
  (evil-set-initial-state 'term-mode 'emacs))
"---------------------------------------------------------------------------"
;; projectile
(use-package projectile
  :config
  (projectile-global-mode 1)
  (setq projectile-completion-system 'helm)
  (helm-projectile-on))
"---------------------------------------------------------------------------"
;; lua
(use-package company-lua
  :config
  (defun my-lua-mode-company-init ()
    (setq-local company-backends '((company-lua
                                    company-etags
                                    company-dabbrev-code
                                    company-yasnippet)))))

(add-hook 'lua-mode-hook #'my-lua-mode-company-init)
"---------------------------------------------------------------------------"
;; go
(use-package company-go
  :config
  (add-hook 'go-mode-hook
            (lambda ()
              (set (make-local-variable 'company-backends) '(company-go))
              (company-mode)))

  (add-hook 'go-mode-hook
            (lambda ()
              (add-hook 'before-save-hook 'gofmt-before-save)
              (setq tab-width 4)
              (setq indent-tabs-mode 1)))

  ;; gorepl
  (add-hook 'go-mode-hook #'gorepl-mode))
"---------------------------------------------------------------------------"
;; nodejs repl
(use-package nodejs-repl
  :config
  (add-hook 'js2-mode-hook
            (lambda ()
              (define-key js2-mode-map (kbd "C-x C-e") 'nodejs-repl-send-last-expression)
              (define-key js2-mode-map (kbd "C-c C-l") 'nodejs-repl-send-line)
              (define-key js2-mode-map (kbd "C-c C-j") 'nodejs-repl-send-region)
              (define-key js2-mode-map (kbd "C-c C-f") 'nodejs-repl-load-file)
              (define-key js2-mode-map (kbd "C-c C-z") 'nodejs-repl-switch-to-repl))))
"---------------------------------------------------------------------------"
(use-package ag
  :init
  (use-package helm-ag))
"---------------------------------------------------------------------------"
;; chinese-wbim
(use-package chinese-wbim
  :defer t
  :config
  (defun my-chinese-wbim-wb-activate-function ()
    (add-hook 'chinese-wbim-active-hook 
              (lambda ()
                (let ((map (chinese-wbim-mode-map)))
                  (define-key map "," 'chinese-wbim-previous-page)
                  (define-key map "." 'chinese-wbim-next-page)))))

  (register-input-method
   "chinese-wbim-wb" "euc-cn" 'chinese-wbim-use-package
   "五笔" "汉字五笔输入法" "wb.txt"
   'my-chinese-wbim-wb-activate-function))
"---------------------------------------------------------------------------"
(use-package ecb
  :defer t
  :config(setq ecb-windows-width 0.15)
  :bind(([f10] . ecb-activate)
        ([C-f10] . ecb-deactivate)))
"---------------------------------------------------------------------------"
;;ac-html补全 use company instead
;;(require 'ac-html)
;;(add-hook 'html-mode-hook 'ac-html-enable)
;;(add-hook 'web-mode-ac-sources-alist
;;	  '("html" . (
;;		      ;; attribute-value better to be first
;;		      ac-source-html-attribute-value
;;		      ac-source-html-tag
;;		      ac-source-html-attribute)))
"---------------------------------------------------------------------------"
