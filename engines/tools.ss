#!r6rs

(library

 (engines tools)

 (export samples->dist
         compute-error
         test-dynamic-runtime)

 (import (rnrs)
         (scheme-tools hash)
         (scheme-tools srfi-compat :1)
         (scheme-tools)
         (scheme-tools profile))

 (define (samples->dist samples)
   (let ([bins (bin samples)])
     (map pair
          (map first bins)
          (map log (normalize (map (lambda (bin) (exact->inexact (rest bin)))
                                   bins))))))

 (define (alist->hash-table* dist)
   (let ([ht (make-equal-hash-table)])
     (alist-map (lambda (v p)
                  (hash-table-set! ht v p))
                dist)
     ht))

 (define (compute-error true-dist dist)
   (let ([dist-table (alist->hash-table* dist)])
     (sum
      (alist-map (lambda (v p)
                   (abs (- (exp p)
                           (exp (hash-table-ref/default dist-table
                                                        v
                                                        -inf.0)))))
                 true-dist))))

 (define (double x)
   (* x 2))

 (define/kw (test-dynamic-runtime f x max-runtime [inc :default double])
   (let-values ([(runtime v) (get-runtime&value (lambda () (f x)))])
     (cons (list x runtime v)
           (if (> runtime max-runtime)
               '()
               (test-dynamic-runtime f (inc x) max-runtime 'inc inc)))))

 )

