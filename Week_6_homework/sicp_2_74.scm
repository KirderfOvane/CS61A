#| 
Exercise 2.74: Insatiable Enterprises, Inc., is a highly decentralized conglomerate company consisting of
a large number of independent divisions located all over the world. 
The company’s computer facilities have just been interconnected by means of a clever network-interfacing 
scheme that makes the entire network appear to any user to be a single computer. 
Insatiable’s president, in her first attempt to exploit the ability of the network to 
extract administrative information from division files, is dismayed to discover that, 
although all the division files have been implemented as data structures in Scheme, 
the particular data structure used varies from division to division. A meeting of division managers 
is hastily called to search for a strategy to integrate the files that will satisfy headquarters’ 
needs while preserving the existing autonomy of the divisions.

Show how such a strategy can be implemented with data-directed programming. 
As an example, suppose that each division’s personnel records consist of a single file, 
which contains a set of records keyed on employees’ names. The structure of the set varies from division to division. 
Furthermore, each employee’s record is itself a set (structured differently from division to division) 
that contains information keyed under identifiers such as address and salary. 
In particular:

    Implement for headquarters a get-record procedure that retrieves a specified employee’s record from a specified personnel file. 
    The procedure should be applicable to any division’s file. Explain how the individual divisions’ files should be structured. 
    In particular, what type information must be supplied?

    Implement for headquarters a get-salary procedure that returns the salary information from a given employee’s record from any division’s personnel file. 
    How should the record be structured in order to make this operation work?

    Implement for headquarters a find-employee-record procedure. 
    This should search all the divisions’ files for the record of a given employee and return the record. 
    Assume that this procedure takes as arguments an employee’s name and a list of all the divisions’ files.
    When Insatiable takes over a new company, 
    what changes must be made in order to incorporate the new personnel information into the central system?  |#


    ; division files is data structures.
    ; bounded contexts for each division.

    ; goal is to have a system for connection between the divisions.
    ; we start with the personnel records.

    ;personnel records:
    ; single file, different structure in divisions.

    ; get-record:
    ; setup a table of records
     (put (list 'division 'personnel-file ) (lambda (employee-id salary) (save-to-database employee-id salary)))
    ; get specified personnel file
    ; get specified employee
     (get (list 'economy 'employees-file ) (lambda (employee-id) (get-from-database employee-id salary)))

    (define (get-record employee-id)
	    (apply-generic (list 'economy 'employees-file ) employee-id)
    )

    (define (get-salary employee-id)
        (apply-generic (list 'economy 'employees-file) employee-id)
    )

    (define (find-employee-record employee-id list-of-divisions)
          (if (empty? list-of-divisions)
              #f
              (define search-result (get (car list-of-divisions) 'employees-file employee-id))
              (if (equal? search-result #f)
                (find-employee-record employee-id (cdr list-of-divisions))
                search-result
              )
          )
    )

    (define (apply-generic op . args)
        (let ((type-tags (map type-tag args)))
            (let ((proc (get op type-tags)))
                (if proc 
                    (apply proc (map contents args))
                    (error
                     "No method for these types: 
                     APPLY-GENERIC"
                     (list op type-tags))
                )
            )
        )
    )

    (define (attach-tag type-tag contents)
  (cons type-tag contents))

(define (type-tag datum)
  (if (pair? datum)
      (car datum)
      (error "Bad tagged datum: 
              TYPE-TAG" datum)))

(define (contents datum)
  (if (pair? datum)
      (cdr datum)
      (error "Bad tagged datum: 
              CONTENTS" datum)))


