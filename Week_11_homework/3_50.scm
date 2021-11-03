#| Exercise 3.50: Complete the following definition, which generalizes stream-map to allow procedures that take multiple arguments, analogous to map in 2.2.1, Footnote 78.

(define (stream-map proc . argstreams)
  (if (⟨??⟩ (car argstreams))
      the-empty-stream
      (⟨??⟩
       (apply proc (map ⟨??⟩ argstreams))
       (apply stream-map
              (cons proc 
                    (map ⟨??⟩ 
                         argstreams)))))) |#



(define (stream-map proc . argstreams)
  (if (stream-null? (car argstreams))
      the-empty-stream
      (cons-stream
       (apply proc (map stream-car argstreams))
       (apply stream-map
              (cons proc 
                    (map stream-cdr
                         argstreams))))))



                         (stream-map + 
     (list 1 2 3) 
     (list 40 50 60) 
     (list 700 800 900))