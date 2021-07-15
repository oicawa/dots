;;; ------------------------------
;;; Package Tool
;;; ------------------------------

;;; package
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;;; use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))



;;; ------------------------------
;;; Base Behaviors
;;; ------------------------------

;;; Save the last status
(desktop-save-mode 1)

;;; Language & Font
(set-language-environment "Japanese")
(set-fontset-font t 'japanese-jisx0208 "TakaoGothic")

;;; To avoid file name garbled characters.
(prefer-coding-system 'utf-8-unix)

;;; For normal window
(setq-default truncate-lines t)

;;; For separated window (left side & right side)
(setq-default truncate-partial-width-windows t)

;; Line number
(global-linum-mode)
(setq linum-format "%4d ")

;; Current Line
(global-hl-line-mode)

;; Display frash instead of beep sound off
(setq visible-bell t)


;;; ------------------------------
;;; Input method
;;; ------------------------------

;;; Mozc
(require 'mozc-im)
(require 'mozc-popup)
(require 'wdired)
(setq default-input-method "japanese-mozc-im")
(setq mozc-candidate-style 'popup)


;; ------------------------------
;; Cursor behavior
;; ------------------------------

; 1 Character Forward/Backward
(define-key global-map (kbd "H-h") 'backward-char)
(define-key global-map (kbd "H-l") 'forward-char)

; 1 Line Previous/Next
(define-key global-map (kbd "H-j") 'next-line)
(define-key global-map (kbd "H-k") 'previous-line)

; 1 Word Forward/Backward
(define-key global-map (kbd "H-C-h") 'backward-word)
(define-key global-map (kbd "H-C-l") 'forward-word)

; Line Beginning/End
(define-key global-map (kbd "H-C-S-h") 'move-beginning-of-line)
(define-key global-map (kbd "H-C-S-l") 'move-end-of-line)

; 5 Lines Previous/Next 
(define-key global-map (kbd "H-C-j") '(lambda ()
					(interactive)
					(next-line 5)))
(define-key global-map (kbd "H-C-k") '(lambda ()
					(interactive)
					(previous-line 5)))

; Page Previous/Next
(define-key global-map (kbd "H-[") 'scroll-down-command)
(define-key global-map (kbd "H-]") 'scroll-up-command)

; File Beginning/End
(define-key global-map (kbd "H-C-[") 'beginning-of-buffer)
(define-key global-map (kbd "H-C-]") 'end-of-buffer)

; Backspace, Delete
; 1 Character
(define-key global-map (kbd "H-b") 'backward-delete-char-untabify)
(define-key global-map (kbd "H-d") 'delete-forward-char)
; 1 Word
(define-key global-map (kbd "H-C-b") 'backward-kill-word)
(define-key global-map (kbd "H-C-d") 'kill-word)

; Mark
(define-key global-map (kbd "H-@") 'set-mark-command)

; Copy / Cut /Paste
(define-key global-map (kbd "H-c") 'kill-ring-save)
(define-key global-map (kbd "H-x") 'kill-region)
(define-key global-map (kbd "H-v") 'yank)

; Cancel?
(define-key global-map (kbd "H-e") 'keyboard-quit)

; Save and Save As
(define-key global-map (kbd "H-s") 'save-buffer)
(define-key global-map (kbd "H-C-s") 'write-file)

; Open
(define-key global-map (kbd "H-o") 'find-file)

; Undo
(define-key global-map (kbd "H-z") 'undo)

; Jump
(define-key global-map (kbd "H-g") 'goto-line)

; Buffer
(define-key global-map (kbd "H-m b") 'switch-to-buffer)
(define-key global-map (kbd "H-m H-b") 'list-buffers)

; On/Off Input method
(define-key global-map (kbd "<zenkaku-hankaku>") 'toggle-input-method)


;;; ------------------------------
;;; LSP
;;; ------------------------------

;;; lsp-mode
(use-package lsp-mode
  :commands lsp
  :custom
  ((lsp-enable-snippet t)
   (lsp-enable-indentation nil)
   (lsp-prefer-flymake nil)
   (lsp-document-sync-method 2)
   (lsp-inhibit-message t)
   (lsp-message-project-root-warning t)
   (create-lockfiles nil)
   (lsp-prefer-capf t))
  :init
  (unbind-key "C-l")
  :bind
  (("C-l C-l"  . lsp)
   ("C-l h"    . lsp-describe-session)
   ("C-l t"    . lsp-goto-type-definition)
   ("C-l r"    . lsp-rename)
   ("C-l <f5>" . lsp-restart-workspace)
   ("C-l l"    . lsp-lens-mode))
  :hook
  (prog-major-mode . lsp-prog-major-mode-enable))

;;; lsp-ui
(use-package lsp-ui
  :commands lsp-ui-mode
  :after lsp-mode
  :custom
  ;; lsp-ui-doc
  (lsp-ui-doc-enable t)
  (lsp-ui-doc-header t)
  (lsp-ui-doc-include-signature t)
  (lsp-ui-doc-position 'top)
  (lsp-ui-doc-max-width  60)
  (lsp-ui-doc-max-height 20)
  (lsp-ui-doc-use-childframe t)
  (lsp-ui-doc-use-webkit nil)
 
  ;; lsp-ui-flycheck
  (lsp-ui-flycheck-enable t)
 
  ;; lsp-ui-sideline
  (lsp-ui-sideline-enable t)
  (lsp-ui-sideline-ignore-duplicate t)
  (lsp-ui-sideline-show-symbol t)
  (lsp-ui-sideline-show-hover t)
  (lsp-ui-sideline-show-diagnostics t)
  (lsp-ui-sideline-show-code-actions t)
 
  ;; lsp-ui-imenu
  (lsp-ui-imenu-enable nil)
  (lsp-ui-imenu-kind-position 'top)
 
  ;; lsp-ui-peek
  (lsp-ui-peek-enable t)
  (lsp-ui-peek-always-show t)
  (lsp-ui-peek-peek-height 30)
  (lsp-ui-peek-list-width 30)
  (lsp-ui-peek-fontify 'always)
  :hook
  (lsp-mode . lsp-ui-mode)
  :bind
  (("C-l s"   . lsp-ui-sideline-mode)
   ("C-l C-d" . lsp-ui-peek-find-definitions)
   ("C-l C-r" . lsp-ui-peek-find-references)))

(use-package company
  :disabled t
  :custom
  (company-transformers '(company-sort-by-backend-importance))
  (company-idle-delay 0)
  (company-echo-delay 0)
  (company-minimum-prefix-length 2)
  (company-selection-wrap-around t)
  (completion-ignore-case t)
  :bind
  (("C-M-c" . company-complete))
  (:map company-active-map
        ("C-n" . company-select-next)
        ("C-p" . company-select-previous)
        ("C-s" . company-filter-candidates)
        ("C-i" . company-complete-selection)
        ([tab] . company-complete-selection))
  (:map company-search-map
        ("C-n" . company-select-next)
        ("C-p" . company-select-previous))
  :init
  (global-company-mode t)
  ;(add-hook 'after-init-hook 'global-company-mode)
  :config
  ;; lowercase first
  (defun my-sort-uppercase (candidates)
    (let (case-fold-search
          (re "\\`[[:upper:]]*\\'"))
      (sort candidates
            (lambda (s1 s2)
              (and (string-match-p re s2)
                   (not (string-match-p re s1)))))))
 
  (push 'my-sort-uppercase company-transformers)
 
  ;; cooraboration with yasnippet
  (defvar company-mode/enable-yas t)
  (defun company-mode/backend-with-yas (backend)
    (if (or (not company-mode/enable-yas) (and (listp backend) (member 'company-yasnippet backend)))
        backend
      (append (if (consp backend) backend (list backend))
              '(:with company-yasnippet))))
  (setq company-backends (mapcar #'company-mode/backend-with-yas company-backends)))
 

(use-package company-lsp
  :disabled t
  :commands company-lsp
  :custom
  (company-lsp-cache-candidates nil)
  (company-lsp-async t)
  (company-lsp-enable-recompletion t)
  (company-lsp-enable-snippet t)
  :after
  (:all lsp-mode lsp-ui company yasnippet)
  :init
  (push 'company-lsp company-backends))


(use-package yasnippet
  :disabled t
  :bind
  (:map yas-minor-mode-map
        ("C-x i n" . yas-new-snippet)
        ("C-x i v" . yas-visit-snippet-file)
        ("C-M-i"   . yas-insert-snippet))
  (:map yas-keymap
        ("<tab>" . nil)) ;; because of avoiding conflict with company keymap
  :init
  (add-hook 'after-init-hook 'yas-global-mode))

;;; CCLS
(use-package ccls
  :custom
  (ccls-executable "/usr/bin/ccls")
  (ccls-sem-highlight-method 'font-lock)
  (ccls-use-default-rainbow-sem-highlight)
  :hook ((c-mode c++-mode objc-mode) .
         (lambda () (require 'ccls) (lsp))))
