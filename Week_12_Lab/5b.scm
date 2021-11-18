#| 5b. Devise an example that demonstrates that Logo uses dynamic scope rather than lexical scope. Your
example should involve the use of a variable that would have a different value if Logo used lexical scope.
Test your code with Berkeley Logo.

 |#

;logo
to outer :var
inner
end

to inner
print var
end

;testing
;outer 25

;scheme
(define (outer var)
    (inner)
)
(define (inner)
    (print var)
)

;testing
;(outer 25)