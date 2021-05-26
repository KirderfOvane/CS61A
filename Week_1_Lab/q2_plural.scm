
(define (boytest wd)
    (if (equal? wd 'boy)
          (word wd 's)
          (word (bl wd) 'ies)))

(define (plural wd)
  (if (equal? (last wd) 'y)
      (boytest wd)
      (word wd 's)))
