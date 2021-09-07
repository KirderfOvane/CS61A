Problem 4 (Data-directed programming)
You are implementing a calculator for physicists, in which arithmetic is performed on
numbers with units attached, e.g., 3 dynes times 4 centimeters equals 12 ergs. There are
two kinds of operations relevant to the project. (You are only required to implement one
of these for the exam!) Two numbers with units can be multiplied, as above, if there is an
appropriate unit for the answer. 

Two numbers with units can be added if their units are identical or if one is a multiple of the other.

To make this work, you are using attach-tag to attach a unit to a number. You plan to
use data-directed programming, with entries like
(put ’dyne ’cm ’erg)

to tell the program about the conversion mentioned above. You also have conversions for
units of the same kind:
(put ’ft ’in 12)
This indicates that a foot equals 12 inches.

Write the procedure (plus x y) that adds two typed quantities. 
If the two arguments are of the same type, just add the contents and preserve the type. 
If the two arguments are of different types, look them up with get. (Don’t forget that the two arguments may not
be in the same order as the types in the table entry. That is,
(plus (attach-tag ’ft 2) (attach-tag ’in 6))
(plus (attach-tag ’in 6) (attach-tag ’ft 2))
should both work with the foot-to-inch table entry above.) If you find a number, do the
appropriate conversion and give a result like
(attach-tag ’in 30)
for the problem above. 

If you find another unit, as in the erg example, or you find no entry
at all, then give the error message “you can’t add apples and oranges.”

(define attach-tag cons)
(define type-tag car)
(define contents cdr)

(define (times x y) (apply-generic 'mul x y))
(define (plus x y) (apply-generic 'add x y))

(define (install-cm-package)
  (define (tag x)
    (attach-tag 'cm x))
  (put 'add '(cm cm)
       (lambda (x y) (tag (+ x y))))
  (put 'sub '(cm cm)
       (lambda (x y) (tag (- x y))))
  (put 'mul '(cm cm)
       (lambda (x y) (tag (* x y))))
  (put 'div '(cm cm)
       (lambda (x y) (tag (/ x y))))
  (put 'make 'cm
       (lambda (x) (tag x)))
  (put 'dyne 'cm (lambda (n) (attach-tag 'dyne (contents n))))
  (put 'cm 'dyne (lambda (n) (attach-tag 'cm (contents n))))
  'done )

(define (make-cm n)
  ((get 'make 'cm ) n))

(define (make-dyne n)
     ((get 'make 'dyne ) n)
)

(define (get-coercion t1 t2)
      (get (type-tag t1) (type-tag t2))
)


;testing
(times (make-dyne 3) (make-cm 4)) ;> 12 ergs
(plus (make-dyne 3) (make-cm 4)) ;> 7 ergs


(define type car)
(put 'in 'ft 12)
(put 'ft 'in 12)


(define (plus x y)
  (let (
          (tx (type x))
	     (ty (type y))
       )
       (if (eq? tx ty)
	      (attach-tag tx (+ (contents x) (contents y)))
	      (let (   
                    (gxy (get tx ty))
	               (gyx (get ty tx))
                )
	           (cond ((number? gxy) (attach-tag ty (+ (* gxy (contents x)) (contents y))))
		            ((number? gyx) (attach-tag tx (+ (contents x) (* gyx (contents y)))))
		            (else (error "You can't add apples and oranges.")))
           )
       )
  )
)

(plus (attach-tag 'in 30) (attach-tag 'in 25))
(plus (attach-tag 'ft 30) (attach-tag 'in 25))
(plus (attach-tag 'in 30) (attach-tag 'ft 25))
(plus (attach-tag 'in 30) (attach-tag 'erg 25))