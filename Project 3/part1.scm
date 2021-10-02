#| PART I:

The first two exercises in this part should be done by everyone -- that is,
everyone should actually sit in front of a terminal and do it!  It's okay to
work in pairs as long as you all really know what's going on by the time
you're finished.  (Nevertheless, you should only hand in one solution, that
both agree about.)  The remaining exercises have numbers like "A3"
which means exercise 3 for Person A.

After you've done the work separately, you should meet together
to make sure that you each understands what the other person did, because
the second week's work depends on all of the first week's work.  You can
do the explaining while you're merging the two sets of modifications into
one adv.scm file to hand in. |#

#| 1.  Create a new person to represent yourself.   |#
(define kirderfovane (instantiate person 'kirderfovane 61A-Lab ))

#| Put yourself in a new place called Dormitory (or wherever you live) and connect it to campus so that you
can get there from here.   |#

(define Dormitory (instantiate place 'Dormitory ))
(can-go Dormitory 'campus 61A-Lab)
(can-go 61A-Lab 'dormitory Dormitory)
#| Create a place called Kirin, north of Soda.
(It's actually on Solano Avenue.)  
 |#
(define Kirin (instantiate place 'Kirin ))
(can-go Soda 'north Kirin)
(can-go Kirin 'south Soda)

#| Put a thing called Potstickers there. |#
(define Potstickers (instantiate thing 'Potstickers ))
(ask Kirin 'appear Potstickers )
#| Then give the necessary commands to move your character to Kirin, take
the Potstickers, then move yourself to where Brian is, put down the
Potstickers, and have Brian take them.  |#
(ask kirderfovane 'go 'north )
(ask kirderfovane 'go 'north )
(ask kirderfovane 'go 'north )
(ask kirderfovane 'take Potstickers )
(ask kirderfovane 'go 'south )
(ask kirderfovane 'go 'up )
(ask kirderfovane 'go 'west )
(ask kirderfovane 'lose Potstickers )
(ask Brian 'take Potstickers )

#| Then go back to the lab and get back to work. (There is no truth to the rumor that you'll get an A in the course
for doing this in real life!)  All this is just to ensure that you know how
to speak the language of the adventure program. |#
(ask kirderfovane 'go 'east ) 
(ask kirderfovane 'go 'down )
(ask kirderfovane 'go 'south )
(ask kirderfovane 'go 'south )

#| LIST ALL THE MESSAGES THAT ARE SENT DURING THIS EPISODE.  It's a good idea
to see if you can work this out in your head, at least for some of the
actions that take place, but you can also trace the ASK procedure to get
a complete list.  You don't have to hand in this listing of messages.  (Do
hand in a transcript of the episode without the tracing.)  The point is that
you should have a good sense of the ways in which the different objects send
messages back and forth as they do their work. |#

#|  MESSAGES:

"The computers seem to be down"
"The workstations come back to life just in time."

kirderfovane moved from 61a-lab to pimentel       

kirderfovane moved from pimentel to soda

kirderfovane moved from soda to kirin

kirderfovane took potstickers

kirderfovane moved from kirin to soda

kirderfovane moved from soda to art-gallery       

kirderfovane moved from art-gallery to bh-office  

brian took potstickers
"What's your favorite programming language?"      
scheme
"Good answer, but my favorite is Logo!"

kirderfovane moved from bh-office to art-gallery

kirderfovane moved from art-gallery to soda     

kirderfovane moved from soda to pimentel        

kirderfovane moved from pimentel to 61a-lab     
"The computers seem to be down" |#

;END OF MESSAGES


#| 
2.  It is very important that you think about and understand the kinds of
objects involved in the adventure game.  Please answer the following questions: 
|#

#| 2A.  What kind of thing is the value of variable BRIAN?
Hint:  What is returned by scheme in the following situation:
     You type:     > BRIAN |#

; An instance of class person


#| 2B.   List all the messages that a PLACE understands.  (You might want to
maintain such a list for your own use, for every type of object, to help
in the debugging effort.)

PLACE MESSAGES:
  directions-and-neighbors 
  things 
  people 
  entry-procs
  exit-procs
  type
  neighbors
  exits
  look-in direction
  appear new-thing
  enter new-person
  gone thing
  exit person
  new-neighbor direction neighbor
  add-entry-procedure proc
  add-exit-procedure proc
  remove-entry-procedure proc
  remove-exit-procedure proc
  clear-all-procs |#
   


#| 2C.   We have been defining a variable to hold each object in our world.
For example, we defined bagel by saying:

     (define bagel (instantiate thing 'bagel ))

This is just for convenience.  Every object does not have to have a
top-level definition.  Every object DOES have to be constructed and
connected to the world.  For instance, suppose we did this:

> (can-go Telegraph-Ave 'east (instantiate place 'Peoples-Park ))

;;; assume BRIAN is at Telegraph
> (ask Brian 'go 'east)

What is returned by the following expressions and WHY?

> (ask Brian 'place) |#

;Answer: an anonymous procedure, as we didn't point it to a name using define.

#| > (let ((where (ask Brian 'place)))
       (ask where 'name)) |#

;Answer: First we ask what place brian is, it returns the anonymous procedure which is the place class instance. We then binds it to where.
;        Then we use where to message the place class instance method called name,that gives back it's name.

;>  (ask Peoples-park 'appear bagel) 
;Answer: Since we haven't defined Peoples-park we cannot directly communicate with this place. 
;        Only Brian knows about Peoples-park.




#|  2D.  The implication of all this is that there can be multiple names for
objects.  One name is the value of the object's internal NAME variable. In
addition, we can define a variable at the top-level to refer to an object.
Moreover, one object can have a private name for another object.  For
example, BRIAN has a variable PLACE which is currently bound to the object
that represents People's Park.  Some examples to think about:

      > (eq? (ask Telegraph-Ave 'look-in 'east) (ask Brian 'place))

      > (eq? (ask Brian 'place ) 'Peoples-Park )

      > (eq? (ask (ask Brian 'place) 'name) 'Peoples-Park)


OK.  Suppose we type the following into scheme:

>  (define computer (instantiate thing 'Durer))


Which of the following is correct?  Why? |#

;(ask 61a-lab 'appear computer)
;computer is a variable that points to the instance thing named 'Durer

;or

;(ask 61a-lab 'appear Durer)
;Durer is not a defined variable pointing to the procedure computer

;or 

;(ask 61a-lab 'appear 'Durer)
;The symbol 'Durer poin

;What is returned by (computer 'name)?  Why?
;the procedure computer has an message called name that is also a symbol pointing to itself.
;So it returns the procedure as anonymous.

#| 2E.  We have provided a definition of the THING class that does not use
the object-oriented programming syntax described in the handout.  Translate
it into the new notation. |#

(define-class (thing name)
     (instance-vars
        (possessor 'no-one )
        (type 'thing )
     )
     (method (change-possessor new-possessor)
        (set! possessor new-possessor)
     )
     
)
;testing
(define mything (instantiate thing 'mything ))
(ask 61A-Lab 'appear mything)
(define new-test-person (instantiate person 'testperson 61A-Lab))
(ask new-test-person 'take mything )
(ask new-test-person 'lose mything )
(ask mything 'possessor )
(ask mything 'type )
(ask mything 'name )

#| 2F.  Sometimes it's inconvenient to debug an object interactively because
its methods return objects and we want to see the names of the objects.  You
can create auxiliary procedures for interactive use (as opposed to use
inside object methods) that provide the desired information in printable
form.  For example: |#

#| (define (name obj) (ask obj 'name))
(define (inventory obj)
  (if (person? obj)
      (map name (ask obj 'possessions))
      (map name (ask obj 'things)))) |#

#| Write a procedure WHEREIS that takes a person as its argument and returns
the name of the place where that person is.|#

(define (WHEREIS person)
    (if (person? person)
        (ask (ask person 'place ) 'name ) 
    )
)

#| Write a procedure OWNER that takes a thing as its argument and returns the
name of the person who owns it.  (Make sure it works for things that aren't
owned by anyone.)|#

(define (OWNER thing)
    (if (thing? thing)
        (if (eq? (ask thing 'possessor ) 'no-one )
            'no-one
            (ask (ask thing 'possessor ) 'name )
        )
    )
)

#| Procedures like this can be very helpful in debugging the later parts of the
project, so feel free to write more of them for your own use.    |#



#| Now it's time for you to make your first modifications to the adventure
game.  This is where you split the work individually.

PART I -- PERSON A: |#

#| A3.  You will notice that whenever a person goes to a new place, the place
gets an 'ENTER message.  In addition, the place the person previously
inhabited gets an 'EXIT message.  When the place gets the message, it calls
each procedure on its list of ENTRY-PROCEDURES or EXIT-PROCEDURES as
appropriate.  Places have the following methods defined for manipulating
these lists of procedures:  ADD-ENTRY-PROCEDURE, ADD-EXIT-PROCEDURE,
REMOVE-ENTRY-PROCEDURE,
REMOVE-EXIT-PROCEDURE, CLEAR-ALL-PROCS.  You can read their definitions in the
code. |#

#|  Sproul Hall has a particularly obnoxious exit procedure attached to it.  Fix
SPROUL-HALL-EXIT so that it counts how many times it gets called, and stops
being obnoxious after the third time. |#

(define testman (instantiate person 'testman s-h))
; to test, type (ask testman 'go 'east ) 3 times and you will eventually exit sproul hall.

#| Remember that the EXIT-PROCS list contains procedures, not names of
procedures!  It's not good enough to redefine SPROUL-HALL-EXIT, since Sproul
Hall's list of exit procedures still contains the old procedure.  The best
thing to do is just to load adv-world.scm again, which will define a new
sproul hall and add the new exit procedure. |#



#| A4a.  We've provided people with the ability to say something using the
messages 'TALK and 'SET-TALK.  As you may have noticed, some people around
this campus start talking whenever anyone walks by.  We want to simulate this
behavior.  In any such interaction there are two people involved: the one
who was already at the place (hereafter called the TALKER) and the one who
is just entering the place (the LISTENER).  We have already provided a
mechanism so that the listener sends an ENTER message to the place when
entering.  Also, each person is ready to accept a NOTICE message, meaning
that the person should notice that someone new has come.  The talker should
get a NOTICE message, and will then talk, because we've made a person's
NOTICE method send itself a TALK message.  (Later we'll see that some special
kinds of people have different NOTICE methods.) |#

#| Your job is to modify the ENTER method for places, so that in addition to
what that method already does, it sends a NOTICE message to each person in
that place other than the person who is entering.  The NOTICE message should
have the newly-entered person as an argument.  (You won't do anything with
that argument now, but you'll need it later.) |#

#| Test your implementation with the following: |#

(define singer (instantiate person 'rick sproul-plaza))

(ask singer 'set-talk "My funny valentine, sweet comic valentine")

(define preacher (instantiate person 'preacher sproul-plaza))

(ask preacher 'set-talk "Praise the Lord")

(define street-person (instantiate person 'harry telegraph-ave))

(ask street-person 'set-talk "Brother, can you spare a buck")

#| YOU MUST INCLUDE A TRANSCRIPT IN WHICH YOUR CHARACTER WALKS AROUND AND
TRIGGERS THESE MESSAGES. |#

;testing:
;(ask kirderfovane 'go 'west ) ; <-- you have to manually run this 4 times to get to sproul plaza
;(ask kirderfovane 'go 'south )


#| 
TRANSCRIPT:

STk> (ask kirderfovane 'go 'west )
kirderfovane moved from sproul-hall to sproul-plaza
"Praise the Lord"
"My funny valentine, sweet comic valentine"
appeared 

STk> (ask kirderfovane 'go 'south )


kirderfovane moved from sproul-plaza to telegraph-ave
"Brother, can you spare a buck"
"There are tie-dyed shirts as far as you can see..."
appeared

|#



#|  A4b.  So far the program assumes that anyone can go anywhere they want.
In real life, many places have locked doors.

Invent a MAY-ENTER? message for places that takes a person as an argument and
always returns #T.  Then invent a LOCKED-PLACE class in which the MAY-ENTER?
method returns #T if the place is unlocked, or #F if it's locked.  (It should
initially be locked.)   |#

(define-class (locked-place name)
    (parent (place name))
    (instance-vars
     (locked #t)
    )
    (method (MAY-ENTER? person)
        (not locked)
    )
    (method (unlock)
        (set! locked #f)
    )
)


#| 
The LOCKED-PLACE class must also have an UNLOCK
message.  For simplicity, write this method with no arguments and have it
always succeed.  In a real game, we would also invent keys, and a mechanism
requiring that the person have the correct key in order to unlock the door.
(That's why MAY-ENTER? takes the person as an argument.)

Modify the person class so that it checks for permission to enter before
moving from one place to another.  Then create a locked place and test
it out. |#

(define mylockedplace (instantiate locked-place 'mylockedplace ))
(can-go mylockedplace 'up s-h)
(can-go s-h 'down mylockedplace)

;(define tlockman (instantiate person 'tlockman mylockedplace))
;(define lockman (instantiate person 'lockman s-h))
;(ask lockman 'go 'down )
;(ask mylockedplace 'unlock )
;write (ask lockman 'go 'down ) 3 times and you get into the locked place.


#|
A5.  Walking around is great, but some people commute from far away, so
they need to park their cars in garages.  A car is just a THING, but you'll
have to invent a special kind of place called a GARAGE.  Garages have two
methods (besides the ones all places have): PARK and UNPARK.  |#

#| You'll also
need a special kind of THING called a TICKET; what's special about it is
that it has a NUMBER as an instantiation variable. |#

#| The PARK method takes a car (a THING) as its argument.  First check to be sure
that the car is actually in the garage.  (The person who possesses the car
will enter the garage, then ask to park it, so the car should have entered the
garage along with the person before the PARK message is sent.)  Then generate
a TICKET with a unique serial number.  (The counter for serial numbers should
be shared among all garages, so that we don't get in trouble later trying to
UNPARK a car from one garage that was parked in a different garage.)  Every
ticket should have the name TICKET. |#

#| You'll associate the ticket number with the car in a key-value table like the
one that we used with GET and PUT in 2.3.3.  However, GET and PUT refer to a
single, fixed table for all operations; in this situation we need a separate
table for every garage.  The file tables.scm contains an implementation of the
table Abstract Data Type:

constructor: (make-table) returns a new, empty table.

mutator: (insert! key value table) adds a new key-value pair to a table.

selector: (lookup key table) returns the corresponding value, or #F if
				the key is not in the table. |#

#| You'll learn how tables are implemented in 3.3.3 (pp. 266-268).
For now, just take them as primitive.

Make a table entry with the ticket number as the key, and the car as the
value.  Then ask the car's owner to lose the car and take the ticket.

The UNPARK method takes a ticket as argument.  First make sure the object
you got is actually a ticket (by checking the name).  Then look up the
ticket number in the garage's table.  If you find a car, ask the ticket's
owner to lose the ticket and take the car.  Also, insert #F in the table for
that ticket number, so that people can't unpark the car twice.

A real-life garage would have a limited capacity, and would charge money
for parking, but to simplify the project you don't have to simulate those
aspects of garages.  |#




(define-class (ticket name )
    (parent (thing name))
    (class-vars (number 0))
    (instance-vars (ident number))
    (initialize (set! number (+ number 1)))
)
;testing
;(define myticket (instantiate ticket 'myticket ))
;(define myticket2 (instantiate ticket 'myticket2 ))
;(ask myticket 'id)
;(ask myticket2 'id)

(define-class (garage name)
    (parent (place name))
    
    (method (park vehicle)
        (cond 
            ((not (eq? (ask vehicle 'type ) 'thing )) (print "you did not provide a vehicle to park"))
            ((not (procedure? (ask vehicle 'possessor ))) (print "there is no possessor in the vehicle that can park it"))
            (else 
                    (begin 
                        
                        (define temp-ticket (instantiate ticket 'ticket ))
                        (ask self 'appear temp-ticket)
                        (insert! (ask temp-ticket 'ident ) vehicle ticket-table)
                        (if (eq? vehicle (lookup (ask temp-ticket 'ident ) ticket-table ))
                            (begin 
                                (ask (ask vehicle 'possessor ) 'take temp-ticket)
                                (ask (ask vehicle 'possessor ) 'lose vehicle )
                            )
                            (print "Could not find the ticket in ticket-table")
                        )
                    ) 
            )
        )
         
    )
    (method (unpark ticket)
        (if (eq? (ask ticket 'name ) 'ticket )
            (let
                (
                    (the-car (lookup (ask ticket 'ident ) ticket-table))
                )
                (if the-car
                    (begin
                        (ask (ask ticket 'possessor ) 'take the-car ) 
                        (ask (ask ticket 'possessor ) 'lose ticket)
                        (insert! (ask ticket 'ident ) #f ticket-table)
                    )
                )
            )
        )
    )
)

;testing:

(define mazda (instantiate thing 'mazda ))
(ask 61A-Lab 'appear mazda)
(define commuter (instantiate person 'commuter 61A-Lab))
(ask commuter 'take mazda )
(ask (ask mazda 'possessor ) 'name )

(define thegarage (instantiate garage 'thegarage ))
(can-go thegarage 'up 61A-Lab)
(can-go 61A-Lab 'down thegarage)

(ask commuter 'go 'down )
(ask thegarage 'park mazda)

(ask thegarage 'unpark (car (ask commuter 'possessions )) )
(lookup 0 ticket-table)
; no validation if thing is a car.




#| --- End of Part I for Person A  |#
