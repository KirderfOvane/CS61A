(load "analyze.scm")
#| Exercise 4.23: Alyssa P. Hacker doesn’t understand why analyze-sequence needs to be so complicated. 
All the other analysis procedures are straightforward transformations of the corresponding evaluation 
procedures (or eval clauses) in 4.1.1. She expected analyze-sequence to look like this: |#

(define (analyze-sequence exps)
  (define (execute-sequence procs env)
    (cond ((null? (cdr procs))
        (begin
            (print "cdr procs is null")
           ((car procs) env))
        ) 
          (else 
             (begin 
                (print "cdr procs is not null")
                (print "car procs")
                (print (car procs))
                ((car procs) env)
                (execute-sequence (cdr procs) env)
            )
          )))
  (let ((procs (map analyze exps)))
    (print "procs:")
    (print procs)
    (if (null? procs)
        (error "Empty sequence: 
                ANALYZE"))
    (lambda (env) 
      (execute-sequence procs env))))

#| Eva Lu Ator explains to Alyssa that the version in the text does more of the work of evaluating a sequence at analysis time. 
Alyssa’s sequence-execution procedure, rather than having the calls to the individual execution procedures built in, 
loops through the procedures in order to call them: 
In effect, although the individual expressions in the sequence have been analyzed, 
the sequence itself has not been.

Compare the two versions of analyze-sequence. For example, consider the
common case (typical of procedure bodies) where the sequence has just one expression. 
What work will the execution procedure produced by Alyssa’s program do? --> It will evaluate instantly,not lazily
What about the execution procedure produced by the program in the text above? 
How do the two versions compare for a sequence with two expressions?  |# ;--> It will always invoke the last expression, not keep it lazy.

 (define (analyze-sequence exps)
  (define (sequentially proc1 proc2) ;creates a lambda-procedure
    (lambda (env) (proc1 env) (proc2 env)))
  (define (loop first-proc rest-procs)
    (if (null? rest-procs) ;if null , we have analysed all subexpressions
        first-proc ;we invoke the first proc witch is the first exp, ergo the procedure.This is what analyzes the sequence.
        (loop (sequentially first-proc (car rest-procs))
              (cdr rest-procs))))
  (let ((procs (map analyze exps)))
    (if (null? procs)
        (error "Empty sequence -- ANALYZE"))
        (begin 
            (print "car procs:")
            (print (car procs))
            (loop (car procs) (cdr procs))
        )
  )) 