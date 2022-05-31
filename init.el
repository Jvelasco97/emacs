;; Make emacs startup faster

(setq comp-deferred-compilation t)
(setq native-comp-async-report-warnings-errors nil)

(defvar startup/file-name-handler-alist file-name-handler-alist)
(setq file-name-handler-alist nil)

(defun startup/revert-file-name-handler-alist ()
  (setq file-name-handler-alist startup/file-name-handler-alist))

(defun startup/reset-gc ()
  (setq gc-cons-threshold 16777216
    gc-cons-percentage 0.1))

(add-hook 'emacs-startup-hook 'startup/revert-file-name-handler-alist)
(add-hook 'emacs-startup-hook 'startup/reset-gc)


(setq straight-repository-branch "master")
(setq straight-use-package-by-default t)

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'use-package)

;; This causes straight.el to download
;; and load the latest version of Org mode,
;; and use the newer version, instead of
;; Emacs' build in version
(use-package org
  :straight t
  :config
  (progn
  (setq org-hide-emphasis-markers t)
  ;; Default directory for org files (not all are stored here).
  (setq org-directory "~/documents/org")

  (setq org-log-done t
        org-return-follows-link t
        org-src-fontify-natively t   ;; Pretty code blocks
        org-src-tab-acts-natively t
        org-confirm-babel-evaluate nil
        org-list-allow-alphabetical t) ;; Make lists using Roman alphabetical characters
  (add-hook 'org-mode-hook 'org-indent-mode)
  (add-hook 'org-mode-hook
            '(lambda ()
              (visual-line-mode 1)))
  (add-hook 'org-mode-hook 'org-bullets-mode))
(org-babel-do-load-languages 'org-babel-load-languages
    '((shell . t)
      (python . t)
      (C . t)
      (makefile . t))))

;; Load config.org for init.el configuration
(org-babel-load-file (expand-file-name "~/.config/emacs/config.org"))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default bold shadow italic underline success warning error])
 '(ansi-color-names-vector
   ["#171717" "#aa4450" "#87875f" "#cc8800" "#87AFD7" "#8787AF" "#87ceeb" "#c2c2b0"])
 '(awesome-tray-mode-line-active-color "#0031a9")
 '(awesome-tray-mode-line-inactive-color "#d7d7d7")
 '(custom-safe-themes
   '("835868dcd17131ba8b9619d14c67c127aa18b90a82438c8613586331129dda63" "6dc02f2784b4a49dd5a0e0fd9910ffd28bb03cfebb127a64f9c575d8e3651440" "0edb121fdd0d3b18d527f64d3e2b57725acb152187eea9826d921736bd6e409e" "cbdf8c2e1b2b5c15b34ddb5063f1b21514c7169ff20e081d39cf57ffee89bc1e" "9b54ba84f245a59af31f90bc78ed1240fca2f5a93f667ed54bbf6c6d71f664ac" "4b0e826f58b39e2ce2829fab8ca999bcdc076dec35187bf4e9a4b938cb5771dc" "31deed4ac5d0b65dc051a1da3611ef52411490b2b6e7c2058c13c7190f7e199b" default))
 '(elfeed-feeds
   '("https://protesilaos.com/advice.xml" "https://protesilaos.com/feeds/"))
 '(exwm-floating-border-color "#1d2127")
 '(fci-rule-color "#62686E")
 '(flymake-error-bitmap '(flymake-double-exclamation-mark modus-themes-fringe-red))
 '(flymake-note-bitmap '(exclamation-mark modus-themes-fringe-cyan))
 '(flymake-warning-bitmap '(exclamation-mark modus-themes-fringe-yellow))
 '(highlight-tail-colors ((("#22221e") . 0) (("#22292c") . 20)))
 '(hl-todo-keyword-faces
   '(("HOLD" . "#70480f")
     ("TODO" . "#721045")
     ("NEXT" . "#5317ac")
     ("THEM" . "#8f0075")
     ("PROG" . "#00538b")
     ("OKAY" . "#30517f")
     ("DONT" . "#315b00")
     ("FAIL" . "#a60000")
     ("BUG" . "#a60000")
     ("DONE" . "#005e00")
     ("NOTE" . "#863927")
     ("KLUDGE" . "#813e00")
     ("HACK" . "#813e00")
     ("TEMP" . "#5f0000")
     ("FIXME" . "#a0132f")
     ("XXX+" . "#972500")
     ("REVIEW" . "#005a5f")
     ("DEPRECATED" . "#201f55")))
 '(ibuffer-deletion-face 'modus-themes-mark-del)
 '(ibuffer-filter-group-name-face 'modus-themes-pseudo-header)
 '(ibuffer-marked-face 'modus-themes-mark-sel)
 '(ibuffer-title-face 'default)
 '(jdee-db-active-breakpoint-face-colors (cons "#1d2127" "#87ceeb"))
 '(jdee-db-requested-breakpoint-face-colors (cons "#1d2127" "#87875f"))
 '(jdee-db-spec-breakpoint-face-colors (cons "#1d2127" "#686858"))
 '(objed-cursor-color "#aa4450")
 '(org-src-block-faces 'nil)
 '(pdf-view-midnight-colors (cons "#c2c2b0" "#171717"))
 '(rustic-ansi-faces
   ["#171717" "#aa4450" "#87875f" "#cc8800" "#87AFD7" "#8787AF" "#87ceeb" "#c2c2b0"])
 '(vc-annotate-background "#171717")
 '(vc-annotate-background-mode nil)
 '(vc-annotate-color-map
   (list
    (cons 20 "#87875f")
    (cons 40 "#9e873f")
    (cons 60 "#b5871f")
    (cons 80 "#cc8800")
    (cons 100 "#dd8d00")
    (cons 120 "#ee9200")
    (cons 140 "#ff9800")
    (cons 160 "#d7923a")
    (cons 180 "#af8c74")
    (cons 200 "#8787AF")
    (cons 220 "#92708f")
    (cons 240 "#9e5a6f")
    (cons 260 "#aa4450")
    (cons 280 "#994d51")
    (cons 300 "#895654")
    (cons 320 "#785f55")
    (cons 340 "#62686E")
    (cons 360 "#62686E")))
 '(vc-annotate-very-old-color nil)
 '(xterm-color-names
   ["black" "#a60000" "#005e00" "#813e00" "#0031a9" "#721045" "#00538b" "gray65"])
 '(xterm-color-names-bright
   ["gray35" "#972500" "#315b00" "#70480f" "#2544bb" "#8f0075" "#30517f" "white"]))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'upcase-region 'disabled nil)
(put 'scroll-left 'disabled nil)
(put 'narrow-to-region 'disabled nil)
