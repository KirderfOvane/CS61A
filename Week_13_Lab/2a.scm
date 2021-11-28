(load "groupreduce.scm")
#| 2(a). One common MapReduce application is a distributed word count. Given a large body of text, such as
Project Gutenberg, we want to find out which words are the most common.
Write a mapreduce program that returns each word in a body of text paired with the number of times
it is used. Remember, the argument to your mapper function is a pair whose key is the document or book
name and whose value is a single line of text from a single book. For example,
> (define gutenberg-wordcounts (mapreduce ...))

> (ss gutenberg-wordcounts 3)

((the . 300) (was . 249) (thee . 132) ... ) ; These aren’t the actual numbers. |#


;3 books:
(define books (append (file->linelist file1) (file->linelist file2) (file->linelist file3)))

;argument to mapper: (book . line)
(lambda (books) (make-kv-pair (caar books) (cdar books)))

;count words in line
(map count line)

;mapper
(define mapper (map (lambda (line) (map count line)) books))


(map (lambda (line) (accumulate + 0 (map count line))) books)

(mapreduce (lambda (book) (map (lambda (wd) (make-kv-pair wd 1)) (cdr (car book))) ) 0 books)

(wordcounts books)