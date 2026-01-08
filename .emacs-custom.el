(menu-bar-mode 0)
(tool-bar-mode 0)
(setq inhibit-startup-screen t)
(scroll-bar-mode 0)

(global-display-line-numbers-mode t)
(setq display-line-numbers-type 'relative)
(ido-mode t)
(ido-everywhere t)

(add-to-list 'default-frame-alist `(font . "consolas"))

(setq url-proxy-services
      '(("http" . "127.0.0.1:7890")
        ("https" . "127.0.0.1:7890")))

(require 'package)
(setq package-archives
      '(("gnu"   . "https://elpa.gnu.org/packages/")
        ("melpa" . "https://melpa.org/packages/")
        ("org"   . "https://orgmode.org/elpa/")))
(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))

;; (setq package-archives
;;       '(("melpa-cn" . "http://mirrors.cloud.tencent.com/elpa/melpa/")
;;         ("gnu-cn" . "http://mirrors.cloud.tencent.com/elpa/gnu/")
;;         ("nongnu-cn" . "http://mirrors.cloud.tencent.com/elpa/nongnu/")))


(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))


(use-package smex
  :ensure t                     
  :config                       
  (smex-initialize)             
  :bind                         
  (("M-x" . smex)               
   ("M-X" . smex-major-mode-commands)))  



(setq default-directory "D:/workspace/VsProject/GameEngine")


(setq ring-bell-function 'ignore)

(use-package ivy
  :ensure t
  :init
  (ivy-mode 1)
  :config
  (setq ivy-use-virtual-buffers t)   
  (setq enable-recursive-minibuffers t)
  (setq ivy-count-format "(%d/%d) "))

(use-package counsel
  :ensure t
  :init
  (counsel-mode 1))

(use-package swiper
  :ensure t)



(use-package yasnippet
  :ensure t
  :config
   (setq yas-snippet-dirs
        (list "~/.emacs.d/snippets" 
              (expand-file-name "snippets" (file-name-directory (locate-library "yasnippet-snippets")))))
  (yas-global-mode 1)

  (with-eval-after-load 'yasnippet
    (add-hook 'c++-mode-hook
              (lambda () (yas-activate-extra-mode 'c-mode)))))

(use-package yasnippet-snippets
  :ensure t)


(use-package company
  :ensure t
  :config
  (setq company-idle-delay 0.0
        company-minimum-prefix-length 1)
  (global-company-mode t)

  (setq company-backends '((company-capf :with company-yasnippet))))

(use-package lsp-mode
  :ensure t
  :init

  (setq lsp-clients-clangd-executable "D:/workspace/git/clangd_21.1.8/bin/clangd.exe")

  :custom

  (lsp-enable-snippet t)                
  (lsp-completion-provider :capf)       
  (lsp-completion-show-detail t)        
  (lsp-completion-show-kind t)          
  (lsp-enable-indentation nil)     
  (lsp-enable-on-type-formatting nil) 
  

  (lsp-idle-delay 0.1)                  
  (lsp-headerline-breadcrumb-enable nil)
  
  :hook

  (c++-mode . lsp)
  (c-mode . lsp)
  
  :config

  (add-hook 'lsp-mode-hook #'yas-minor-mode)
  


  (with-eval-after-load 'yasnippet
    (add-hook 'c++-mode-hook
              (lambda () (yas-activate-extra-mode 'c-mode))))
  
  :commands lsp)


(use-package projectile
  :ensure t
  :config
  (projectile-mode +1)
  :bind-keymap
  ("C-c p" . projectile-command-map))

(use-package format-all
  :ensure t
  :init

  (add-to-list 'exec-path "D:/workspace/git/clangd_21.1.8/bin/")
  :hook 
  (c++-mode . format-all-mode)
  :config


  (setq-default format-all-formatters '(("C++" (clang-format))))
  

  (add-hook 'format-all-mode-hook 'format-all-ensure-formatter))

(setq lsp-enable-indentation nil)   
(setq lsp-enable-on-type-formatting nil)

(defun open-my-init-file ()
  (interactive)
  (find-file (expand-file-name ".emacs-custom.el" user-emacs-directory)))


(global-set-key (kbd "<f5>") 'open-my-init-file)


(use-package google-translate
  :ensure t
  :config
  (setq google-translate-default-source-language "en")
  (setq google-translate-default-target-language "zh-CN")

  (global-set-key (kbd "C-c t") 'google-translate-at-point)
  (global-set-key (kbd "C-c T") 'google-translate-query-translate))


(use-package magit
  :ensure t
  :bind (("C-x g" . magit-status)   
         ("C-x M-g" . magit-dispatch)) 
  :config
  (setq magit-refresh-status-buffer nil))

(use-package multiple-cursors
  :ensure t
  :bind (("C->" . mc/mark-next-like-this)      
         ("C-<" . mc/mark-previous-like-this))
  :config
  (setq mc/always-run-for-all t)
  (add-to-list 'mc/cmds-to-run-for-all 'kill-region)
(setq mc/edit-lines-empty-lines t))
(with-eval-after-load 'multiple-cursors
    (setq mc/always-run-for-all t))
