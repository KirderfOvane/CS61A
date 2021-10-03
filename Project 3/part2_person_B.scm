#| PART II, PERSON B:

B6.  The way we're having people take food from restaurants is unrealistic
in several ways.  Our overall goal this week is to fix that.  As a first
step, you are going to create a FOOD class.
We will give things that are food two properties, an EDIBLE? property
and a CALORIES property.  EDIBLE?  will have the value #T if the object is a
food.  If a PERSON eats some food, the food's CALORIES are added to the
person's STRENGTH. |#

#| (Remember that the EDIBLE? property will automatically be false for objects
other than food, because of the way properties were implemented in question B4.
You don't have to go around telling all the other stuff not to be edible
explicitly.) |#

#| Write a definition of the FOOD class that uses THING as the parent class.
It should return #T when you send it an EDBILE? message, and it should
correctly respond to a CALORIES message. |#

#| Replace the procedure named EDIBLE? in the original adv.scm with a new
version that takes advantage of the mechanism you've created, instead of
relying on a built-in list of types of food. |#

#| Now that you have the FOOD class, invent some child classes for particular
kinds of food.  For example, make a bagel class that inherits from FOOD.
Give the bagel class a class-variable called NAME whose value is the word
bagel.  (We'll need this later when we invent RESTAURANT objects.) |#

#| Make an EAT method for people.  Your EAT method should look at your
possessions and filter for all the ones that are edible.  It should then add
the calorie value of the foods to your strength.  Then it should make the
foods disappear (no longer be your possessions and no longer be at your
location). |#

#| ** Now get your partner to explain problem A6 and its solution. **

B7.  Your job is to define the police class.  A policeperson is to have the
following behavior: |#
(define-class (police name place)
    (parent (person name place))
    (method (type) 'police )
    (method (apprehend thief)
        
    )
)

#| The police stays at one location.  When the police notices a new person
entering the location, the police checks to see if that person is a thief.
If the person is a thief the police says "Crime Does Not Pay," then takes
away all the thief's possessions and sends the thief directly to jail. |#

#| Give thieves and police default strengths.  Thieves should start out stronger
than persons, but police should be stronger than thieves.  Of course, if you
eat lots you should be able to build up enough STRENGTH (mass?) to take food
away from a thief.  (Only a character with a lot of CHUTZPAH would take food
away from the police. :-) |#

#| Please test your code and turn in a transcript that shows the thief stealing
your food, you chasing the thief and the police catching the thief.  In case
you haven't noticed, we've put a thief in Sproul Plaza. |#


#| B8.  Now we want to reorganize TAKE so that it looks to see who previously
possesses the desired object.  If its possessor is 'NO-ONE, go ahead and
take it as always.  Otherwise, invoke
	(ask thing 'MAY-TAKE? receiver)
The MAY-TAKE? method for a thing that belongs to someone should compare
the strength of its owner with the strength of the requesting person to
decide whether or not it can be taken.  The method should return #F
if the person may not take the thing, or the thing itself if the person may
take it.  This is a little more complicated than necessary right now, but
we are planning ahead for a situation in which, for example, an object
might want to make a clone of itself for a person to take.

Note the flurry of message-passing going on here.  We send a message to the
taker.  It sends a message to the thing, which sends messages to two people
to find out their strengths. |#