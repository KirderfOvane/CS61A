#| 
Exercise 1.40: Define a procedure cubic that can be used together with the newtons-method procedure 
in expressions of the form

(newtons-method (cubic a b c) 1)

to approximate zeros of the cubic x 3 + a x 2 + b x + c .  

|#


(define (cubic a b c) 
(lambda (x)
(+ (* x x x) (* a x x) (* b x) c)))


;deriv
(define (deriv g)
  (lambda (x)
    (/ (- (g (+ x dx)) (g x))
       dx)))

(define dx 0.00001)


;newton transform
(define (newton-transform g)
  (lambda (x)
    (- x (/ (g x) 
            ((deriv g) x)))))

;fixed point
(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) 
       tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))
  (define tolerance 0.00001)

;newton method
(define (newtons-method g guess)
  (fixed-point (newton-transform g) 
               guess))

; exec
(newtons-method (cubic a b c) 1)
