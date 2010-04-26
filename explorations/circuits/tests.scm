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

 (define-test (simple-resistor)
   (interaction
    (initialize-scheduler)
    (define-cell test (resistor-circuit))
    (define-cell answer (the current R test))
    (run)

    (content answer)
    (produces #(tms (#(supported 2 ())))) ; Doesn't depend on KCL!

    (define-cell source-current (the current V test))
    (run)

    (content source-current)
    (produces #(tms (#(supported -2 (#(node-premise n2)))
		     #(supported -2 (#(node-premise n1))))))
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
    (content load-current)
    (produces #(tms (#(supported 1/250 (#(hypothetical))))))
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
     #(layered (bias . #(tms (#(supported -2 (#(node-premise n2)))
			      #(supported -2 (#(node-premise n1))))))
	       (incremental . #(tms (#(supported 0 (#(node-premise n2)))
				     #(supported 0 (#(node-premise n1))))))))
    ))
 )
