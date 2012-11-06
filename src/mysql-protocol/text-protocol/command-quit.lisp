;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;                                                                  ;;;
;;; Free Software published under an MIT-like license. See LICENSE   ;;;
;;;                                                                  ;;;
;;; Copyright (c) 2012 Google, Inc.  All rights reserved.            ;;;
;;;                                                                  ;;;
;;; Original author: Alejandro Sedeño                                ;;;
;;;                                                                  ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(in-package :qmynd-impl)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; 15.6.2 command-quit

;; We don't actually receive this packet as a client, but it looks like this.

;; (define-packet command-quit
;;   ((tag :mysql-type (integer 1)
;;         :value +mysql-command-quit+
;;         :transient t :bind nil)))

;; Closes connection or returns OK packet.

(defun send-command-quit ()
  (with-mysql-connection (c)
    (mysql-command-init c +mysql-command-quit+)
    (mysql-write-packet (vector +mysql-command-quit+))
    ;; Don't bother listening for the OK packet, just close the connection.
    (usocket:socket-close (mysql-connection-socket c))
    (setf (mysql-connection-connected c) nil)))
