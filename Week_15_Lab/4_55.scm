#| Exercise 4.55: Give simple queries that retrieve the following information from the data base:

all people supervised by Ben Bitdiddle;
the names and jobs of all people in the accounting division;
the names and addresses of all people who live in Slumerville. |#

(supervisor ?who (Bitdiddle Ben))
(job ?who (accounting . type?))
(address ?who (Slumerville . type?))