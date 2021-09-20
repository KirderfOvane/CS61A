#| Exercise 3.13: Consider the following make-cycle procedure, 
which uses the last-pair procedure defined in Exercise 3.12:

(define (make-cycle x)
  (set-cdr! (last-pair x) x)
  x)

Draw a box-and-pointer diagram that shows the structure z created by

(define z (make-cycle (list 'a 'b 'c)))

What happens if we try to compute (last-pair z)?  |#


(define (make-cycle x)
  (set-cdr! (last-pair x) x)
  x
)
(define (last-pair x)
  (if (null? (cdr x))
      x
      (last-pair (cdr x)))
)


(define z (make-cycle (list 'a 'b 'c )))

(last-pair (list 'a 'b 'c ))
(define temp (list 'a 'b 'c ))
(set-cdr! (last-pair temp) (list 'a 'b 'c ))



;initial
;-> |a|-|-> |b|-|-> |c|/|
;(set-cdr! (last-pair (list 'a 'b 'c )) (list 'a 'b 'c ))
; replaces |c|/| with the list -> |a|-|-> |b|-|-> |c|/|

;What happens if we try to compute (last-pair z)? 
; endless loop because as soon as we invoke z it invokes make-cycle that invokes last-pair. last-pair
; base-case never is false as we are adding to x every iteration, so it just continues calling itself.