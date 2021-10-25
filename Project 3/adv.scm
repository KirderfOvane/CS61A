;; ADV.SCM
;; This file contains the definitions for the objects in the adventure
;; game and some utility procedures.

(define-class (basic-object)
    (class-vars (number 0))
    (instance-vars (properties (list number)))
    (initialize 
      (set! number (+ number 1))
      (insert! 'strength 50 properties)
    )
    (method (put key val) 
        (insert! key val properties)
    )
    (method (get key)
        (lookup key properties)
    )
    (default-method
         (lookup message properties)
    )
)

(define-class (place name)
  (parent (basic-object))
  (instance-vars
   (directions-and-neighbors '())
   (things '())
   (people '())
   (entry-procs '())
   (exit-procs '()))
  (method (type) 'place )
  (method (place?) #t)
  (method (neighbors) (map cdr directions-and-neighbors))
  (method (exits) (map car directions-and-neighbors))
  (method (look-in direction)
    (let ((pair (assoc direction directions-and-neighbors)))
      (if (not pair)
	  '()                     ;; nothing in that direction
	  (cdr pair))))           ;; return the place object
  (method (appear new-thing)
    (if (memq new-thing things)
	(error "Thing already in this place" (list name new-thing)))
    (set! things (cons new-thing things))
    'appeared )

  (method (enter new-person)
    (for-each (lambda (pers) (ask pers 'notice new-person)) people )
    (if (memq new-person people)
	    (error "Person already in this place" (list name new-person)))
    (set! people (cons new-person people))
    (for-each (lambda (proc) (proc)) entry-procs)
    'appeared )

  (method (gone thing)
    (if (not (memq thing things))
	(error "Disappearing thing not here" (list name thing)))
    (set! things (delete thing things)) 
    'disappeared )
  (method (exit person)
    (for-each (lambda (proc) (proc)) exit-procs)
    (if (not (memq person people))
	(error "Disappearing person not here" (list name person)))
    (set! people (delete person people)) 
    'disappeared )

  (method (new-neighbor direction neighbor)
    (if (assoc direction directions-and-neighbors)
	(error "Direction already assigned a neighbor" (list name direction)))
    (set! directions-and-neighbors
	  (cons (cons direction neighbor) directions-and-neighbors))
    'connected )
  (method (MAY-ENTER? person)
     #t
  )
  (method (add-entry-procedure proc)
    (set! entry-procs (cons proc entry-procs)))
  (method (add-exit-procedure proc)
    (set! exit-procs (cons proc exit-procs)))
  (method (remove-entry-procedure proc)
    (set! entry-procs (delete proc entry-procs)))
  (method (remove-exit-procedure proc)
    (set! exit-procs (delete proc exit-procs)))
  (method (clear-all-procs)
    (set! exit-procs '())
    (set! entry-procs '())
    'cleared) )

(define-class (person name place)
  (parent (basic-object))
  (instance-vars
   (possessions '())
   (saying "")
   (money 100)
  )
   
  (initialize
   (if (ask place 'may-enter? self) 
        (ask place 'enter self)
        (error "Place is locked and you may not enter!")
   )
  )
  (method (get-money) (ask self 'money ))
  (method (pay-money num) (if (> (ask self 'money ) num)
                              (begin 
                                (set! money (- (ask self 'money ) num))
                                #t
                              )
                              #f
                          )
  )
  (method (buy food-name)
    (let
      (
        (response (ask place 'sell self food-name ) )
      )

      (if (eq? response #f)
          (print "can't buy this food")
          (ask self 'change-possessions (append (list response) (ask self 'possessions ))) 
      )
      
    )
  )
  (method (person?) #t)
  (method (type) 'person )
  (method (look-around)
    (map (lambda (obj) (ask obj 'name ))
	 (filter (lambda (thing) (not (eq? thing self)))
		 (append (ask place 'things ) (ask place 'people )))))
  (method (take thing)

    
    (cond ((not (thing? thing)) (error "Not a thing" thing))
      ((not (memq thing (ask place 'things )))
      (error "Thing taken not at this place"
        (list (ask place 'name ) thing)))
      ((memq thing possessions) (error "You already have it!"))
      (else
        ;; Check If somebody already has this object...
        (for-each
          (lambda (pers)
             
              (if (and (not (eq? pers self)) ; ignore myself
                      (memq thing (ask pers 'possessions )) ; ask person if they possess this thing
                  ) 
                  (let
                    (
                      (response (ask thing 'may-take? self )) ; ask possessor if we may take thing.
                    )
                    (if response
                      (begin
                        (print "We are stronger so we take it!") 
                        (ask pers 'lose response)
                        (have-fit pers)
                      )
                      (error "No can't take, it's possessed by someone stronger!")
                    )
                  )
                  (begin
                    (print (ask pers 'name ))
                    (print "do not possess this thing")  
                  )
              )
          )
          (ask place 'people )
        )  
        
        ;; Add thing to person possessions state.
        (announce-take name thing)
        (set! possessions (cons thing possessions))

        ;; Set person as thing possessor state
        (ask thing 'change-possessor self)
        'taken 
      )
    )
  )
  (method (take-all)
    (if (eq? (ask place 'things ) '())
      (print "no things in this place!")
      (begin 
          (map 
            (lambda (thing) 
              (if (eq? (owner thing) 'no-one )
                  (ask self 'take thing)
                  (print "owned by someone, ignoring")
              )
            ) 
            (ask place 'things )
          )
      )
    )
  )
(method (eat)
  (map (lambda (t)
                (if (ask t 'edible? )
                  (begin
                    (ask self 'put 'strength (+ (ask self 'strength ) (ask t 'calories )))
                    (ask self 'lose t)
                    (ask (ask self 'place ) 'gone t)
                  )
                )
        ) 
  (ask self 'possessions ))
)
  (method (lose thing)
    (set! possessions (delete thing possessions))
    (ask thing 'change-possessor 'no-one )
    'lost )
  (method (talk) (print saying))
  (method (set-talk string) (set! saying string))
  (method (exits) (ask place 'exits ))
  (method (notice person) (ask self 'talk ))
 (method (go-directly-to new-place)
    (announce-move name place new-place) 
    (set! place new-place)
    (ask new-place 'enter self)
 )
 (method (change-possessions new-possessions)
    (set! possessions new-possessions)
  )
  (method (go direction)
    (let ((new-place (ask place 'look-in direction)))
      (print new-place)
      (lambda (test) (ask new-place test) 'type )
      (cond ((null? new-place) (error "Can't go" direction))
       ((not (ask new-place 'may-enter? self )) (error "Can't go, place is locked!"))
        (else
          (begin
            (ask place 'exit self)
            (announce-move name place new-place)
            ;; change place of the possessions
            (for-each
              (lambda (p)
                (ask place 'gone p)
                (ask new-place 'appear p)
              )
              possessions
            )
              ;; change place of person
            (set! place new-place)  
            (ask new-place 'enter self)
          )
        )
      )
        
      )
  )  
        )

(define-class (thing name)
  (parent (basic-object))
  (instance-vars
    (possessor 'no-one )
    (type 'thing )
  )
  (method (thing?) #t)
  (method (change-possessor new-possessor)
        (set! possessor new-possessor)
  )
  (method (may-take? receiver)
      (if (< (ask (ask self 'possessor ) 'strength ) (ask receiver 'strength ))
          self
          #f
      )
  )
)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Implementation of thieves for part two
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define *foods* '(pizza potstickers coffee))

(define (edible? thing)
  (member? (ask thing 'name ) *foods* ))

(define-class (thief name place)
  (parent (person name place))
  (instance-vars
   (behavior 'steal )
  )
  (initialize (ask self 'put 'strength 75))
  (method (type) 'thief )
  
  (method (notice person)
      (if (eq? behavior 'run )
        ;; if behaviour run:
        (ask self 'go (pick-random (ask (usual 'place ) 'exits )))
        ;; if behaviour steal:
        (let (
              (food-things (filter 
                                  (lambda (thing) (and 
                                                      (ask thing 'edible? )
                                                      (not (eq? (ask thing 'possessor ) self))
                                                    )
                                  )
                                  (ask (usual 'place ) 'things )
                           )
              )
            )
            (if (not (null? food-things))
                (begin
                   (let*
                    (
                      (previous-possessor (ask (car food-things) 'possessor ))
                      (response (ask (car food-things) 'may-take? self )) ; ask possessor if we may take thing.
                    )
           
                    (if response
                      (begin
                        (ask previous-possessor 'lose (car food-things))
                        (have-fit previous-possessor)
                        
                          ;; Add thing to person possessions state.
                          (announce-take name response)
                          (ask self 'change-possessions (append (list response) (ask self 'possessions )))

                          ;; Set person as thing possessor state
                          (ask response 'change-possessor self)
                          'taken 
                      )
                      (print "No can't take, it's possessed by someone stronger!")
                    )
                  )
                  
                  (set! behavior 'run )
                  (ask self 'notice person)
                )
                (print "did not find any food to steal") 
            )
        )
      )
  ) 
)


;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Utility procedures
;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; this next procedure is useful for moving around

(define (move-loop who)
  (newline)
  (print (ask who 'exits))
  (display "?  > ")
  (let ((dir (read)))
    (if (equal? dir 'stop)
	(newline)
	(begin (print (ask who 'go dir))
	       (move-loop who)))))


;; One-way paths connect individual places.

(define (can-go from direction to)
  (ask from 'new-neighbor direction to))


(define (announce-take name thing)
  (newline)
  (display name)
  (display " took ")
  (display (ask thing 'name))
  (newline))

(define (announce-move name old-place new-place)
  (newline)
  (newline)
  (display name)
  (display " moved from ")
  (display (ask old-place 'name))
  (display " to ")
  (display (ask new-place 'name))
  (newline))

(define (have-fit p)
  (newline)
  (display "Yaaah! ")
  (display (ask p 'name))
  (display " is upset!")
  (newline))


(define (pick-random set)
  (nth (random (length set)) set))

(define (delete thing stuff)
  (cond ((null? stuff) '())
	((eq? thing (car stuff)) (cdr stuff))
	(else (cons (car stuff) (delete thing (cdr stuff)))) ))

(define (person? obj)
  (and (procedure? obj)
       (member? (ask obj 'type ) '(person police thief))))

(define (thing? obj)
  (and (procedure? obj)
       (eq? (ask obj 'type ) 'thing )))
