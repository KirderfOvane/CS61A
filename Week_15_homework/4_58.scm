#| Exercise 4.58: Define a rule that says that a person is a “big shot” in a division 
if the person works in the division but does not have a supervisor who works in the division.  |#

(load "query.scm")
(initialize-data-base microshaft-data-base)
(query-driver-loop)


(and (job ?person (?division . ?title))
     (or (not (supervisor ?person ?employee))
         (and (supervisor ?person ?employee)
              (not (job ?employee (?division . ?anothertitle)))
         )
     )
)

(assert! (rule (bigshot ?person ?division)
                (and (job ?person (?division . ?title))
                (or (not (supervisor ?person ?employee))
                    (and (supervisor ?person ?employee)
                        (not (job ?employee (?division . ?anothertitle)))
                    )
                )
                ) 
         )
)



