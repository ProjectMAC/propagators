;;; This is Baker, Cooper, Fletcher, Miller and Smith
;;; with all the metadata necessary to draw a (somewhat) decent
;;; picture of their graph with prop:dot:show-graph

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
