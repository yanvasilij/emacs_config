(setq url-proxy-services
   '(("no_proxy" . "^\\(localhost\\|10\\..*\\|192\\.168\\..*\\)")
     ("http" . "127.0.0.1:3128")
     ("https" . "127.0.0.1:3128")))

  (require 'package)
  (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
  (package-initialize)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(bmkp-last-as-first-bookmark-file "~/.emacs.d/bookmarks")
 '(custom-safe-themes
   '("ea5822c1b2fb8bb6194a7ee61af3fe2cc7e2c7bab272cbb498a0234984e1b2d9" default))
 '(helm-minibuffer-history-key "M-p")
 '(package-selected-packages
   '(yasnippet-snippets flycheck-clang-tidy cmake-ide xclip flycheck helm-rtags company-rtags company-go evil-collection neotree iedit anzu comment-dwim-2 ws-butler dtrt-indent clean-aindent-mode yasnippet undo-tree volatile-highlights helm-gtags helm-projectile helm-swoop helm zygospore projectile company use-package evil)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;(setq auto-mode-alist
;      (append
;       '(
;         ( "\\.el$". lisp-mode))))
;(global-font-lock-mode 1)

(setq evil-want-keybinding nil)
(evil-collection-init)
(require 'evil)
(evil-mode 1)
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(load-theme 'zenburn)
(add-to-list 'load-path "~/.emacs.d/bookmark-plus")
(require 'bookmark+)

(global-set-key (kbd "<f8>") 'neotree)

(require 'yasnippet)
(yas-global-mode 1)

(require 'projectile)
(define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
(projectile-mode +1)

(setq projectile-project-search-path '("/home/user/ide-7.0-workspace/PLC" "/var/work/isagraf/qnxnto-i386/prdk" "/var/work/linux_scripts" "/var/work/qnx_scripts"))

(require 'company)
(add-hook 'after-init-hook 'global-company-mode)

(require 'rtags)
(require 'company-rtags)

(setq rtags-completions-enabled t)
(eval-after-load 'company
  '(add-to-list
    'company-backends 'company-rtags))
(setq rtags-autostart-diagnostics t)
(rtags-enable-standard-keybindings)

(require 'helm-rtags)
(setq rtags-use-helm t)

(define-key evil-normal-state-map (kbd "M-.") 'rtags-find-symbol-at-point)
(define-key evil-normal-state-map (kbd "M-,") 'rtags-location-stack-back)

(global-set-key (kbd "<f5>") (lambda ()
			       (interactive)
			       (setq-local compilation-read-command nil)
			       (call-interactively 'cmake-ide-compile)))
(setq cmake-ide-build-dir "/home/user/ide-7.0-workspace/PLC/PLC")
(cmake-ide-setup)

(require 'helm-config)
(global-set-key (kbd "M-x") 'helm-M-x)
(helm-mode 1)

(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))
(add-hook 'after-init-hook #'global-flycheck-mode)
(add-hook 'c++-mode-hook (lambda () (setq flycheck-gcc-language-standard "c++11")))

;(use-package flycheck-clang-tidy
;  :after flycheck
;  :hook
;  (flycheck-mode . flycheck-clang-tidy-setup)
;  )

(eval-after-load 'flycheck
  '(add-hook 'flycheck-mode-hook #'flycheck-clang-tidy-setup))


(global-display-line-numbers-mode)

(defun switch-cmake-directory (path-to-project)
  "Switch work directory for cmake-ide.  PATH-TO-PROJECT path to directory with sources."
  (interactive "Dpath:\n")
  (message "switched to %s" path-to-project)
  )

(defun plc-stack ()
  "Switch cmake-ide to PLC-stack project."
  (interactive)
  (setq cmake-ide-build-dir "/home/user/ide-7.0-workspace/PLC/PLC")
  (cmake-ide-setup)
  )

(defun libshmem ()
  "Switch cmake-ide to libshmem project."
  (interactive)
  "Switch cmake-ide to PLC-stack project."
  (setq cmake-ide-build-dir "/var/work/libshmem/src")
  (cmake-ide-setup)
  )

;(global-set-key (kbd "<f9>") (lambda ()
;			       (interactive)
;			       (setq-local compilation-read-command nil)
;			       (call-interactively 'compile)))
