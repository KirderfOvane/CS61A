#| Exercise 4.24: Design and carry out some experiments to compare the speed of the original metacircular evaluator 
with the version in this section.
Use your results to estimate the fraction of time that is spent in analysis versus execution for various procedures.  |#

(load "analyze.scm")
 (mce)
 (define (fib n) 
     (if (<= n 2)
         1 
         (+ (fib (- n 1)) (fib (- n 2))))) 
 (fib 25) ;> 17 sec
(exit)

(load "meta.scm")
 (mce)
 (define (fib n) 
     (if (<= n 2)
         1 
         (+ (fib (- n 1)) (fib (- n 2))))) 
 (fib 25) ;> 27 sec

 ; 17/27 => 37% of time is spent in analysis.