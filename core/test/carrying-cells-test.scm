;;; ----------------------------------------------------------------------
;;; Copyright 2010 Alexey Radul and Gerald Jay Sussman
;;; ----------------------------------------------------------------------
;;; This file is part of Propagator Network Prototype.
;;; 
;;; Propagator Network Prototype is free software; you can
;;; redistribute it and/or modify it under the terms of the GNU
;;; General Public License as published by the Free Software
;;; Foundation, either version 3 of the License, or (at your option)
;;; any later version.
;;; 
;;; Propagator Network Prototype is distributed in the hope that it
;;; will be useful, but WITHOUT ANY WARRANTY; without even the implied
;;; warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
;;; See the GNU General Public License for more details.
;;; 
;;; You should have received a copy of the GNU General Public License
;;; along with Propagator Network Prototype.  If not, see
;;; <http://www.gnu.org/licenses/>.
;;; ----------------------------------------------------------------------

(in-test-group
 carrying-cells
 (define-test (smoke)
   (interaction
    (initialize-scheduler)
    (define-cell bill (make-tms (supported 3 '(bill))))
    (define-cell bill-cons (e:carry-cons nothing bill))
    (define-cell answer)
    (c:== bill-cons answer)
    (define-cell fred (make-tms (supported 4 '(fred))))
    (define-cell fred-cons (e:carry-cons fred nothing))
    (define-cell george (make-tms (supported #t '(george))))
    (conditional-wire george fred-cons answer)
    (define-cell the-pair? (e:carry-pair? answer))
    (define-cell the-car (e:carry-car answer))
    (define-cell the-cdr (e:carry-cdr answer))
    (run)
    ; (pp (content answer))
    (content the-pair?)
    (produces #t)
    (content the-car)
    (produces #(tms (#(supported 4 (fred george)))))
    (content the-cdr)
    (produces #(tms (#(supported 3 (bill)))))))

 ;; This test exercises the following situation: v&s-merge is merging
 ;; v&s1 and v&s2, where the value of v&s1 is more informative than
 ;; the value of v&s2 when viewed unconditionally; but if one
 ;; conditions on the premises in the support of v&s1, then the values
 ;; actually are equivalent.  Further, the support of v&s2 is more
 ;; informative than the support of v&s1, containing fewer premises.
 ;; Furthermore, it is true (but possibly not relevant) that merging
 ;; the values of v&s1 and v&s2 produces whichever is given first
 ;; (because they are cells) together with an effect which becomes
 ;; redundant when conditioned on the union of the supports of v&s1
 ;; and v&s2 (and is duly filtered out).

 ;; In this situation, v&s-merge returns v&s1 because its value is
 ;; unconditionally more informative than the value of v&s2; but
 ;; arguably it should return v&s2.  Logically, the situation looks
 ;; something like this:
 ;;   A -> () -> X  merge  () -> A -> X
 ;; which probably ought to emit () -> A -> X.  The analogy is not
 ;; quite right, because the X's are not actually the same, being
 ;; merged cells.
 (define-test (cell-in-v&s)
   (interaction
    (define-cell four 4)
    (define-cell george-four (supported 4 '(george)))
    (execute-effect
     (make-cell-join-effect
      four
      george-four
      (make-tms (supported #t '(george)))))
    (define v&s1 (supported four '(george)))
    (define v&s2 (supported george-four '()))
    ;; Given the way four and george-four are connected, v&s2 is
    ;; strictly more informative, so merging the twain should produce
    ;; it.
    (merge v&s1 v&s2)
    (produces v&s2)))

 (define-test (early-access-test)
   (interaction
    (initialize-scheduler)
    (define-cell source-car)
    (define-cell source-cdr)
    (define-cell the-pair (e:carry-cons source-car source-cdr))
    (check (eq? source-car (e:carry-car the-pair)))
    (check (eq? source-cdr (e:carry-cdr the-pair)))
    ))

 (define-test (deposit)
   (interaction
    (initialize-scheduler)
    (define-cell two-cell (e:deposit 2))
    (run)
    (check (cell? two-cell))
    (check (cell? (content two-cell)))
    (content (content two-cell))
    (produces 2)
    (define-cell examined (e:examine two-cell))
    (content examined)
    (produces 2)))

 (define-test (examine)
   (interaction
    (initialize-scheduler)
    (define-cell examinee)
    (define-cell exam (e:examine examinee))
    (add-content exam 2)
    (run)
    (check (cell? (content examinee)))
    (content (content examinee))
    (produces 2)))
 )
