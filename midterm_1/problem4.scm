#| 
Problem 4 (Iterative and recursive processes).
One or more of the following procedures generates an iterative process. 
Circle them. 
Don’t circle the ones that generate a recursive process.

(define (butfirst-n num stuff)
    (if (= num 0)
        stuff
        (butfirst-n (- num 1) (bf stuff))))       
;recursive

(define (member? thing stuff)
    (cond ((empty? stuff) #f)
          ((equal? thing (first stuff)) #t)
          (else (member? thing (bf stuff)))))
;iterative (tail recursive)



(define (addup nums)
    (if (empty? nums)
        0
        (+ (first nums)(addup (bf nums))))) |#

;recursive