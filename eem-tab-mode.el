(evil-define-state tab
  "Tab state."
  :tag " <T> "
  :message "-- TAB --"
  :entry-hook (hydra-tab/body)
  :enable (normal))


(defhydra hydra-tab (:color pink
                     :columns 2
                     :idle 1.0
                     :post (evil-normal-state))
  "Tab mode"
  ("/" centaur-tabs-counsel-switch-group "search" :exit t)
  ("h" centaur-tabs-backward "previous")
  ("l" centaur-tabs-forward "next")
  ("<return>" eem-enter-lower-level "enter lower level" :exit t)
  ("<escape>" eem-enter-higher-level "escape to higher level" :exit t))

(global-set-key (kbd "s-t") 'evil-tab-state)

(provide 'eem-tab-mode)
