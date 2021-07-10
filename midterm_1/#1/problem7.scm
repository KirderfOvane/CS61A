#|
Problem 7 (Data abstraction).
We want to write a program that uses the time of day as an abstract data type. 
We’ll represent times internally as a list of three elements, 
such as (11 23 am) for 11:23 am. 
For the purposes of this problem, assume that the hour part is never 12, 
so there’s never any special problems about noon and midnight. 
The hour will be a number 1–11, the minute will be a number 0–59, and the third element (which we’ll call the category) must be the word am or the word pm. 
Here’s our implementation:

(define (make-time hr mn cat) (list hr mn cat))
(define hour car)
(define minute cadr)
(define category caddr)

(a) This is a good internal representation, but not a good representation for the user of our program to see. 
Write a function time-print-form that takes a time as its argumentand returns a word of the form 3:07pm.

(b) If we want to ask whether one time is before or after another, it’s convenient to use the 24-hour representation in which 3:47 pm has the form 1547. 
Write a procedure 24-hour that takes a time as its argument and returns the number that represents that time in 24-hour notation:

> (24-hour (make-time 3 47 ’pm))
1547

Respect the data abstraction!
(c) Now we decide to change the internal representation of times to be a number in 24-hour form. 
But we want the constructor and selectors to have the same interface so that programs using the abstract data type don’t have to change. 
Rewrite the constructor and selectors to accomplish this. 
|#

;a>
(define hour car)
(define minute cadr)
(define category caddr)
(define (time-print-form time-li)
    (define (make-time hr mn cat)
        (list hr mn cat)
    )
    
    (define time (make-time (hour time-li) (minute time-li) (category time-li)))
    
    (list (hour time) ': (minute time) (category time))
)
(define (hour time)
        time
)
;testing
(time-print-form (make-time 11 23 'am) )
(time-print-form (make-time 10 03 'am) )


;correct
(define (time-print-form time)
  (word (hour time) ': (two-digit (minute time)) (category time)))

(define (two-digit num)
  (if (< num 10)
      (word 0 num)
      num))


(define (24-hour time)
  (+ (* (hour time) 100)
     (minute time)
     (if (equal? (category time) 'pm) 1200 0)))


(define (make-time hr min cat)
  (+ (* hr 100)
     min
     (if (equal? cat 'pm) 1200 0)))

(define (hour time)
  (if (>= time 1200)
      (- (div time 100) 12)
      (div time 100)))

(define (minute time)
  (remainder time 100))

(define (category time)
  (if (>= time 1200) 'pm 'am))


;b>

(define (24-hour time-li)
     (if (equal? (hour cat) 'pm )
         (append (+ (hour time) 12) (minute time))   
     )
)

;c>


(define (time-print-form time-li)
    (define (make-time hr mn)
        (list hr mn)
    )
    (define hour car)
    (define minute cdr)
    (define time (make-time time-li))
    (list (hour time) ': (minute time))
)

