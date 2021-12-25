#| Exercise 4.57: Define a rule that says that person 1 can replace person 2 if either person 1 does the same job as person 2 or 
someone who does person 1’s job can also do person 2’s job, and if person 1 and person 2 are not the same person. 
Using your rule, give queries that find the following:

all people who can replace Cy D. Fect;
all people who can replace someone who is being paid more than they are, together with the two salaries. |#

(rule same ?p ?p)
(rule (standin ?person1 ?person2) 
  (or (and (not same ?person1 ?person2)
           (job person1 ?work1)
           (job person2 ?work2)
           (lisp-value equal? work1 work2)

      )
      (and (not same person1 person2)
           (job person1 ?x)
           (job person2 ?y)
           (can-do-job (?x) (?y))
      )
  )
)


;queries:
(standin (Cy D. Fect) ?y)
(and (standin ?x ?y)
     (salary ?y ?x)
     (salary ?y ?amount)
     (lisp-value > ?amount ?x)
)

