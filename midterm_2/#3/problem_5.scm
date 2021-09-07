#| Problem 5 (Object oriented programming)
We are going to prepare a simulation of an FM car radio. To simplify the problem we’ll
restrict our attention to tuning, not to volume or balance or anything else a radio does.
This radio features digital tuning. There are six buttons that can be preset to particular
stations; for manual tuning, there are up and down buttons that move to the next higher
or lower frequency. (FM frequencies are measured in megahertz and have values separated
by 0.2: 88.1, 88.3, 88.5, 88.7, 88.9, 90.1, etc.) To simplify the problem further, we’ll ignore
the boundary problem of what to do when you’re at the lowest assigned FM frequency and
try to go down below that frequency. Just pretend you can keep going up or down forever.
Use the OOP language (define-class and so on).
(a) Create a button object class that accepts these messages:
set-freq! 93.3 sets the button’s remembered frequency
freq returns the remembered frequency
The initial frequency should be zero (because the buttons don’t have settings initially).
(b) Create a radio object class that has six buttons, numbered 0 through 5, and accepts
these messages:
set-button! 3 sets button 3 to the radio’s current frequency
push 3 sets the radio to button 3’s frequency
up sets the radio to the next higher frequency
down sets the radio to the next lower frequency
freq returns the radio’s current frequency
The radio’s initial frequency should be 90.7 MHz. Points to remember: Your radio has
to use six of your button objects; you needn’t check for invalid argument values in the
methods. Hint: Give your radio a list of six buttons, and use list-ref to get the one
you want. |#



;(a)
(define-class (button)
    (instance-vars (freq 0))
	(method (set-freq! num)
		(set! freq num)
    )
)
;(b)

(define-class (radio)
    (instance-vars 
        (buttonlist
            (list 
                (instantiate button)
                (instantiate button)
                (instantiate button)
                (instantiate button)
                (instantiate button)
                (instantiate button)
            ) 
        )
        (freq 90.7)
    )
   
 
    (method (set-button! btn-num)
        (ask (list-ref buttonlist btn-num) 'set-freq! freq)
    )
    (method (push btn-num)
        (set! freq (ask (list-ref buttonlist btn-num) 'freq ))
    )
    (method (up)
        (set! freq (+ freq 0.2))
    )
    (method (down)
        (set! freq (- freq 0.2))
    )
   
)