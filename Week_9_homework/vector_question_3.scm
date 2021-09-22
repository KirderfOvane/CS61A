#| 3. Sorting a vector.
(a) Write bubble-sort!, which takes a vector of numbers and rearranges them to be in
increasing order. (You’ll modify the argument vector; don’t create a new one.) It uses the
following algorithm:
[1] Go through the array, looking at two adjacent elements at a time, starting with elements
0 and 1. If the earlier element is larger than the later element, swap them. Then look at
the next overlapping pair (0 and 1, then 1 and 2, etc.).
[2] Recursively bubble-sort all but the last element (which is now the largest element).
[3] Stop when you have only one element to sort.
(b) Prove that this algorithm really does sort the vector. Hint: Prove the parenthetical
claim in step [2].
(c) What is the order of growth of the running time of this algorithm? |#
; Theta(n2)


    (define (bubble-sort! vec)
            (define (inner i j vec counter)
                ;if counter is same as array no swaps occured and we are done!
                (if (>= counter (- (vector-length vec) 1)) 
                    vec
                    (if (<= j (- (vector-length vec) 1 counter))
                        (if (> (vector-ref vec i) (vector-ref vec j))
                            (let 
                                (
                                    (temp (vector-ref vec i))
                                )
                                (begin
                                    (vector-set! vec i (vector-ref vec j))
                                    (vector-set! vec j temp)
                                    (inner (+ i 1) (+ j 1) vec counter)
                                )
                            )
                            (inner (+ i 1) (+ j 1) vec counter)
                        )
                        ; if we are here , we have reached the end of j and last element is now sorted.
                        ; this means we can remove this last element from the vector list to operate on.
                        (inner 0 1 vec (+ counter 1))
                    )
                )
            )
            (inner 0 1 vec 0)
    )
 
     (define test (bubble-sort! (vector 6 5 4 3)))
     (define test2 (bubble-sort! (vector 1 2 3 4 5 6)))
     (define test3 (bubble-sort! (vector 100 95 93 92 22 123 556 32 23 5 6 7 1 2 0 232 545 2332 5 23 5 2 1)))

