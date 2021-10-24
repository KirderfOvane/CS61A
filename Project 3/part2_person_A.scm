#| PART II:

This part of the project includes three exercises for each person, but YOU
HAVE TO READ EACH OTHER'S CODE midweek, because one partner's exercises 7 and
8 build on the other partner's exercise 6.  Finally, exercise 9 requires the
two partners' work to be combined.  You will have to create a version of
adv.scm that has both partners' changes.  This may take some thinking!  If
both parners modify the same method in the same object class, you'll have to
write a version of the method that incorporates both modifications. |#


#| PART II, PERSON A:

Adv.scm includes a definition of the class THIEF, a subclass of person.
A thief is a character who tries to steal food from other people.  Of
course, Berkeley can not tolerate this behavior for long.  Your job is to
define a POLICE class; police objects catch thieves and send them directly
to jail.  To do this you will need to understand how theives work.|#


#| Since a thief is a kind of person, whenever another person enters the place
where the thief is, the thief gets a NOTICE message from the place.  When
the thief notices a new person, he does one of two things, depending on the
state of his internal BEHAVIOR variable.  If this variable is set to STEAL,
the thief looks around to see if there is any food at the place.  If there
is food, the thief takes the food from its current possessor and sets his
behavior to RUN.  When the thief's behavior is RUN, he moves to a new random
place whenever he NOTICEs someone entering his current location.  The RUN
behavior makes it hard to catch a thief.

Notice that a thief object delegates many messages to its person object.  |#

#| A6a.  To help the police do their work, you will need to create a place called
jail.  Jail has no exits.  Moreover, you will need to create a method for
persons and thieves called GO-DIRECTLY-TO.  Go-directly-to does not require
that the new-place be adjacent to the current-place.  So by calling (ASK
THIEF 'GO-DIRECTLY-TO JAIL) the police can send the thief to jail no matter
where the thief currently is located, assuming the variable thief is bound
to the thief being apprehended. |#
(define-class (jail name)
    (parent (place name))
    (method (type) 'jail )
)
(define myjail (instantiate jail 'myjail ))
(define testthief (instantiate person 'testthief soda))
(define anotherthief (instantiate person 'anotherthief 61a-lab))
(ask testthief 'go-directly-to myjail)
(ask anotherthief 'go 'north )
(ask anotherthief 'go-directly-to myjail )
#| A6b.  Thieves sometimes try to leave their place in a randomly chosen
direction.  This, it turns out, won't work if there are no exits from
that place -- for example, the jail.  Modify the THIEF class so that
a thief won't try to leave a place with no exits. |#

#| ** Now get your partner to explain problem B6 and its solution. ** |#

#| A7a.  We are now going to invent restaurant objects.  People will interact
with the restaurants by buying food there.  First we have to make it possible
for people to buy stuff.  Give PERSON objects a MONEY property, which is a
number, saying how many dollars they have.  Note that money is not an
object.  We implement it as a number because, unlike the case of objects
such as chairs and potstickers, a person needs to be able to spend SOME
money without giving up all of it.  In principle we could have objects like
QUARTER and DOLLAR-BILL, but this would make the change-making process
complicated for no good reason. |#

#| To make life simple, we'll have every PERSON start out with $100.  (We should
really start people with no money, and invent banks and jobs and so on, but
we won't.)  Create two methods for people, GET-MONEY and PAY-MONEY, each of
which takes a number as argument and updates the person's money value
appropriately.  PAY-MONEY must return true or false depending on whether
the person had enough money. |#


#| A7b.  Another problem with the adventure game is that Noah's only has one
bagel.  Once someone has taken that bagel, they're out of business. |#

#| To fix this, we're going to invent a new kind of place, called a RESTAURANT.
(That is, RESTAURANT is a subclass of PLACE.)  Each restaurant serves only
one kind of food.  (This is a simplification, of course, and it's easy to see
how we might extend the project to allow lists of kinds of food.)  When a
restaurant is instantiated, it should have two extra arguments, besides the
ones that all places have: the class of food objects that this restaurant
sells,  and the price of one item of this type:

   > (define-class (bagel) (parent (food ...)) ...)

   > (define Noahs (instantiate restaurant 'Noahs bagel 0.50))

Notice that the argument to the restaurant is a CLASS, not a particular
bagel (instance). |#

#| Restaurants should have two methods.  The MENU method returns a list
containing the name and price of the food that the restaurant sells.
The SELL method takes two arguments, the person who wants to buy something
and the name of the food that the person wants.  The SELL method must first
check that the restaurant actually sells the right kind of food.  If so,
it should ASK the buyer to PAY-MONEY in the appropriate amount.  If that
succeeds, the method should instantiate the food class and return the new
food object.  The method should return #F if the person can't buy the food. |#


#| A8.  Now we need a BUY method for people.  It should take as argument the
name of the food we want to buy:  (ask Brian 'buy 'bagel).  The method must
send a SELL message to the restaurant.  If this succeeds (that is, if the
value returned from the SELL method is an object rather than #F) the new food
should be added to the person's possessions. |#
