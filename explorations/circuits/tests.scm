;;; ----------------------------------------------------------------------
;;; Copyright 2010 Alexey Radul and Gerald Jay Sussman
;;; ----------------------------------------------------------------------
;;; This file is part of Propagator Network Prototype.
;;; 
;;; Propagator Network Prototype is free software; you can redistribute it and/or modify
;;; it under the terms of the GNU General Public License as published by
;;; the Free Software Foundation, either version 3 of the License, or
;;; (at your option) any later version.
;;; 
;;; Propagator Network Prototype is distributed in the hope that it will be useful,
;;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;; GNU General Public License for more details.
;;; 
;;; You should have received a copy of the GNU General Public License
;;; along with Propagator Network Prototype.  If not, see <http://www.gnu.org/licenses/>.
;;; ----------------------------------------------------------------------

(in-test-group
 circuits

 (define-each-check
   (generic-match
    #(layered ((bias . 0)) 0)
    (merge 0 (make-layered `((bias . ,nothing)))))
   (generic-match
    #(layered ((incremental . 0) (bias . 0)) 0)
    (merge (merge 0 (make-layered `((bias . ,nothing))))
	   (make-layered `((incremental . ,nothing)))))
   (generic-match
    #(layered ((incremental . 0) (bias . 0)) 0)
    (merge 0 (merge (make-layered `((bias . ,nothing)))
		    (make-layered `((incremental . ,nothing))))))
   )

 (define-test (simple-resistor)
   (interaction
    (initialize-scheduler)
    (define-cell test (resistor-circuit))
    (define-cell answer (the current R test))
    (run)

    (content answer)
    (produces 2)			; Doesn't depend on KCL!

    (define-cell source-current (the current V test))
    (run)

    (content source-current)
    (produces #(tms (#(supported -2 (#(kcl-premise n1))))))
    ))

 (define-test (true-voltage-divider)
   (interaction
    (initialize-scheduler)
    (define-cell test (voltage-divider-circuit))
    (define-cell answer (the potential n2 test))
    (run)

    (content answer)
    (produces #(*the-nothing*))

    (voltage-divider-slice (the R1 test) (the n2 test) (the R2 test))
    (run)
    (content answer)
    (produces #(tms (#(supported 4 (#(hypothetical)))))))
   )

 (define-test (approximate-voltage-divider)
   (interaction
    (initialize-scheduler)
    (define-cell test (voltage-divider-circuit-2))
    (define-cell answer (the potential n2 test))
    (run)

    (content answer)
    (produces #(*the-nothing*))

    (voltage-divider-slice (the R1 test) (the n2 test) (the R2 test))
    (run)
    (content answer)
    (produces #(tms (#(supported 4 (#(hypothetical))))))

    (define-cell load-current (the current load test))
    (run)
    (content load-current) #;
    (produces #(tms (#(supported 1/250 (#(hypothetical))))))
    ;; This answer actually depends on the propagator firing order,
    ;; because the voltage divider slice is in fact contradictory (but
    ;; the contradiction may not be detected until after this answer
    ;; is deduced.)
    ))

 (define-test (resistor-bias-model)
   (interaction
    (initialize-scheduler)
    (define-cell test (resistor-circuit-2))
    (define-cell answer (the current R test))
    (run)

    (content answer)
    (produces 
     #(layered (bias . #(tms (#(supported 2 ()))))
	       (incremental . #(tms (#(supported 0 ()))))))

    (define-cell source-current (the current V test))
    (run)

    (content source-current)
    (produces
     #(layered (bias . #(tms (#(supported -2 (#(kcl-premise n1))))))
	       (incremental . #(tms (#(supported 0 (#(kcl-premise n1))))))))
    ))

 (define-test (ce-amp-1)
   (interaction
    (initialize-scheduler)
    (define-cell test (breadboard))

    (add-content (the resistance Rb1 amp test) 51000)
    (add-content (the resistance Rb2 amp test) 10000)
    (add-content (the resistance Re amp test) 1000)
    (add-content (the capacitance Cin amp test) 10e-6)
    (add-content (the capacitance Cout amp test) 10e-6)
    
    (define-cell Rc-resistance (the resistance Rc amp test))
    (add-content Rc-resistance 5000)

    (define-cell gain (the gain amp test))
    #; (add-content gain 5)

    (add-content (the strength VCC test) 15)
    (add-content (the strength vin test) 1/10)

    (define-cell output (the voltage vout test))
    (define-cell Q-power (the power Q amp test))
    
;;     (run)

;;     (content gain)
;;     (produces #(layered (incremental . #(tms (#(supported 5 ()))))
;; 			(bias . 5)))

;;     (content output)
;;     (produces
;;      #(layered (bias . #(*the-nothing*))
;; 	       (incremental
;; 		. #(tms (#(supported -1/2
;; 			   (#(kcl-premise out)
;; 			    #(kcl-premise en)
;; 			    #(kcl-premise cn))))))))
;;     (content Q-power)
;;     (produces 
;;      #(layered (bias . #(*the-nothing*))
;; 	       (incremental
;; 		. #(tms (#(supported -3/50000
;; 			   (#(kcl-premise out)
;; 			    #(kcl-premise en)
;; 			    #(kcl-premise cn))))))))

    ;; The slice can be added either inside the circuit or
    ;; after the fact like this
    #;
    (define-cell slice 
      (bias-voltage-divider-slice
       (the Rb1 amp test) (the bn amp test) (the Rb2 amp test)))
    (run)

    (content output)
    (produces
     #(layered (bias . #(*the-nothing*))
	       (incremental
		. #(tms (#(supported -1/2
			   (#(kcl-premise out)
			    #(kcl-premise en)
			    #(kcl-premise cn))))))))
    (content Q-power)
    (produces 
     #(layered (bias
		. #(tms (#(supported 7.149594195108842e-3
                           (#(kcl-premise en)
			    #(hypothetical)
			    #(kcl-premise cn))))))
	       (incremental
		. #(tms (#(supported -3/50000
			   (#(kcl-premise out)
			    #(kcl-premise en)
			    #(kcl-premise cn))))))))
    #; (length (all-propagators))
    #; (produces 994)
    ))
 )
