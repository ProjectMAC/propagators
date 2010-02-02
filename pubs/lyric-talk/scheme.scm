5
(+ 1 1)
(* 4 3)
(* (+ 2 3) (- 3 2))
(define x 4)
(+ x x)

(define (add4 x)
  (+ x 4))
(add4 7)
x

(let ((x (* 3 4)))
  (+ x (- x 7)))
+

(lambda (x)
  (+ 5 x))

(define add5
  (lambda (x)
    (+ 5 x)))
(add5 9)

(define count
  (let ((counter 0))
    (lambda ()
      (set! counter (+ counter 1))
      counter)))
(count)
(count)
(count)

(define (addx x)
  (lambda (y)
    (+ x y)))
(define add8 (addx 8))
(add8 7)
(add8 3)
(load "~/probscheme/load-probscheme")
