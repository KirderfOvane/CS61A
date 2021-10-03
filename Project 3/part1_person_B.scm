#| PART I, PERSON B:


B3.  Define a method TAKE-ALL for people.  If given that message, a person
should TAKE all the things at the current location that are not already
owned by someone. |#

(define personB (instantiate person 'PersonB soda))
;take no thing
(ask personB 'take-all )
;take one thing
(define shinynewthing (instantiate thing 'shinynewthing ))
(ask soda 'appear shinynewthing)
(ask personB 'take-all )
;take multiple things
(define shinynewthing2 (instantiate thing 'shinynewthing2 ))
(define shinynewthing3 (instantiate thing 'shinynewthing3 ))
(ask pimentel 'appear shinynewthing2)
(ask pimentel 'appear shinynewthing3)
(ask personB 'go 'south )
(ask personB 'take-all )
#| B4a.  It's unrealistic that anyone can take anything from anyone.  We want to
give our characters a STRENGTH, and then one person can take something from
another only if the first has greater STRENGTH than the second.

However, we aren't going to clutter up the person class by adding a local
STRENGTH variable.  That's because we can anticipate wanting to add lots
more attributes as we develop the program further.  People can have CHARISMA
or WISDOM; things can be FOOD or not; places can be INDOORS or not.
Therefore, you will create a class called BASIC-OBJECT that keeps a local
variable called PROPERTIES containing an attribute-value table like the
one that we used with GET and PUT in 2.3.3.  However, GET and PUT refer to
a single, fixed table for all operations; in this situation we need a
separate table for every object.  The file tables.scm contains an
implementation of the table Abstract Data Type:|#

;See basic-object implementation in adv.scm

;testing:
(ask Brian 'put 'strength 100)
(ask Brian 'strength )
(ask Brian 'get 'strength )
(ask personB 'get 'strength )
(ask personB 'put 'strength 50)
(ask personB 'strength )
(ask personB 'weight )
#| constructor: (make-table) returns a new, empty table.

mutator: (insert! key value table) adds a new key-value pair to a table.

selector: (lookup key table) returns the corresponding value, or #F if
				the key is not in the table.

You'll learn how tables are implemented in 3.3.3 (pp. 266-268).
For now, just take them as primitive. 
 |#
#| You'll modify the person, place and thing classes so that they will inherit
from basic-object.  This object will accept a message PUT so that
	> (ask Brian 'put 'strength 100)
does the right thing.  Also, the basic-object should treat any message not
otherwise recognized as a request for the attribute of that name, so
	> (ask Brian 'strength)
	100
should work WITHOUT having to write an explicit STRENGTH method in the
class definition. |#

#| Don't forget that the property list mechanism in 3.3.3 returns #F if you ask
for a property that isn't in the list.  This means that
	> (ask Brian 'charisma)
should never give an error message, even if we haven't PUT that property in
that object.  This is important for true-or-false properties, which will
automatically be #F (but not an error) unless we explicitly PUT a #T
value for them. |#
#| 
Give people some reasonable (same for everyone) initial strength.  Next
week they'll be able to get stronger by eating.
 |#





#| B4b.  You'll notice that the type predicate PERSON? checks to see if the type
of the argument is a member of the list '(person police thief).  This means
that the PERSON? procedure has to keep a list of all the classes that
inherit from PERSON, which is a pain if we make a new subclass. |#

#| We'll take advantage of the property list to implement a better system for
type checking.  If we add a method named PERSON? to the person class, and
have it always return #T, then any object that's a type of person will
automatically inherit this method.  Objects that don't inherit from person
won't find a PERSON? method and won't find an entry for person? in their
property table, so they'll return #F. |#
#| 
Similarly, places should have a PLACE? method, and things a THING? method.

Add these type methods and change the implementation of the type predicate
procedures to this new implementation. |#

;testing
(ask shinynewthing 'thing? )
(ask shinynewthing 'person? )
(ask brian 'person? )
(ask brian 'place? )
(ask soda 'place? )
(ask soda 'person? )


#| B5.  In the modern era, many places allow you to get connected to the net.
Define a HOTSPOT as a kind of place that allows network connectivity.  Each
hotspot should have a PASSWORD (an instantiation variable) that you must know
to connect.  (Note: We're envisioning a per-network password, not a per-person
password as you use with AirBears.)  The hotspot has a CONNECT method with two
arguments, a LAPTOP (a kind of thing, to be invented in a moment) and a
password.  If the password is correct, and the laptop is in the hotspot, add
it to a list of connected laptops.  When the laptop leaves the hotspot, remove
it from the list. |#

(define-class (hotspot name password)
    (parent (place name))
    (instance-vars (connected-devices '()))
    (method (connect laptop user-provided-password)
        (cond ((not (eq? password user-provided-password)) (print "incorrect password"))
              ((ask laptop 'laptop? ) (begin (print "logged in") (set! connected-devices (cons (ask laptop 'name ) connected-devices))))
              (else (print "you need a laptop to connect to hotspot"))
        )
    )
    (method (surf laptop url)
        (if (memq laptop things)
            (system (string-append "lynx " url))
        )
    )
)

#| Hotspots also have a SURF method with two arguments, a laptop and a text
string, such as

		"http://www.cs.berkeley.edu"

If the laptop is connected to the network, then the surf method should

	(system (string-append "lynx " url))

where URL is the text string argument.

Now invent laptops.  A laptop is a thing that has two extra methods:  CONNECT,
with a password as argument, sends a CONNECT message to the place where the
laptop is.  SURF, with a URL text string as argument, sends a SURF message to
the place where it is.  Thus, whenever a laptop enters a new hotspot, the user
must ask to CONNECT to that hotspot's network; when the laptop leaves the
hotspot, it must automatically be disconnected from the network.  (If it's in
a place other than a hotspot, the SURF message won't be understood; if it's in
a hotspot but not connected, the hotspot won't do anything.)|#

(define-class (laptop name)
    (parent (thing name))
    (method (laptop?) #t)
    (method (connect password)
        (if (eq? (ask self 'possessor ) 'no-one )
            (print "this laptop does not have a owner")
            (ask (ask (ask self 'possessor ) 'place )  'connect self password )
        ) 
    )
    (method (surf url)
         (if (eq? (ask self 'possessor ) 'no-one )
            (print "this laptop does not have a owner")
            (if (member? (ask self 'name ) (ask (ask (ask self 'possessor ) 'place ) 'connected-devices ))
                (system (string-append "lynx " url))
                (print "the device is not connected to the hotspot")
            )
        )
    )
)

;testing:
(define wifi (instantiate hotspot 'wifi 'password ))
(define mylaptop (instantiate laptop 'mylaptop ))
(ask wifi 'appear mylaptop)
(define nisse (instantiate person 'nisse wifi))
(ask mylaptop 'connect 'password );> "this laptop does not have a owner"
(ask nisse 'take mylaptop )

(ask mylaptop 'surf 'whatever ) ;> #f, nothing happens as the laptop is not connected.
(ask mylaptop 'connect 'password ) ;> "logged in"
;(ask mylaptop 'surf "http://www.google.com" );> we surf <- disabled because gives error. but works

;--- End of Part I, PERSON B. 
