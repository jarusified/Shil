;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)
                                        ;  #### Loading related file ####
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)

; Loads neotree - Travelling files
(add-to-list 'load-path "/Users/jarus/.emacs.d/personal/neotree")
(require 'neotree)
(global-set-key [f1] 'neotree-toggle)

; org-mode - To-do maintainer
;(require 'org)
;(add-to-list 'package-archives("org","http://orgmode.org/elps")

;ido package 
(require 'ido)
(ido-mode t)

                                        ; #### Tweak modes ####
 ; disables menu-bar
(menu-bar-mode -1)
(set-default 'cursor-type 'hbar)
(column-number-mode)
(winner-mode t)

                                        ;  #### Aesthetics ####

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes 'zenburn)
 '(custom-safe-themes
   (quote
    ("4e753673a37c71b07e3026be75dc6af3efbac5ce335f3707b7d6a110ecb636a3" default)))
 '(package-selected-packages
   (quote
    (esup zop-to-char zenburn-theme which-key volatile-highlights vkill undo-tree smartparens smart-mode-line projectile ov operate-on-number move-text markdown-mode+ magit imenu-anywhere guru-mode grizzl god-mode gitignore-mode gitconfig-mode git-timemachine gist flycheck expand-region exec-path-from-shell easy-kill discover-my-major diminish diff-hl crux browse-kill-ring beacon bash-completion back-button anzu ace-window))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
