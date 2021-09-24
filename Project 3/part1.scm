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