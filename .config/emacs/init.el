;;; EMACS Configuration 
;;; TODO: Change to an ORG File

;;; Make escape quite all prompts 
(global-set-key (kbd "<escape>") `keyboard-escape-quit)

;; Don't show the splash screen
(setq inhibit-startup-message t)  ; Comment at end of line!


;; Turn off some unneeded UI elements
(menu-bar-mode -1) 
(tool-bar-mode -1)
(scroll-bar-mode -1)


;; Make emacs remember most recently edited files
(recentf-mode 1)


;; Save the minibuffer history 
;; Sets the number of previous commands saved to 25 
(setq history-length 25)
(savehist-mode 1)

;; Make EMACS remember the locations in files 
(save-place-mode 1)

;; Display line numbers in every buffer
(global-display-line-numbers-mode 1)

;; Column numbers as well 
(column-number-mode)

;; Dont pop up UI dialogs when prompting
;; Removes the need for clicking on anything 
(setq use-dialog-box nil)


;; Automotically reload buffers
;; Makes emacs watch all files 
(global-auto-revert-mode 1)

;; Completion
(setq modus-themes-completion 'opinionated)

;; Customize Org files themes 
(setq modus-themes-headings
      '(( 1 , (rainbow overline background 1.4))
        ( 2 , (rainbow overline 1.3))
        ( 3 , (rainbow bold 1.2))
        ( t , (semilight  1.1))))
(setq modus-themes-themes-scale-headings t)
	
(setq modus-themes-org-blocks 'tinted-background)

;; If you're using Emacs 27, either install Modus themes or use this one!
(load-theme 'modus-vivendi t)

(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
 (package-refresh-contents))

;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
   (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;;; Ivy for completion
(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
         :map ivy-minibuffer-map
         ("TAB" . ivy-alt-done)
         ("C-l" . ivy-alt-done)
         ("C-j" . ivy-next-line)
         ("C-k" . ivy-previous-line)
         :map ivy-switch-buffer-map
         ("C-k" . ivy-previous-line)
         ("C-l" . ivy-done)
         ("C-d" . ivy-switch-buffer-kill)
         :map ivy-reverse-i-search-map
         ("C-k" . ivy-previous-line)
         ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))



;;; UNDO
;; Vim style undo not needed for emacs 28
(use-package undo-fu)







;;; Vim Bindings
(use-package evil
  :demand t
  :bind (("<escape>" . keyboard-escape-quit))
  :init
  ;; allows for using cgn
  ;; (setq evil-search-module 'evil-search)
  (setq evil-want-keybinding nil)
  ;; no vim insert bindings
  (setq evil-undo-system 'undo-fu)
  (setq eval-want-C-u-scroll t)
  :config
  (evil-mode 1)
  (define-key evil-insert-state-map "jk" 'evil-normal-state)
  )



;;; Vim Bindings Everywhere else
(use-package evil-collection
  :after evil
  :config
  (setq evil-want-integration t)
  (evil-collection-init))


;;; Configuration to use ESS (Emacs Speaks Statistics)
(use-package ess
  :defer t
  :init
  (require `ess-r-mode))


;;; Doome modeline and fonts
(use-package all-the-icons)

(use-package doom-modeline
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 15)))


(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 1))

(use-package counsel
  :bind (("M-x" . counsel-M-x)
         ("C-x b" . counsel-ibuffer)
         ("C-x C-f" . counsel-find-file)
         :map minibuffer-local-map
         ("C-r" . 'counsel-minibuffer-history)))

(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :custom ((projectile-completion-system 'ivy))
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  (setq projectile-switch-project-action #'projectile-dired))

(use-package counsel-projectile
  :config (counsel-projectile-mode))

(use-package magit
  :custom
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))


(use-package evil-magit
  :after magit)

(use-package org)


(use-package org-bullets
  :after org
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))
