(load "groupreduce.scm")

;Breakdown/buildup of mapreduce

;1
(map count '(got to get you in my life)) ;(3 2 3 3 2 2 4)
;2
(accumulate + (map count '(got to get you in my life))) ;19
;3
(define (abstract-data-type mapper red base data)
    (accumulate red (map mapper data))
)
(abstract-data-type count + 0 '(got to get you in my life)) ;19
;4
(define (simplereduce f1 f2 base dataname)
    (accumulate f2 (map f1 dataname))
) ;(simplereduce count + 0 '(item1 item2 item3 item4))
;5
(define (groupreduce fn base buckets) ;operates on list of lists of pairs: (((bucketname . value)) (bucketname . value)))
  (map (lambda (subset)
	 (make-kv-pair (kv-key (car subset))
		       (accumulate fn base (map kv-value subset))))
       buckets))

(append mt1 mt2 mt3)
;((cs61a-xc . 27) (cs61a-ya . 40) (cs61a-xw . 35) (cs61a-xd . 38) (cs61a-yb . 29) (cs61a-xf . 32) 
; (cs61a-yc . 32) (cs61a-xc . 25) (cs61a-xb . 40) (cs61a-xw . 27) (cs61a-yb . 30) (cs61a-ya . 40) 
; (cs61a-xb . 32) (cs61a-xk . 34) (cs61a-yb . 30) (cs61a-ya . 40) (cs61a-xc . 28) (cs61a-xf . 33))
(sort-into-buckets (append mt1 mt2 mt3))
;( ((cs61a-xb . 40) (cs61a-xb . 32))  bucket xb
;  ((cs61a-xc . 27) (cs61a-xc . 25) (cs61a-xc . 28)) ((cs61a-xd . 38))  bucket xc...
;  ((cs61a-xf . 32) (cs61a-xf . 33)) 
;  ((cs61a-xk . 34)) 
;  ((cs61a-xw . 27) (cs61a-xw . 35)) 
;  ((cs61a-ya . 40) (cs61a-ya . 40) (cs61a-ya . 40)) 
;  ((cs61a-yb . 30) (cs61a-yb . 29) (cs61a-yb . 30)) 
;  ((cs61a-yc . 32)))
(groupreduce + 0 (sort-into-buckets (append mt1 mt2 mt3)))
;((cs61a-xb . 72)  sum of all xb buckets
; (cs61a-xc . 80)  sum of all xc buckets....
; (cs61a-xd . 38) 
; (cs61a-xf . 65) 
; (cs61a-xk . 34) 
; (cs61a-xw . 62) 
; (cs61a-ya . 120) 
; (cs61a-yb . 89) 
; (cs61a-yc . 32))
(groupreduce + 0 '( ((bucketgroup1name . 2) (bucketgroup1name . 5)) ((bucketgroup2name . 7) (bucketgroup2name . 3)) ) ) 








