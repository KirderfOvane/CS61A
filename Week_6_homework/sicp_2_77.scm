#| Exercise 2.77: Louis Reasoner tries to evaluate the expression (magnitude z) where z is the object shown in Figure 2.24. 
To his surprise, instead of the answer 5 he gets an error message from apply-generic, saying there is 
no method for the operation magnitude on the types (complex). He shows this interaction to 
Alyssa P. Hacker, who says “The problem is that the complex-number selectors were never defined for complex numbers, 
just for polar and rectangular numbers. All you have to do to make this work is add the following to the complex package:”

(put 'real-part '(complex) real-part)
(put 'imag-part '(complex) imag-part)
(put 'magnitude '(complex) magnitude)
(put 'angle '(complex) angle)

Describe in detail why this works. As an example, trace through all the procedures 
called in evaluating the expression (magnitude z) where z is the object shown in Figure 2.24. 
In particular, how many times is apply-generic invoked? What procedure is dispatched to in each case?  |#

;See this system in System_with_Generic_operations.scm

; execution flow:
1. we call (magnitude (make-complex-from-real-imag 3 4)).
2. make-complex-from-real-imag gets called and does ((get 'make-from-real-imag 'complex ) 3 4)
and returns (complex rectangular 3 . 4), the two datatypes and values.
2. magnitude has a generic selector defined: 
(define (magnitude z) 
  (apply-generic 'magnitude z)
)
3. we call apply-generic with (magnitude '(complex rectangular 3 . 4)) as arg.
4. (type-tags (map type-tag args) saves all types via tag selector from the object in a let-var.
The object: '(complex rectangular 3 . 4) -> (map car '((complex rectangular 3 . 4))) evals. to (complex).
5. We lookup/apply 'magnitude '(complex) and finds magnitude. We call magnitude.
6. (apply-generic 'magnitude '(rectangular 3 . 4) ) is called.
7. (car '(rectangular 3 . 4)) evals to rectangular.
8. wee lookup/apply 'magnitude 'rectangular and finds magnitude directly inside rectangular-package. we call it.
9. rectangular-package-procedure: (define (magnitude z)
        (sqrt (+ (square (real-part z))
                (square (imag-part z))))) 
10. z is (3 . 4). real-part z is 3, imag-part z is 4. square 3 -> 9 , square 4 -> 16, (+ 9 16) -> 25 -> square root of 25 -> 5 = answer 5.


apply-generic is invoked 2 times, one for every data-type prefixed in the args provided to apply-generic.