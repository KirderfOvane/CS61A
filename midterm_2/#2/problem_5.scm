#| Problem 5 (Scheme-1 interpreter)
For reference, here are the central procedures of scheme-1, with the lines numbered:
1 (define (eval-1 exp)
2 (cond ((constant? exp) exp)
3 ((symbol? exp) (eval exp))
4 ((quote-exp? exp) (cadr exp))
5 ((if-exp? exp)
6 (if (eval-1 (cadr exp))
7 (eval-1 (caddr exp))
8 (eval-1 (cadddr exp))))
9 ((lambda-exp? exp) exp)
10 ((pair? exp) (apply-1 (eval-1 (car exp))
11 (map eval-1 (cdr exp))))
12 (else (error "bad expr: " exp))))
13 (define (apply-1 proc args)
14 (cond ((procedure? proc)
15 (apply proc args))
16 ((lambda-exp? proc)
17 (eval-1 (substitute (caddr proc)
18 (cadr proc)
19 args
20 ’())))
21 (else (error "bad proc: " proc))))
A student tries to type this into his computer, but makes one mistake. Here is a transcript
of some of his test cases:
Scheme-1: (+ 2 3)
5
Scheme-1: (+ (* 2 2) 3)
ERROR
Scheme-1: ((lambda (x) (* x x)) 2)
4
Scheme-1: ((lambda (x) (* x x)) (+ 1 1))
ERROR
Scheme-1: (if #t 2 3)
2
Scheme-1: (if (> 3 0) (+ 2 1) (+ 3 1))
3
Based on the test cases, what is wrong with his version of scheme-1? Indicate the line
number with the problem, and what the student typed on that line. |#

;line 17 and 18 , caddr proc and cadr proc should switch.