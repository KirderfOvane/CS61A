;3. Explain why make-procedure does not call eval.
;make-procedure is used to create an anonymous procedure and it's only returned and not invoked at this time.
;make-procedure contains params,body and what env. it points to, all that is needed to later
;evaluate the procedure.