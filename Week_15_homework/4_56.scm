#| Exercise 4.56: Formulate compound queries that retrieve the following information:

the names of all people who are supervised by Ben Bitdiddle, together with their addresses;
all people whose salary is less than Ben Bitdiddle’s, together with their salary and Ben Bitdiddle’s salary;
all people who are supervised by someone who is not in the computer division, together with the supervisor’s name and job. |#

(and (supervisor ?who (Bitdiddle Ben))
     (address ?who ?where)
)
;------------------------------------------------

(and 
     (salary (Bitdiddle Ben) ?x)
     (salary ?who ?amount)
     (lisp-value > ?amount ?x)
)
;-------------------------------------------------
(and (supervisor ?x ?y)
     (not (job ?y (computer . ?type)))
     (job ?y ?what)
)