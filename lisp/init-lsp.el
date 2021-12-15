;;; init-lsp.el --- config lsp

;;; Code:

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :hook
  (lsp-mode . lsp-enable-which-key-integration)
  :init
  (setq lsp-keymap-prefix "C-c l")
  :config
  (lsp-enable-which-key-integration t))

;; Optional - provides fancier overlays.
(use-package lsp-ui
  :ensure t
  :requires lsp-mode flycheck
  :after (lsp-mode)
  :commands (lsp-ui-mode)
  :bind
  (:map lsp-ui-mode-map
        ;; use lsp to search definitions (M-.)
        ([remap xref-find-references] . lsp-ui-peek-find-references)
        ;; use lsp to search references (M-?)
        ([remap xref-find-definitions] . lsp-ui-peek-find-definitions)
        ;; symbol list
        ("C-c u" . lsp-ui-imenu))
  :hook (lsp-mode . lsp-ui-mode)
  :config
  (setq lsp-ui-sideline-enable t
        lsp-ui-sideline-delay 0.2
        lsp-ui-sideline-show-diagnostics t
        lsp-ui-sideline-show-hover nil
        lsp-ui-sideline-show-code-actions t
        lsp-signature-auto-activate t
        lsp-signature-render-documentation t
        lsp-modeline-code-actions-enable t
        lsp-enable-symbol-highlighting t
        lsp-ui-sideline-update-mode t
        lsp-ui-doc-enable t
        lsp-eldoc-enable-hover t
        lsp-ui-imenu-auto-refresh t
        lsp-ui-imenu-refresh-delay 1))

(provide 'init-lsp)
;;; init-lsp.el ends here
