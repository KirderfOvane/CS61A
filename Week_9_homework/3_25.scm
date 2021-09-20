#| 
Exercise 3.25: Generalizing one- and two-dimensional tables, show how to implement a table 
in which values are stored under an arbitrary number of keys and different values may 
be stored under different numbers of keys. The lookup and insert! procedures 
should take as input a list of keys used to access the table.  
|#

(define (make-table)
  (list '*table* ))


(define (lookup key-1 key-2 table)
  (let ((subtable (assoc key-1 (cdr table))))
    (if subtable
        (let ((record 
               (assoc key-2 (cdr subtable))))
          (if record (cdr record) false))
        false)))

(define (insert! key-1 key-2 value table)
  (let ((subtable (assoc key-1 (cdr table))))
    (if subtable
        (let ((record 
               (assoc key-2 (cdr subtable))))
          (if record
              (set-cdr! record value)
              (set-cdr! 
               subtable
               (cons (cons key-2 value)
                     (cdr subtable)))))
        (set-cdr! 
         table
         (cons (list key-1 (cons key-2 value))
               (cdr table)))))
  'ok )

(define active-key car)


(define (insert! keylist value table)
    (define (splice new-struct table-to-change)
        (set-cdr! table-to-change new-struct)
    )
    (define (traverse-keylist keylist inner-table value)
        (print keylist)
        (print inner-table)
        (if (null? keylist)
            (set-cdr! inner-table value)
                (let ((subtable (assoc (active-key keylist) (cdr inner-table))))
                    (print "subtable: ")
                    (print subtable)
                    (if subtable
                        (traverse-keylist (cdr keylist) subtable value)
                        (begin 
                            (splice (cons 
                                        (list (active-key keylist))
                                        (cdr inner-table)
                                    )
                                    inner-table
                            )
                            (insert! (cdr keylist) value (cadr inner-table))
                        )
                    )
                )
        )
    )
    (traverse-keylist keylist table value)
)


(define mytable (make-table))


(insert! (list 'newstruct 'test ) 5 mytable)
(insert! (list 'letters 'test ) 5 mytable)
(insert! (list 'letters 'math ) 5 mytable)
(insert! (list 'letters 'sith ) 11 mytable)
(insert! (list 'letters 'what ) 11 mytable)
(insert! (list 'letters 'what 'cool ) 52 mytable)
(insert! (list 'path 'math ) 5 mytable)






