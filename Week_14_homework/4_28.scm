#| Exercise 4.28: Eval uses actual-value rather than eval to evaluate 
the operator before passing it to apply, 
in order to force the value of the operator. 
Give an example that demonstrates the need for this forcing.  |#

;If it's an 'thunk or 'evaluated-thunk procedure, apply do only check if it's an primitive or compound procedure.
; Running it without actual-value will render apply to error on unknown procedure.