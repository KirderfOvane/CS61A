;Baker, Cooper, Fletcher, Miller, and Smith live on different floors of an apartment house 
;that contains only five floors. 

;Baker does not live on the top floor. 
;Cooper does not live on the bottom floor. 
;Fletcher does not live on either the top or the bottom floor. 
;Miller lives on a higher floor than does Cooper. 
;Smith does not live on a floor adjacent to Fletcher’s. 
;Fletcher does not live on a floor adjacent to Cooper’s. Where does everyone live? 

;enumerate all the possibilities and impose the given restrictions:
(load "vambeval.scm")

(define (multiple-dwelling)
    ; CHOICE PATHS
  (let ((baker (amb 1 2 3 4 5)) 
        (cooper (amb 1 2 3 4 5))
        (fletcher (amb 1 2 3 4 5))
        (miller (amb 1 2 3 4 5))
        (smith (amb 1 2 3 4 5)))
    (require
     (distinct? (list baker cooper fletcher ;only one occurance per choice path
                      miller smith)))
    (require (not (= baker 5))) ;Baker does not live on the top floor. 
    (require (not (= cooper 1))) ;cooper does not live on the floor 1. 
    (require (not (= fletcher 5))) ;fletcher do not live on floor 5
    (require (not (= fletcher 1))); fletcher do not live on floor 1
    (require (> miller cooper)); miller lives above cooper
    (require
     (not (eq? (abs (- smith fletcher)) 1))) ; smith does not live a floor (+-1)-close to fletcher <-- not working
    (require 
     (not (eq? (abs (- fletcher cooper)) 1))); fletcher does not live a floor (+-1)-close to smith <-- not working
    (list (list 'baker baker)
          (list 'cooper cooper)
          (list 'fletcher fletcher)
          (list 'miller miller)
          (list 'smith smith))))



(define (distinct? li)
    (define (iter li new-li)
        (if (null? li)
            new-li
            (if (member? (car li) (cdr li))
                (begin 
                    ;(print "found non unique! skipping...")
                    (iter (cdr li) new-li)
                )
                (begin 
                    ;(print "found unique item!,saving")
                    (iter (cdr li) (append new-li (list (car li))))
                )
            )
        )
    )
     (iter li '())
)

(define (member? x li)
    (if (null? li)
        #f
        (if (eq? x (car li))
            #t
            (member? x (cdr li))
        )
    )
)

(define (require p)
  (if (not p) (amb)))