Goal
----------------------------------------------------------------------

Modern programming systems are not expressive enough. The traditional
image of a single computer that has global effects on a large memory
is too restrictive.  The propagation paradigm replaces this with
computing by networks of local, independent, stateless machines
interconnected with stateful storage cells.  In so doing, it offers
great flexibility and expressive power:

- disentanglement of flow of data from flow of control
- modular non-hierarchical composition of peer systems
  without imposing extraneous command structures
- easy and natural concurrent and distributed programming
- support for and unification of existing programming paradigms:

  - functional
  - object-oriented
  - constraint programming
  - logic programming

We are pushing the frontiers of expressivity and flexibility in
programming systems by developing a prototype propagation-oriented
programming language, writing new kinds of programs in it, and
studying what it takes to develop the paradigm for use for artificial
intelligence and general programming.

People
----------------------------------------------------------------------

...

Vision
----------------------------------------------------------------------

First of all and most of all, propagators are way to explore new
frontiers of the expressivity of programming languages.  We believe
that many of the breakthroughs in computing and artificial intelligence
are built on
advances in the expressivity of their underlying languages.  In
particular, propagators allow us to explore what happens when we
separate control dependencies from data dependencies. They also allow
us to combine multiple constraint-like paradigms on a common
substrate, so that many special-purpose hacks along this vein can be
seen to be all variations on one theme. It is possible that in much
the same way that functional programming increases a programmer's
power by inducing a style that keeps mutation to a minimum and forces
the programmer to keep track of those extraordinary circumstances when
mutable state is absolutely necessary, propagators may induce a style
that keeps data dependencies local and separate from control
dependencies, and forces the programmer to keep track of those
extraordinary circumstances when non-local dependencies and the
interference of the chosen control algorithm are absolutely
necessary. This kind of "forced mindfulness" about mutation or
dependency might seem like a burden at first to a new programmer, but
in the long run it allows him to control the effects of the "dangerous
elements" of the language -- and so increases his power. For example,
it is possible that the natural style of "propagator-oriented
programming" may enable compilers of the language to target multiple
architectures, including parallel ones, because they have been freed
from the constraints imposed by accidental control dependencies and
similarly accidental non-locality, while still having careful
instructions about the essential dependencies in the problem.  In this
day and age of fabulously smart compilers and hardware designers, a
language that allows a programmer to tell a compiler the true essence
of their intentions, while leaving to the discretion of the machine all
non-essential choices, is one that might unlock hidden power,
currently suffocated by out-of-date computing models.

Secondly, propagators could become a substrate to investigate various
as-yet unimplemented visions of Artificial Intelligence. The natural
multi-directionality of propagators allows a system to "learn from its
mistakes" -- to reverse a computation which failed, carrying with it
information about the nature of the failure. It may allow for
"controlled hallucination," the ability to see or hear something
because we already have some idea of what we are expecting to see or
hear -- an ability key to
understanding how humans can so dramatically outperform machines in
vision or speech understanding. Propagators may allow for a
layered system of "reactive critics," in which a higher layer of
"critics" observe and control the processing that happens in lower
layers. In the same way that a propagator language might make life
easier for a compiler that is trying to translate the problem to a
lower level of abstraction, it might also make life easier for a
"critic" that is trying to view the computation at a higher level of
abstraction. The elimination of inessential dependencies and the
"forced mindfulness" induced in the programmer facilitate both
goals. This underlines the importance of language expressivity as the
foundation of all other advances.
