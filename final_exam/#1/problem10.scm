#| Problem 10 (MapReduce).
Suppose we’ve done some MapReduce computations, and now we have my-pairs, the
following stream of key-value pairs:
> (ss my-pairs)
((bar . 2) (bat . 3) (baz . 1) (big . 8) (bill . 7) (bin . 6) (bog . 0))
Now, what is the stream returned by each of the following calls to mapreduce? If the
result is an error, just say ERROR. Otherwise, show the entire stream as show-stream
does (every element, unless there are more than 10).
(A) <---;It sums up the values from base 0. => (bin . 27)
(mapreduce (lambda (kvp) (list (make-kv-pair (butlast (kv-key kvp))
(kv-value kvp))))
+
0
my-pairs)
(B) <--- ;ERROR ,x and y input is only provided a pair so it will fail.
(mapreduce (lambda (kvp) (list (make-kv-pair (butlast (kv-key kvp))
(kv-value kvp))))
(lambda (x y) (+ (kv-value x) (kv-value y)))
0
my-pairs) |#