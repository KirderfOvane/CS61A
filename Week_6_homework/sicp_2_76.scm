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
;we also need to create a new type-tag.

(define (area shape)  ;_PROCEDURE_ to handle area-calculation
	(cond ((eq? (type-tag shape) 'square) 
				 (* (contents shape) (contents shape))) ;operation on squares data-tag
				((eq? (type-tag shape) 'circle)
				 (* pi (contents shape) (contents shape))) ;operation on circles data-tag
				(else (error "Unknown shape -- AREA"))))

;this strategy is BAD for a evolving large system as if we need to add something we need to edit existing code.
;Our goal is to be able to add features without having to edit old working code.

;data-directed style:

;as we setup a table and a generic operation procedure,
;all we need to do for new features is add a new put instruction with the operation:
(put 'square 'area (lambda (s) (* s s)))
;and optionally add a new operate-function like below for easier usage:
(define (new-feat shape)
	(operate 'new-feat shape)
)

;message-passing-style

;after initial generic operation is created ,what we need to add for every new feature is
;a new procedure (like below) if it's a new data-type
(define (make-square side)
	(lambda (message)
		(cond ((eq? message ’area) (* side side))
					((eq? message ’perimeter) (* 4 side))
					(else (error "Unknown message"))
		)
	)
)
;add a message in the cond in all data-tag-procedures if it's new operation. 

;advantage with message-passing-style is that we don't need to keep a lookup-table/database 
;it's also good if your system will add alot of new data types rather than operations.