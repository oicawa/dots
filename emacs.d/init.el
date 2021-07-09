(desktop-save-mode 1)

(set-language-environment "Japanese")
(set-fontset-font t 'japanese-jisx0208 "TakaoGothic")

;; for normal window
(setq-default truncate-lines t)
;; for separated window (left side & right side)
(setq-default truncate-partial-width-windows t)

(define-key global-map (kbd "H-h") 'backward-char)
(define-key global-map (kbd "H-j") 'next-line)
(define-key global-map (kbd "H-k") 'previous-line)
(define-key global-map (kbd "H-l") 'forward-char)

(define-key global-map (kbd "H-C-h") 'backward-word)
(define-key global-map (kbd "H-C-j") 'forward-paragraph)
(define-key global-map (kbd "H-C-k") 'backward-paragraph)
(define-key global-map (kbd "H-C-l") 'forward-word)
