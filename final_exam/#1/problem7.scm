Problem 7 (Environment diagrams).
Consider the following definitions.
(define x 1)

(define (charm x)
    (lambda (y) (+ x y)))

(define z ((charm 3) 5))
Below are two partial environment diagrams for these definitions. They are missing two
things:

(1) An arrow from the y --> 5 frame to the environment that it extends;

(2) The value of z in the global frame.

Complete the first diagram as it would appear in lexically scoped Scheme; complete the
second diagram as it would appear if Scheme used dynamic scope.



DYNAMIC SCOPE                                                       LEXICAL SCOPE
-------------                                                       -------------
____global_                                                          ____global_
|           |                                                       |            |
| x --> 1   |<------------,                                         | x --> 1    |<------------,
|           |         _   |                                         |            |          _  |
|  charm ------------>(_)(_)   <------+                             |   charm ------------>(_)(_)
|           | params: x               |                             |            |         params: x
|  z --> 6  | body: (lambda (y)       |                             | z -->  8   |         body: (lambda (y)
|           |          (+ x y))       |                             |            |                  (+ x y))
|           |<------------,           |                             |            |<------------,
|___________|             |           |                             |___________ |             |
                       ___|_______    |                                                     ___|_______
                      |           |   |                                                    |           |
           +--------->| x --> 3   |   |                                         +--------->|  x --> 3  |
           |          |___________|   |                                         |          |___________|
       (_)(_)                         |                                     (_)(_)<------------+
       params: y                      |                                     params: y          |(1)
       body: (+ x y)   ___________    |                                     body: (+ x y)   ___|________
                      |           |   | (1)                                                |           |
                      | y --> 5   | --+                                                    |   y --> 5 |
                      |___________|                                                        |___________|


