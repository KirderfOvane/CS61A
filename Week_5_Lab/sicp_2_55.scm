#| Exercise 2.55: Eva Lu Ator types to the interpreter the expression

(car ''abracadabra)

To her surprise, the interpreter prints back quote. Explain.  |#

;> car of list of 'abracadabra is ',which is the shorthand for quote
(car (quote (quote abracadabra))) ; => (car ''abracadabra)