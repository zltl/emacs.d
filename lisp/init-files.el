;;; init-files.el --- config abount files -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

;; Lock files
;; On single-user environments, as we tend to run Emacs these days,
;; those .#* files are more likely to confuse some other program as
;; they are to protect us from conflicting edits.
(setopt create-lockfiles nil)

;; Junk drawer
;;
;; These customizations don’t fit anywhere else.
;; Remove the training wheels #
(put 'narrow-to-region 'disabled nil)

;; Auto-revert
(use-package autorevert
  :diminish
  :hook (on-first-buffer . global-auto-revert-mode)
  :custom
  (global-auto-revert-non-file-buffers t))

;; Recent files
;; This maintains a list of recent files, as we often find in other
;; applications. I wonder if it can or should be integrated with
;; MacOS' list of recent files?
;; C-c f r open recentf
(use-package recentf
  :hook (on-first-file-hook . recentf-mode)
  :bind
  (:map ltl/files-map
        ("r" . recentf-open)))

;; project/projectile
;; (use-package project
;;   :config
;;   (setq project-vc-extra-root-markers '("go.mod" "*.csproj" "package.json"))
;;   (defun project-find-go-module (dir)
;;     (when-let ((root (locate-dominating-file dir "go.mod")))
;;       (cons 'go-module root)))
;;   :config
;;   (cl-defmethod project-root ((project (head go-module)))
;;     (cdr project))
;;   :config
;;   (add-hook 'project-find-functions #'project-find-go-module))
(use-package projectile
  :diminish
  :config
  (add-to-list 'projectile-project-root-files-bottom-up "go.mod")
  (add-to-list 'projectile-project-root-files-bottom-up ".envrc")
  (projectile-register-project-type 'npm '("package.json")
                                    :project-file "package.json"
				    :compile "npm install"
				    :test "npm test"
				    :run "npm start"
				    :test-suffix ".spec")

  (projectile-register-project-type 'go #'projectile-go-project-p
                                    :project-file '("go.mod"))
  
  (projectile-mode)
  (defun my-project-try-cargo-toml (dir)
    "Try to locate a Rust project."
    (when (locate-dominating-file dir "Cargo.toml")
      `(transient . ,dir)))
  (defun my-project-try-go-mod (dir)
    "Try to locate a Rust project."
    (when (locate-dominating-file dir "go.mod")
      `(transient . ,dir)))
  ;; Try rust projects before version-control (vc) projects
  (add-hook 'project-find-functions 'my-project-try-cargo-toml nil nil)
  (add-hook 'project-find-functions 'my-project-try-go-mod nil nil))

;; ffap, short for “find file at point,” guesses a default file from
;; the point. ffap-bindings rebinds several commands with ffap
;; equivalents.
(use-package ffap
  :hook (on-first-input . ffap-bindings))

;; Counting words
;; The default binding of M-= is count-words-region. The newer
;; count-words counts the buffer when there’s no active region.
(bind-key [remap count-words-region] 'count-words)

;; Dired
;; Dired should refresh the listing on each revisit.
;; C-\ to goggle input method
(require 'dired)
(setf dired-auto-revert-buffer t)

(provide 'init-files)
;;; init-files.el ends here
