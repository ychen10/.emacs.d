(use-package doom-themes
  :demand t
  :custom
  (doom-themes-enable-bold t)
  :config
  (load-theme 'doom-material t))

(set-face-attribute 'default nil :height 165)
(setq ring-bell-function 'ignore) ;; disable bell
(tool-bar-mode -1) ;; disable ugly toolbar
(scroll-bar-mode -1) ;; disable ugly scroll bar

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :config (setq doom-modeline-height 15
                doom-modeline-bar-width 3))

(display-time-mode 1) ;; displays time

;; do not load average data
(setq display-time-default-load-average nil)
(setq display-time-string-forms
        '((format-time-string "%m/%d (%a) %H:%M")))
(display-battery-mode t) ;; displays battery

(column-number-mode 1) ;; always displays the column number
(add-hook 'prog-mode-hook 'linum-mode) ;; displays line numbers

(global-set-key [f8] 'neotree-toggle) ;; side bar

(global-hl-line-mode 1) ;; highlight current line
(global-hl-todo-mode 1) ;; highlight TODOs
(show-paren-mode 1) ;; highlight matching parens
(setq show-paren-delay 0.0) ;; no delay in showing paren
(setq hl-todo-highlight-punctuation ":"
			hl-todo-keyword-faces
			'(("TODO"       error bold)
        ("FIXME"      warning bold)
        ("NOTE"       success bold))
			hl-todo-include-modes
			(quote (LaTeX-mode emacs-lisp-mode)))

(setq initial-buffer-choice "~/Org/planning.org") ;; enter with planning.org
(global-set-key (kbd "M-C-f") 'toggle-frame-fullscreen) ;; full-screen
(desktop-save-mode 1) ;; recover sessions on startup
(global-auto-revert-mode t) ;; auto revert
(fset 'yes-or-no-p 'y-or-n-p) ;; y/n instead of yes/no

;; add LaTeX-mode to prog-mode
(add-hook 'LaTeX-mode-hook
          (lambda () (run-hooks 'prog-mode-hook)))
;; add org-mode to prog-mode
(add-hook 'org-mode-hook
          (lambda () (run-hooks 'prog-mode-hook)))
(add-hook 'before-save-hook 'delete-trailing-whitespace)

(add-to-list 'auto-mode-alist '("\\.pdf\\'" . pdf-tools-install))

(delete-selection-mode 1) ;; typing replaces selected word

(global-flycheck-mode 1) ;; flycheck
(add-hook 'text-mode-hook 'flyspell-mode) ;; flyspell
(add-hook 'prog-mode-hook 'flyspell-prog-mode)

(setq-default auto-fill-function 'do-auto-fill) ;; auto-fill-mode enabled universally
(setq-default fill-column 85)

(setq-default cursor-type 'bar)
(setq-default tab-width 2)

(electric-pair-mode 1) ;; automatically close parens, etc.

(use-package yasnippet
  :ensure t
  :init
    (yas-global-mode 1))

(use-package auto-complete
	:config
	(ac-config-default)
	(global-auto-complete-mode t) ;; auto-complete-mode
	(add-to-list 'ac-modes 'LaTeX-mode)
	)

;; quick dictionary and thesaurus
(use-package define-word
  :bind ("C-c d" . define-word-at-point))

(use-package mw-thesaurus
  :bind ("C-c t" . mw-thesaurus-lookup-at-point)
)



(use-package comment-dwim-2
	:bind ("M-;" . comment-dwim-2)
	)

(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))

(use-package drag-stuff
  :ensure t
  :config (drag-stuff-global-mode 1)
  :bind (
  ("<C-M-up>" . drag-stuff-up)
  ("<C-M-down>" . drag-stuff-down)
  ("<C-M-left>" . drag-stuff-left)
	("<C-M-right>" . drag-stuff-right)))

(use-package multiple-cursors
  :bind
  ("C-S-c C-S-c" . mc/edit-lines)
  ("C->" . mc/mark-next-like-this)
  ("C-<" . mc/mark-previous-like-this)
  ("C-c C-<" . mc/mark-all-like-this))

(global-set-key [(control f3)] 'highlight-symbol)
(global-set-key [f3] 'highlight-symbol-next)
(global-set-key [(shift f3)] 'highlight-symbol-prev)
(global-set-key [(meta f3)] 'highlight-symbol-query-replace)

(use-package org
	:mode ("\\.org$" . org-mode)
  :init (org-clock-persistence-insinuate)
	:commands (org-clock-persistence-insinuate)
	:bind (("C-c l" . org-store-link)
				 ("C-c a" . org-agenda)
				 ("C-c c" . org-capture)
				 ("C-c b" . org-switchb)
				 ("C-c C-x C-o" . org-clock-out)
				 ("C-c C-x C-i" . org-clock-in-anywhere)
				 )
	:config
	(defun org-clock-in-anywhere (&optional select)
		"Clock in. If called w/o prefix, check whether we are in an org-mode buffer first."
		(interactive "P")
		(if select
				(org-clock-in select)
			(if (equal major-mode 'org-mode) (org-clock-in) (error "Not in Org-mode"))))
	(setq org-agenda-files '("~/Org" "~/Org/journal")
				org-clock-persist 'history
				org-startup-indented t
				org-default-notes-file (concat org-directory "/notes.org")
				org-support-shift-select t
				org-todo-keywords (quote ((sequence "TODO" "IN PROGRESS" "|" "DONE")))
				org-todo-keyword-faces (quote (("IN PROGRESS" :foreground "orange" :weight bold)))
				org-clock-idle-time 15
        org-clock-mode-line-total 'current

				org-agenda-deadline-faces
				'((1.001 . error)
					(1.0 . org-warning)
					(0.5 . org-upcoming-deadline)
					(0.0 . org-upcoming-distant-deadline))

        org-columns-default-format "%50ITEM(Task) %10Effort(Effort){:} %10CLOCKSUM"
				)
	(add-to-list 'org-modules '(org-habit org-crypt))
  (add-to-list 'org-structure-template-alist '("sl" "#+BEGIN_SRC emacs-lisp\n?\n#+END_SRC"))
	)

(use-package org-capture
  :config
  ;; append to the last headline by default
  ;; does not support multiple entries within the same day
  (defun org-journal-find-location ()
    (org-journal-new-entry t)
    (goto-char (point-max))
    (re-search-backward "^\\*")
    )

  (setq org-capture-templates
      '(("t" "TODO Entry" entry (file "~/Org/Planning.org")
         "* TODO %^{Description}\n")
        ("j" "Journal Entry" entry
           (function org-journal-find-location)
           "* %(format-time-string org-journal-time-format) %^{Title}\n%i%?")
        ("r" "Weekly Review" entry
           (function org-journal-find-location)
           "* Weekly Review %(format-time-string org-journal-time-format)\n%i%?" :created t)
        ("n" "Note" entry (file org-default-notes-file)
         "* %^{Title}\n%U\n%i%?")
        ("k" "Quote" entry (file "~/Org/Babel/quotes.org")
         "* %^{Author}, /%^{Work}/\n%U\n%i#+BEGIN_QUOTE\n%?\n#+END_QUOTE")
        ("c" "Correct Reasoning" entry (file "~/Org/Notes/correct-reasoning.org")
         "- %^{Description}\n")
        )
      )
)

(use-package org-bullets
	:ensure t
	:config
	(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

(use-package org-journal
  :ensure t
  :init
  :custom
  (org-journal-file-type 'yearly)
  (org-journal-file-format "%Y.org")
  (org-journal-dir  "~/Org/journal/")
  (org-journal-date-format "%A, %m/%d/%Y")
  (org-journal-time-format "%H:%M")
  (org-journal-encrypt-journal t)
  (org-journal-enable-encryption t)
	)

(use-package org-pomodoro
  :ensure t
  :after org
  :bind (("C-c p" . org-pomodoro))
  :config
  (setq org-pomodoro-ticking-sound-p nil)
  (setq org-pomodoro-start-sound-p nil)
  (setq org-pomodoro-length 45)
  (setq org-pomodoro-short-break-length 5)
  (setq org-pomodoro-long-break-length 15))

(use-package org-alert
  :ensure t
  :init
  (setq alert-default-style 'libnotify)
  )

(setenv "PATH" (concat (getenv "PATH") ":/Library/TeX/texbin/"))
(setq exec-path (append exec-path '("/Library/TeX/texbin/")))
;; Add /Library/TeX/texbin/ to emacs' PATH variable
(setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin/"))
(setq exec-path (append exec-path '("/usr/local/bin/")))

(eval-after-load 'latex
  '(setq LaTeX-clean-intermediate-suffixes
         (append LaTeX-clean-intermediate-suffixes
                 (list "\\.fdb_latexmk" "\\.tex~" "\\.log"))
         LaTeX-clean-output-suffixes
         (append LaTeX-clean-output-suffixes
                 (list "\\.dvi" "\\.ps" "\\.xdv" "\\.log" "\\.prv" "\\.fmt"))))

(use-package tex
  :ensure auctex
  :mode ("\\.tex\\'" . LaTeX-mode)
  :bind ("s-[" . TeX-command-run-all) ;; C-c C-a
  :config
  (setq TeX-auto-save t
        TeX-parse-self t
        LaTeX-electric-left-right-brace 1 ;; automatic close tags
        TeX-source-correlate-method 'synctex
        TeX-source-correlate-mode t
        TeX-source-correlate-start-server t)

  (setq-default TeX-master nil)
  ;; matching dollar sign
  (add-hook 'LaTeX-mode-hook
            (lambda () (set (make-local-variable 'TeX-electric-math)(cons "$" "$")))
            'TeX-source-correlate-mode ;; correlate enabled
            )
 ;; open preview using pdf-tools
 (setq TeX-view-program-selection '((output-pdf "PDF Tools"))
    TeX-view-program-list '(("PDF Tools" TeX-pdf-tools-sync-view)))

   ;; DEPRECATED
   ;; use Skim as external viewer
   ;(add-hook 'LaTeX-mode-hook
   ;           (lambda()
   ;           (add-to-list 'TeX-expand-list
   ;                        '("%q" skim-make-url))))
   ;(defun skim-make-url ()
   ;	(concat
   ;	 (TeX-current-line)
   ;	 " \""
   ;	 (expand-file-name (funcall file (TeX-output-extension) t)
   ;                    (file-name-directory (TeX-master-file)))
   ;	 "\" \""
   ;	 (buffer-file-name)
   ;	 "\""))
   ;(setq TeX-view-program-list
   ;			'(("Skim" "/Applications/Skim.app/Contents/SharedSupport/displayline %q")))
   ;(setq TeX-view-program-selection '((output-pdf "Skim")))
)

(eval-after-load 'cdlatex ;; disable cdlatex auto paren
	(lambda ()
		(substitute-key-definition 'cdlatex-pbb nil cdlatex-mode-map)
		(substitute-key-definition 'cdlatex-dollar nil cdlatex-mode-map)
		))

(use-package cdlatex
	:hook (LaTeX-mode . turn-on-cdlatex)
	:ensure t
	:init
  ;; does not really work but putting them here anyways
	(setq cdlatex-math-modify-prefix 96  ;; "`"
				cdlatex-math-symbol-prefix 64) ;; "@"
  (setq cdlatex-math-symbol-alist
				'((?0 ("\\varnothing" ))
					(?e ("\\varepsilon"))
					(?> ("\\geq"))
					(?< ("\\leq" "\\vartriangleleft"))
					(123 ("\\subseteq"))
					(125 ("\\supseteq"))
          (?~ ("\\simeq" "\\approx"))
					(?! ("\\neq" "\\neg"))
          (?c ("\\circ"))
          (?. ("\\ldots" "\\cdots"))
          (?[ ("\\Longleftarrow"))
          (?] ("\\Longrightarrow"))
          (?+ ("\\oplus"))
          (?| ("\\mid"))
          (?F ("\\Phi"))
					))
	(setq cdlatex-math-modify-alist
				'((?b "\\mathbb" nil t nil nil)
					(?c "\\mathcal" nil t nil nil)
					(?2 "\\sqrt" nil t nil nil)
					(?t "\\text" nil t nil nil)
					))
  (setq cdlatex-command-alist
      '(("lcm" "Insert \\text{lcm}"
         "\\text{lcm}" cdlatex-position-cursor nil nil t)
        ("gal" "Insert \\text{Gal}()"
         "\\text{Gal}(?)" cdlatex-position-cursor nil nil t)
        ("irr" "Insert \\text{irr}_{}()"
         "\\text{irr}_{?}()" cdlatex-position-cursor nil nil t)
        ("im" "Insert \\text{im}()"
         "\\text{im}(?)" cdlatex-position-cursor nil nil t)
        ))
)

(use-package magit
  :config
  :bind
  ("C-x g" . magit-status))

(use-package elpy
  :ensure t
  :init
  (elpy-enable))

(use-package ein
  :ensure t
  )
