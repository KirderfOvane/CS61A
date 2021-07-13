;2.29
(define (make-mobile left right)
  (list left right))

(define (make-branch length structure)
  (list length structure))

(define (length num)
  (if (number? num)
      num
      (print "length needs a number")
  )
)
(define (structure mobile-or-weight)
  (cond ((list? mobile-or-weight) mobile-or-weight)
        ((number? mobile-or-weight) mobile-or-weight)
        ((print "needs a structure or weight as input"))
  )
)
(define (left-branch mobile)
  (car mobile)
)
(define (right-branch mobile)
  (cadr mobile)
)
(define (branch-length branch)
  (car branch)
)
(define (branch-structure branch)
  (cdr branch)
)
(define (total-weight mobile)
  (+
   (car (branch-structure (left-branch mobile)))
   (car (branch-structure (right-branch mobile)))
  )
)
(define (balanced? mobile)
  (= 
    (* 
      (car (branch-structure (left-branch mobile)) )
       (branch-length (left-branch mobile)) 
    )
    (*
      (car (branch-structure (right-branch mobile)) )
       (branch-length (right-branch mobile)) 
    )
  )
)

;testing
(define b1 (make-branch 2 (structure 4)))
(define b2 (make-branch 3 (structure 4)))
(define m1 (make-mobile b1 b2))
(left-branch m1)
(right-branch m1)
(branch-length (left-branch m1))
(branch-structure (left-branch m1))
(total-weight m1)
(balanced? m1)


;part 4
(define (make-mobile left right)
  (cons left right))


(define (make-branch length structure)
  (cons length structure))

 (define (length num)
  (if (number? num)
      num
      (print "length needs a number")
  )
) 


(define (structure mobile-or-weight)
  (cond ((pair? mobile-or-weight) mobile-or-weight)
        ((number? mobile-or-weight) mobile-or-weight)
        ((print "needs a structure or weight as input"))
  )
)

(define (left-branch mobile)
  (car mobile)
)
(define (right-branch mobile)
  (cdr mobile)
)
(define (branch-length branch)
  (car branch)
)
(define (branch-structure branch)
  (cdr branch)
)
(define (total-weight mobile)
  (+
    (branch-structure (left-branch mobile))
    (branch-structure (right-branch mobile))
  )
)
(define (balanced? mobile)
  (= 
    (* 
       (branch-structure (left-branch mobile)) 
       (branch-length (left-branch mobile)) 
    )
    (*
       (branch-structure (right-branch mobile)) 
       (branch-length (right-branch mobile)) 
    )
  )
)

;testing
(define b1 (make-branch 3 (structure 4)))
(define b2 (make-branch 3 (structure 4)))
(define m1 (make-mobile b1 b2))

(left-branch m1)
(right-branch m1)
(branch-length (left-branch m1))
(branch-structure (left-branch m1))
(total-weight m1)
(balanced? m1)


  