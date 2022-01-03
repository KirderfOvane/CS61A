#| Exercise 4.56: Formulate compound queries that retrieve the following information:

the names of all people who are supervised by Ben Bitdiddle, together with their addresses;
all people whose salary is less than Ben Bitdiddle’s, together with their salary and Ben Bitdiddle’s salary;
all people who are supervised by someone who is not in the computer division, together with the supervisor’s name and job. |#

(and (supervisor ?who (Bitdiddle Ben))
     (address ?who ?where)
)

;;; Query results:
(and (supervisor (tweakit lem e) (bitdiddle ben)) (address (tweakit lem e) (boston (bay state road) 22)))
(and (supervisor (fect cy d) (bitdiddle ben)) (address (fect cy d) (cambridge (ames street) 3)))
(and (supervisor (hacker alyssa p) (bitdiddle ben)) (address (hacker alyssa p) (cambridge (mass ave) 78)))

;------------------------------------------------

(and 
     (salary (Bitdiddle Ben) ?x)
     (salary ?who ?amount)
     (lisp-value > ?amount ?x)
)

;;; Query results:
(and (salary (bitdiddle ben) 60000) (salary (scrooge eben) 75000) (lisp-value > 75000 60000))
(and (salary (bitdiddle ben) 60000) (salary (warbucks oliver) 150000) (lisp-value > 150000 60000))

;-------------------------------------------------
(and (supervisor ?x ?y)
     (not (job ?y (computer . ?type)))
     (job ?y ?what)
)

;;; Query results:
(and (supervisor (aull dewitt) (warbucks oliver)) (not (job (warbucks oliver) (computer . ?type))) (job (warbucks oliver) (administration big wheel)))
(and (supervisor (cratchet robert) (scrooge eben)) (not (job (scrooge eben) (computer . ?type))) (job (scrooge eben) (accounting chief accountant)))
(and (supervisor (scrooge eben) (warbucks oliver)) (not (job (warbucks oliver) (computer . ?type))) (job (warbucks oliver) (administration big wheel)))
(and (supervisor (bitdiddle ben) (warbucks oliver)) (not (job (warbucks oliver) (computer . ?type))) (job (warbucks oliver) (administration big wheel)))