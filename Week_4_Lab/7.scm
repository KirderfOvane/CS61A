(define x '(a (b c) d))  
(car x) ;car gets first index/argument
(cdr x) ;cdr gets everything after first index/argument
(car (cdr x))  ;this gets the first of everything after first index of x.