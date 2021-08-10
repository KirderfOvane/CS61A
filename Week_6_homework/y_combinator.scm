  

    (
        ((lambda (f) (lambda (n) (f f n))) 
            (lambda (fn x)
                (if (= x 0)
                    1
                    (* x (fn fn (- x 1))))
            )  
        ) 
     5)