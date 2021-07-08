(desktop-save-mode 1)

(set-language-environment "Japanese")
(set-fontset-font t 'japanese-jisx0208 "TakaoGothic")

;; for normal window
(setq-default truncate-lines t)
;; for separated window (left side & right side)
(setq-default truncate-partial-width-windows t)

(define-key global-map (kbd "s-h") 'backward-char)
(define-key global-map (kbd "s-j") 'next-line)
(define-key global-map (kbd "s-k") 'previous-line)
(define-key global-map (kbd "s-l") 'forward-char)

(define-key global-map (kbd "s-C-h") 'backward-word)
(define-key global-map (kbd "s-C-j") 'forward-paragraph)
(define-key global-map (kbd "s-C-k") 'backward-paragraph)
(define-key global-map (kbd "s-C-l") 'forward-word)
