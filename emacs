;;; http://www.emacswiki.org/emacs/el-get#toc3
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
  (url-retrieve-synchronously 
    "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
  (let (el-get-master-branch)
    (goto-char (point-max))
    (eval-print-last-sexp))))
(el-get 'sync)

;; http://jblevins.org/projects/markdown-mode/
(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.txt\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

(load "pandoc-mode")
(add-hook 'markdown-mode-hook 'turn-on-pandoc)
(add-hook 'pandoc-mode-hook 'pandoc-load-default-settings)

;; http://www.emacswiki.org/emacs/Evil
(require 'evil)
(evil-mode 1)

;; http://www.emacswiki.org/emacs/RecentFiles
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)

;; http://ess.r-project.org/Manual/ess.html#Unix-installation
(require 'ess-site)
