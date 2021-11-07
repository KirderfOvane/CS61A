#| Exercise 3.53: Without running the program, describe the elements of the stream defined by

(define s (cons-stream 1 (add-streams s s))) |#


; answer:
;if we look at the definition of add-streams we see that
(define (add-streams s1 s2) 
  (stream-map + s1 s2))
;evals to
(cons-stream 1 (stream-map + (cons-stream 1 (add-streams s s)) (cons-stream 1 (add-streams s s))))
;so it will create infinite streams inside streams with the stream-car value of 1 that is added together.
; next call to stream s is 2 so 2+2 is 4 and next 4+4 is 8 and so on...

(stream-ref s 8);> 256



