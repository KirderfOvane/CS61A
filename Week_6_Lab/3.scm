;Using adjoin-set, construct the trees shown on page 156.


;;; bst.scm -- Binary Search Trees (A & S section 2.2.5)
;;;

(define (entry tree) (car tree))
(define (left-branch tree) (cadr tree))
(define (right-branch tree) (caddr tree))
(define (make-tree entry left right)
    (list entry left right))

(define tree1
    (make-tree 7
	(make-tree 3
	    (make-tree 1 '() '())
	    (make-tree 5 '() '()))
	(make-tree 9 '() (make-tree 11 '() '()))))

(define (element-of-set? x set)
    (cond
	((null? set) #f)
	((= x (entry set)) #t)
	((< x (entry set))
	    (element-of-set? x (left-branch set)))
	((> x (entry set))
	    (element-of-set? x (right-branch set)))))



(define (adjoin-set x set)
  (if (element-of-set? x set)
      set
      (cons x set)
  )
)
(define (adjoin-set x set)
  (cond ((null? set) (make-tree x '() '()))
        ((= x (entry set)) set)
        ((< x (entry set))
         (make-tree (entry set) 
                    (adjoin-set x (left-branch set))
                    (right-branch set)))
        ((> x (entry set))
         (make-tree (entry set)
                    (left-branch set)
                    (adjoin-set x (right-branch set))))))

    (adjoin-set 1 (adjoin-set 5 (adjoin-set 11 (adjoin-set 3 (adjoin-set 9 (adjoin-set 7 '()))))))
    (adjoin-set 11 (adjoin-set 5 (adjoin-set 9 (adjoin-set 1 (adjoin-set 7 (adjoin-set 3 '()))))))
    (adjoin-set 11 (adjoin-set 7 (adjoin-set 1 (adjoin-set 9 (adjoin-set 3 (adjoin-set 5 '()))))))







