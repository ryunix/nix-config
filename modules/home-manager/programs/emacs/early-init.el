;;; early-init.el --- Early initialization file  -*- lexical-binding: t; -*-

;;; Code:

(setq gc-cons-threshold (* 128 1024 1024))

(let ((saved-file-name-handler-alist file-name-handler-alist))
  (setq file-name-handler-alist nil)

  (add-hook 'emacs-startup-hook
            (lambda ()
              (setq gc-cons-threshold (* 16 1024 1024)
                    file-name-handler-alist (append file-name-handler-alist
                                                    saved-file-name-handler-alist)))))

(setq package-archives nil)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;;; early-init.el ends here
