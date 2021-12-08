#| Exercise 4.50: Implement a new special form ramb that is like amb except that it searches alternatives in a random order, 
rather than from left to right. Show how this can help with Alyssa’s problem in Exercise 4.49. |# 

(load "ambeval.scm")

(define (ramb? exp) (tagged-list? exp 'ramb ))

(define (len li)
    (define (iter lst count)
        (if (null? lst)
            count
            (iter (cdr lst) (+ count 1))
        )
    )
    (iter li 0)
)

(define (remove-from-list x li)
    (filter (lambda (i) (not (eq? x i ))) li)
)

(define (randomize li)
    (define (iter lst new-li)
        (if (null? lst)
            new-li
            (let*
                (
                    (rand-num (random (len lst)))
                    (removed (list-ref lst rand-num))
                    (pruned-list (remove-from-list removed lst))
                )  
                (iter pruned-list (append new-li (list removed)))
            )
        )
    )
    (iter li '())
)

(define (analyze exp)
  (cond ((self-evaluating? exp) 
         (analyze-self-evaluating exp))
        ((quoted? exp) (analyze-quoted exp))
        ((variable? exp) (analyze-variable exp))
        ((assignment? exp) (analyze-assignment exp))
        ((definition? exp) (analyze-definition exp))
        ((if? exp) (analyze-if exp))
        ((lambda? exp) (analyze-lambda exp))
        ((begin? exp) (analyze-sequence (begin-actions exp)))
        ((cond? exp) (analyze (cond->if exp)))
        ((let? exp) (analyze (let->combination exp))) ;**
        ((amb? exp) (analyze-amb exp))                ;**
        ((ramb? exp) (analyze-ramb exp))
        ((application? exp) (analyze-application exp))
        (else
         (error "Unknown expression type -- ANALYZE" exp))))


(define (analyze-ramb exp)
  (let ((cprocs (map analyze (amb-choices exp))))
    (print "cprocs")
    (print cprocs)
    (lambda (env succeed fail)
      (define (try-next choices)
        (if (null? choices)
            (fail)
            ((car choices) env
                           succeed
                           (lambda ()
                             (try-next (cdr choices))))))
      (try-next (randomize cprocs)))))


;run / Testing
;(mce) +
;Grammar
(define nouns 
  '(noun student professor cat class))

(define verbs 
  '(verb studies lectures eats sleeps))

(define articles '(article the a))

(define prepositions 
  '(prep for to in by with))


;Parsers
 (define (parse-sentence)
  (list 'sentence
         (parse-noun-phrase)
         (parse-verb-phrase)))

(define (parse-verb-phrase)
  (define (maybe-extend verb-phrase)
    (ramb 
     verb-phrase
     (maybe-extend 
      (list 'verb-phrase
            verb-phrase
            (parse-prepositional-phrase)))))
  (maybe-extend (parse-word verbs)))

(define (parse-simple-noun-phrase)
  (list 'simple-noun-phrase
        (parse-word articles)
        (parse-word nouns)))

(define (parse-noun-phrase)
  (define (maybe-extend noun-phrase)
    (ramb 
     noun-phrase
     (maybe-extend 
      (list 'noun-phrase
            noun-phrase
            (parse-prepositional-phrase)))))
  (maybe-extend (parse-simple-noun-phrase)))

(define (parse-prepositional-phrase)
  (list 'prep-phrase
        (parse-word prepositions)
        (parse-noun-phrase)))

(define (parse-word word-list)
  (define (iter words)
    (if (null? words)
	(ramb)
	(ramb (car words) (iter (cdr words)))))
  (list (car word-list) (iter (cdr word-list))))

;Initialization
(define *unparsed* '())
(define (parse input)
  (set! *unparsed* input)
  (let ((sent (parse-sentence)))
    (require (null? *unparsed*))
    sent))

;normal amb:
;(parse-word '(the professor lectures to the student))
;;; Starting a new problem
;;; Amb-Eval value:
;(the professor)

;;; Amb-Eval input:
;try-again

;;; Amb-Eval value:
;(the lectures)

;;; Amb-Eval input:
;try-again

;;; Amb-Eval value:
;(the to)

;;; Amb-Eval input:
;try-again

;;; Amb-Eval value:
;(the the)

;;; Amb-Eval input:
;try-again

;;; Amb-Eval value:
;(the student)

;;; Amb-Eval input:
;try-again

;;; There are no more values of
;(parse-word (quote (the professor lectures to the student))) 


;ramb:
;(parse-word '(the professor lectures to the student))
;try-again * 5 --> see random generation

;;; Amb-Eval input:
#| (parse-word '(the professor lectures to the student)) |#

;;; Starting a new problem #[closure arglist=(env succeed fail) 7fdc82a8]
#| #[closure arglist=(env succeed fail) 7fdcba78]
#[closure arglist=(env succeed fail) 7fdc82a8]
#[closure arglist=(env succeed fail) 7fdcba78]
#[closure arglist=(env succeed fail) 7fdc82a8]
#[closure arglist=(env succeed fail) 7fdcba78]
#[closure arglist=(env succeed fail) 7fdc82a8]
#[closure arglist=(env succeed fail) 7fdcba78]
#[closure arglist=(env succeed fail) 7fdc82a8]
#[closure arglist=(env succeed fail) 7fdcba78] |#

;;; Amb-Eval value:
#| (the student) |#

;;; Amb-Eval input:
#| try-again |#

;;; Amb-Eval value:
#| (the the) |#

;;; Amb-Eval input:
#| try-again |#

;;; Amb-Eval value:
#| (the to) |#

;;; Amb-Eval input:
#| try-again |#

;;; Amb-Eval value:
#| (the lectures) |#

;;; Amb-Eval input:
#| try-again |#

;;; Amb-Eval value:
#| (the professor) |#

;;; Amb-Eval input:
#| try-again |#

;;; There are no more values of
#| (parse-word (quote (the professor lectures to the student)))   |#