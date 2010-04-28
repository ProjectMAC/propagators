======================================================================
		     Programming with Propagators
======================================================================


Making Propagator Networks
======================================================================

The "read and macroexpand" phase of the propagator
system is the "read and eval" phase of the host Scheme;
with the understanding that all Scheme variables that
get bound to cells are propagator variables, and
all Scheme variables that get bound to other Scheme objects
are "macros" from the perspective of the propagator
system.

This "macro system" is therefore much more developed than the
propagator language itself, so such "macros" are still needed for many
purposes.  Perhaps the most egregious example is the predefined
procedures: in Scheme, + is a variable that's bound to a procedure,
whereas in the propagator system, the corresponding object p:+ is a
piece of syntax (that is, p:+ is not a cell that holds a propagator
abstraction that adds, but is a Scheme procedure that directly makes
such a propagator.  More on this below).

let-cell
let-cells

p: style things are Scheme procedures that attach a propagator
to a bunch of given cells.  "Attach a propagator" means
create a Scheme thunk to do that job; notify the scheduler
about that thunk; and teach the given cells to reawaken that
propagator-thunk when they get new information.

Convention: the "return value" of the job done by a p: thing
goes into the last supplied argument cell.

e: things return cells
e: stuff is Scheme procedures.  They will make one cell
to return; they will convert non-cell arguments to cells
with corresponding constant propagtors staring at them;
and they will attach corresponding p: things to the
given cells.  The cell receiving the output of the
underlying job is the cell made and returned

c: are multidirectional constraint versions of p:
ce: ditto e:

(e: foo bar)  ==  (e: foo bar %%)

(e: foo %% bar)  ==>  (let-cell new (p: foo new bar) new)


Making New Compound Propagators
======================================================================


Making New Primitive Propagators
======================================================================

(Almost) All the p:, e:, c:, and ce: are defined in
extensions/expression-language.scm

Also the propagatify macro makes more of them
(propagatify eq?)
defines
p:eq? and e:eq?


Making New Partial Information Types
======================================================================

- Making cells deal with them
- Making existing propagators support them


Debugging
======================================================================

The metadata that gets tracked
How to make sure that your network tracks it well
How to draw pictures
How to wander around using the metadata
