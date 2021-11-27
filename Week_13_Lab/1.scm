(load "groupreduce.scm")


(mapreduce (lambda (input-key-value-pair)
    (list (make-kv-pair 'line 1))) ; mapper
    + ; reducer
    0 ; base case
    "/gutenberg/shakespeare") ; data

#| 1. The example above is inefficient because the map phase happens in parallel, but the reduce phase happens
on a single machine, since all the keys are the same, and each group of same-key pairs go to a single reduce
instance. Fix this example so that the plays are line-counted in parallel, but we still get a single total line
count at the end. (Hint: Do something to the value that mapreduce returns.) |#


; count the number of lines in the collected works
(define (mapreducer? mapper-fn reducer-fn base data)
    (accumulate reducer-fn base (map cdar (map mapper-fn data))) 
)
(define (mapreducer? mapper-fn reducer-fn base data)
    (make-kv-pair 'lines (accumulate reducer-fn base (map cdar (map mapper-fn data))))
)
(define (mapreducer? mapper-fn reducer-fn base data)
     (groupreduce reducer-fn base (group (map (lambda (x) (make-kv-pair (caar x) (cdar x))) (map mapper-fn data))))
)


;testing /invoking multiple plays:
 (mapreducer? (lambda (input-key-value-pair)
    (list (make-kv-pair (kv-key input-key-value-pair) 1))) ; mapper
    + ; reducer
    0 ; base case
    (append (file->linelist file1) (file->linelist file2) (file->linelist file3))) ; data



