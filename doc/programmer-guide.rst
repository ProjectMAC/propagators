======================================================================
		     Programming with Propagators
======================================================================

Scheme-Propagators, pending a better name, is a prototype
propagator-oriented programming language embedded in Scheme.
Scheme-Propagators is also the name of the only extant implementation.
The purpose of this document is to teach you how to write and run
propagator programs in Scheme-Propagators for fun and profit.

Propagator-orientation is a new programming paradigm under development
by Alexey Radul and Gerald Jay Sussman at the Massachusetts Institute
of Technology, with the support of the Mind Machine Project of same.
Scheme-Propagators is the most advanced programming language built
from the ground up to support the propagator-oriented paradigm, and is
being codeveloped with the paradigm itself by Alexey Radul and Gerald
Jay Sussman.

The propagator-orientation paradigm offers

- easy and natural non-sequential programming
- freedom from unnecessary worries about flow of control
- modular non-hierarchical composition of peer systems
  without imposing extraneous command structures
- easy and natural concurrent and distributed programming
- support for and unification of existing programming paradigms:

  - functional
  - object-oriented
  - constraint programming
  - logic programming

For more discusion of the paradigm and its benefits, please peruse the
`Art of the Propagator`_ paper or the `Propagation Networks`_ PhD
thesis; but that is now enough advertising.  You are presumably here
because you are already impressed, and want to start trying it out,
rather than to be even more convinced.

.. _`Art of the Propagator`: http://dspace.mit.edu/handle/1721.1/44215
.. _`Propagation Networks`: http://dspace.mit.edu/handle/1721.1/49525

Getting Started
======================================================================

Scheme-Propagators is implemented in `MIT/GNU Scheme`_, which you will
need in order to use it.  Start up your Scheme and load the main entry
file with ``(load "load")``.  This gives you a read-eval-print loop
(traditionally called a REPL for short) for both the
Scheme-Propagators system and the underlying Scheme implementation.
Check out the README for more on this.

.. _`MIT/GNU Scheme`: http://www.gnu.org/software/mit-scheme/

Once you've got your REPL, you can start typing away at it to create
propagator networks, give them inputs, ask them to do computations,
and look at the results.

Here's a little propagator example that adds two and three to get
five::

  (define-cell a)
  (define-cell b)
  (add-content a 3)
  (add-content b 2)
  (define-cell answer (e:+ a b))
  (run)
  (content answer) ==> 5

Each of the parenthesized phrases above are things to type into
the REPL, and the ``==> 5`` at the end is the result that Scheme
will print.  I omitted the results of all the other expressions
because they are not interesting.

Let's have a closer look at what's going on in this example,
to serve as a guide for more in-depth discussion later.
``define-cell`` is a Scheme macro for making and naming propagator
cells.::

  (define-cell a)

creates a new cell and binds it to the Scheme variable ``a``.::

  (define-cell b)

makes another one.  Then ``add-content`` is a Scheme procedure
that lets you directly zap some information into a propagator
cell.  So::

  (add-content a 3)

puts a ``3`` into the cell named ``a``, and::

  (add-content b 2)

puts a ``2`` into the cell named ``b``.  Now ``e:+`` (I'll explain
that naming convention later) is a Scheme procedure that creates
a propagator that adds, attaches it to the given cells as inputs,
and makes a cell to hold the adder's output and returns it.  So::

  (define-cell answer (e:+ a b))

creates an adding propagator, and also creates a cell, now called
``answer``, to hold the result of the addition.  Be careful!  No
computation has happened yet.  You've just made up a network, but it
hasn't done its work yet.  That's what the Scheme procedure ``run`` is
for.::

  (run)

actually executes the network, and only when the network is done
computing does it give you back the REPL to interact with.  Finally
``content`` is a Scheme procedure that gets the content of cells::

  (content answer)

looks at what the cell named ``answer`` has now, which is ``5``
because the addition propagator created by ``e:+`` has had a chance to
do its job.  If you had forgotted to type ``(run)`` before typing
``(content answer)``, it would have printed out ``#(*the-nothing*)``,
which means that cell has no information about the value it is meant
to have.

Making Propagator Networks
======================================================================

The "read and syntax" phase of the Scheme-Propagators is the "read and
eval" phase of the host Scheme; with the understanding that all Scheme
variables that get bound to cells are propagator variables, and all
Scheme variables that get bound to other Scheme objects are "syntax"
from the perspective of Scheme-Propagators.

Scheme-Propagators therefore has a "macro system" that is much more
developed than the propagator language itself, because MIT/GNU Scheme
is a full programming language that has been around for decades, while
Scheme-Propagators is a prototype whose name hasn't even stabilized
yet.  Thus these "macros" are still needed for many purposes.  Perhaps
the most egregious example is the predefined procedures: in Scheme,
``+`` is a variable that's bound to a procedure, whereas in
Scheme-Propagators, the corresponding object ``e:+`` is a piece of
syntax (that is, the Scheme variable ``e:+`` is not bound to a cell
that holds a propagator abstraction that adds, and therefore is not a
variable of Scheme-Propagators, but is rather bound to a Scheme
procedure that directly makes a propagator that adds, and therefore is
Scheme-Propagators syntax.  More on this below).

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


Mention: initialize-scheduler
