(define (type-check FN type? value)
    (if (type? value)
    (FN value)
    #f))