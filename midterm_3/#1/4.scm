#| Problem 4 (List mutation).

Write make-alist!, a procedure that takes as its argument a list of alternating keys and
values, like this:

'(color orange zip 94720 name wakko)
and changes it, by mutation, into an association list, like this:
((color . orange) (zip . 94720) (name . wakko))
You may assume that the argument list has an even number of elements. The result of your
procedure requires exactly as many pairs as the argument, so you will work by rearranging
the pairs in the argument itself. Do not allocate any new pairs in your solution! |#

(define (make-alist! li)
    (begin
        (set-car! li (cons (car li) (car (cdr li))) )
        (set-cdr! (car (cdr li)) (cons (car (cdr (cdr li))) (car (cdr (cdr (cdr li))))))
        (set-cdr! (car (cdr (cdr li))) (cons (car (cdr (cdr (cdr (cdr li))))) (car (cdr (cdr (cdr (cdr (cdr li))))))))
    )
)

(define (make-alist! lst)
  (if (null? lst)
      'done
      (let ((tmp (make-alist! (cddr lst))))
	(set-cdr! (cdr lst) (cadr lst))
	(set-car! (cdr lst) (car lst))
    (print lst)
	(set-car! lst (cdr lst))
	(set-cdr! lst tmp)))
  lst)