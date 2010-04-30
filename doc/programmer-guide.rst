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

The "read and syntax" phase of Scheme-Propagators is the "read and
eval" phase of the host Scheme; with the understanding that all Scheme
variables that get bound to cells are propagator variables, and all
Scheme variables that get bound to other Scheme objects are "syntax"
from the perspective of Scheme-Propagators.  Things that can live in
cells are the first-class entities of Scheme-Propagators, and other
things from the host Scheme are second-class as far as the
Scheme-Propagators langauge is concerned.

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

Attaching Basic Propagators: p:foo and e:foo
----------------------------------------------------------------------

The two basic operations when making a propagator network are making
cells and attaching propagators to cells.  You already met one way to
make cells in the form of ``define-cell``; we will talk about more
later.  You attach propagators to cells by calling an appropriate
Scheme procedure that does that.  For example, the procedure ``p:+`` attaches
an adding propagator::

  (p:+ foo bar baz)

means attach a propagator that will add the contents of ``foo`` and
``bar`` and write them into ``baz``.  This means that henceforth,
whenever ``foo`` or ``bar`` gets any new interesting information,
the appropriate sum will eventually get computed and written into
``baz``.

Note that this ``p:+`` is different from the ``e:+`` in the example at
the beginning.  This is a general naming convention.  ``p:`` stands
for "propagator".  A thing named ``p:foo`` is a Scheme procedure
(therefore Scheme-Propagators syntax) that attaches a propagator that
does the ``foo`` job to a full collection of cells, one for each input
to ``foo`` and one for the output from ``foo``.  The output cells
conventionally go last (though I am open to changing that).  In
principle the ``p:`` convention will work just as well for jobs that
have multiple outputs, but I don't actually have any of those in the
system at present.

In contrast, ``e:`` stands for "expression".  A thing named ``e:foo``
is a Scheme procedure (so Scheme-Propagators syntax) just like
``p:foo``, except that it makes a fresh cell for the output and
returns it (whereas ``p:foo`` does not return anything useful).  Here
are two different ways to write the same thing::

  (define-cell x)
  (define-cell y)
  (define-cell z)
  (p:* x y z)

and::

  (define-cell x)
  (define-cell y)
  (define-cell z (e:* x y))

Generally the ``e:`` procedures are much more convenient to use most
of the time, when some propagator is the only one that writes to its
output; and you can chain them in the familiar way

::

  (e:- w (e:* (e:+ x y) z))

but when you need to make a propagator that writes to a cell you
already have, such as when multiple propagators need to write to the
same cell, you need the ``p:`` versions.  For example, if you wanted
to be able to go back from ``z`` and one of ``x`` or ``y`` to the
other, rather than just from ``x`` and ``y`` to ``z``, you could write::

  (define-cell x)
  (define-cell y)
  (define-cell z (e:* x y))
  (p:/ z x y)
  (p:/ z y x)

and get a multidirectional constraint::

  (add-content z 6)
  (add-content x 3)
  (run)
  (content y) ==> 2

Attaching Propagator Constraints: c:foo and ce:foo
----------------------------------------------------------------------

Speaking of constraints, they are so useful that many are predefined,
and they have their own naming convention.  ``c:`` stands for
"constraining".  A thing named ``c:foo`` is the constraining analogue
of ``p:foo``, in that in addition to attaching a propagator that does
``foo`` to its cells, it also attaches ``foo-inverse`` propagators
that deduce "inputs" from "outputs".  For example, the product
constraint that we built in the previous section is available as
``c:*``::

  (define-cell x)
  (define-cell y)
  (define-cell z)
  (c:* x y z)

  (add-content z 12)
  (add-content y 4)
  (run)
  (content x) ==> 3
  
The ``c:`` procedures also have expression versions:::

  (define-cell x)
  (define-cell y)
  (define-cell z (ce:* x y))

``ce:foo`` is to ``c:foo`` as ``e:foo`` is to ``p:foo``.

Of course, not every operation has a useful inverse, so there are
fewer ``c:`` procedures defined than ``p:``.  For the complete list see TODO.

Constants and Literal Values
----------------------------------------------------------------------

Programs have embedded constants all the time, and propagator programs
are no different (except that constant values, like all other values,
can be partial; see below).  We've already seen one way to put a
Scheme value into a propagator program: the ``add-content`` procedure
zaps a value straight into a cell.  This is generally encouraged at
the REPL, but frowned upon in actual programs.  It is much nicer (in
my current opinion) to use ``constant`` or ``p:constant`` (they're the
same) to make a propagator that will zap your value into your cell for
you::

  (define-cell thing)
  ((constant 5) thing)
  (content thing) ==> #(*the-nothing*)
  (run)
  (content thing) ==> 5

There is also an expression-oriented version, called, naturally,
``e:constant``::

  (define-cell thing (e:constant 5))
  (run)
  (content thing) ==> 5

In fact, inserting constants is so important, that there is one more
nicification of this: all the ``e:`` and ``ce:`` procedures will
automatically convert any non-cell Scheme value that they get as
arguments into a cell, using ``e:constant`` to zap that value in
there.  For example::

  (define-cell x)
  (define-cell y (e:+ x 2))

is the same as

::

  (define-cell x)
  (define-cell y (e:+ x (e:constant 2)))

TODO: A near-term plan of mine is to extend this feature to other
aspects of the propagator language, namely to the ``p:`` and ``c:``
procedures, and to ``define-cell``, ``let-cells``, and all other
places where it belongs.  But for the time being, only ``e:foo`` and
``ce:foo`` understand raw non-cell Scheme values as constants.

Implicit Cell Syntax
----------------------------------------------------------------------

Before we move on, there is one more quirky little feature, called
``%%``.  This is a Scheme object, therefore Scheme-Propagators syntax,
for controlling the argument position of the implicit cell that an
``e:`` or ``ce:`` procedure will make and return.  Perhaps examples
are best::

  (e: foo bar)     <==>  (e: foo bar %%)

  (e: foo %% bar)  <==>  (let-cell new (p: foo new bar) new)

I borrowed this idea from Guy Steele's PhD thesis on constraint
languages, and was a year between when I implemented it and
when I first used it.  The use case I do have is when I
want to make a new cell participate in an input position
in a constraint with some existing cells::

  (define-cell x)
  (define-cell z)
  (define-cell y (ce:+ x %% z))
  (add-content x 5)
  (add-content y 3)
  (run)
  (content z) ==> 8

Perhaps this use case could also be served by adding more
expression-style constraint procedures (namely ``ce:-``, which I do
not currently have), but then again maybe it's elegant.

Making Cells
----------------------------------------------------------------------

let-cell
let-cells



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

Using Partial Information
======================================================================

Making New Kinds of Partial Information
======================================================================

- Making cells deal with them
- Making existing propagators support them


Debugging
======================================================================

The metadata that gets tracked
How to make sure that your network tracks it well
How to draw pictures
How to wander around using the metadata

Advanced Features
======================================================================

Provenance tracking
Truth maintenance
Search (binary-amb)

Mention: initialize-scheduler

TODO Where do I have a reference of available propagator constructors?


"Attach a propagator" means
create a Scheme thunk to do that job; notify the scheduler
about that thunk; and teach the given cells to reawaken that
propagator-thunk when they get new information.

