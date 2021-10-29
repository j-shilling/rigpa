
;;; Utilities for development and testing

(defun rigpa--combine-alists (al1 al2)
  "Combine two association lists, prioritizing one of them.

The result includes all values present in either AL1 or AL2.  If a key
exists in both AL1 as well as AL2, the value in AL1 is retained in the
result."
  (let ((result al1))
    (dolist (p al2)
      (cl-pushnew p result :key #'car :test #'equal))
    result))

;; test different evil keybindings - nil to pass through
(setq rigpa-char--user-evil-keyspec
      '(("g" . goto-char)
        ("G" . goto-char)))

(let ((keyspec (rigpa--combine-alists rigpa-char--user-evil-keyspec
                                      rigpa--char-mode-keyspec)))
  (rigpa--define-evil-keys-from-spec keyspec
                                     rigpa-char-mode-map
                                     'char))
