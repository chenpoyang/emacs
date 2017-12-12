(add-to-list 'auto-mode-alist '("\\.h\\'" . objc-mode))
"---------------------------------------------------------------------------"
; etags for objc
(defun create-objc-tags (dir-name)
  "Create tags file."
  (interactive "DDirectory: ")
  (eshell-command 
   (format "find %s -type f -name \"*.[hm]\" | etags -" dir-name)))
"---------------------------------------------------------------------------"
; key bindings, objc opening corresponding header file
(add-hook 'objc-mode-hook
          (lambda()
	    (local-set-key "\C-cE" 'create-objc-tags)
            (local-set-key "\C-xz" 'ff-find-other-file)))
"---------------------------------------------------------------------------"
