;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

(setq doom-font-increment 1
      doom-font (font-spec :family "BlexMono Nerd Font" :size 15 :weight 'regular)
      )

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; (setq doom-theme 'doom-solarized-dark)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

(with-eval-after-load 'org
  (setq org-log-into-drawer t
        org-agenda-todo-ignore-scheduled 'future
        )
  (setq org-capture-templates
        `(("i" "Inbox" entry (file "inbox.org") "* TODO %?")))
  (require 'org-habit)
  (defun my/org-todo-as-of (time)
    "Complete task as of a chosen date/time."
    (interactive (list (org-read-date t t)))
    (cl-letf (((symbol-function 'current-time) (lambda () time)))
      (org-todo 'done))
    ))

(use-package! mozc
  :config
  (setq default-input-method "japanese-mozc")
  )

(global-auto-revert-mode 1)
(setq auto-revert-use-notify t
      auto-revert-verbose nil)

(use-package! calibredb
  :defer t
  :config
  (setq calibredb-root-dir "~/Syncthing/Books")
  (setq calibredb-db-dir (expand-file-name "metadata.db" calibredb-root-dir))
  (setq calibredb-library-alist
        '(
          ("~/Syncthing/Books" (name . "Calibre"))
          ("http://arxiv.maplepop.com/catalog/" (name . "arxiv"))
          ("https://m.gutenberg.org/ebooks.opds/" (name . "Gutenberg"))
          )
        )
  (setq calibredb-format-nerd-icons t)
  (map! :map calibredb-search-mode-map
        :n "RET" #'calibredb-find-file
        :n "/" #'calibredb-search-live-filter)
  )

(defun my/nov-setup ()
  (visual-line-mode 1)
  (setq-local visual-fill-column-width 90
              visual-fill-column-center-text t)
  (visual-fill-column-mode 1))

(use-package! nov
  :mode ("\\.epub\\'" . nov-mode)
  :hook (nov-mode . my/nov-setup))

(after! mu4e
  (setq mu4e-maildir "~/Maildir"
        mu4e-change-filenames-when-moving t
        mu4e-update-interval nil ; fetch manually with `U'; set to seconds for auto-fetch
        ;; Send through msmtp (already configured by the home-manager email
        ;; module) rather than Emacs' built-in smtpmail, so SMTP credentials
        ;; only live in one place.
        sendmail-program (executable-find "msmtp")
        send-mail-function #'sendmail-send-it
        message-sendmail-f-is-evil t
        message-sendmail-extra-arguments '("--read-envelope-from")
        message-send-mail-function #'message-send-mail-with-sendmail))

;; NOTE: Sent/Drafts/Trash below match home-manager's folder defaults, and
;; Archive is a guess -- verify (and create Archive if missing) against
;; Infomaniak's actual IMAP folders after the first `mbsync --all' run.
(set-email-account! "ik"
                    '((mu4e-sent-folder       . "/ik/Sent")
                      (mu4e-drafts-folder     . "/ik/Drafts")
                      (mu4e-trash-folder      . "/ik/Trash")
                      (mu4e-refile-folder     . "/ik/Archive")
                      (smtpmail-smtp-user     . "luca.bracone@ik.me")
                      (user-mail-address      . "luca.bracone@ik.me")
                      (mu4e-compose-signature . "Luca Bracone"))
                    t)
