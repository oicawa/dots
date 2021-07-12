(desktop-save-mode 1)

(set-language-environment "Japanese")
(set-fontset-font t 'japanese-jisx0208 "TakaoGothic")

;; for normal window
(setq-default truncate-lines t)
;; for separated window (left side & right side)
(setq-default truncate-partial-width-windows t)
;; Line number
(global-linum-mode)
(setq linum-format "%4d ")
;; Current Line
(global-hl-line-mode)

;; Short cut keys
(define-key global-map (kbd "H-h") 'backward-char)
(define-key global-map (kbd "H-j") 'next-line)
(define-key global-map (kbd "H-k") 'previous-line)
(define-key global-map (kbd "H-l") 'forward-char)

(define-key global-map (kbd "H-C-h") 'backward-word)
(define-key global-map (kbd "H-C-j") 'forward-paragraph)
(define-key global-map (kbd "H-C-k") 'backward-paragraph)
(define-key global-map (kbd "H-C-l") 'forward-word)

(define-key global-map (kbd "<zenkaku-hankaku>") 'toggle-input-method)

(define-key global-map (kbd "H-b") 'backward-delete-char-untabify)
(define-key global-map (kbd "H-d") 'delete-char)
(define-key global-map (kbd "H-@") 'set-mark-command)

; Line
(define-key global-map (kbd "H-C-S-h") 'move-beginning-of-line)
(define-key global-map (kbd "H-C-S-l") 'move-end-of-line)
; Page
(define-key global-map (kbd "H-S-j") 'scroll-down-command)
(define-key global-map (kbd "H-S-k") 'scroll-up-command)
; File
(define-key global-map (kbd "H-C-l") 'beginning-of-buffer)
(define-key global-map (kbd "H-C-l") 'end-of-buffer)

; Copy / Cut /Paste
(define-key global-map (kbd "H-c") 'kill-ring-save)
(define-key global-map (kbd "H-x") 'kill-region)
(define-key global-map (kbd "H-v") 'yank)

; Cancel?
(define-key global-map (kbd "H-e") 'keyboard-quit)

; Save
(define-key global-map (kbd "H-s") 'save-buffer)

; Open
(define-key global-map (kbd "H-o") 'find-file)

; Undo
(define-key global-map (kbd "H-z") 'undo)

(define-key global-map (kbd "H-g") 'goto-line)

(define-key global-map (kbd "H-m b") 'list-buffers)
