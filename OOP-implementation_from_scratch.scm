; class with instance vars and class vars
(define make-count
    (let ((glob 0))
        (lambda ()
            (let ((loc 0))
                (lambda ()
                    (set! loc (+ loc 1))
                    (set! glob (+ glob 1))
                    (list loc glob)
                )
            )
        )
    )
)

(define c1 (make-count))
(define c2 (make-count))

(c1)
(c1)
(c2)

; class with instance,class vars and message passing implemented.
(define make-count
    (let ((glob 0)) ; class-var
        (lambda ()
            (let ((loc 0)) ; instance-var
                (lambda (msg)
                    (cond ((eq? msg 'local )  ;method
                            (lambda ()
                                (set! loc (+ loc 1))
                                    loc))
                        ((eq? msg 'global )  ;method
                                (lambda ()
                                    (set! glob (+ glob 1))
                                        glob))
                        ((eq? msg 'set-local! ) ;method 
                            (lambda (new-local-value)
                                (set! loc new-local-value)
                                'okay
                            )
                        )
                        (else (error "No such method" msg))
                    )
                )
            )
        )
    )
)
            
        
    

(define c3 (make-count))
((c3 'global ))
((c3 'global ))
((c3 'global ))
((c3 'local ))
((c3 'local ))
((c3 'local ))

; reason of double brackets:
; we call c3 with a message, which returns a procedure.
; then we call that procedure


; class that is a child of make-count, illustrating the implementation of inheritance
(define make-buzzer
    (lambda ()
        (let ((parent (make-count)))  ; extend
            (lambda (msg)
                (cond ((eq? msg 'local ) ; 'local in parent is "overwritten"
                        (lambda ()
                            (let ((result ((parent 'local )))) ; get method & value of local from parent class
                                (if (= (remainder result 7) 0)
                                    'buzz ;invoke buzz
                                    result ; invote result
                                )
                            )
                        )
                )
                (else (parent msg))) ; if no message exist in make-buzzer we ask it's parent.
            )
    )
))

(define buzzer (make-buzzer))

(ask buzzer 'local )
(ask buzzer 'local )
(ask buzzer 'local )
(ask buzzer 'local )
(ask buzzer 'local )
(ask buzzer 'local )
(ask buzzer 'local )
(ask buzzer 'local )
(ask buzzer 'local )
(ask buzzer 'set-local! 13)