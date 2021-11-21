#| Exercise 4.14: Eva Lu Ator and Louis Reasoner are each experimenting with the metacircular evaluator. 
Eva types in the definition of map, and runs some test programs that use it. 
They work fine. Louis, in contrast, has installed the system version of map as a 
primitive for the metacircular evaluator. When he tries it, things go terribly wrong. 
Explain why Louis’s map fails even though Eva’s works.  |#

;Evas method communicates with metacircular env completely, which has different implementations. In this case it fails on
;procedures as mc-eval and normal scheme eval has different data input. 


;evalutors way:
;type this in mc-eval
;(define (map fn li)
 ;   (if (null? li)
  ;      '()
   ;     (cons (fn (car li)) (map fn (cdr li)))
    ;)
;)

;test it: (map (lambda (x) (* x x)) (list 1 2 3 4))
;works fine

;Louis way:
#| (define primitive-procedures
  (list (list 'car car)
        (list 'cdr cdr)
        (list 'cons cons)
        (list 'null? null?)
	(list '+ +)
	(list '- -)
	(list '* *)
	(list '/ /)
	(list '= =)
	(list 'list list)
	(list 'append append)
	(list 'equal? equal?)
    (list 'map map) ;<- don't work
;;      more primitives
        )) |#