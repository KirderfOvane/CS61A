#| 
1. Modify the person class given in the lecture notes for week 7 (it’s in the file demo2.scm in the
~cs61a/lectures/3.0 directory) to add a repeat method, which repeats the last thing said. Here’s an
example of responses to the repeat message.
> (define brian (instantiate person 'brian))
brian
> (ask brian 'repeat)
()
> (ask brian 'say '(hello))
(hello)
> (ask brian 'repeat)
(hello)
> (ask brian 'greet)
(hello my name is brian)
> (ask brian 'repeat)
(hello my name is brian)
> (ask brian 'ask '(close the door))
(would you please close the door)
> (ask brian 'repeat)
(would you please close the door) |#

;demo2.scm:
(define-class (counter)
  (instance-vars (count 0))
  (class-vars (total 0))
  (method (next)
    (set! total (+ total 1))
    (set! count (+ count 1))
    (list count total))
)
; additions start
(define-class (person name)
  (class-vars (last-message '()))
  (method (say stuff)
    (set! last-message stuff) 
    (ask self 'last-message )
  )
  (method (ask stuff) 
    (set! last-message (ask self 'say (se '(would you please) stuff)))
    (ask self 'last-message )
  )
  (method (greet)
    (set! last-message (ask self 'say (se '(hello my name is) name))) 
    (ask self 'last-message )
        
  ) 
  (method (repeat) (ask self 'last-message ))  
)
; additions end 


(define-class (pigger name)
  (parent (person name))
  (method (pigl wd)
    (if (member? (first wd) '(a e i o u))
	(word wd 'ay )
	(ask self 'pigl (word (bf wd) (first wd))) ))
  (method (say stuff)
    (if (word? stuff)
	(ask self 'pigl stuff)
	(map (lambda (w) (ask self 'pigl w)) stuff))) 
)

(define-class (squarer)
  (default-method (* message message))
  (method (7) 'buzz ) 
)

(define-class (counter)
  (instance-vars (count 0))
  (class-vars (total 0) (counters '()))
  (initialize (set! counters (cons self counters)))
  (method (next)
    (set! total (+ total 1))
    (set! count (+ count 1))
    (list count total))
)

(define-class (pigger name)
  (parent (person name))
  (method (pigl wd)
    (if (member? (first wd) '(a e i o u))
	(word wd 'ay )
	(ask self 'pigl (word (bf wd) (first wd))) ))
  (method (say stuff)
    (if (word? stuff)
	(if (equal? stuff 'my ) (usual 'say stuff) (ask self 'pigl stuff))
	(map (lambda (w) (ask self 'say w)) stuff))) 
)

;pigl
(define (pigl wd)
  (if (pl-done? wd)
      (word wd 'ay)
      (pigl (word (bf wd) (first wd)))))

(define (pl-done? wd)
  (vowel? (first wd)))

(define (vowel? letter)
  (member? letter '(a e i o u)))
