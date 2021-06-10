#| 3. Explain the effect of interchanging the order in which 
the base cases in the cc procedure on page 41 of Abelson and Sussman are checked. 
That is, describe completely the set of arguments for which the original cc procedure 
would return a different value or behave 
differently from a cc procedure coded as given below, 
and explain how the returned values would differ.
(define (cc amount kinds-of-coins)
    (cond((or (< amount 0) (= kinds-of-coins 0)) 0)
        ((= amount 0) 1)
        (else ... ) 
    ) 
)      
   as in the original version |#

;helpers
(define (count-change amount)
  (cc amount 5))

(define (first-denomination kinds-of-coins)
  (cond ((= kinds-of-coins 1) 1)
        ((= kinds-of-coins 2) 5)
        ((= kinds-of-coins 3) 10)
        ((= kinds-of-coins 4) 25)
        ((= kinds-of-coins 5) 50)))



;testing

(define (cc amount kinds-of-coins)
  (cond ((= amount 0) 1)
        ((or (< amount 0) 
             (= kinds-of-coins 0)) 
         0)
        (else 
         (+ (cc amount (- kinds-of-coins 1))
            (cc (- amount (first-denomination 
                           kinds-of-coins))
                kinds-of-coins)))))

(cc 0 0)  => 1 <--*
(cc 0 5)  => 1
(cc -1 5) => 0
(cc -1 0) => 0

;interchanged order
(define (cc amount kinds-of-coins)
  (cond ((or (< amount 0) (= kinds-of-coins 0)) 0)
        ((= amount 0) 1)
        (else 
         (+ (cc amount (- kinds-of-coins 1))
            (cc (- amount (first-denomination 
                           kinds-of-coins))
                kinds-of-coins)))))

(cc 0 0) =>  0
(cc 0 5) =>  1
(cc -1 5) => 0
(cc -1 0) => 0

; conclusion: interchanging the order returns 1 instead of 0 when 0 coins is provided, which technically is more wrong.
; On the other hand, cc is meant to be used with an array of coins provided as kinds-of-coins.