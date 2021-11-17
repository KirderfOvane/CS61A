#| Exercise 4.1: Notice that we cannot tell whether the metacircular evaluator 
evaluates operands from left to right or from right to left. 
Its evaluation order is inherited from the underlying Lisp: 
If the arguments to cons in list-of-values are evaluated from left to right, 
then list-of-values will evaluate operands from left to right; 
and if the arguments to cons are evaluated from right to left, 
then list-of-values will evaluate operands from right to left.

Write a version of list-of-values that evaluates operands from left to right 
regardless of the order of evaluation in the underlying Lisp. 
Also write a version of list-of-values that evaluates operands from right to left. 
 |#


(define (no-operands? ops) (null? ops))
(define (first-operand ops) (car ops))
(define (rest-operands ops) (cdr ops))

(define (list-of-values exps env)
  (if (no-operands? exps)
      '()
      (cons (eval (first-operand exps) env)
            (list-of-values 
             (rest-operands exps) 
             env))))





; left-to-right eval
(define (list-of-values exps env)
  (if (no-operands? exps)
      '()
      (let
        (
            (left-op (eval (first-operand exps) env))
        )
        (
            (cons left-op (list-of-values (rest-operands exps) env))
        )
      )
  )
)


; right-to-left eval
(define (list-of-values exps env)
    (define (reverse li) 
        (define (length items)
            (define (length-iter a count)
                (if (null? a)
                    count
                    (length-iter (cdr a) 
                                (+ 1 count))))
            (length-iter items 0)
        )
        (define (iter li list-length)
            (if (> 1 list-length)
                li
                (append (iter (cdr li) (- list-length 1)) (list (car li)))
            )
        )
        (iter li (length li))
    )
    (define (right-eval exps env)
        (if (no-operands? exps)
            '()
            (let
                (
                    (left-op (eval (first-operand exps) env))
                )
                (
                    (cons left-op (right-eval (rest-operands exps) env))
                )
            )
        )
    )
    (right-eval (reverse exps) env)
)

