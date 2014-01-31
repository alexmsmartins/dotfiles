;; Configure fullscreen mode
;;; http://www.emacswiki.org/emacs/FullScreen#toc2
(custom-set-variables
 '(initial-frame-alist (quote ((fullscreen . maximized)))))

;;; Save emacs session
;;; http://www.gnu.org/software/emacs/manual/html_node/emacs/Saving-Emacs-Sessions.html 
(desktop-save-mode 1)

;; Remove irritating start screen messages
;;; http://stackoverflow.com/questions/144983/how-do-i-make-emacs-start-without-so-much-fanfare
(setq inhibit-startup-echo-area-message t)
(setq inhibit-startup-message t)

;;; https://github.com/milkypostman/melpa
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

;;; https://github.com/dimitri/el-get
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (let (el-get-master-branch)
      (goto-char (point-max))
      (eval-print-last-sexp))))

(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-user/recipes")
(el-get 'sync)

;;; http://jblevins.org/projects/markdown-mode/
(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.txt\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;;; http://joostkremers.github.io/pandoc-mode/
(load "pandoc-mode")
(add-hook 'markdown-mode-hook 'turn-on-pandoc)
(defcustom pandoc-binary "~/.cabal/bin/pandoc"
   "*The full path of the pandoc binary."
   :group 'pandoc
   :type 'file)

;;; http://www.dr-qubit.org/emacs.php#undo-tree
(require 'undo-tree)

;;; http://www.emacswiki.org/emacs/Evil
(require 'evil)
(evil-mode 1)
;; change mode-line color by evil state
(lexical-let ((default-color (cons (face-background 'mode-line)
                                   (face-foreground 'mode-line))))
  (add-hook 'post-command-hook
    (lambda ()
      (let ((color (cond ((minibufferp) default-color)
                         ((evil-insert-state-p) '("#e80000" . "#ffffff"))
                         ((evil-emacs-state-p)  '("#444488" . "#ffffff"))
                         ((buffer-modified-p)   '("#006fa0" . "#ffffff"))
                         (t default-color))))
        (set-face-background 'mode-line (car color))
        (set-face-foreground 'mode-line (cdr color))))))

;;; https://github.com/redguardtoo/evil-nerd-commenter
;(require 'evil-nerd-commenter)
;(global-set-key (kbd "M-;") 'evilnc-comment-or-uncomment-lines)
;(global-set-key (kbd "M-:") 'evilnc-comment-or-uncomment-to-the-line)
;(global-set-key (kbd "C-c c") 'evilnc-copy-and-comment-lines)

;;; https://github.com/hvesalai/scala-mode2
(require 'scala-mode2)

;;; http://www.gnu.org/software/auctex/manual/auctex/Loading-the-package.html#Loading-the-package

;;; http://www.xemacs.org/Documentation/packages/html/reftex_1.html#SEC2
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)   ; with AUCTeX LaTeX mode
(setq reftex-plug-into-AUCTeX t)

;;; http://stackoverflow.com/questions/13607156/autocomplete-pandoc-style-citations-from-a-bibtex-file-in-emacs
(eval-after-load 'reftex-vars
  '(progn 
     (setq reftex-cite-format '((?\C-m . "[@%l]")))))

;;; http://www.emacswiki.org/emacs/MakefileMode
(require 'make-mode)

;;; https://github.com/senny/emacs-eclim
(require 'eclim)
(global-eclim-mode)

;; If you want to control eclimd from emacs, also add:
(require 'eclimd)

;; Eclipse installation
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(eclim-eclipse-dirs (quote ("~/eclipse")))
 '(show-paren-mode t))

;; Displaying compilation error messages in the echo area
(setq help-at-pt-display-when-idle t)
(setq help-at-pt-timer-delay 0.1)
(help-at-pt-set-timer)

;; Configuring auto-complete-mode
;; regular auto-complete initialization
(require 'auto-complete-config)
(ac-config-default)

;; Configuring company-mode
(require 'company)
(require 'company-emacs-eclim)
(company-emacs-eclim-setup)
(global-company-mode t)

;; add the emacs-eclim source
(require 'ac-emacs-eclim-source)
(ac-emacs-eclim-config)



;;; http://www.emacswiki.org/emacs-es/RecentFiles
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Inconsolata" :foundry "unknown" :slant normal :weight normal :height 131 :width normal)))))

;; Zoom using the scroll wheel
;; my tweaks
(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)
;;; https://stackoverflow.com/questions/5533110/emacs-zoom-in-zoom-out
(global-set-key [C-mouse-4] 'text-scale-increase)
(global-set-key [C-mouse-5] 'text-scale-decrease)
