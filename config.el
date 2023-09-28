(setq make-backup-files nil)
(setq auto-save-default nil)
(setq locale-coding-system 'utf-8)

(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)

;; zoom in/out like we do everywhere else.
(global-set-key (kbd "C-=") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)

(global-display-line-numbers-mode 1)
;;(global-display-fill-column-indicator-mode 1)
(setq-default display-line-numbers-type 'relative
              display-line-numbers-current-absolute t
              display-line-numbers-width 4
              display-line-numbers-widen t)
(add-hook 'prog-mode-hook #'display-line-numbers-mode)
(defun my-turn-off-line-numbers ()
  "Disable line numbering in the current buffer."
  (display-line-numbers-mode -1))

(add-hook 'pdf-view-mode-hook #'my-turn-off-line-numbers)

(show-paren-mode 1)

(setq inhibit-startup-message t)

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

(setq select-enable-clipboard t)

(setq backup-directory-alist '(("." . "~/.config/emacs/backups")))
  ;; disk space is cheap
(setq delete-old-versions -1)
(setq version-control t)
(setq vc-make-backup-files t)
(setq auto-save-file-name-transforms '((".*" "~/.config/emacs/auto-save-list/" t)))

(setq scroll-conservatively 100)

(setq ring-bell-function 'ignore)

(setq-default tab-width 2)
(setq-default standard-indent 2)
(setq c-basic-offset tab-width)
(setq-default electric-indent-inhibit t)
;; Use spaces instead of tabs
(setq-default indent-tabs-mode nil)
(setq backward-delete-char-untabify-method 'nil)

(setq electric-pair-pairs '(
                            (?\{ . ?\})
                            (?\( . ?\))
                            (?\[ . ?\])
                            (?\" . ?\")
                            ))
(electric-pair-mode t)

(if (version<= emacs-version "28.0")
    (defalias 'yes-or-no-p 'y-or-n-p)
  (setq use-short-answers 1))

(global-hl-line-mode t)

;; NOTE: init.el is now generated from Emacs.org.  Please edit that file
;;       in Emacs and init.el will be generated automatically!

;; You will most likely need to adjust this font size for your system!
(defvar efs/default-font-size 180)
(defvar efs/default-variable-font-size 180)

;; Make frame transparency overridable
(defvar efs/frame-transparency '(90 . 90))

(set-face-attribute 'default nil :font "Fira Code Retina" :height efs/default-font-size)

;; Set the fixed pitch face
(set-face-attribute 'fixed-pitch nil :font "Fira Code Retina" :height efs/default-font-size)

;; Set the variable pitch face
(set-face-attribute 'variable-pitch nil :font "Cantarell" :height efs/default-variable-font-size :weight 'regular)

;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

(use-package general
  :straight t
  :after evil
  :config
  (general-create-definer efs/leader-keys
    :keymaps '(normal insert visual emacs)
    :prefix "SPC"
    :global-prefix "C-SPC")

  (efs/leader-keys
    "t"  '(:ignore t :which-key "toggles")
    "tt" '(counsel-load-theme :which-key "choose theme")
    "b b"   '(ibuffer :which-key "Ibuffer")
    "b c"   '(clone-indirect-buffer-other-window :which-key "Clone indirect buffer other window")
    "b k"   '(kill-current-buffer :which-key "Kill current buffer")
    "b n"   '(next-buffer :which-key "Next buffer")
    "b p"   '(previous-buffer :which-key "Previous buffer")
    "b B"   '(ibuffer-list-buffers :which-key "Ibuffer list buffers")
    "b K"   '(kill-buffer :which-key "Kill buffer")
    "b r"   '(projectile-ripgrep :which-key "Ripgrep into project")
    "b t"   '(vterm :which-key "vterm")
    "fde" '(lambda () (interactive) (find-file (expand-file-name "~/.emacs.d/Emacs.org")))))

(use-package evil
  :straight t
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  :config
  (evil-mode 1)
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)

  ;; Use visual line motions even outside of visual-line-mode buffers
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)

  (evil-set-undo-system 'undo-redo)

  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal))

(use-package evil-collection
  :straight t
  :after evil
  :config
  (evil-collection-init))

(use-package all-the-icons
  :straight t
  :config
    ;; (all-the-icons-install-fonts)

)

(use-package all-the-icons-completion
  :straight t
  :config
  (all-the-icons-completion-mode))

(use-package doom-themes
  :straight t
  :init (load-theme 'doom-palenight t))

(use-package nerd-icons
  :straight t
  )
(use-package doom-modeline
  :straight t
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 15)))

(use-package which-key
  :straight t
  :diminish which-key-mode
  :config
  (which-key-mode)
  (setq which-key-idle-delay 1))

(use-package org-indent
        :straight nil
        :diminish org-indent-mode)

      (use-package htmlize
        :straight t)

    (use-package org-bullets
      :straight t
      :hook (org-mode . org-bullets-mode))

  (defun echo-area-tooltips ()
    "Show tooltips in the echo area automatically for current buffer."
    (setq-local help-at-pt-display-when-idle t
                help-at-pt-timer-delay 0)
    (help-at-pt-cancel-timer)
    (help-at-pt-set-timer))

  (add-hook 'org-mode-hook #'echo-area-tooltips)
;; Sets LaTeX preview size
(setq org-format-latex-options (plist-put org-format-latex-options :scale 2.0))

(use-package org-beautify-theme
  :straight t)
(add-hook 'org-mode-hook #'(lambda () (load-theme 'org-beautify t)))

;; (add-hook 'org-mode-hook #'(lambda () (load-theme 'org-beautify t)))

(use-package org-present
  :straight t
  :config
  (add-hook 'org-present-mode-hook
       (lambda ()
         (org-present-big)
         (org-display-inline-images)
         (org-present-hide-cursor)
         (org-present-read-only)
         (hide-mode-line-mode +1)))

  (add-hook 'org-present-mode-quit-hook
     #'(lambda ()
       (org-present-small)
       (org-remove-inline-images)
       (org-present-show-cursor)
       (org-present-read-write)
       (hide-mode-line-mode))))

(use-package org-bullets
  :straight t
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))

(use-package ivy
  :straight t
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

(use-package ivy-rich
  :straight t
  :after ivy
  :init
  (ivy-rich-mode 1))

(use-package counsel
  :straight t
  :bind (("C-M-j" . 'counsel-switch-buffer)
         :map minibuffer-local-map
         ("C-r" . 'counsel-minibuffer-history))
  :custom
  (counsel-linux-app-format-function #'counsel-linux-app-format-function-name-only)
  :config
  (counsel-mode 1))

(add-hook 'dired-mode-hook #'dired-hide-details-mode)

(use-package async
  :straight t
  :init
  (dired-async-mode 1))

(use-package projectile
 :straight t
 :config
 (projectile-mode +1)
 (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map))

(use-package dashboard
  :straight t
  :config
  (dashboard-setup-startup-hook)
      (setq dashboard-set-heading-icons t)
      (setq dashboard-set-file-icons t)
      (setq dashboard-projects-backend 'projectile)
      (setq dashboard-items '((projects . 5)
                              (recents . 5)
                              (bookmarks . 5)
                              (agenda . 5)))
  (setq dashboard-banner-logo-title "E M A C S - The worst text editor!")
  (setq dashboard-startup-banner "~/.config/emacs/hitagi.png")
  (setq dashboard-center-content t)
  (setq dashboard-show-shortcuts nil)
  (setq dashboard-set-init-info t)
  ;; (setq dashboard-init-info (format "%d packages loaded in %s"
  ;;                                   (length package-activated-list) (emacs-init-time)))
  (setq dashboard-set-footer t)
  (setq dashboard-set-navigator t))

(setq initial-buffer-choice (lambda () (get-buffer "*dashboard*")))

(use-package rainbow-mode
  :straight t
  :hook
  ((prog-mode . rainbow-mode)))

(use-package rainbow-delimiters
  :straight (rainbow-delimiters :type git :host github :repo "Fanael/rainbow-delimiters")
  :hook
  ((prog-mode . rainbow-delimiters-mode)))

(use-package plantuml-mode
  :straight t)

(setq org-plantuml-jar-path (expand-file-name "/home/vym/.java/plantuml.jar"))
(add-to-list 'org-src-lang-modes '("plantuml" . plantuml))
(org-babel-do-load-languages 'org-babel-load-languages '((plantuml . t)))

(use-package eglot
  :straight nil
  :custom
  (eglot-autoshutdown t)
  (eglot-extend-to-xref t)
  (eglot-ignored-server-capabilities '(:documentHighlightProvider))
  :hook
  ((typescript-mode . eglot-ensure)
   (tsx-ts-mode . eglot-ensure)
   (typescript-ts-mode . eglot-ensure)
   (c-ts-mode . eglot-ensure)
   (c-mode . eglot-ensure)
   (c++-mode . eglot-ensure)
   (c++-ts-mode . eglot-ensure)
   (js-mode . eglot-ensure)
   (js-ts-mode . eglot-ensure)
   (python-mode . eglot-ensure)
   (python-ts-mode . eglot-ensure)
   (java-mode . eglot-ensure)
   (java-ts-mode . eglot-ensure))
  :config
  (add-to-list 'eglot-server-programs '(typescript-ts-mode . ("typescript-language-server" "--stdio")))
  (add-to-list 'eglot-server-programs '(tsx-ts-mode . ("typescript-language-server" "--stdio")))
  :bind (:map eglot-mode-map
              ("C-c l r"   . eglot-rename)
              ("C-c l f f" . eglot-format)
              ("C-c l f b" . eglot-format-buffer)
              ("C-c l a a" . eglot-code-actions)
              ("C-c l a q" . eglot-code-action-quickfix)
              ("C-c l a e" . eglot-code-action-extract)
              ("C-c l a i" . eglot-code-action-inline)
              ("C-c l a r" . eglot-code-action-rewrite)))

(use-package ripgrep
  :straight t
 )

(use-package company
 :straight t
 :config
 (global-company-mode))

(use-package yasnippet
  :straight t
  :diminish yas
  :config
  (yas-global-mode 1)
)
;; Bundled snippets
(use-package yasnippet-snippets
  :straight t
  :config
  (yas-global-mode 1)
)

(use-package vterm
  :straight t
  :commands vterm
  :config
  (setq term-prompt-regexp "^[^#$%>\n]*[#$%>] *")  ;; Set this to match your custom shell prompt
  ;;(setq vterm-shell "zsh")                       ;; Set this to customize the shell to launch
  (setq vterm-max-scrollback 10000))

(use-package pdf-tools
   :straight t
   :config
       (pdf-tools-install)
       (setq-default pdf-view-display-size 'fit-page)
   :bind (:map pdf-view-mode-map
         ("\\" . hydra-pdftools/body)
         ("<s-spc>" .  pdf-view-scroll-down-or-next-page)
         ("g"  . pdf-view-first-page)
         ("G"  . pdf-view-last-page)
         ("l"  . image-forward-hscroll)
         ("h"  . image-backward-hscroll)
         ("j"  . pdf-view-next-page)
         ("k"  . pdf-view-previous-page)
         ("e"  . pdf-view-goto-page)
         ("u"  . pdf-view-revert-buffer)
         ("al" . pdf-annot-list-annotations)
         ("ad" . pdf-annot-delete)
         ("aa" . pdf-annot-attachment-dired)
         ("am" . pdf-annot-add-markup-annotation)
         ("at" . pdf-annot-add-text-annotation)
         ("y"  . pdf-view-kill-ring-save)
         ("i"  . pdf-misc-display-metadata)
         ("s"  . pdf-occur)
         ("b"  . pdf-view-set-slice-from-bounding-box)
         ("r"  . pdf-view-reset-slice)))

   (use-package org-pdfview
       :straight t
       :config 
               (add-to-list 'org-file-apps
               '("\\.pdf\\'" . (lambda (file link)
               (org-pdfview-open link)))))
