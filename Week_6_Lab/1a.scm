

    ;((lambda (x) (+ x 3)) 5)

Scheme-1: ((lambda (x) (+ x 3)) 5)
.. -> scheme-1 .... -> eval-1 with exp = ((lambda (x) (+ x 3)) 5)
...... -> constant? with exp = ((lambda (x) (+ x 3)) 5)
...... -> procedure? with args = (((lambda (x) (+ x 3)) 5))
...... <- procedure? returns #f
...... <- constant? returns #f
...... -> symbol? with x = ((lambda (x) (+ x 3)) 5)
...... <- symbol? returns #f
...... -> quote-exp? with exp = ((lambda (x) (+ x 3)) 5)
...... -> pair? with args = (((lambda (x) (+ x 3)) 5))
...... <- pair? returns #t ;pair is detected , run apply-1 
........ -> symbol? with x = (lambda (x) (+ x 3))
........ <- symbol? returns #f
...... <- quote-exp? returns #f
...... -> if-exp? with exp = ((lambda (x) (+ x 3)) 5)
...... -> pair? with args = (((lambda (x) (+ x 3)) 5))
...... <- pair? returns #t ;pair is detected , run apply-1 
........ -> symbol? with x = (lambda (x) (+ x 3))
........ <- symbol? returns #f
...... <- if-exp? returns #f
...... -> lambda-exp? with exp = ((lambda (x) (+ x 3)) 5)
...... -> pair? with args = (((lambda (x) (+ x 3)) 5))
...... <- pair? returns #t ;pair is detected , run apply-1 
........ -> symbol? with x = (lambda (x) (+ x 3))
........ <- symbol? returns #f
...... <- lambda-exp? returns #f
.... -> pair? with args = (((lambda (x) (+ x 3)) 5))
.... <- pair? returns #t ;pair is detected , run apply-1 
...... -> eval-1 with exp = (lambda (x) (+ x 3))
........ -> constant? with exp = (lambda (x) (+ x 3))
........ -> procedure? with args = ((lambda (x) (+ x 3)))
........ <- procedure? returns #f
........ <- constant? returns #f
........ -> symbol? with x = (lambda (x) (+ x 3))
........ <- symbol? returns #f
........ -> quote-exp? with exp = (lambda (x) (+ x 3))
........ -> pair? with args = ((lambda (x) (+ x 3)))
........ <- pair? returns #t ;pair is detected , run apply-1 
.......... -> symbol? with x = lambda
.......... <- symbol? returns #t
.......... -> symbol? with x = #\l
.......... <- symbol? returns #f
........ <- quote-exp? returns #f
........ -> if-exp? with exp = (lambda (x) (+ x 3))
........ -> pair? with args = ((lambda (x) (+ x 3)))
........ <- pair? returns #t ;pair is detected , run apply-1 
.......... -> symbol? with x = lambda
.......... <- symbol? returns #t
.......... -> symbol? with x = #\l
.......... <- symbol? returns #f
........ <- if-exp? returns #f
........ -> lambda-exp? with exp = (lambda (x) (+ x 3))
........ -> pair? with args = ((lambda (x) (+ x 3)))
........ <- pair? returns #t ;pair is detected , run apply-1 
.......... -> symbol? with x = lambda
.......... <- symbol? returns #t
.......... -> symbol? with x = #\l
.......... <- symbol? returns #f
........ <- lambda-exp? returns #t
...... <- eval-1 returns (lambda (x) (+ x 3))
...... -> eval-1 with exp = 5
........ -> constant? with exp = 5
........ <- constant? returns #t
...... <- eval-1 returns 5
...... -> apply-1 with proc = (lambda (x) (+ x 3)),  args = (5)
...... -> procedure? with args = ((lambda (x) (+ x 3)))
...... <- procedure? returns #f
........ -> lambda-exp? with exp = (lambda (x) (+ x 3))
........ -> pair? with args = ((lambda (x) (+ x 3)))
........ <- pair? returns #t
.......... -> symbol? with x = lambda
.......... <- symbol? returns #t
.......... -> symbol? with x = #\l
.......... <- symbol? returns #f
........ <- lambda-exp? returns #t
........ -> substitute with exp = (+ x 3),  params = (x),  args = (5),  bound = ()
.......... -> constant? with exp = (+ x 3)
.......... -> procedure? with args = ((+ x 3))
.......... <- procedure? returns #f
.......... <- constant? returns #f
.......... -> symbol? with x = (+ x 3)
.......... <- symbol? returns #f
.......... -> quote-exp? with exp = (+ x 3)
.......... -> pair? with args = ((+ x 3))
.......... <- pair? returns #t
............ -> symbol? with x = +
............ <- symbol? returns #t
............ -> symbol? with x = #\+
............ <- symbol? returns #f
.......... <- quote-exp? returns #f
.......... -> lambda-exp? with exp = (+ x 3)
.......... -> pair? with args = ((+ x 3))
.......... <- pair? returns #t
............ -> symbol? with x = +
............ <- symbol? returns #t
............ -> symbol? with x = #\+
............ <- symbol? returns #f
.......... <- lambda-exp? returns #f
.......... -> substitute with exp = +,  params = (x),  args = (5),  bound = ()
............ -> constant? with exp = +
............ -> procedure? with args = (+)
............ <- procedure? returns #f
............ <- constant? returns #f
............ -> symbol? with x = +
............ <- symbol? returns #t
............ -> lookup with name = +,  params = (x),  args = (5)
.............. -> symbol? with x = +
.............. <- symbol? returns #t
.............. -> symbol? with x = #\+
.............. <- symbol? returns #f
.............. -> lookup with name = +,  params = (),  args = ()
.............. <- lookup returns +
............ <- lookup returns +
.......... <- substitute returns +
.......... -> substitute with exp = x,  params = (x),  args = (5),  bound = ()
............ -> constant? with exp = x
............ -> procedure? with args = (x)
............ <- procedure? returns #f
............ <- constant? returns #f
............ -> symbol? with x = x
............ <- symbol? returns #t
............ -> lookup with name = x,  params = (x),  args = (5)
.............. -> symbol? with x = x
.............. <- symbol? returns #t
.............. -> symbol? with x = #\x
.............. <- symbol? returns #f
.............. -> maybe-quote with value = 5
................ -> lambda-exp? with exp = 5
................ -> pair? with args = (5)
................ <- pair? returns #f
................ <- lambda-exp? returns #f
................ -> constant? with exp = 5
................ <- constant? returns #t
.............. <- maybe-quote returns 5
............ <- lookup returns 5
.......... <- substitute returns 5
.......... -> substitute with exp = 3,  params = (x),  args = (5),  bound = ()
............ -> constant? with exp = 3
............ <- constant? returns #t
.......... <- substitute returns 3
........ <- substitute returns (+ 5 3)
........ -> eval-1 with exp = (+ 5 3)
.......... -> constant? with exp = (+ 5 3)
.......... -> procedure? with args = ((+ 5 3))
.......... <- procedure? returns #f
.......... <- constant? returns #f
.......... -> symbol? with x = (+ 5 3)
.......... <- symbol? returns #f
.......... -> quote-exp? with exp = (+ 5 3)
.......... -> pair? with args = ((+ 5 3))
.......... <- pair? returns #t
............ -> symbol? with x = +
............ <- symbol? returns #t
............ -> symbol? with x = #\+
............ <- symbol? returns #f
.......... <- quote-exp? returns #f
.......... -> if-exp? with exp = (+ 5 3)
.......... -> pair? with args = ((+ 5 3))
.......... <- pair? returns #t
............ -> symbol? with x = +
............ <- symbol? returns #t
............ -> symbol? with x = #\+
............ <- symbol? returns #f
.......... <- if-exp? returns #f
.......... -> lambda-exp? with exp = (+ 5 3)
.......... -> pair? with args = ((+ 5 3))
.......... <- pair? returns #t
............ -> symbol? with x = +
............ <- symbol? returns #t
............ -> symbol? with x = #\+
............ <- symbol? returns #f
.......... <- lambda-exp? returns #f
........ -> pair? with args = ((+ 5 3))
........ <- pair? returns #t
.......... -> eval-1 with exp = +
............ -> constant? with exp = +
............ -> procedure? with args = (+)
............ <- procedure? returns #f
............ <- constant? returns #f
............ -> symbol? with x = +
............ <- symbol? returns #t
.......... <- eval-1 returns #[closure arglist=args 7fe10978]
.......... -> eval-1 with exp = 5
............ -> constant? with exp = 5
............ <- constant? returns #t
.......... <- eval-1 returns 5
.......... -> eval-1 with exp = 3
............ -> constant? with exp = 3
............ <- constant? returns #t
.......... <- eval-1 returns 3
.......... -> apply-1 with proc = #[closure arglist=args 7fe10978],  args = (5 3)
.......... -> procedure? with args = (#[closure arglist=args 7fe10978])
.......... <- procedure? returns #t
.......... <- apply-1 returns 8
........ <- eval-1 returns 8
...... <- apply-1 returns 8
.... <- eval-1 returns 8
8