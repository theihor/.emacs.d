;;;;----------------------------------------------------------------------------
;;;; required packages and initialization code for language modes
;;;;----------------------------------------------------------------------------



;;;-----------------------------------------------------------------------------
;;; python
;;;-----------------------------------------------------------------------------
(el-get-bundle elpy
  (elpy-enable))

(el-get-bundle smartparens)

(defun python-mode-custom-hook ()
  (smartparens-mode 1)
  (highlight-indentation-mode 0))

(add-hook 'python-mode-hook 'python-mode-custom-hook)
;;;-----------------------------------------------------------------------------




;;;-----------------------------------------------------------------------------
;;; golang
;;;-----------------------------------------------------------------------------
(el-get-bundle go-mode)
(el-get-bundle exec-path-from-shell)
(el-get-bundle go-autocomplete)

(defun go-mode-add-custom-keys ()
  ;; insert initialization operator `:='
  (local-set-key
   (kbd "C-;")
   (lambda ()
     (interactive)
     (unless (char-equal (char-before) ?\s)
       (insert " "))
     (insert ":= ")))

  ;; insert 'standard' error handler
  ;; if err != nil {
  ;;       >point here<
  ;; }
  (local-set-key
   (kbd "C-M-;")
   (lambda ()
     (interactive)
     (insert "if err != nil {}")
     (backward-char)
     (newline-and-indent)))

  (local-set-key (kbd "M-.") 'godef-jump))

(defun go-mode-custom-hook ()
  (add-to-list 'exec-path (concat (getenv "GOPATH") "/bin"))
  (setq gofmt-command "goimports")
  (add-hook 'before-save-hook 'gofmt-before-save)
  (go-mode-add-custom-keys)
  (auto-complete-mode 1)
  (electric-pair-mode 1)
  (go-guru-hl-identifier-mode))

(add-hook 'go-mode-hook 'go-mode-custom-hook)
;;;-----------------------------------------------------------------------------




;;;-----------------------------------------------------------------------------
;;; common lisp
;;;-----------------------------------------------------------------------------
(el-get-bundle! slime
  :features slime-autoloads
  (setq inferior-lisp-program "/usr/bin/sbcl")
  (setq slime-contribs '(slime-fancy))
  (slime-setup))
;;;-----------------------------------------------------------------------------



;;;-----------------------------------------------------------------------------
;;; lisp
;;;-----------------------------------------------------------------------------
(add-hook 'lisp-mode-hook 'rainbow-delimiters-mode)
;;;-----------------------------------------------------------------------------




;;;-----------------------------------------------------------------------------
;;; clojure
;;;-----------------------------------------------------------------------------
(el-get-bundle clojure-mode)
(el-get-bundle cider)
(el-get-bundle auto-complete)
(el-get-bundle ac-cider)
;; (el-get-bundle clj-refactor)
(el-get-bundle company)

(defun cider-mode-custom-hook ()
  (ac-flyspell-workaround)
  (ac-cider-setup)
  (company-mode))

(add-hook 'cider-mode-hook 'cider-mode-custom-hook)
(add-hook 'cider-repl-mode-hook 'cider-mode-custom-hook)
(add-hook 'clojure-mode-hook 'rainbow-delimiters-mode)

(with-eval-after-load "auto-complete"
  (add-to-list 'ac-modes 'cider-mode)
  (add-to-list 'ac-modes 'cider-repl-mode))
;;;-----------------------------------------------------------------------------




;;;-----------------------------------------------------------------------------
;;; rust
;;;-----------------------------------------------------------------------------
(el-get-bundle! rust-mode
  :url "https://github.com/rust-lang/rust-mode.git")

(el-get-bundle! racer)

(el-get-bundle rustfmt
  :url "https://github.com/fbergroth/emacs-rustfmt.git")

(setq racer-rust-src-path
      "/home/whythat/.multirust/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src")

;; hooks
(add-hook 'rust-mode-hook #'racer-mode)
(add-hook 'racer-mode-hook #'eldoc-mode)
(add-hook 'rust-mode-hook 'smartparens-mode)
;; (add-hook 'rust-mode-hook 'rustfmt-enable-on-save)

(add-hook 'racer-mode-hook #'company-mode)

(setq company-tooltip-align-annotations t)
;;;-----------------------------------------------------------------------------


;;;-----------------------------------------------------------------------------
;;; haskell
;;;-----------------------------------------------------------------------------
(el-get-bundle! haskell-mode)
(el-get-bundle ghc)
(el-get-bundle! company-ghc)
(el-get-bundle! company)

(add-to-list 'company-backends 'company-ghc)

(add-hook 'haskell-mode-hook 'global-company-mode)
(custom-set-variables '(company-ghc-show-info t))

(add-hook 'haskell-mode-hook 'haskell-indentation-mode)
;;;-----------------------------------------------------------------------------




;;;-----------------------------------------------------------------------------
;;; c++ mode
;;;-----------------------------------------------------------------------------
(require 'electric)
(el-get-bundle! cmake-ide)

(add-to-list 'auto-mode-alist '("\\.hpp\\'" . c++-mode))

(defun cpp-setup ()
  (setq c-default-style "k&r"
        c-basic-offset 4)
  (electric-pair-mode 1)
  (cmake-ide-setup)
  (electric-pair-mode 1))

(add-hook 'c++-mode-hook 'cpp-setup)
;;;-----------------------------------------------------------------------------




;;;-----------------------------------------------------------------------------
;;; misc
;;;-----------------------------------------------------------------------------
(el-get-bundle protobuf-mode)

(el-get-bundle magit)
;;;-----------------------------------------------------------------------------





(provide 'init-language-modes)
