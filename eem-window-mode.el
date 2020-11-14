(require 'ace-window)
(require 'winner)
(require 'lithium)

(evil-define-state window
  "Window state."
  :tag " <W> "
  :message "-- WINDOW --"
  :enable (normal))

;; configure home-row hotkeys to index windows in ace-window,
;; used as "search" feature in window mode
(setq aw-keys '(?h ?j ?k ?l ?g ?f ?d ?s ?a))

;; enable winner mode, used to provide "undo/redo" functionality
;; in window mode
(winner-mode t)

(defun my-window-mru ()
  "Jump to most recent window, or other window if there is only one other.

TODO: This doesn't work with more than 2 windows that are all the same buffer."
  (interactive)
  (let ((num-windows (length (window-list))))
    (if (= num-windows 2)
        (other-window 1)
      (evil-window-mru))))

(defun my-quit-other-window ()
  "Quit other window without changing focus."
  (interactive)
  (other-window 1)
  (quit-window))

;; TODO: after-exit shoudl call a true eem-window-post-exit, which can run hooks
(defhydra hydra-window (:idle 1.0
                        :columns 4
                        :post (eem--update-mode-exit-flag "window" t)
                        :after-exit (eem-hydra-signal-exit "window"))
  "Window mode"
  ("h" evil-window-left "left")
  ("j" evil-window-down "down")
  ("k" evil-window-up "up")
  ("l" evil-window-right "right")
  ("H" evil-window-move-far-left "move to far left")
  ("J" evil-window-move-very-bottom "move to bottom")
  ("K" evil-window-move-very-top "move to top")
  ("L" evil-window-move-far-right "move to far right")
  ("x" evil-window-delete "delete")
  ("c" evil-window-delete)
  ("Q" my-quit-other-window "quit other window" :exit t)
  ("o" my-window-mru "Jump to most recent (like Alt-Tab)" :exit t)
  ("n" other-window "next")
  ("w" delete-other-windows "maximize" :exit t)
  ("s" evil-window-split "split horizontally")
  ("_" evil-window-split "")
  ("v" evil-window-vsplit "split vertically")
  ("|" evil-window-vsplit "")
  ("u" winner-undo "undo")
  ("C-r" winner-redo "redo")
  ("/" ace-window "search")
  ("+" evil-window-increase-height "expand vertically")
  ("-" evil-window-decrease-height "shrink vertically")
  (">" evil-window-increase-width "expand horizontally")
  ("<" evil-window-decrease-width "shrink horizontally")
  ("=" balance-windows "balance")
  ("r" evil-window-rotate-downwards "rotate downwards")
  ("R" evil-window-rotate-upwards "rotate upwards")
  ("f" ffap-other-window "go to file in other window" :exit t)
  ("i" nil "exit" :exit t)
  ("<return>" eem-enter-lower-level "enter lower level" :exit t)
  ("<escape>" eem-enter-higher-level "escape to higher level" :exit t))

(defvar lithium-window-mode-entry-hook nil
  "Entry hook for epistemic window mode.")

(defvar lithium-window-mode-exit-hook nil
  "Exit hook for epistemic window mode.")

(defvar lithium-window-mode
  (make-lithium-mode :enter #'hydra-window/body
                     :entry-hook 'lithium-window-mode-entry-hook
                     :exit-hook 'lithium-window-mode-exit-hook))

;; register mode with the epistemic framework
(eem-register-mode "window")

(provide 'eem-window-mode)
;;; eem-window-mode.el ends here
