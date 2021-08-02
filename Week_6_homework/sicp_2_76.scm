#| 
Exercise 2.76: As a large system with generic operations evolves, 
new types of data objects or new operations may be needed. 

For each of the three strategies—generic operations with explicit dispatch,
data-directed style, and message-passing-style—describe the changes that must 
be made to a system in order to add new types or new operations. Which organization 
would be most appropriate for a system in which new types must often be added? 
Which would be most appropriate for a system in which new operations must often be added?  
|#

;explicit dispatch:
;for every new data type we need to write new _PROCEDURE_ for the old operations.
;for every new operation, we need to add that operation to every data type.

(define (area shape)  ;_PROCEDURE_ to handle area-calculation
	(cond ((eq? (type-tag shape) 'square) 
				 (* (contents shape) (contents shape))) ;operation on squares data-tag
				((eq? (type-tag shape) 'circle)
				 (* pi (contents shape) (contents shape))) ;operation on circles data-tag
				(else (error "Unknown shape -- AREA"))))

;this strategy is BAD for a evolving large system as if we need to add something we need to edit existing code.
;Our goal is to be able to add features without having to edit old working code.

;data-directed style:



;message-passing-style