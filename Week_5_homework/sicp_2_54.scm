
(define (equal? x y)
  (print "x" x)
  (print "y" y)
  (if (and (null? x) (null? y))
      #t
      (if (null? y)
          #f
          (if (null? x)
            #f
            (if (eq? (car x) (car y))
              (equal? (cdr x) (cdr y))
              #f
            )
          )
          
      )
  )
)
;testing
(equal? '(testing resting) '(testing resting));>#t
(equal? '(testing resting) '(testing resting nesting));>#f
