(in-test-group
 graph-drawing

 (define-each-check
   (equal? '+ (name generic-+)))

 (define-test (naming-smoke)
   (define-cell foo)
   (define-cell bar)
   (define-cell baz)
   (vc:adder foo bar baz)
   (check (= 1 (length (neighbors foo))))
   (check (= 1 (length (neighbors bar))))
   (check (= 1 (length (neighbors baz))))
   (check (eq? 'foo (name foo)))
   (check (eq? 'bar (name bar)))
   (check (eq? 'baz (name baz)))
   (define the-adder (car (neighbors foo)))
   (check (eq? the-adder (car (neighbors bar))))
   (check (eq? the-adder (car (neighbors baz))))
   (check (equal? (list foo bar) (prop:propagator-inputs the-adder)))
   (check (equal? (list baz) (prop:propagator-outputs the-adder)))
   (check (eq? '+ (name the-adder)))
   (check (propagator? the-adder))
   (check (cell? foo))
   (check (cell? bar))
   (check (cell? baz))))
