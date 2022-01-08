#| Exercise 4.65: Cy D. Fect, looking forward to the day when he will rise in the organization, gives a query to find all the wheels (using the wheel rule of 4.4.1):

(wheel ?who)

To his surprise, the system responds

;;; Query results:
(wheel (Warbucks Oliver))
(wheel (Bitdiddle Ben))
(wheel (Warbucks Oliver))
(wheel (Warbucks Oliver))
(wheel (Warbucks Oliver))

Why is Oliver Warbucks listed four times?  |#
;Answer: eben, ben,alyssa and ben again as supervisor for alyssa and then ben as a wheel on his own as he is supervisor of alyssa who is in turn supervisor.
; Every time the conditions are met the data gets instanciated.
(load "query.scm")
(initialize-data-base microshaft-data-base)
(query-driver-loop)

(rule (wheel ?person)
      (and (supervisor ?middle-manager 
                       ?person)
           (supervisor ?x ?middle-manager)))

