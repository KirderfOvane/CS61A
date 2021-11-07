#| Exercise 3.66: Examine the stream (pairs integers integers). 
Can you make any general comments about the order in which the pairs are placed into the stream? 

For example, 
approximately how many pairs precede the pair (1, 100)? the pair (99, 100)? the pair (100, 100)? 

(If you can make precise mathematical statements here, all the better. 
But feel free to give more qualitative answers if you find yourself getting bogged down.)  |#

(define ones 
  (cons-stream 1 (stream-map + ones ))
)
(define integers
  (cons-stream 1 (stream-map + ones integers))
)

(define (stream-append s1 s2)
  (if (stream-null? s1)
      s2
      (cons-stream 
       (stream-car s1)
       (stream-append (stream-cdr s1) s2))))


(define (interleave s1 s2)
  (if (stream-null? s1)
      s2
      (cons-stream 
       (stream-car s1)
       (interleave s2 (stream-cdr s1)))))


(define (pairs s t)
  (cons-stream
   (list (stream-car s) (stream-car t))
   (interleave
    (stream-map (lambda (x) 
                  (list (stream-car s) x))
                (stream-cdr t))
    (pairs (stream-cdr s) (stream-cdr t)))))


;answer: (1,100) : about 200 pairs.
;        (99,100) : never reached
;        (100,100): never reached



(ss (pairs integers integers) 200)


(define (stream-for-each proc s)
  (if (stream-null? s)
      'done
      (begin 
        (proc (stream-car s))
        (stream-for-each proc 
                         (stream-cdr s)))))

(define (display-stream s)
  (stream-for-each display-line s))
(define (display-line x)
  (newline)
  (display x))





      
(define (check-car s) (if (= (caaar s) 99)
      (begin (print "found it")
        (print (stream-cdr s))
      )))

      (define (whatev s) 
         (if (= 99 (car s))
             (begin (print "found it!")
                (print cdr s)
             )
             ;(print (cdr s))
         ))