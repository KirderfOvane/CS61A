#| Problem 3 (Abstract data types).
The following program is designed for use with the “world tree” discussed in lecture, in
which the nodes represent geographical regions (countries, states, cities). The selectors for
Trees are datum and children. The datum at each node is a word or sentence. The
program, which returns a list of all the cities whose first word is “San,” does not respect
data abstraction:
(define (find-san-cities tree)
    (if (null? (cdr tree)) ; Is this node a city?
        (if (equal? (car (car tree)) 'San )
            (list (car tree)) 
            '()
        )
        (san-helper (cdr tree))
    )
)

(define (san-helper forest)
(if (null? forest)
    '()
    (append (find-san-cities (car forest))
        (san-helper (cdr forest)))))

In the version below, each car and cdr has been replaced by a blank. Fill in the blanks
with the correct selectors, respecting all the relevant abstract data types: |#
(define (find-san-cities tree)
    (if (null? ( children tree))
        (if (equal? (first (datum tree)) 'San )
            (list ( datum tree))
            '()
        )
        (san-helper ( children tree))
    )
)
    
(define (san-helper forest)
    (if (null? forest)
        '()
        (append (find-san-cities ( car forest)) (san-helper ( cdr forest)))
    )
)

;tree? ,why not below ?
#| 
world:
( (country (state (city city city)) (state (city city city)))  
  (country (state (city city city)) (state (city city city)))  
  (country (state (city city city)) (state (city city city)))  
  (country (state (city city city)) (state (city city city))) ) |#

