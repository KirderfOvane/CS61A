#| 
Exercise 2.79: Define a generic equality predicate equ? that tests the equality of two numbers, 
and install it in the generic arithmetic package. This operation should work for ordinary numbers, 
rational numbers, and complex numbers.  |#




; requirements
(define attach-tag cons)
(define type-tag car)
(define contents cdr)

(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contents args))
          (error
            "No method for these types: 
             APPLY-GENERIC"
            (list op type-tags))))))


; 1. Create a generic interface for users to interact with

(define (add x y) (apply-generic 'add x y))
(define (sub x y) (apply-generic 'sub x y))
(define (mul x y) (apply-generic 'mul x y))
(define (div x y) (apply-generic 'div x y))
(define (equ? x y) (apply-generic 'equ? x y))  ; <-- ADDITION

; 2. Create the default procedures used with this interface in a package.

(define (install-scheme-number-package)
  (define (tag x)
    (attach-tag 'scheme-number x))
  (put 'add '(scheme-number scheme-number)
       (lambda (x y) (tag (+ x y))))
  (put 'sub '(scheme-number scheme-number)
       (lambda (x y) (tag (- x y))))
  (put 'mul '(scheme-number scheme-number)
       (lambda (x y) (tag (* x y))))
  (put 'div '(scheme-number scheme-number)
       (lambda (x y) (tag (/ x y))))
  (put 'equ? '(scheme-number scheme-number)  ; <-- ADDITION
       (lambda (x y) (= x y)))
  (put 'make 'scheme-number
       (lambda (x) (tag x)))
  'done )

; 3. Users create procedures and attach data types to use this package.

(define (make-scheme-number n)
  ((get 'make 'scheme-number ) n))

#|  

 test execution:
 STk> (install-scheme-number-package)
 done
 STk> (add (make-scheme-number 5) (make-scheme-number 3))
 (scheme-number . 8) 
 STk> (equ? (make-scheme-number 5) (make-scheme-number 3)) ; <-- ADDITION
 #f 
 STk> (equ? (make-scheme-number 5) (make-scheme-number 5)) ; <-- ADDITION
 #t 
|#


; 4. Create additional packages

(define (install-rational-package)
  ;; internal procedures
  (define (numer x) (car x))
  (define (denom x) (cdr x))
  (define (make-rat n d)
    (let ((g (gcd n d)))
      (cons (/ n g) (/ d g))))
  (define (add-rat x y)
    (make-rat (+ (* (numer x) (denom y))
                 (* (numer y) (denom x)))
              (* (denom x) (denom y))))
  (define (equ?-rat x y)   ; <-- ADDITION
    (= (/ (numer x) (denom x))
    (/ (numer y) (denom y)))
  )
  (define (sub-rat x y)
    (make-rat (- (* (numer x) (denom y))
                 (* (numer y) (denom x)))
              (* (denom x) (denom y))))
  (define (mul-rat x y)
    (make-rat (* (numer x) (numer y))
              (* (denom x) (denom y))))
  (define (div-rat x y)
    (make-rat (* (numer x) (denom y))
              (* (denom x) (numer y))))
  ;; interface to rest of the system
  (define (tag x) (attach-tag 'rational x))
  (put 'add '(rational rational)
       (lambda (x y) (tag (add-rat x y))))
  (put 'sub '(rational rational)
       (lambda (x y) (tag (sub-rat x y))))
  (put 'mul '(rational rational)
       (lambda (x y) (tag (mul-rat x y))))
  (put 'div '(rational rational)
       (lambda (x y) (tag (div-rat x y))))
  (put 'equ? '(rational rational)            ; <-- ADDITION
       (lambda (x y) (equ?-rat x y)))
  (put 'make 'rational
       (lambda (n d) (tag (make-rat n d))))
  'done )

;procedures to execute the package
(define (make-rational n d)
  ((get 'make 'rational) n d))

; test of package
;STk> 
(install-rational-package)
;done
;STk> 
(add (make-rational 3 5) (make-rational 4 6))
(equ? (make-rational 3 5) (make-rational 4 6)) ; <-- ADDITION
(equ? (make-rational 3 5) (make-rational 3 5)) ; <-- ADDITION
;(rational 19 . 15)


; additional packages with a two-level tag system:

(define (install-complex-package)
  ;; imported procedures from rectangular 
  ;; and polar packages
  (define (make-from-real-imag x y)
    ((get 'make-from-real-imag 'rectangular ) 
     x y))
  (define (make-from-mag-ang r a)
    ((get 'make-from-mag-ang 'polar ) 
     r a))
  ;; internal procedures
  (define (add-complex z1 z2)
    (make-from-real-imag 
     (+ (real-part z1) (real-part z2))
     (+ (imag-part z1) (imag-part z2))))
  (define (sub-complex z1 z2)
    (make-from-real-imag 
     (- (real-part z1) (real-part z2))
     (- (imag-part z1) (imag-part z2))))
  (define (mul-complex z1 z2)
    (make-from-mag-ang 
     (* (magnitude z1) (magnitude z2))
     (+ (angle z1) (angle z2))))
  (define (div-complex z1 z2)
    (make-from-mag-ang 
     (/ (magnitude z1) (magnitude z2))
     (- (angle z1) (angle z2))))
  (define (equ-complex? x y)      ; <-- ADDITION
    (and (= (real-part x) (real-part y))
	     (= (imag-part x) (imag-part y)))
  )
  ;; interface to rest of the system
  (define (tag z) (attach-tag 'complex z))
  (put 'add '(complex complex)
       (lambda (z1 z2) 
         (tag (add-complex z1 z2))))
  (put 'sub '(complex complex)
       (lambda (z1 z2) 
         (tag (sub-complex z1 z2))))
  (put 'mul '(complex complex)
       (lambda (z1 z2) 
         (tag (mul-complex z1 z2))))
  (put 'div '(complex complex)
       (lambda (z1 z2) 
         (tag (div-complex z1 z2))))
  (put 'make-from-real-imag 'complex
       (lambda (x y) 
         (tag (make-from-real-imag x y))))
  (put 'make-from-mag-ang 'complex
       (lambda (r a) 
         (tag (make-from-mag-ang r a))))
  (put 'real-part '(complex) real-part)
  (put 'imag-part '(complex) imag-part)
  (put 'magnitude '(complex) magnitude)
  (put 'angle '(complex) angle))
  (put 'equ? '(complex complex) equ-complex?)  ; <-- ADDITION
  'done
)


;usage procedures:
(define (make-complex-from-real-imag x y)
  ((get 'make-from-real-imag 'complex ) x y))
(define (make-complex-from-mag-ang r a)
  ((get 'make-from-mag-ang 'complex ) r a))
 (define (get-mag-complex-rectangular x y)
    ((get 'magnitude '(complex) ) (make-complex-from-real-imag x y))
 ) 


  ;TESTING below
  
  ; polar and rectangular package is used in complex package:
(define (install-rectangular-package)
    ;; internal procedures
    (define (real-part z) (car z))
    (define (imag-part z) (cdr z))
    (define (make-from-real-imag x y) 
        (cons x y))
    (define (magnitude z)
        (sqrt (+ (square (real-part z))
                (square (imag-part z)))))
    (define (angle z)
        (atan (imag-part z) (real-part z)))
    (define (make-from-mag-ang r a)
        (cons (* r (cos a)) (* r (sin a))))
    ;; interface to the rest of the system
    (define (tag x) 
        (attach-tag 'rectangular x))
    (put 'real-part '(rectangular) real-part)
    (put 'imag-part '(rectangular) imag-part)
    (put 'magnitude '(rectangular) magnitude)
    (put 'angle '(rectangular) angle)
    (put 'make-from-real-imag 'rectangular
        (lambda (x y) 
            (tag (make-from-real-imag x y))))
    (put 'make-from-mag-ang 'rectangular
        (lambda (r a) 
            (tag (make-from-mag-ang r a))))
    'done
)


  (define (install-polar-package)
    ;; internal procedures
    (define (magnitude z) (car z))
    (define (angle z) (cdr z))
    (define (make-from-mag-ang r a) (cons r a))
    (define (real-part z)
        (* (magnitude z) (cos (angle z))))
    (define (imag-part z)
        (* (magnitude z) (sin (angle z))))
    (define (make-from-real-imag x y)
        (cons (sqrt (+ (square x) (square y)))
            (atan y x)))
    ;; interface to the rest of the system
    (define (tag x) (attach-tag 'polar x))
    (put 'real-part '(polar) real-part)
    (put 'imag-part '(polar) imag-part)
    (put 'magnitude '(polar) magnitude)
    (put 'angle '(polar) angle)
    (put 'make-from-real-imag 'polar
        (lambda (x y) 
            (tag (make-from-real-imag x y))))
    (put 'make-from-mag-ang 'polar
        (lambda (r a) 
            (tag (make-from-mag-ang r a))))
    'done
  )
; also add the generic selectors:
(define (real-part z) 
  (apply-generic 'real-part z))
(define (imag-part z) 
  (apply-generic 'imag-part z))
(define (magnitude z) 
  (apply-generic 'magnitude z))
(define (angle z) 
  (apply-generic 'angle z))


    (define (square x) (* x x))
  (install-polar-package)
  (install-rectangular-package)
  (install-complex-package)
  (add (make-complex-from-mag-ang 1 2) (make-complex-from-mag-ang 3 5))

(magnitude (make-complex-from-mag-ang 1 2))
(magnitude (make-complex-from-mag-ang 3 4))
(magnitude (make-complex-from-mag-ang 3 4))
#| 
.. -> apply-generic with op = magnitude,  args = ((complex polar 3 . 4))
.... -> apply-generic with op = magnitude,  args = ((polar 3 . 4))
.... <- apply-generic returns 3
.. <- apply-generic returns 3
3 |#
(magnitude (make-complex-from-real-imag 3 4))
#| 
.. -> apply-generic with op = magnitude,  args = ((complex rectangular 3 . 4))
.... -> apply-generic with op = magnitude,  args = ((rectangular 3 . 4))
.... <- apply-generic returns 5
.. <- apply-generic returns 5
5 |#

; apply-generic is called 2 times, first on complex and then on rectangular.