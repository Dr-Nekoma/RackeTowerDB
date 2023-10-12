(defun racketower-handler (process message)
  (let ((response (process-get process :response)))
    (message "Received: %s" response)
    (delete-process process)))

(defun racketower-client ()
  (interactive)
  (let* ((address (read-string "Server Address: "))
     (port (read-number "Server Port: "))
     (connection (open-network-stream "racketower" "*racket-tcp*" address port)))
    (process-put connection :response nil)
    (set-process-filter connection 'racketower-handler)
    (process-send-string connection "Hello!\n")))