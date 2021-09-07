#| 
Problem 3 (Tree recursion)
This question concerns the Trees with constructor make-tree and selectors datum and
children as discussed in lecture.
Every node of a Tree has some number of children, possibly zero. We’ll call that number the
fanout of the node. (We are talking about the node’s own children, not its grandchildren
or more remote descendants.) For a given Tree, there is some node with a fanout larger or
equal to the fanout of any other node. Write the procedure max-fanout that takes a Tree
as its argument, and returns the largest fanout of any node in the Tree. 
|#

(define (max-fanout tree)
    (let 
        ((largest-fanout 0))
        (define (breadth-first-search tree)
	        (bfs-iter (list tree))
        )
        (define (bfs-iter queue)
            (if (null? queue)
                (last largest-fanout)
                (let ((task (car queue)))
                    (if (> (datum task) largest-fanout)
                        (cons largest-fanout (datum task))
                    )
                    (bfs-iter (append (cdr queue) (children task)))
                )
            )
        )
        (breadth-first-search tree)
    )
)

(define node list)
(define datum car)
(define children cdr)
(define make-tree cons)

(define (length items)
        (define (length-iter a count)
            (if (null? a)
                count
                (length-iter (cdr a) 
                            (+ 1 count))))
        (length-iter items 0)
)

(define (count-length items)
    
        (define (length-iter a count)
            
                (if (null? a)
                count
                (length-iter (cdr a) 
                            (+ 1 count)))
                
            )

        (if (list? items)
            (length-iter items 0)
            1
        )    
        
)







(define testtree2 (make-tree 5 ((make-tree 1 2) (make-tree 6 8)) )) ;>(5 (3 1 2) (7 6 8))
(define dt (make-tree 5 (make-tree 3 1 2) (make-tree (make-tree 2 3 4 5 6 7) 6 (make-tree 4 5)))) ;>(5 (3 1 2) ((2 3 4 5 6 7) 6 (4 5)))
(define dt ((make-tree 5 5 6) (make-tree 3 1 2) (make-tree (make-tree 2 3 4 5 6 7) 6 (make-tree 4 5)))) ;>(5 (3 1 2) ((2 3 4 5 6 7) 6 (4 5)))
(datum testtree2)
(children testtree2)
(length (datum (children testtree2)))


 (maximum (map length (children testtree2)))
 (maximum (map length (children dt)))

 (define (maximum li)
    (define (iter li max)
        (if (null? li)
            max
            (if (> (car li) max)
                (iter (cdr li) (car li))
                (iter (cdr li) max)
            )
        )
    )
    (iter li 0)
 )






(define (deep-map fn lol)
	(cond ((null? lol) '())
		  ((pair? (car lol))
		   (list (deep-map fn (car lol))
				 (deep-map fn (cdr lol))))
		  (else (fn lol))
	)
)
(define lol '((john lennon) (paul mccartney) (george harrison) (ringo starr))) 
(define num '((1 2) (3 4) (5 6) (1 2))) 
(define lol2 '((lennon (matt damon ben afflet)) (paul mccartney) (george harrison) (ringo starr))) 
 (deep-map max lol2)
 (deep-map max (deep-map length (deep-map cdr lol2)))
 (deep-map length (deep-map car lol2))
 (maximum '(1 2 3))
 (maximum (deep-map length lol2))
 
 (define (max-fanout tree)
  (accumulate print
	      (length (children tree))
	      (map max-fanout (children tree))))