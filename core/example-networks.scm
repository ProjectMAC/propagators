;;; Some propagator functions used in the test suite.

(define (fahrenheit->celsius f c)
  (let-cells (thirty-two f-32 five c*9 nine)
    ((constant 32) thirty-two)
    ((constant 5) five)
    ((constant 9) nine)
    (subtractor f thirty-two f-32)
    (multiplier f-32 five c*9)
    (divider c*9 nine c)))

(define (sum x y total)
  (adder x y total)
  (subtractor total x y)
  (subtractor total y x))

(define (product x y total)
  (multiplier x y total)
  (divider total x y)
  (divider total y x))

(define (quadratic x x^2)
  (squarer x x^2)
  (sqrter x^2 x))

(define (fahrenheit-celsius f c)
  (let-cells (thirty-two f-32 five c*9 nine)
    ((constant 32) thirty-two)
    ((constant 5) five)
    ((constant 9) nine)
    (sum thirty-two f-32 f)
    (product f-32 five c*9)
    (product c nine c*9)))

(define (celsius-kelvin c k)
  (let-cells (many)
    ((constant 273.15) many)
    (sum c many k)))

(define (fall-duration t h)
  (let-cells (g one-half t^2 gt^2)
    ((constant (make-interval 9.789 9.832)) g)
    ((constant (make-interval 1/2 1/2)) one-half)
    (quadratic t t^2)
    (product g t^2 gt^2)
    (product one-half gt^2 h)))

(define (similar-triangles s-ba h-ba s h)
  (let-cells (ratio)
    (product s-ba ratio h-ba)
    (product s ratio h)))

(define (heron-step x g h)
  (compound-propagator (list x g)       ; inputs
    (lambda ()                          ; how to build
      (let-cells (x/g g+x/g two)
        (divider x g x/g)
        (adder g x/g g+x/g)
        ((constant 2) two)
        (divider g+x/g two h)))))

(define (sqrt-iter x g answer)
  (compound-propagator (list x g)
    (lambda ()
      (let-cells (done x-if-not-done g-if-done g-if-not-done
		       new-g recursive-answer)
        (good-enuf? x g done)
        (conditional-writer done x (make-cell) x-if-not-done)
        (conditional-writer done g g-if-done g-if-not-done)
        (heron-step x-if-not-done g-if-not-done new-g)
        (sqrt-iter x-if-not-done new-g recursive-answer)
        (conditional done g-if-done recursive-answer answer)))))

(define (sqrt-network x answer)
  (compound-propagator x
    (lambda ()
      (let-cells (one)
        ((constant 1.0) one)
        (sqrt-iter x one answer)))))

(define (good-enuf? x g done)
  (compound-propagator (list x g)
    (lambda ()
      (let-cells (g^2 eps x-g^2 ax-g^2)
        ((constant .00000001) eps)
        (multiplier g g g^2)
        (subtractor x g^2 x-g^2)
        (absolute-value x-g^2 ax-g^2)
        (<? ax-g^2 eps done)))))
