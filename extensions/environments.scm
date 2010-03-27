;;; ----------------------------------------------------------------------
;;; Copyright 2009-2010 Alexey Radul.
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

;;;; Fully-virtual environments.  See environments.tex.

(declare (usual-integrations))

;;;; Frames

;;; A frame tag is a record with an identity and a parent list.  The
;;; notion is that the information in a cell at a frame is the stuff
;;; computed directly in that frame, or anywhere up the chain of
;;; ancestors.  This is orthogonal to whether a frame can have
;;; multiple parents.
(define-structure
  (frame (constructor %make-frame) (safe-accessors #t))
  parents
  strict-ancestors)			; Cache the ancestor computation

(define (%compute-ancestors frames)
  (delete-duplicates (append-map frame-ancestors frames)))

(define (frame-ancestors frame)
  (cons frame (frame-strict-ancestors frame)))

(define (make-frame parents)
  (%make-frame parents (%compute-ancestors parents)))

;;;; Virtual Copy Sets

;;; A virtual copies set is a structure that associates frame tags
;;; (which for the nonce need only be assumed to be eq?-comparable)
;;; with information.
(define-structure
  (virtual-copies (safe-accessors #t))
  alist)

(define alist->virtual-copies make-virtual-copies)
(define virtual-copies->alist virtual-copies-alist)

(define (frame-binding copy-set frame)
  ;; TODO Of course, an alist is the worst possible data structure for
  ;; this purpose, but it's built-in and it's persistent.
  (assq frame (virtual-copies-alist copy-set)))

(define (occurring-frames copy-set)
  (map car (virtual-copies-alist copy-set)))

(define (occurring-frames* copy-sets)
  (delete-duplicates (append-map occurring-frames copy-sets)))

(define (frame-occurs? copy-set frame)
  (not (not (frame-binding copy-set frame))))

(define (direct-frame-content copy-set frame)
  (let ((occurrence (frame-binding copy-set frame)))
    (if occurrence
	(cdr occurrence)
	nothing)))

;;;; Frame & Copy-set Interactions

;;; The intention is that the full information content of a cell in a
;;; frame is the merge of all information available in that frame and
;;; all that frame's ancestors.  I can implement that intention
;;; directly per below; or I can use one-cell cross-frame propagators
;;; to maintain the invariant that the direct content in every frame
;;; stabilizes to be the same as the intended full content; or I can
;;; hatch some scheme whereby that intention is maintained in some
;;; implicit manner but not represented explicitly.  That's a choice.
(define (full-frame-content copy-set frame)
  (fold merge nothing
	(map (lambda (frame)
	       (direct-frame-content copy-set frame))
	     (frame-ancestors frame))))

(define (ancestral-occurrence-count copy-set frame)
  (count (lambda (frame)
	   (frame-occurs? copy-set frame))
	 (frame-ancestors frame)))

;; See environments.tex for the meaning of "acceptable".
(define (acceptable-frame? frame copy-sets)
  (apply boolean/and
   (map (lambda (copy-set)
	  (<= 1 (ancestral-occurrence-count copy-set frame)))
	copy-sets)))

;; See environments.tex for the meaning of "good".
(define (good-frame? frame copy-sets)
  (and (acceptable-frame? frame copy-sets)
       (not (apply boolean/or
	     (map (lambda (parent)
		    (acceptable-frame? parent copy-sets))
		  (frame-parents frame))))))

(define (good-frames copy-sets)
  ;; TODO I'm *certain* there's a more efficient way to do this
  (filter (lambda (frame)
	    (good-frame? frame copy-sets))
	  (occurring-frames* copy-sets)))

(define (lexical-invariant? copy-set)
  (apply boolean/and
   (map (lambda (frame)
	  (<= (ancestral-occurrence-count copy-set frame) 1))
	(occurring-frames copy-set))))

;; This operation, as named, depends on the lexical invariant above
;; holding good.
(define (the-occurring-parent frame copy-set)
  (find (lambda (parent)
	  (frame-occurs? copy-set parent))
	(frame-ancestors frame)))

;;;; Equating and merging virtual copy sets

(define (equivalent? info1 info2)
  (or (eq? info1 info2)			; Fast path...
      (and (implies? info1 info2)
	   (implies? info2 info1))))

(define (v-c-equal? copy-set1 copy-set2)
  (let ((the-frames (occurring-frames copy-set1)))
    (and (lset= eq? the-frames (occurring-frames copy-set2))
	 (apply boolean/and
		(map (lambda (frame)
		       (equivalent? (full-frame-content copy-set1 frame)
				    (full-frame-content copy-set2 frame)))
		     the-frames)))))

;; TODO This utility really belongs in the standard propagator
;; library...
(define (with-equality merge equal?)
  (lambda (item1 item2)
    (let ((answer (merge item1 item2)))
      (cond ((equal? answer item1) item1)
	    ((equal? answer item2) item2)
	    (else answer)))))

;;; This merge is OK if "normal" propagators use v-c-i/o-unpacking
;;; (below) for their operations.  Then they will respect the
;;; occurrence structure so the merge operation doesn't have to.
(define (virtual-copy-merge copy-set1 copy-set2)
  (define (frame-by-frame f)
    (lambda args
      (alist->virtual-copies
       (map (lambda (frame)
	      (cons frame (apply f (map (lambda (arg)
					  (full-frame-content arg frame))
					args))))
	    (occurring-frames* args)))))
  ((frame-by-frame merge) copy-set1 copy-set2))

(defhandler merge
  (with-equality virtual-copy-merge v-c-equal?)
  virtual-copies? virtual-copies?)

;;;; Propagator Machinery

;;; Doing virtual copies via the generic-unpack mechanism presents
;;; three problems.  First, imagine a binary operation with two
;;; virtual-copies arguments.  A direct implementation of
;;; virtual-copy-bind would evaluate that operation on all
;;; quadratically many combinations of pairs of frames, and then do
;;; something to only keep the pieces we had wanted.  That could get
;;; ugly.  Second, the unpacking mechanism below actually needs to
;;; look at all the neighbor cells in order to decide which sets of
;;; frames to operate on.  Third, if one goes through the standard
;;; unpack-flatten mechanism, then a binary operation working on a
;;; pair of virtual copies of TMSes of something will find itself
;;; trying to flatten a set of virtual copies of TMSes of virtual
;;; copies of TMSes of something.  Doing that correctly requires a
;;; mechanism to turn a TMS of virtual copies of X into a virtual
;;; copies of a TMS of X; but under the current regime (i.e. without
;;; knowing what type the final result is supposed to be) the
;;; existence of that mechanism will force all TMSes of virtual copies
;;; to become virtual copies of TMSes.  But what if I *want* to
;;; subject the frames to TMS premises in some region of the network?
;;; This is a very general problem.  Are monad transformers such
;;; conversion mechanisms?  Or do they prevent this issue from arising
;;; by some other means?  (Or are they completely unrelated?)  This
;;; whole mess is perhaps a function of not being able to look at what
;;; the client wants.
(define (v-c-i/o-unpacking f)
  (lambda args
    (let ((output (car (last-pair args)))
	  (inputs (except-last-pair args)))
      (alist->virtual-copies
       (map (lambda (frame)
	      (cons (the-occurring-parent frame output)
		    (apply f (map (lambda (copy-set)
				    (full-frame-content copy-set frame))
				  inputs))))
	    (good-frames args))))))

(define (i/o-function->propagator-constructor f)
  (lambda cells
    (let ((output (car (last-pair cells))))
      (propagator cells
	(lambda ()
	  (add-content output (apply f (map content cells))))))))

;; Now the version with the metadata
(define (i/o-function->propagator-constructor f)
  (lambda cells
    (let ((output (car (last-pair cells))))
      (propagator cells
	(eq-label!
	 (lambda ()
	   (add-content output (apply f (map content cells))))
	 ;; TODO Currently ok, because the last "input" is only used
	 ;; for virtualization
	 'inputs (except-last-pair cells)
	 'name f
	 'outputs (list output))))))

(define (doit f)
  (i/o-function->propagator-constructor
   (eq-put!
    (lambda args
      ;; TODO Generalize this to other information types
      (if (any nothing? args)
	  nothing
	  (apply (v-c-i/o-unpacking (nary-unpacking f)) args)))
    'name f)))

;;;; Propagators

(define vc:adder (doit generic-+))
(define vc:subtractor (doit generic--))
(define vc:multiplier (doit generic-*))
(define vc:divider (doit generic-/))

(define vc:absolute-value (doit generic-abs))
(define vc:squarer (doit generic-square))
(define vc:sqrter (doit generic-sqrt))
(define vc:=? (doit generic-=))
(define vc:<? (doit generic-<))
(define vc:>? (doit generic->))
(define vc:<=? (doit generic-<=))
(define vc:>=? (doit generic->=))

(define vc:inverter (doit generic-not))
(define vc:conjoiner (doit generic-and))
(define vc:disjoiner (doit generic-or))

(define (vc:const value)
  (doit (eq-put! (lambda () value) 'name (list 'const value))))
(define vc:switch (doit switch-function))

(define generic-quotient (make-generic-operator 2 'quotient quotient))
(eq-put! generic-quotient 'name 'quotient)
(define vc:quotient (doit generic-quotient))
(define generic-remainder (make-generic-operator 2 'remainder remainder))
(eq-put! generic-remainder 'name 'remainder)
(define vc:remainder (doit generic-remainder))

;;;; Frame Maps

(define-structure
  frame-map
  alist
  default-parents)

(define (frame-map-bind frame-map key1 key2)
  (make-frame-map
   (cons (cons key1 key2)
	 (frame-map-alist frame-map))
   (frame-map-default-parents frame-map)))

(define (frame-map-lookup frame-map key)
  (assq key (frame-map-alist frame-map)))

(define (frame-map-get frame-map key)
  (let ((binding (frame-map-lookup frame-map key)))
    (if binding
	(cdr binding)
	(error "Key not found" key frame-map))))

(define (mapping-available? frame-map key)
  (not (not (frame-map-lookup frame-map key))))

;;;; Equating and merging frame maps

(define (same-binding? bind1 bind2)
  (and (eq? (car bind1) (car bind2))
       (eq? (cdr bind1) (cdr bind2))))

(define (frame-map-merge map1 map2)
  (define (repeated-elt? lst)
    (not (lset= eq? lst (delete-duplicates lst))))
  (define (merge-bindings alist1 alist2)
    (let ((answer (lset-union same-binding? alist1 alist2)))
      (if (repeated-elt? (map car answer))
	  (error "Same frame mapped to different targets" map1 map2)
	  answer)))
  (make-frame-map
   (merge-bindings (frame-map-alist map1) (frame-map-alist map2))
   (delete-duplicates (append (frame-map-default-parents map1)
			      (frame-map-default-parents map2)))))

(define (f-m-equal? map1 map2)
  (and (lset= same-binding?
	      (frame-map-alist map1) (frame-map-alist map2))
       (lset= eq? (frame-map-default-parents map1)
	          (frame-map-default-parents map2))))

(defhandler merge
  (with-equality frame-map-merge f-m-equal?) frame-map? frame-map?)

;;;; Extending frame maps

(define (complete-frame-map copy-set frame-map)
  (let loop ((frame-map frame-map)
	     (frames (occurring-frames copy-set)))
    (if (null? frames)
	frame-map
	(ensure-mapping-available-for
	 frame-map (car frames)
	 (lambda (new-map) (loop new-map (cdr frames)))))))

(define (ensure-mapping-available-for frame-map key cont)
  (define (doit frame-map)
    (if (mapping-available? frame-map key)
	(cont frame-map)
	(cont (frame-map-bind
	       frame-map key (make-image-for frame-map key)))))
  (let loop ((frame-map frame-map)
	     (parents (frame-parents key)))
    (if (null? parents)
	(doit frame-map)
	(ensure-mapping-available-for
	 frame-map (car parents)
	 (lambda (new-map) (loop new-map (cdr parents)))))))

(define (make-image-for frame-map key)
  (make-frame
   (append
    ;; Do I really want the images of the parents of the current frame
    ;; to be parents of the image?  What if those parents do not have
    ;; images?  should I always create them?  Are there frames that
    ;; should not get images in called abstractions?  Or should not
    ;; always get fresh images?
    ;; Hm.  It seems that it's ok to make lots of images, provided I
    ;; am careful not to generate occurrences in the callee that
    ;; do not correspond to occurrences that exist in the caller.
    (map (lambda (parent)
	   (frame-map-get frame-map parent))
	 (frame-parents key))
    ;; If I could promise that all frames eventually topped out at
    ;; frames without incoming parents, then I could choose to attach
    ;; these only to such frames, instead of to all of them.
    (frame-map-default-parents frame-map))))

;;;; Call Sites

(define-structure
  closure
  inside
  interior
  default-parents)

;; TODO This still requires the closure to be known statically.
(define (call-site outside-cells closure)
  (let ((inside-cells (closure-inside closure))
	(interior-cells (closure-interior closure)))
    (if (not (= (length outside-cells)
		(length inside-cells)))
	(error "Differing boundary lengths" outside-cells inside-cells))
    (let ((frame-map (make-frame-map '() (closure-default-parents closure)))
	  (frame-map-cell (make-named-cell 'frame-map)))
      (add-content frame-map-cell frame-map)
      (interior-copier frame-map-cell outside-cells interior-cells)
      (map (lambda (outside-cell inside-cell)
	     (map-keeper outside-cell frame-map-cell)
	     (inward-transferrer frame-map-cell inside-cell outside-cell)
	     (outward-transferrer frame-map-cell inside-cell outside-cell))
	   outside-cells
	   inside-cells))))

(define (map-keeper outside frame-map-cell)
  (propagator outside
    (eq-label!
     (lambda ()
       (add-content frame-map-cell
         (complete-frame-map (content outside) (content frame-map-cell))))
     'name 'map-keeper
     'inputs (list outside)
     'outputs (list frame-map-cell))))

(define (interior-copier frame-map-cell outside interior)
  (propagator (cons frame-map-cell outside)
    (eq-label!
     (lambda ()
       (let ((answer (needed-interior-copies (content frame-map-cell)
					     (map content outside))))
	 (for-each (lambda (cell)
		     (add-content cell answer))
		   interior)))
     'name 'interior-copier
     'inputs (cons frame-map-cell outside)
     ;; I'm scared to write the outputs of this one, because it hits
     ;; the whole interior (and only with virtualization information)
     )))

(define (inward-transferrer frame-map-cell inside outside)
  (propagator (list frame-map-cell outside)
    (eq-label!
     (lambda ()
       (add-content inside
         (transfer-inward (content frame-map-cell) (content outside))))
     'name 'inward
     'inputs (list frame-map-cell outside)
     'outputs (list inside))))

(define (outward-transferrer frame-map-cell inside outside)
  (propagator (list frame-map-cell inside outside)
    (eq-label!
     (lambda ()
       (add-content outside
	 (transfer-outward
	  (content frame-map-cell) (content inside) (content outside))))
     'name 'outward
     'inputs (list frame-map-cell inside)
     'outputs (list outside))))

;;;; Actually migrating things across abstraction boundaries

;;; This treats the outside as the boss: new frames that appear on the
;;; outside generate new frame map entries, but new frames that appear
;;; on the inside do not.  Instead, the channels from the inside to
;;; the outside only transport things for which there already are
;;; frame map entries.  Perhaps this has something to do with the fact
;;; that the inside is by design shared by all call sites of a given
;;; abstraction, but each call site has a different outside.

(define (select-submap frame-map frames)
  (let* ((mapped-frames
	  (filter (lambda (frame)
		    (mapping-available? frame-map frame))
		  frames)))
    (map (lambda (frame)
	   (cons frame (frame-map-get frame-map frame)))
	 mapped-frames)))

(define (transfer-inward frame-map outside-copies)
  (if (or (nothing? frame-map) (nothing? outside-copies))
      nothing
      ;; This is careful about mappings
      (alist->virtual-copies
       (map (lambda (frame-pair)
	      (cons (cdr frame-pair)
		    ;; This can be direct-frame-content if all the
		    ;; parents of the inside frame are images of the
		    ;; frame map; but they may not be if stuff is
		    ;; known about the interior abstraction
		    ;; independently of its call sites.
		    ;; TODO In fact, this is the place where things that
		    ;; care about crossing abstraction boundaries might
		    ;; be checked.
		    (full-frame-content outside-copies (car frame-pair))))
	    (select-submap frame-map (occurring-frames outside-copies))))))

(define (transfer-outward frame-map inside-copies outside-copies)
  (if (or (nothing? frame-map)
	  (nothing? inside-copies) (nothing? outside-copies))
      nothing
      ;; This is very careful about occurrences
      (let* ((exterior-bindings
	      (select-submap frame-map (occurring-frames outside-copies)))
	     (bindings
	      (filter
	       (lambda (frame-pair)
		 (frame-occurs? inside-copies (cdr frame-pair)))
	       exterior-bindings)))
	(alist->virtual-copies
	 (map (lambda (frame-pair)
		(cons (car frame-pair)
		      ;; direct- vs full- here as above
		      (full-frame-content inside-copies (cdr frame-pair))))
	      bindings)))))

(define (needed-interior-copies frame-map outside-vcs)
  (if (or (nothing? frame-map) (any nothing? outside-vcs))
      nothing
      (let ((right-frames 
	     (filter
	      (lambda (frame)
		;; TODO Maybe the inside-transferrer needs to do
		;; something like this too, to avoid creating copies
		;; when all inputs are nothing.
		(not (every nothing?
			    (map (lambda (vcs)
				   ;; TODO direct- or full-?
				   (direct-frame-content vcs frame))
				 outside-vcs))))
	      (good-frames outside-vcs))))
	(alist->virtual-copies
	 (map (lambda (frame)
		(cons frame nothing))
	      (map cdr (select-submap frame-map right-frames)))))))
