#| 1c. Since all the Scheme primitives are automatically available in scheme-1, you might think you could
use STk’s primitive map function. Try these examples:
Scheme-1: (map first ’(the rain in spain))
Scheme-1: (map (lambda (x) (first x)) ’(the rain in spain))
Explain the results. |#

; lambda expressions in scheme-1 is self-evaluating,so the stk-map-procedure won't recognise it , as it is
; looking for a procedure and not a 'lambda thingamayabb it is called in scheme-1.