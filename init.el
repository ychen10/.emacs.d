;;; init.el
(eval-when-compile
  (require 'package)
  (package-initialize)
  (defvar use-package-verbose t)
  (require 'use-package))

;;; Code:
(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
												 ("melpa-stable" . "https://stable.melpa.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-revert-check-vc-info nil)
 '(cdlatex-math-modify-prefix 96)
 '(cdlatex-math-symbol-prefix 64)
 '(custom-enabled-themes (quote (doom-material)))
 '(custom-safe-themes
	 (quote
		("1ed5c8b7478d505a358f578c00b58b430dde379b856fbcb60ed8d345fc95594e" default)))
 '(doc-view-continuous t)
 '(org-modules
	 (quote
		(org-bbdb org-bibtex org-docview org-gnus org-habit org-info org-irc org-mhe org-rmail org-w3m)))
 '(package-selected-packages
	 (quote
		(markdown-mode magit elpy multiple-cursors dimmer
									 highlight-symbol org-journal org-capture-pop-frame org-alert
									 pandoc-mode comment-dwim-2 neotree hl-todo auto-complete
									 doom-modeline doom-themes org-bullets yasnippet pdf-tools
									 cdlatex org auctex ## flycheck tide)))
 '(safe-local-variable-values
	 (quote
		((eval add-hook
					 (quote after-save-hook)
					 (lambda nil
						 (org-babel-tangle))
					 nil t))))
 '(tetris-x-colors
	 [[229 192 123]
		[97 175 239]
		[209 154 102]
		[224 108 117]
		[152 195 121]
		[198 120 221]
		[86 182 194]]))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(org-babel-load-file (concat user-emacs-directory "config.org"))
;;; .emacs ends here
