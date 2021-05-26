(define (if-new predicate true-clause else-clause)
(cond (predicate true-clause)
(else else-clause)))

(define (pigl wd)
  (if-new (pl-done? wd) ;is pl-done? , is pig latin done, is there a vowel letter first in the word?
      (word wd 'ay)  ; when true , add ay to the end of the word
      (pigl (word (bf wd) (first wd)))))  ; when false, 

(define (pl-done? wd)
  (vowel? (first wd)))

(define (vowel? letter)
  (member? letter '(a e i o u)))

#| Try 1: If you do a trace on pigl with if-new we see it is in an endless loop. The else clause in a cond is a return value rather than a else value. 
   So it exits the procedure. But as pigl is what is returned ,another procedure starts and somehow fails the test aswell. Don't understand why. As we are in an endless loop
   and are creating more and more function calls , we end up with a segmentation fault when stack memory is full.

   Try 2: Above was wrong, it's about execution of procedure:
   new-if is considered a ordinary procedure and therefore the arguments is first evaluated. 
   if on the other hand, will be considered a special form and will use the applicative order evaluation.
   So it breaks down every argument and procedure to primites _before_ eval.
   Then it evals the cond/test first and see that it is false and therefore never evaluate the true clause.
   But why is it false on estt ?
   
-> pigl with wd = test
... -> pigl with wd = estt
........ -> pigl with wd = stte
................... -> pigl with wd = ttes
...................... -> pigl with wd = test
..................... -> pigl with wd = estt 
|#



