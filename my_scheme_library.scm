;This library contains common sequence operators

;map -> param -> operation -> data / list
(map (lambda (i) (print i)) '(1 2 3))


;enumurate
(define (enumerate-interval low high)
  (if (> low high)
      '()
      (cons low 
            (enumerate-interval 
             (+ low 1) 
             high)))
)
;(enumerate-interval 1 5)


;accumulate
(define (accumulate fn init li)
  (if (null? li)
      init
      (fn (car li) (accumulate fn init (cdr li)))
  )
)
;(accumulate + 0 (list 1 2 3))


;accumulate list of lists
(define (accumulate-n fn init li)
  (if (null? (car li))
      '()
      (cons
          (accumulate fn init (map car li))
          (accumulate-n fn init (map cdr li))
      )
  )
)
;(accumulate-n + 0 '((1 2 3) (4 5 6) (7 8 9) (10 11 12)))


;fold-left
(define (fold-left op initial sequence)
  (define (iter result rest)
    (if (null? rest)
        result
        (iter (op result (car rest)) (cdr rest))
    )
  )
  (iter initial sequence)
)


;fold-right
(define (fold-right op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence) (fold-right op initial (cdr sequence)))
  )
)


;traverse a tree.
(define (tree-map fn tree)
  (map (lambda (sub-tree)
         (if (pair? sub-tree)
             (tree-map fn sub-tree)
             (fn sub-tree)))
       tree))


;filter by boolean/predicate-function.
(define (filter predicate sequence)
  (cond ((null? sequence) '())
        ((predicate (car sequence))
         (cons (car sequence)
               (filter predicate 
                       (cdr sequence))))
        (else  (filter predicate 
                       (cdr sequence)))
  )
)
;(filter odd? (list 1 2 3 4 5 6 7 8 9))


;loop trough ,combine and then flatten.
(define (flatmap proc seq)
  (accumulate append '() (map proc seq))
)

  (flatmap       
    (lambda (i)
      (map (lambda (j) 
                (list i j))
                (enumerate-interval 1 (- i 1))
      )
    ) 
    (list 1 2 3 4 5)
  )

;remove one item from a list/sequence
(define (remove item sequence)
  (filter (lambda (x) (not (= x item)))
          sequence)
)
;(remove 3 (list 1 2 3 4))


;does list x contain item(string) 
(define (memq item x)
  (cond ((null? x) #f)
        ((eq? item (car x)) x)
        (else (memq item (cdr x)))))

;(memq 'apple '(banana apple orange))

; range
(define (range from to)
  (if (> from to)
      '()
      (cons from (range (+ from 1) to))
  )
)

; CS61A prime?, use with range
(define (prime? n)
  (null? (filter (lambda (x) (= (remainder n x) 0))
  (range 2 (- n 1)))))


; better
(define (prime? n)
  (define (F n i) ;"helper"
    (cond ((< n (* i i)) #t)
          ((zero? (remainder n i)) #f)
          (else
           (F n (+ i 1)))))
 ;"primality test"
 (cond ((< n 2) #f)
     (else
      (F n 2))))


; Vectors

(define (vector-map fn vec)
	  (define (loop newvec n)
			    (if (< n 0)
					 newvec
					 (begin 
							(vector-set! newvec n (fn (vector-ref vec n)))
				      (loop newvec (- n 1))
					)
		 )
   )
   (loop (make-vector (vector-length vec)) (- (vector-length vec) 1))
)

; Streams
(define (stream-for-each proc s)
  (if (stream-null? s)
      'done
      (begin 
        (proc (stream-car s))
        (stream-for-each proc 
                         (stream-cdr s)))))

(define (stream-map proc s)
  (if (stream-null? s)
      the-empty-stream
      (cons-stream 
       (proc (stream-car s))
       (stream-map proc (stream-cdr s)))))

(define (stream-ref s n)
  (if (= n 0)
      (stream-car s)
      (stream-ref (stream-cdr s) (- n 1))))

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


; infinite streams when stream-map/recursive call is in the stream-cdr
(define ones 
  (cons-stream 1 (stream-map + ones ))
)
(define integers
  (cons-stream 1 (stream-map + ones integers))
)

; example of abstraction and streams
(define (helper s t)
  (cons-stream (stream-car s)
    (helper (stream-map * (stream-cdr s) t)
      (stream-cdr t))))

  (define powers (helper integers (stream-cdr integers)))
