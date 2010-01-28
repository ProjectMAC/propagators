;;; This is Baker, Cooper, Fletcher, Miller and Smith
;;; with all the metadata necessary to draw a (somewhat) decent
;;; picture of their graph with prop:dot:show-graph

(define (one-of values output-cell)
  (let ((cells
         (map (lambda (value)
                (let-cells (cell)
                  ((constant value) cell)
                  cell))
              values)))
    (one-of-the-cells cells output-cell)))

(define (one-of-the-cells input-cells output-cell)
  (cond ((= (length input-cells) 2)
         (let-cells (p)
           (conditional p
             (car input-cells) (cadr input-cells)
             output-cell)
           (binary-amb p)))
        ((> (length input-cells) 2)
         (let-cells (link p)
           (one-of-the-cells (cdr input-cells) link)
           (conditional
            p (car input-cells) link output-cell)
           (binary-amb p)))
        (else
         (error "Inadequate choices for one-of-the-cells"
                input-cells output-cell))))

(define (multiple-dwelling)
  (let ((floors '(1 2 3 4 5)))
    (let-cells (baker cooper fletcher miller smith
		      b=5 c=1 f=5 f=1 m>c sf fc one five s-f as-f f-c af-c)
     (one-of floors baker)       (one-of floors cooper)
     (one-of floors fletcher)    (one-of floors miller)
     (one-of floors smith)
     (require-distinct
      (list baker cooper fletcher miller smith))
     ((constant 1) one)        ((constant 5) five)
     (=? five baker b=5)       (forbid b=5)
     (=? one cooper c=1)       (forbid c=1)
     (=? five fletcher f=5)    (forbid f=5)
     (=? one fletcher f=1)     (forbid f=1)
     (>? miller cooper m>c)    (require m>c)
     (subtractor smith fletcher s-f)
     (absolute-value s-f as-f)
     (=? one as-f sf)          (forbid sf)
     (subtractor fletcher cooper f-c)
     (absolute-value f-c af-c)
     (=? one af-c fc)          (forbid fc)
     (list baker cooper fletcher miller smith))))
