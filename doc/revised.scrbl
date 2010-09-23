#lang scribble/base

@title{Revised Report on the Propagator Model}
@author{Alexey Radul and Gerald Jay Sussman}


\begin{abstract}
In the past year we have made serious progress
on elaborating the propagator programming model
\cite{art-thesis, art}.  Things have gotten serious enough to
build a system that can be used for real
experiments.
\end{abstract}

The most important problem facing a programmer is the revision
of an existing program to extend it for some new situation.
Unfortunately, the traditional models of programming provide little
support for this activity.  The programmer often finds that
commitments made in the existing code impede the extension, but the
costs of reversing those commitments are excessive.

Such commitments tend to take the form of choices of strategy.  In the
design of any significant system there are many implementation plans
proposed for every component at every level of detail.  However, in
the system that is finally delivered this diversity of plans is lost
and usually only one unified plan is adopted and implemented.  As in
an ecological system, the loss of diversity in the traditional
engineering process has serious consequences.

The Propagator Programming Model is an attempt to mitigate this
problem.  It is a model that supports the expression and integration
of multiple viewpoints on a design.  It incorporates explicit
structure to support the integration of redundant pieces and
subsystems that solve problems in several different ways.  It will
help us integrate the diversity that was inherent in the design
process into the delivered operational product.

The Propagator Programming Model is built on the idea that the basic
computational elements are autonomous machines interconnected by
shared cells through which they communicate.  Each machine
continuously examines the cells it is interested in, and adds
information to some based on computations it can make from information
from the others.  Cells accumulate information from the propagators
that produce that information.  The key idea here is additivity.  New
ways to make contributions can be added just by adding new
propagators; if an approach to a problem doesn't turn out to work
well, it can be identified by its premises and ignored, dynamically
and without disruption.


This work was supported in part by the MIT Mind Machine Project.

\tableofcontents

%___________________________________________________________________________

\hypertarget{propagator-system}{}
\pdfbookmark[0]{Propagator System}{propagator-system}
@section{Propagator System}
\label{propagator-system}

Although most of this document introduces you to the Scheme-Propagator
system that we have developed in MIT Scheme, the Propagator Model is
really independent of the language.  You should be able to write
propagators in any language you choose, and others should be able to
write subsystems in their favorite language that cooperate with your
subsystems.  What is necessary is that all users agree on the protocol
by which propagators communicate with the cells that are shared among
subsystems.  These rules are very simple and we can enumerate them
right here:

Cells must support three operations:
\begin{itemize}
\item {} 
add some content

\item {} 
collect the content currently accumulated

\item {} 
register a propagator to be notified when the accumulated content changes

\end{itemize}

When new content is added to a cell, the cell must merge the addition
with the content already present.  When a propagator asks for the
content of a cell, the cell must deliver a complete summary of the
information that has been added to it.

The merging of content must be commutative, associative, and
idempotent.  The behavior of propagators must be monotonic with
respect to the lattice induced by the merge operation.


%___________________________________________________________________________

\hypertarget{getting-started}{}
\pdfbookmark[0]{Getting Started}{getting-started}
@section{Getting Started}
\label{getting-started}

Scheme-Propagators is implemented in \href{http://www.gnu.org/software/mit-scheme/}{MIT/GNU Scheme}, which you will
need in order to use it.  You will also need Scheme-Propagators
itself, which you can download from
\href{http://groups.csail.mit.edu/mac/users/gjs/propagators/propagator.tar}
Once you
have it, go to the \texttt{propagator/} directory, start up your Scheme and
load the main entry file with \texttt{(load "load")}.  This gives you a
read-eval-print loop (traditionally called a REPL for short) for both
the Scheme-Propagators system and the underlying Scheme
implementation.  Check out the README for more on this.

Once you've got your REPL, you can start typing away at it to create
propagator networks, give them inputs, ask them to do computations,
and look at the results.

Here's a little propagator example that adds two and three to get
five:
\begin{quote}{\ttfamily \raggedright \noindent
(define-cell~a)~\\
(define-cell~b)~\\
(add-content~a~3)~\\
(add-content~b~2)~\\
(define-cell~answer~(e:+~a~b))~\\
(run)~\\
(content~answer)~==>~5
}\end{quote}

Each of the parenthesized phrases above are things to type into the
REPL, and the \texttt{==> 5} at the end is the result that Scheme will
print.  The results of all the other expressions are not interesting.

Let's have a closer look at what's going on in this example, to serve
as a guide for more in-depth discussion later.  \texttt{define-cell} is a
Scheme macro for making and naming propagator cells:
\begin{quote}{\ttfamily \raggedright \noindent
(define-cell~a)
}\end{quote}
creates a new cell and binds it to the Scheme variable \texttt{a}.
\begin{quote}{\ttfamily \raggedright \noindent
(define-cell~b)
}\end{quote}
makes another one.  Then \texttt{add-content} is the Scheme procedure that
directly zaps some information into a propagator cell (all the
propagators use it to talk to the cells, and you can too).  So:
\begin{quote}{\ttfamily \raggedright \noindent
(add-content~a~3)
}\end{quote}
puts a \texttt{3} into the cell named \texttt{a}, and:
\begin{quote}{\ttfamily \raggedright \noindent
(add-content~b~2)
}\end{quote}
puts a \texttt{2} into the cell named \texttt{b}.  Now \texttt{e:+} (the naming
convention will be explained later) is a Scheme procedure that creates
a propagator that adds, attaches it to the given cells as inputs, and
makes a cell to hold the adder's output and returns it.  So:
\begin{quote}{\ttfamily \raggedright \noindent
(define-cell~answer~(e:+~a~b))
}\end{quote}
creates an adding propagator, and also creates a cell, now called
\texttt{answer}, to hold the result of the addition.  Be careful!  No
computation has happened yet.  You've just made up a network, but it
hasn't done its work yet.  That's what the Scheme procedure \texttt{run} is
for:
\begin{quote}{\ttfamily \raggedright \noindent
(run)
}\end{quote}
actually executes the network, and only when the network is done
computing does it give you back the REPL to interact with.  Finally
\texttt{content} is a Scheme procedure that gets the content of cells:
\begin{quote}{\ttfamily \raggedright \noindent
(content~answer)
}\end{quote}
looks at what the cell named \texttt{answer} has now, which is \texttt{5}
because the addition propagator created by \texttt{e:+} has had a chance to
do its job.  If you had forgotten to type \texttt{(run)} before typing
\texttt{(content answer)}, it would have printed out \texttt{{\#}(*the-nothing*)},
which means that cell has no information about the value it is meant
to have.


%___________________________________________________________________________

\hypertarget{examples}{}
\pdfbookmark[1]{Examples}{examples}
@subsection{Examples}
\label{examples}

There are some basic examples of Scheme-Propagators programs in
\texttt{core/example-networks.scm}; more elaborate examples are available
in \texttt{examples/}.


%___________________________________________________________________________

\hypertarget{the-details}{}
\pdfbookmark[0]{The Details}{the-details}
@section{The Details}
\label{the-details}

Now that you know how to play around with our propagators we have to
tell you what we actually provide.  In every coherent system for
building stuff there are primitive parts, the means by which they can
be combined, and means by which combinations can be abstracted so that
they can be named and treated as if they are primitive.


%___________________________________________________________________________

\hypertarget{making-propagator-networks}{}
\pdfbookmark[0]{Making Propagator Networks}{making-propagator-networks}
@section{Making Propagator Networks}
\label{making-propagator-networks}

The ingredients of a propagator network are cells and propagators.
The cells' job is to remember things; the propagators' job is to
compute.  The analogy is that propagators are like the procedures of a
traditional programming language, and cells are like the memory
locations; the big difference is that cells accumulate partial
information (which may involve arbitrary internal computations), and
can therefore have many propagators reading information from them and
writing information to them.

The two basic operations when making a propagator network are making
cells and attaching propagators to cells.  You already met one way to
make cells in the form of \texttt{define-cell}; we will talk about more
later, but let's talk about propagators first.


%___________________________________________________________________________

\hypertarget{attaching-basic-propagators-d}{}
\pdfbookmark[1]{Attaching Basic Propagators: d@"@"}{attaching-basic-propagators-d}
@subsection{Attaching Basic Propagators: d@"@"}
\label{attaching-basic-propagators-d}

The Scheme procedure \texttt{d@"@"} attaches propagators to cells.  The
name \texttt{d@"@"} is mnemonic for ``diagram apply''.  For
example, \texttt{p:+} makes adder propagators:
\begin{quote}{\ttfamily \raggedright \noindent
(d@"@"~p:+~foo~bar~baz)
}\end{quote}
means attach a propagator that will add the contents of the cells
named \texttt{foo} and \texttt{bar} and write the sum into the cell named \texttt{baz}.
Once attached, whenever either the \texttt{foo} cell or the \texttt{bar} cell
gets any new interesting information, the adding propagator will
eventually compute the appropriate sum and give it to \texttt{baz} as an
update.
\begin{description}
\item[{\texttt{(d@"@" propagator boundary-cell ...)}}] \leavevmode 
Attaches a propagator to the given boundary cells.  By convention,
cells used as outputs go last.  As a Scheme procedure, \texttt{d@"@"} does
not return a useful value.

\end{description}

As in Scheme, \texttt{p:+} is actually the name of a cell that contains a
propagator constructor for attaching propagators that do addition.
The first argument to \texttt{d@"@"} can be any cell that contains any desired
partial information (see Section~\ref{using-partial-information})
about a propagator constructor.
Actual attachment of propagators will occur as the propagator
constructor becomes sufficiently well constrained.


%___________________________________________________________________________

\hypertarget{propagator-expressions-e}{}
\pdfbookmark[1]{Propagator Expressions: e@"@"}{propagator-expressions-e}
@subsection{Propagator Expressions: e@"@"}
\label{propagator-expressions-e}

The \texttt{d@"@"} style is the right underlying way to think about the
construction of propagator networks.  However, it has the unfortunate
feature that it requires the naming of cells for holding all
intermediate values in a computation, and in that sense programming
with \texttt{d@"@"} feels a lot like writing assembly language.

It is pretty common to have expressions: one's propagator networks
will have some intermediate values that are produced by only one
propagator, and consumed by only one propagator.  In this case it is a
drag to have to define and name a cell for that value, if one would
just name it ``the output of foo''.  Scheme-Propagators provides a
syntactic sugar for writing cases like this in an expression style, like a
traditional programming language.

The Scheme procedure \texttt{e@"@"} attaches propagators in expression style.
The name \texttt{e@"@"} is mnemonic for ``expression apply''.  The \texttt{e@"@"}
procedure is just like \texttt{d@"@"}, except it synthesizes an extra cell to
serve as the last argument to \texttt{d@"@"}, and returns it from the \texttt{e@"@"}
expression (whereas the return value of \texttt{d@"@"} is unspecified).
\begin{description}
\item[{\texttt{(e@"@" propagator boundary-cell ...)}}] \leavevmode 
Attaches the given propagator to a boundary consisting of the given
boundary cells augmented with an additional, synthesized cell.  The
synthesized cell goes last, because that is the conventional
position for an output cell.  Returns the synthesized cell as the
Scheme return value of \texttt{e@"@"}.

\end{description}

For example, here are two ways to do the same thing:
\begin{quote}{\ttfamily \raggedright \noindent
(define-cell~x)~\\
(define-cell~y)~\\
(define-cell~z)~\\
(d@"@"~p:*~x~y~z)
}\end{quote}
and:
\begin{quote}{\ttfamily \raggedright \noindent
(define-cell~x)~\\
(define-cell~y)~\\
(define-cell~z~(e@"@"~p:*~x~y))
}\end{quote}

Generally the \texttt{e@"@"} style is convenient because it chains in
the familiar way
\begin{quote}{\ttfamily \raggedright \noindent
(e@"@"~p:-~w~(e@"@"~p:*~(e@"@"~p:+~x~y)~z))
}\end{quote}

Because of the convention that output cells are listed last,
expressions in \texttt{e@"@"} style build propagator networks that
compute corresponding Lisp expressions.

On the other hand, the \texttt{d@"@"} style is necessary when a propagator
needs to be attached to a full set of cells that are already there.
For example, if one wanted to be able to go back from \texttt{z} and one of
\texttt{x} or \texttt{y} to the other, rather than just from \texttt{x} and \texttt{y} to
\texttt{z}, one could write:
\begin{quote}{\ttfamily \raggedright \noindent
(define-cell~x)~\\
(define-cell~y)~\\
(define-cell~z~(e@"@"~p:*~x~y))~\\
(d@"@"~p:/~z~x~y)~\\
(d@"@"~p:/~z~y~x)
}\end{quote}
and get a multidirectional constraint:
\begin{quote}{\ttfamily \raggedright \noindent
(add-content~z~6)~\\
(add-content~x~3)~\\
(run)~\\
(content~y)~==>~2
}\end{quote}

To save typing when the propagator being attached is known at network
construction time, the \texttt{p:foo} objects are also themselves
applicable in Scheme, defaulting to applying themselves in the \texttt{d@"@"}
style.  Each also has an \texttt{e:foo} variant that defaults to the \texttt{e@"@"}
style.  So the following also works:
\begin{quote}{\ttfamily \raggedright \noindent
(define-cell~x)~\\
(define-cell~y)~\\
(define-cell~z~(e:*~x~y))~\\
(p:/~z~x~y)~\\
(p:/~z~y~x)
}\end{quote}


%___________________________________________________________________________

\hypertarget{late-binding-of-application}{}
\pdfbookmark[1]{Late Binding of Application}{late-binding-of-application}
@subsection{Late Binding of Application}
\label{late-binding-of-application}

The preceding discusses attaching propagators to cells when the
propagators being attached are known at network construction time.
That will not always be the case.  For example:
\begin{quote}{\ttfamily \raggedright \noindent
(define-cell~operation)~\\
(define-cell~answer)~\\
(d@"@"~operation~3~4~answer)~\\
(run)~\\
(content~answer)~~==>~~nothing
}\end{quote}

We didn't say what operation to perform.  This is not an error, but
since nothing is known about what to do with the 3 and the 4, nothing
is known about the answer.  Now if we supply an operation, the
computation will proceed:
\begin{quote}{\ttfamily \raggedright \noindent
(p:id~p:*~operation)~\\
(run)~\\
(content~answer)~~==>~~12
}\end{quote}

In fact, in this case, \texttt{d@"@"} (or \texttt{e@"@"}) will build an \emph{apply propagator}
that will wait until an operation appears in the
\texttt{operation} cell, and then apply it.

What would have happened if we had left off the \texttt{d@"@"} and just
written \texttt{(operation 3 4 answer)}?  If you put into operator position
a cell that does not have a fully-known propagator at network
construction time, it will be applied in diagram style by default.  If
you put into operator position a cell that contains a fully-known
propagator at network construction time, it will be applied either in
diagram style or expression style, as dependent on that propagator's
default preference.  \texttt{d@"@"} and \texttt{e@"@"} override these defaults.


%___________________________________________________________________________

\hypertarget{provided-primitives-p-foo-and-e-foo}{}
\pdfbookmark[1]{Provided Primitives: p:foo and e:foo}{provided-primitives-p-foo-and-e-foo}
@subsection{Provided Primitives: p:foo and e:foo}
\label{provided-primitives-p-foo-and-e-foo}

Many propagator primitives directly expose procedures from the
underlying Scheme, with the naming conventions that \texttt{p:foo}, and
\texttt{e:foo} does the job \texttt{foo} to the contents of an appropriate pile
of input cells and gives the result to an output cell (which is passed
in as the last argument to \texttt{p:foo} and synthesized and returned by
\texttt{e:foo}).  \texttt{p:} is mnemonic for ``propagator'' and \texttt{e:} is
mnemonic for ``expression''.
\begin{description}
\item[{\texttt{(p:foo input ... output)}}] \leavevmode 
Attaches a propagator that does the \texttt{foo} job to the given input
and output cells.  \texttt{p:abs}, \texttt{p:square}, \texttt{p:sqrt},
\texttt{p:not}, \texttt{p:pair?}, and \texttt{p:null?} accept one input cell and one
output cell.  \texttt{p:+}, \texttt{p:-}, \texttt{p:*}, \texttt{p:/}, \texttt{p:=}, \texttt{p:<},
\texttt{p:>}, \texttt{p:<=}, \texttt{p:>=}, \texttt{p:and}, \texttt{p:or}, \texttt{p:eq?},
\texttt{p:eqv?}, and \texttt{p:expt}, accept two input cells and one output
cell.

\item[{\texttt{(e:foo input ...)}}] \leavevmode 
The \texttt{e:foo} equivalents of all the \texttt{p:foo} propagator
constructors are all available and accept the same number of input
cells (and make their own output cell).

\item[{\texttt{(p:id input output)}, \texttt{(e:id input)}}] \leavevmode 
Attaches an identity propagator to the given cells.  The identity
propagator will continuously copy the contents of the \texttt{input} cell
to the \texttt{output} cell.

\item[{\texttt{(p:== input ... output)}, \texttt{(e:== input ...)}}] \leavevmode 
These are variadic versions of \texttt{p:id}.  The result is a
star topology, with every input feeding into the one output.

\item[{\texttt{(p:switch control input output)}, \texttt{(e:switch control input)}}] \leavevmode 
Conditional propagation.  The propagator made by \texttt{switch} copies
its \texttt{input} to its \texttt{output} if and only if its \texttt{control} is
``true''.  The presence of partial information (see Section~\ref{using-partial-information}) makes this
interesting.  For example, a \texttt{{\#}t} contingent on some premise will
cause \texttt{switch} to propagate, but the result written to the
\texttt{output} will be contingent on that premise (in addition to any
other premises the \texttt{input} may already be contingent on).

\item[{\texttt{(p:conditional control consequent alternate output)},}]
\item[{\texttt{(e:conditional control consequent alternate)}}] \leavevmode 
Two-armed conditional propagation.  May be defined by use of two
\texttt{switch} propagators and a \texttt{not} propagator.

\item[{\texttt{(p:conditional-router control input consequent alternate)},}]
\item[{\texttt{(p:conditional-router control input consequent)}}] \leavevmode 
Two-output-armed conditional propagation.  This is symmetric with
\texttt{conditional}; the \texttt{consequent} and \texttt{alternate} are possible
output destinations.

\end{description}


%___________________________________________________________________________

\hypertarget{cells-are-data-too}{}
\pdfbookmark[1]{Cells are Data Too}{cells-are-data-too}
@subsection{Cells are Data Too}
\label{cells-are-data-too}

Cells, and structures thereof, are perfectly good partial information
(see Section~\ref{using-partial-information})
and are therefore perfectly legitimate contents of other
cells.  The event that two different cells A and B find themselves
held in the same third cell C means that A and B are now known to
contain information about the same thing.  The two cells are therefore
merged by attaching \texttt{c:id} propagators to them so as to keep their
contents in sync in the future.
\begin{description}
\item[{\texttt{(p:deposit cell place-cell)}, \texttt{(e:deposit cell)}}] \leavevmode 
Grabs the given \texttt{cell} and deposits it into \texttt{place-cell}.  The
rule for merging cells has the effect that the given \texttt{cell} will
be identified with any other cells that \texttt{place-cell} may come to
hold.

\item[{\texttt{(p:examine place-cell cell)}, \texttt{(e:examine place-cell)}}] \leavevmode 
Grabs the given \texttt{cell} and deposits it into \texttt{place-cell}.  The
rule for merging cells has the effect that the given \texttt{cell} will
be identified with any other cells that \texttt{place-cell} may come to
hold.

In fact, \texttt{p:deposit} and \texttt{p:examine} are the same operation,
except with the arguments reversed.

The \texttt{e:examine} variant includes an optimization: if the
\texttt{place-cell} already contains a cell, \texttt{e:examine} will just
Scheme-return that cell instead of synthesizing a new one and
identifying it with the cell present.

\end{description}


%___________________________________________________________________________

\hypertarget{compound-data}{}
\pdfbookmark[1]{Compound Data}{compound-data}
@subsection{Compound Data}
\label{compound-data}

Propagator compound data structures are made out of Scheme compound
data structures that carry around cells collected as with \texttt{deposit}.
The corresponding accessors take those cells out as with \texttt{examine}.
\begin{description}
\item[{\texttt{(p:cons car-cell cdr-cell output)}, \texttt{(e:cons car-cell cdr-cell)}}] \leavevmode 
Constructs a propagator that collects the \texttt{car-cell} and the
\texttt{cdr-cell}, makes a pair of them, and writes that pair into the
\texttt{output} cell.  This is like a binary \texttt{p:deposit}.

\item[{\texttt{(p:pair? input output)}, \texttt{(e:pair? input)}}] \leavevmode 
Attaches a propaagtor that tests whether input cell contains a
pair.

\item[{\texttt{(p:null? input output)}, \texttt{(e:null? input)}}] \leavevmode 
Attaches a propaagtor that tests whether input cell contains
the empty list.

\item[{\texttt{(p:car input output)}, \texttt{(e:car input)}}] \leavevmode 
Makes a propagator that identifies the given \texttt{output} with the
cell in the \texttt{car} of the pair in the given \texttt{input}.  This is
like a \texttt{p:examine} of that field.  Note that using \texttt{p:car} on an
\texttt{input} implies the expectation that said \texttt{input} contains a
pair.  That wish is treated as a command, and a pair appears.
If fact, \texttt{(p:car input output)} is equivalent to
\texttt{(p:cons output nothing input)}.

The \texttt{e:} variant includes the same optimization that \texttt{e:examine}
does: if the \texttt{input} already contains a pair with a cell in the
\texttt{car}, \texttt{e:car} will just Scheme-return that cell instead of
synthesizing a new one and identifying it with the cell present.

\item[{\texttt{(p:cdr input output)}, \texttt{(e:cdr input)}}] \leavevmode 
Same as \texttt{p:car} and \texttt{e:car}, except the other field of the
pair.

\end{description}

Note that the identification of cells that merge is bidirectional, so
information written into the \texttt{output} of a \texttt{p:car} will flow into
the cell in the \texttt{car} of the pair in the \texttt{input} (and therefore
into any other cells identified with it by other uses of \texttt{p:car} on
the same pair).  For example, in a program like:
\begin{quote}{\ttfamily \raggedright \noindent
(let-cell~frob~\\
~~(let-cell~(quux~(e:car~frob))~\\
~~~~...~quux~...)~\\
~~(let-cell~(quux2~(e:car~frob))~\\
~~~~...~quux2~...))
}\end{quote}
the two cells named \texttt{quux} and \texttt{quux2} will end up identified, and
the cell named \texttt{frob} will end up containing a pair whose car field
will contain one of them.

Scheme pairs created by \texttt{p:cons} and company are partial information
structures, and they merge by recursively merging their corresponding
fields.  Together with the rule for merging cells, the emergent
behavior is unification (with a merge delay instead of the occurs
check).


%___________________________________________________________________________

\hypertarget{propagator-constraints-c-foo-and-ce-foo}{}
\pdfbookmark[1]{Propagator Constraints: c:foo and ce:foo}{propagator-constraints-c-foo-and-ce-foo}
@subsection{Propagator Constraints: c:foo and ce:foo}
\label{propagator-constraints-c-foo-and-ce-foo}

Although the primitive propagators are like functions in that they
compute only from inputs to outputs, we can also define constraints,
which may also derive information about the arguments of a function
from information about the value.  Constraints are so useful that many
are predefined, and they have their own naming convention.  \texttt{c:}
stands for ``constraining''.  A thing named \texttt{c:foo} is the
constraining analogue of \texttt{p:foo}, in that in addition to attaching a
propagator that does \texttt{foo} to its cells, it also attaches
\texttt{foo-inverse} propagators that deduce ``inputs'' from ``outputs''.  For
example, the product constraint that we built in a previous section is
available as \texttt{c:*}:
\begin{quote}{\ttfamily \raggedright \noindent
(define-cell~x)~\\
(define-cell~y)~\\
(define-cell~z)~\\
(d@"@"~c:*~x~y~z)~\\
~\\
(add-content~z~12)~\\
(add-content~y~4)~\\
(run)~\\
(content~x)~==>~3
}\end{quote}

The \texttt{c:foo} objects, like the \texttt{p:foo} objects, are also
self-applicable, and also default to applying themselves
in diagram style:
\begin{quote}{\ttfamily \raggedright \noindent
(c:*~x~y~z)~~==~~(d@"@"~c:*~x~y~z)
}\end{quote}

The \texttt{c:foo} objects also have \texttt{ce:foo} analogues, that
apply themselves in expression style:
\begin{quote}{\ttfamily \raggedright \noindent
(ce:*~x~y)~~==~~(e@"@"~c:*~x~y)
}\end{quote}

Of course, not every operation has a useful inverse, so there are
fewer \texttt{c:} procedures defined than \texttt{p:}:
\begin{description}
\item[{\texttt{(c:foo constrainee ...)}}] \leavevmode 
Attaches propagators to the given boundary cells that collectively
constrain them to be in the \texttt{foo} relationship with each other.
\texttt{c:+} and \texttt{c:*} accept three cells to constrain.  \texttt{c:square},
\texttt{c:not}, and \texttt{c:id} accept two cells to constrain.  \texttt{c:==}
accepts any number of cells.

\item[{\texttt{(ce:foo constrainee ...)}}] \leavevmode 
Synthesizes one additional constrainee cell and attaches propagators
that constrain the given cells to be in the \texttt{foo} relationship
with the new one.  Since the position of the synthesized cell in
the argument list is fixed, some diagram style constraints have
multiple expression style variants:
\begin{quote}{\ttfamily \raggedright \noindent
c:+~~~~~~~ce:+~~~~~~~ce:-~\\
c:*~~~~~~~ce:*~~~~~~~ce:/~\\
c:square~~ce:square~~ce:sqrt~\\
c:not~~~~~ce:not~\\
c:id~~~~~~ce:id~\\
c:==~~~~~~ce:==
}\end{quote}
\end{description}


%___________________________________________________________________________

\hypertarget{constants-and-literal-values}{}
\pdfbookmark[1]{Constants and Literal Values}{constants-and-literal-values}
@subsection{Constants and Literal Values}
\label{constants-and-literal-values}

Programs have embedded constants all the time, and propagator programs
are no different (except that constant values, like all other values,
can be partial).  We've already seen one way to put a Scheme value
into a propagator program: the \texttt{add-content} procedure zaps a value
straight into a cell.  This is generally encouraged at the REPL, but
frowned upon in actual programs.  It is much nicer to use \texttt{constant}
or \texttt{p:constant} (they're the same) to make a propagator that will
zap your value into your cell for you:
\begin{quote}{\ttfamily \raggedright \noindent
(define-cell~thing)~\\
((constant~5)~thing)~\\
(content~thing)~==>~{\#}(*the-nothing*)~\\
(run)~\\
(content~thing)~==>~5
}\end{quote}

There is also an expression-oriented version, called, naturally,
\texttt{e:constant}:
\begin{quote}{\ttfamily \raggedright \noindent
(define-cell~thing~(e:constant~5))~\\
(run)~\\
(content~thing)~==>~5
}\end{quote}


%___________________________________________________________________________

\hypertarget{constant-conversion}{}
\pdfbookmark[1]{Constant Conversion}{constant-conversion}
@subsection{Constant Conversion}
\label{constant-conversion}

In fact, inserting constants is so important, that there is one more
nicification of this: whenever possible, the system will convert a raw
constant (i.e. a non-cell Scheme object) into a cell, using
\texttt{e:constant}.

Some examples:
\begin{quote}{\ttfamily \raggedright \noindent
(e:+~x~2)~~~~~~~~~~==~~~(e:+~x~(e:constant~2))~\\
(define-cell~x~4)~~==~~~(define-cell~x~(e:constant~4))~\\
(c:+~x~y~0)~~~~~~~~==~~~(c:+~x~y~(e:constant~0))
}\end{quote}


%___________________________________________________________________________

\hypertarget{making-cells}{}
\pdfbookmark[1]{Making Cells}{making-cells}
@subsection{Making Cells}
\label{making-cells}

Cells are the memory locations of the Scheme-Propagators
language: Scheme variables whose bindings are cells correspond to
Scheme-Propagators variables (Scheme variables whose bindings are
other things look like syntax to Scheme-Propagators).  We've
already met one way to make cells:
\begin{quote}{\ttfamily \raggedright \noindent
(define-cell~x)
}\end{quote}
creates a Scheme variable named \texttt{x} and binds a cell to it.  The
underlying mechanism underneath this is the procedure \texttt{make-cell},
which creates a cell and lets you do whatever you want with it.  So
you could write:
\begin{quote}{\ttfamily \raggedright \noindent
(define~x~(make-cell))
}\end{quote}
which would also make a Scheme variable named \texttt{x} and bind a cell to
it.  In fact, that is almost exactly what \texttt{define-cell} does, except
that \texttt{define-cell} attaches some metadata to the cell it creates to
make it easier to debug the network (see Section~\ref{debugging})
and also does constant
conversion (so \texttt{(define-cell x 5)} makes \texttt{x} a cell that will get
a \texttt{5} put into it, whereas \texttt{(define x 5)} would just bind \texttt{x} to
\texttt{5}).

Just as Scheme has several mechanisms of making variables, so
Scheme-Propagators has corresponding ones.  Corresponding to Scheme's
\texttt{let}, Scheme-Propagators has \texttt{let-cells}:
\begin{quote}{\ttfamily \raggedright \noindent
(let-cells~((foo~(e:+~x~y))~\\
~~~~~~~~~~~~(bar~(e:*~x~y)))~\\
~~...)
}\end{quote}
will create the Scheme bindings \texttt{foo} and \texttt{bar}, and bind them to
the cells made by \texttt{(e:+ x y)} and \texttt{(e:* x y)}, respectively (this
code is only sensible if \texttt{x} and \texttt{y} are already bound to cells
(or subject to constant conversion)).  The new bindings will only be
visible inside the scope of the \texttt{let-cells}, just like in Scheme;
but if you attach propagators to them, the cells themselves will
continue to exist and function as part of your propagator network.

One notable difference from Scheme: a cell in a propagator network,
unlike a variable in Scheme, has a perfectly good ``initial state''.
Every cell starts life knowing \texttt{nothing} about its intended
contents; where Scheme variables have to start life in a weird
``unassigned'' state, \texttt{nothing} is a perfectly good partial
information structure.  This means that it's perfectly reasonable
for \texttt{let-cells} to make cells with no initialization forms:
\begin{quote}{\ttfamily \raggedright \noindent
(let-cells~(x~y~(foo~(some~thing)))~...)
}\end{quote}
creates cells named \texttt{x} and \texttt{y}, which are empty and have
no propagators attached to them initially, and also a cell
named \texttt{foo} like above.  \texttt{let-cells} also recognizes the
usage:
\begin{quote}{\ttfamily \raggedright \noindent
(let-cells~((x)~(y)~(foo~(some~thing)))~...)
}\end{quote}
by analogy with Scheme \texttt{let}.

Corresponding to Scheme's \texttt{let*}, Scheme-Propagators has
\texttt{let-cells*}.  \texttt{let-cells*} is to \texttt{let-cells} what \texttt{let*} is
to \texttt{let}:
\begin{quote}{\ttfamily \raggedright \noindent
(let-cells*~((x)~\\
~~~~~~~~~~~~~(y~(e:+~x~x)))~\\
~~...)
}\end{quote}
will make a cell named \texttt{x} and a cell named \texttt{y} with an adder both
of whose inputs are \texttt{x} and whose output is \texttt{y}.

Corresponding to Scheme's \texttt{letrec}, Scheme-Propagators has
\texttt{let-cells-rec}.  \texttt{let-cells-rec} has the same scoping rules as
Scheme's \texttt{letrec}, namely that all the names it defines are
available to all the defining forms.  Moreover, since an
``uninitialized'' propagator cell can still start life in a perfectly
sensible state, namely the state of containing \texttt{nothing},
\texttt{let-cells-rec} removes a restriction that Scheme's \texttt{letrec}
enforced; namely, you may use the names defined by a given
\texttt{let-cells-rec} directly in the defining forms, without any explicit
intermediate delay in evaluation.  For example:
\begin{quote}{\ttfamily \raggedright \noindent
(let-cells-rec~((z~(e:+~x~y))~\\
~~~~~~~~~~~~~~~~(x~(e:-~z~y))~\\
~~~~~~~~~~~~~~~~(y~(e:-~z~x)))~\\
~~...)
}\end{quote}
is a perfectly reasonable bit of Scheme-Propagators code, and binds
the names \texttt{x}, \texttt{y} and \texttt{z} to cells that are
interconnected with the three propagators indicated.

Now, \texttt{let-cells}, \texttt{let-cells*}, and \texttt{let-cells-rec} are, like
\texttt{define-cell}, basically a convenience over doing the same thing in
Scheme with \texttt{let}, \texttt{let*}, \texttt{letrec} and \texttt{make-cell}.  Also
like \texttt{define-cell}, \texttt{let-cells}, \texttt{let-cells*}, and
\texttt{let-cells-rec} do constant conversion (so in \texttt{(let-cells ((x 3)) ...)},
\texttt{x} becomes a cell, not a Scheme object), and attach
debugging information to the cells they bind.

Since \texttt{let-cells} is plural (where \texttt{let} was number-neutral),
Scheme-Propagators also define \texttt{let-cell} and \texttt{let-cell-rec}
(\texttt{let-cell*} being useless) for the case when you just want to make
one cell:
\begin{quote}{\ttfamily \raggedright \noindent
(let-cell~x~...)~~~~~~~~~~~~~~==~~(let-cells~(x)~...)~\\
(let-cell~(x~(e:+~y~z))~...)~~==~~(let-cells~((x~(e:+~y~z)))~...)~\\
(let-cell-rec~(ones~(e:cons~1~ones))~...)~~==~\\
(let-cells-rec~((ones~(e:cons~1~ones)))~...)
}\end{quote}

Scheme-Propagators currently has no analogue of Scheme's named \texttt{let}
syntax.

Finally, there is one more, somewhat sneaky way to make cells.
The \texttt{e@"@"}
procedure makes and returns a cell to hold the ``output'' of the
propagator being applied.  These implicit cells are just
like the implicit memory locations that Scheme creates under the hood
for holding the return values of expressions before they get used by
the next expression or assigned to variables.


%___________________________________________________________________________

\hypertarget{conditional-network-construction}{}
\pdfbookmark[1]{Conditional Network Construction}{conditional-network-construction}
@subsection{Conditional Network Construction}
\label{conditional-network-construction}

The \texttt{switch} propagator does conditional propagation -{}-{}- it only
forwards its input to its output if its control is ``true''.  As such,
it serves the purpose of controlling the flow of data through an existing
propagator network.  However, it is also appropriate to control the
construction of more network, for example to design recursive networks
that expand themselves no further than needed.  The basic idea here
is to delay the construction of some chunk of network until
some information appears on its boundary, and control whether
said information appears by judicious use of \texttt{switch} propagators.  The
low-level tools for accomplishing this effect are
\texttt{delayed-propagator-constructor} and \texttt{switch}.  The supported
user interface is:
\begin{description}
\item[{\texttt{(p:when internal-cells condition-cell body ...)}}] \leavevmode 
Delays the construction of the body until sufficiently ``true'' (in
the sense of \texttt{switch}) partial information appears in the
\texttt{condition-cell}.  The \texttt{condition-cell} argument is an
expression to evaluate to produce the cell controlling whether
construction of the \texttt{body} takes place.  The \texttt{body} is an
arbitrary collection of code, defining some amount of propagator
network that will not be built until the controlling cell indicates
that it should.  The \texttt{internal-cells} argument is a list of the
free variables in \texttt{body}.  This is the same kind of kludge as the
\texttt{import} clause in \texttt{define-propagator} (see Section~\ref{lexical-scope}).

\item[{\texttt{(e:when internal-cells condition-cell body ...)}}] \leavevmode 
Expression-style variant of \texttt{p:when}.  Augments its boundary with
a fresh cell, which is then synchronized with the cell returned from
the last expression in \texttt{body} when \texttt{body} is constructed.

\end{description}

\texttt{(p:unless internal-cells condition-cell body ...)}
\begin{description}
\item[{\texttt{(e:unless internal-cells condition-cell body ...)}}] \leavevmode 
Same as \texttt{p:when} and \texttt{e:when}, but reversing the sense of the
control cell.

\item[{\texttt{(p:if internal-cells condition-cell consequent alternate)}}] \leavevmode 
Two-armed conditional construction.  Just like a \texttt{p:when} and a
\texttt{p:unless}: constructs the network indicated by the \texttt{consequent}
form when the \texttt{condition-cell} becomes sufficiently ``true'', and
constructs the network indicated by the \texttt{alternate} form when the
\texttt{condition-cell} becomes sufficiently ``false''.  Note that both can
occur for the same \texttt{p:if} over the life of a single computation,
for example if the \texttt{condition-cell} comes to have a TMS that includes
a \texttt{{\#}t} contingent on some premises and later a \texttt{{\#}f} contingent
on others.

\item[{\texttt{(e:if internal-cells condition-cell consequent alternate)}}] \leavevmode 
Expression-style variant of \texttt{p:if}.

\end{description}


%___________________________________________________________________________

\hypertarget{making-new-compound-propagators}{}
\pdfbookmark[0]{Making New Compound Propagators}{making-new-compound-propagators}
@section{Making New Compound Propagators}
\label{making-new-compound-propagators}

So, you know the primitives (the supplied propagators) and the means
of combination (how to make cells and wire bunches of propagators up
into networks).  Now for the means of abstraction.  A propagator
constructor such as \texttt{p:+} is like a wiring diagram with a few holes
where it can be attached to other structures.  Supply \texttt{p:+} with
cells, and it makes an actual propagator for addition whose inputs and
outputs are those cells.  How do you make compound propagator
constructors?

The main way to abstract propagator construction is with the
\texttt{define-d:propagator} and \texttt{define-e:propagator} Scheme macros.
\texttt{define-d:propagator} defines a compound propagator in diagram style,
that is, with explicit named parameters for the entire boundary of the
compound:
\begin{quote}{\ttfamily \raggedright \noindent
(define-d:propagator~(my-sum-constraint~x~y~z)~\\
~~(p:+~x~y~z)~\\
~~(p:-~z~y~x)~\\
~~(p:-~z~x~y))
}\end{quote}

\texttt{define-e:propagator} defines a compound propagator in expression
style, that is, expecting the body of the propagator to return one
additional cell to add to the boundary at the end:
\begin{quote}{\ttfamily \raggedright \noindent
(define-e:propagator~(double~x)~\\
~~(e:+~x~x))
}\end{quote}

Both defining forms will make variants with names beginning in \texttt{p:}
and \texttt{e:}, that default to being applied in diagram and expression
style, respectively.  Note that this definition does not bind
the Scheme variable \texttt{double}.

With these definitions we can use those pieces to build more complex
structures:
\begin{quote}{\ttfamily \raggedright \noindent
(p:my-sum-constraint~x~(e:double~x)~z)
}\end{quote}
which can themselves be abstracted so that they can be used
as if they were primitive:
\begin{quote}{\ttfamily \raggedright \noindent
(define-d:propagator~(foo~x~z)~\\
~~(p:my-sum-constraint~x~(e:double~x)~z))
}\end{quote}

\texttt{define-propagator} is an alias for \texttt{define-d:propagator} because
that's the most common use case.

Just as in Scheme, the definition syntaxes have a corresponding
syntax for anonymous compound propagators, \texttt{lambda-d:propagator} and
\texttt{lambda-e:propagator}.

Compound propagator constructors perform constant conversion:
\begin{quote}{\ttfamily \raggedright \noindent
(p:my-sum-constraint~x~3~z)~~==~~(p:my-sum-constraint~x~(e:constant~3)~z)
}\end{quote}

\texttt{define-propagator} and \texttt{define-e:propagator} respect the \texttt{c:}
and \texttt{ce:} naming convention, in that if the name supplied for
definition begins with \texttt{c:} or \texttt{ce:}, that pair of prefixes will
be used in the names actually defined instead of \texttt{p:} and \texttt{e:}.
So:
\begin{quote}{\ttfamily \raggedright \noindent
(define-propagator~(foo~...)~...)~~~~~defines~~p:foo~and~e:foo~\\
(define-propagator~(p:foo~...)~...)~~~defines~~p:foo~and~e:foo~\\
(define-propagator~(e:foo~...)~...)~~~defines~~p:foo~and~e:foo~\\
(define-propagator~(c:foo~...)~...)~~~defines~~c:foo~and~ce:foo~\\
(define-propagator~(ce:foo~...)~...)~~defines~~c:foo~and~ce:foo
}\end{quote}


%___________________________________________________________________________

\hypertarget{lexical-scope}{}
\pdfbookmark[1]{Lexical Scope}{lexical-scope}
@subsection{Lexical Scope}
\label{lexical-scope}

Compound propagator definitions can be closed over cells available in
their lexical environment:
\begin{quote}{\ttfamily \raggedright \noindent
(define-e:propagator~(addn~n)~\\
~~(define-e:propagator~(the-adder~x)~\\
~~~~(import~n)~\\
~~~~(e:+~n~x))~\\
~~e:the-adder)
}\end{quote}

\texttt{import} is a kludge, which is a consequence of the embedding of
Scheme-Propagators into Scheme.  Without enough access to the Scheme
interpreter, or enough macrological wizardry, we cannot detect the
free variables in an expression, so they must be listed explicitly by
the user.  Globally bound objects like \texttt{e:+} (and \texttt{p:addn} and
\texttt{e:addn} if the above were evaluated at the top level) need not be
mentioned.


%___________________________________________________________________________

\hypertarget{recursion}{}
\pdfbookmark[1]{Recursion}{recursion}
@subsection{Recursion}
\label{recursion}

Propagator abstractions defined by \texttt{define-propagator} are expanded
immediately when applied to cells.  Therefore, magic is needed to
build recursive networks, because otherwise the structure would be
expanded infinitely far.  As in Scheme, this magic is in \texttt{if}.  The
Scheme-Propagators construct \texttt{p:if} (which is implemented as a
Scheme macro) delays the construction of the diagrams in its branches
until sufficient information is available about the predicate.
Specifically, the consequent is constructed only when the predicate is
sufficiently ``true'', and the alternate is constructed only when the
predicate is sufficiently ``false''.  Note that, unlike in Scheme, these
can both occur to the same \texttt{p:if}.

In Scheme-Propagators, the one-armed conditional construction
construct \texttt{p:when} is more fundamental than the two-armed construct
\texttt{p:if}.  This is because, where Scheme's \texttt{if} is about selecting
values, and so has to have two options to select from, \texttt{p:when} and
\texttt{p:if} are about building machinery, and there is no particular
reason why choosing among two pieces of machinery to construct is any
more basic than choosing whether or not to construct one particular
piece.

For example, here is the familiar recursive \texttt{factorial}, rendered in
propagators with \texttt{p:if}:
\begin{quote}{\ttfamily \raggedright \noindent
(define-propagator~(p:factorial~n~n!)~\\
~~(p:if~(n~n!)~(e:=~0~n)~\\
~~~~(p:==~1~n!)~\\
~~~~(p:==~(e:*~n~(e:factorial~(e:-~n~1)))~n!)))
}\end{quote}

The only syntactic difference between this and what one would write in
Scheme for this same job is that this is written in diagram style,
with an explicit name for the cell that holds the answer, and that
\texttt{p:if} needs to be told the names of the non-global variables that
are free in its branches, just like the \texttt{import} clause of a
propagator definition (and for the same kludgerous reason).
\texttt{p:when} is the one-armed version.  \texttt{p:unless} is also provided;
it reverses the sense of the predicate.

Like everything else whose name begins with \texttt{p:}, \texttt{p:if} and co
have expression-style variants.  The difference is that the tail
positions of the branches are expected to return cells, which are
wired together and returned to the caller of the \texttt{e:if}.  Here is
\texttt{factorial} again, in expression style:
\begin{quote}{\ttfamily \raggedright \noindent
(define-e:propagator~(e:factorial~n)~\\
~~(e:if~(n)~(e:=~0~n)~\\
~~~~1~\\
~~~~(e:*~n~(e:factorial~(e:-~n~1)))))
}\end{quote}

Looks familiar, doesn't it?


%___________________________________________________________________________

\hypertarget{using-partial-information}{}
\pdfbookmark[0]{Using Partial Information}{using-partial-information}
@section{Using Partial Information}
\label{using-partial-information}

Partial, cumulative information is essential to
multidirectional, non-sequential programming.  Each ``memory
location'' of Scheme-Propagators, that is each cell, maintains not ``a
value'', but ``all the information it has about a value''.  Such
information may be as little as ``I know absolutely nothing about my
value'', as much as ``I know everything there is to know about my value,
and it is \texttt{42}'', and many possible variations in between; and also
one not-in-between variation, which is ``Stop the presses!  I know
there is a contradiction!''

All these various possible states of information are represented
(perforce) as Scheme objects.  The Scheme object \texttt{nothing} represents
the information ``I don't know anything''.  This requires only a single
Scheme object, because not knowing anything is a single state of
knowledge.  Most Scheme objects represent ``perfect, consistent''
information: the Scheme object \texttt{5} represents the information ``I
know everything there is to know, and the answer is \texttt{5}.''  There are
also several Scheme types provided with the system that denote
specific other states of knowledge, and you can make your own.  For
example, objects of type \texttt{interval?} contain an upper bound and a
lower bound, and represent information of the form ``I know my value is
between this real number and that one.''

The way to get partial knowledge into the network is to put it into
cells with \texttt{add-content} or constant propagators.  For example:
\begin{quote}{\ttfamily \raggedright \noindent
(define-cell~x~(make-interval~3~5))
}\end{quote}
produces a cell named \texttt{x} that now holds the partial information
\texttt{(make-interval 3 5)}, which means that its value is
between \texttt{3} and \texttt{5}.

Partial information structures are generally built to be contagious,
so that once you've inserted a structure of a certain type into
the network, the normal propagators will generally produce answers
in kind, and, if needed, coerce their inputs into the right form
to co-operate.  For example, if \texttt{x} has an interval like above,
\begin{quote}{\ttfamily \raggedright \noindent
(define-cell~y~(e:+~x~2))
}\end{quote}
will make an adder that will eventually need to add \texttt{2} to the
interval between \texttt{3} and \texttt{5}.  This is a perfectly reasonable
thing to ask, because both \texttt{2} and \texttt{(make-interval 3 5)} are
states of knowledge about the inputs to that adder, so it ought to
produce the best possible representation of the knowledge it can
deduce about the result of the addition.  In this case, that would be
the interval between \texttt{5} and \texttt{7}:
\begin{quote}{\ttfamily \raggedright \noindent
(run)~\\
(content~y)~~==>~~{\#}(interval~5~7)
}\end{quote}

The key thing about partial information is that it's
cumulative.  So if you also added some other knowledge to the \texttt{y}
cell, it would need to merge with the interval that's there to
represent the complete knowledge available as a result:
\begin{quote}{\ttfamily \raggedright \noindent
(add-content~y~(make-interval~4~6))~\\
(content~y)~~==>~~{\#}(interval~5~6)
}\end{quote}

If incoming knowledge hopelessly contradicts the knowledge a cell
already has, it will complain:
\begin{quote}{\ttfamily \raggedright \noindent
(add-content~y~15)~~==>~~An~error
}\end{quote}
stop the network mid-stride, and give you a chance to examine the
situation so you can debug the program that led to it, using the
standard MIT Scheme debugging facilities.

The partial information types are defined by a suite of Scheme
procedures.  The ones defining the actual partial information types
are \texttt{equivalent?}, \texttt{merge}, and \texttt{contradictory?}, which test
whether two information structures represent the same information,
merge given information structures, and test whether a given
information structure represents an impossible state, respectively.
Each partial information structure also defines the way various
propagators treat it.  The behavior in the control position of a
\texttt{switch} propagator and in the operator position of an apply
propagator are particularly important.


%___________________________________________________________________________

\hypertarget{built-in-partial-information-structures}{}
\pdfbookmark[0]{Built-in Partial Information Structures}{built-in-partial-information-structures}
@section{Built-in Partial Information Structures}
\label{built-in-partial-information-structures}

The following partial information structures are provided with
Scheme-Propagators:
\begin{itemize}
\item {} 
nothing

\item {} 
just a value

\item {} 
intervals

\item {} 
propagator cells

\item {} 
compound data

\item {} 
closures

\item {} 
supported values

\item {} 
truth maintenance systems

\item {} 
contradiction

\end{itemize}


%___________________________________________________________________________

\hypertarget{nothing}{}
\pdfbookmark[1]{Nothing}{nothing}
@subsection{Nothing}
\label{nothing}
\begin{description}
\item[{\texttt{nothing}}] \leavevmode 
A single Scheme object that represents the complete absence of
information.

\item[{\texttt{(nothing? thing)}}] \leavevmode 
A predicate that tests whether a given Scheme object is the \texttt{nothing}
object.

\end{description}

\texttt{nothing} is \texttt{equivalent?} only to itself.

\texttt{nothing} never contributes anything to a merge -{}-{}- the merge of
anything with \texttt{nothing} is the anything.

\texttt{nothing} is not \texttt{contradictory?}.

Strict propagators, such as ones made by \texttt{p:+}, output \texttt{nothing}
if any of their inputs are \texttt{nothing}.

A \texttt{switch} whose control cell contains \texttt{nothing} will emit
\texttt{nothing}.

An apply propagator whose operator cell contains \texttt{nothing} will not
do anything.


%___________________________________________________________________________

\hypertarget{just-a-value}{}
\pdfbookmark[1]{Just a Value}{just-a-value}
@subsection{Just a Value}
\label{just-a-value}

A Scheme object that is not otherwise defined as a partial information
structure indicates that the content of the cell is
completely known, and is exactly (by \texttt{eqv?}) that object.  Note:
floating point numbers are compared by approximate numerical equality;
this is guaranteed to screw you eventually, but we don't know how to
do better.

Raw Scheme objects are \texttt{equivalent?} if they are \texttt{eqv?} (or are
approximately equal floating point numbers).

Non-\texttt{equivalent?} raw Scheme objects merge into the contradiction object.

A raw Scheme object is never \texttt{contradictory?}.

A \texttt{switch} interprets any non-\texttt{{\#}f} raw Scheme object in its
control cell as true and forwards its input cell to its output cell
unmodified.  A \texttt{switch} whose control cell is \texttt{{\#}f} emits
\texttt{nothing} to its output cell.

An apply propagator whose operator cell contains a raw Scheme
procedure will apply it to the boundary cells.  It is an error for a
raw Scheme object which is not a Scheme procedure to flow into the
operator cell of an apply propagator.


%___________________________________________________________________________

\hypertarget{numerical-intervals}{}
\pdfbookmark[1]{Numerical Intervals}{numerical-intervals}
@subsection{Numerical Intervals}
\label{numerical-intervals}

An object of type \texttt{interval?} has fields for a lower bound and an
upper bound.  Such an object represents the information ``This value is
between these bounds.''
\begin{description}
\item[{\texttt{(make-interval low high)}}] \leavevmode 
Creates an interval with the given lower and upper bounds

\item[{\texttt{(interval-low interval)}}] \leavevmode 
Extracts the lower bound of an interval

\item[{\texttt{(interval-high interval)}}] \leavevmode 
Extracts the upper bound of an interval

\item[{\texttt{(interval? thing)}}] \leavevmode 
Tests whether the given object is an interval

\end{description}

Two interval objects are \texttt{equivalent?} if they are the same
interval.  An interval is \texttt{equivalent?} to a number if both the
upper and lower bounds are that number.

Interval objects merge with each other by intersection.  Interval
object merge with numbers by treating the number as a degenerate
interval and performing intersection (whose result will either be that
number or an empty interval).  Interval objects merge with other
raw Scheme objects into the contradiction object.

An interval object is \texttt{contradictory?} if and only if it represents
a strictly empty interval (that is, if the upper bound is strictly
less than the lower bound).

The arithmetic propagators react to interval objects by performing
interval arithmetic.

A \texttt{switch} propagator treats any interval object in its control as a
non-\texttt{{\#}f} object and forwards its input to its output.

It is an error for an interval object to appear in the operator
position of an apply propagator.

As an interval arithmetic facility, this one is very primitive.  In
particular it assumes that all the numbers involved are positive.  The
main purpose of including it is to have a partial information
structure with an intuitive meaning, and that requires nontrivial
operations on the information it is over.


%___________________________________________________________________________

\hypertarget{propagator-cells-as-partial-information}{}
\pdfbookmark[1]{Propagator Cells as Partial Information}{propagator-cells-as-partial-information}
@subsection{Propagator Cells as Partial Information}
\label{propagator-cells-as-partial-information}

A propagator cell interpreted as partial information is an
indirection: it means ``I contain the structure that describes this
value''.  Cells can appear as the contents of cells or other structures
via the \texttt{deposit} and \texttt{examine} propagators
(see Section~\ref{cells-are-data-too}).

Propagator cells are \texttt{equivalent?} if they are known to contain
information about the same subject.  This occurs only if they are
identically the same cell, or if they have previously been
unconditionally identified (by merging).

Propagator cells merge with each other by attaching bidirectional
identity propagators that keep the contents of the cells in sync.
These identity propagators will cause the contents of the cells to
merge, both now and in the future.

A propagator cell is never \texttt{contradictory?}.


%___________________________________________________________________________

\hypertarget{id1}{}
\pdfbookmark[1]{Compound Data}{id1}
@subsection{Compound Data}
\label{id1}

A Scheme pair is partial information that means ``This object is a
pair.  My car and cdr contain cells that describe the car and cdr of
this object.''  A Scheme empty list means ``This object is the empty
list''.

The propagators \texttt{p:cons}, \texttt{e:cons}, \texttt{p:car}, \texttt{e:cdr},
\texttt{p:pair?}, \texttt{e:pair?}, \texttt{p:null?}, and \texttt{e:null?}
(see Section~\ref{compound-data})
introduce and examine pairs and empty lists.

Two pairs are \texttt{equivalent?} if their cars and cdrs are both
\texttt{equivalent?}.  A pair is not \texttt{equivalent?} to any non-pair.  The
empty list is only \texttt{`equivalent?} to itself.

Pairs merge by recursively merging the \texttt{car} and \texttt{cdr} fields.
Given the behavior of propagator cells as mergeable data, the effect
will be unification (with a delay instead of the occurs check).  A
pair merged with a Scheme object of a different type will produce a
contradiction.  An empty list merged with anything that is not the
empty list will produce a contradiction.

Neither a pair nor the empty list is ever \texttt{contradictory?}.

A \texttt{switch} propagator treats any pair or empty list in its control
as a non-\texttt{{\#}f} object and forwards its input to its output.

It is an error for a pair or the empty list to appear in the operator
position of an apply propagator.

Other compound data structures can be made partial information that
behaves like pairs using \texttt{define-propagator-structure}.
\begin{description}
\item[{\texttt{(define-propagator-structure type constructor accessor ...)}}] \leavevmode 
Declares that additional Scheme data structures are partial
information like pairs, and defines appropriate propagators
that handle them.  For example:
\begin{quote}{\ttfamily \raggedright \noindent
(define-propagator-structure~pair?~cons~car~cdr)
}\end{quote}
is the declaration that causes Scheme pairs to \texttt{merge}, be
\texttt{equivalent?}, and be \texttt{contradictory?} the way they are, and
defines the propagators \texttt{p:pair?}, \texttt{e:pair?}, \texttt{p:cons},
\texttt{e:cons}, \texttt{p:car}, and \texttt{e:cdr}.

\end{description}


%___________________________________________________________________________

\hypertarget{closures}{}
\pdfbookmark[1]{Closures}{closures}
@subsection{Closures}
\label{closures}

Propagator closures as mergeable data behave like a compound data
structure.  A closure is a code pointer together with an environment.
The code pointer is a Scheme procedure; the environment is a map from
names to cells, and as such is a compound structure containing cells.
Code pointers merge by testing that they point to the same code
(merging closures with different code produces a contradiction), and
environments merge by merging all the cells they contain in
corresponding places.
\begin{description}
\item[{\texttt{lambda-d:propagator}, \texttt{lambda-e:propagator}}] \leavevmode 
Scheme-Propagators syntax for anonymous compound propagator
constructors (which are implemented as closures).

\item[{\texttt{define-propagator}}] \leavevmode 
Internally produces lambda-d:propagator or lambda-e:propagator
and puts the results into appropriately named cells.

\end{description}


%___________________________________________________________________________

\hypertarget{truth-maintenance-systems}{}
\pdfbookmark[1]{Truth Maintenance Systems}{truth-maintenance-systems}
@subsection{Truth Maintenance Systems}
\label{truth-maintenance-systems}

A Truth Maintenance System (TMS) is a set of contingent values.  A
contingent value is any partial information object that describes the
``value'' in the cell, together with a set of premises.  The premises
are Scheme objects that have no interesting properties except identity
(by \texttt{eq?}).  A worldview defines which premises are believed.

The meaning of a TMS as information is the logical \texttt{and} of the
meanings of all of its contingent values.  The meaning of each
contingent value is an implication: The conjunction of the premises
implies the contingent information.  Therefore, given a worldview,
some of the contingent information is believed and some is not.  If
the TMS is queried, it produces the best summary it can of the
believed information, together with the full set of premises that
information is contingent upon.

In this system, there is a single current global worldview, which
starts out believing all premises.  The worldview may be changed to
exclude (or re-include) individual premises, allowing the user to
examine the consequences of different consistent subsets of premises.
\begin{description}
\item[{\texttt{(kick-out! premise)}}] \leavevmode 
Remove the given premise from the current worldview.

\item[{\texttt{(bring-in! premise)}}] \leavevmode 
Return the given premise to the current worldview.

\item[{\texttt{(premise-in? premise)}}] \leavevmode 
Is the given premise believed in the current worldview?

\item[{\texttt{(contingent info premises)}}] \leavevmode 
Constructs a contingency object representing the information
that the given info is contingent on the given list of premises.

\item[{\texttt{(contingent-info contingency-object)}}] \leavevmode 
The information that is contingent.

\item[{\texttt{(contingent-premises contingency-object)}}] \leavevmode 
The list of premises on which that information is contingent.

\item[{\texttt{(contingency-object-believed? contingency-object)}}] \leavevmode 
Whether the given contingency object is believed.

\item[{\texttt{(make-tms contingency-object-list)}}] \leavevmode 
Constructs a TMS with the given contingency objects as its initial
set.

\item[{\texttt{(tms-query tms)}}] \leavevmode 
Returns a contingency object representing the strongest deduction
the given TMS can make in the current worldview.  tms-query gives
the contingency with the strongest contingent information that is
believed in the current worldview.  Given that desideratum,
tms-query tries to minimize the premises that information is
contingent upon.

\end{description}

Calling \texttt{initialize-scheduler} resets the worldview to believing all
premises.

TMSes are \texttt{equivalent?} if they contain equivalent contingent
objects.  Contingent objects are equivalent if they have equivalent
info and the same set of premises.

TMSes merge by appending their lists of known contingencies (and
sweeping out redundant ones).

Strict propagators react to TMSes by querying them to obtain
ingredients for computation.  The result of a computation is
contingent on the premises of the ingredients that contribute to that
result.

If a TMS appears in the control of a \texttt{switch}, the \texttt{switch} will
first query the TMS to extract a contingent object.  The \texttt{switch}
will choose whether to forward its input or not based on the info that
is contingent, but if it does forward, it will additionally make the
result contingent upon the premises on which that info was contingent
(as well as any premises on which the input may have been contingent).
If the input itself is a TMS, \texttt{switch} queries it and (possibly)
forwards the result of the query, rather than forwarding the entire
TMS.  For example:
\begin{quote}{\ttfamily \raggedright \noindent
(define-cell~frob~(make-tms~(contingent~4~'(bill))))~\\
(define-cell~maybe-frob~(e:switch~(make-tms~(contingent~{\#}t~'(fred)))~frob))~\\
(run)~\\
(tms-query~(content~maybe-frob))~~==>~~{\#}(contingent~4~(bill~fred))
}\end{quote}

If a TMS appears in the operator cell of an apply propagator, the
apply propagator will query the TMS.  If the result of the query is a
contingent propagator constructor, the apply propagator will execute
that constructor in a sandbox that ensures that the premises on which
the constructor was contingent are both forwarded to the constructed
propagator's inputs and attached to the constructed propagator's
outputs.  For example, suppose Bill wanted us to add 3 to 4:
\begin{quote}{\ttfamily \raggedright \noindent
(define-cell~operation)~\\
(define-cell~answer)~\\
(p:switch~(make-tms~(contingent~{\#}t~'(bill)))~p:+~operation)~\\
(d@"@"~operation~3~4~answer)~\\
(run)~\\
(tms-query~(content~answer))~~==>~~{\#}(contingent~7~(bill))
}\end{quote}

The \texttt{answer} cell contains a 7 contingent on the Bill premise.  This
is the right thing, because that answer depends not only on the inputs
to the operation being performed, but also on the identity of the
operation itself.


%___________________________________________________________________________

\hypertarget{contradiction}{}
\pdfbookmark[1]{Contradiction}{contradiction}
@subsection{Contradiction}
\label{contradiction}

The Scheme object \texttt{the-contradiction} represents a completely
contradictory state of information.  If a cell ever finds itself in
such a contradictory state, it will signal an error.  The
explicit \texttt{the-contradiction} object is useful, however, for
representing contradictory information in recursive contexts.  For
example, a truth maintenance system may discover that some collection
of premises leads to a contradiction -{}-{}- this is represented by a
\texttt{the-contradiction} object contingent on those premises.
\begin{description}
\item[{\texttt{the-contradiction}}] \leavevmode 
A Scheme object representing a contradictory state of information
with no further structure.

\end{description}

\texttt{the-contradiction} is \texttt{equivalent?} only to itself.

Any information state merges with \texttt{the-contradiction} to produce
\texttt{the-contradiction}.

\texttt{the-contradiction} is \texttt{contradictory?}.

Propagators cannot operate on \texttt{the-contradiction} because any cell
containing it will signal an error before any such propagator might
run.


%___________________________________________________________________________

\hypertarget{implicit-dependency-directed-search}{}
\pdfbookmark[1]{Implicit Dependency-Directed Search}{implicit-dependency-directed-search}
@subsection{Implicit Dependency-Directed Search}
\label{implicit-dependency-directed-search}

If a cell discovers that it contains a TMS that harbors a contingent
contradiction, the cell will signal that the premises of that
contradiction form a nogood set, and that nogood set will be recorded.
For the worldview to be consistent, at least one of those premises
must be removed.  The system maintains the invariant that the current
worldview never has a subset which is a known nogood.

If a nogood set consists entirely of user-introduced premises, the
computation will be suspended, a description of the nogood set will be
printed, and the user will have the opportunity to remove an offending
premise (with \texttt{kick-out!}) and, if desired, resume the computation
(with \texttt{run}).

There is also a facility for introducing hypothetical premises that
the system is free to manipulate automatically.  If a nogood set
contains at least one hypothetical, some hypothetical from that nogood
set will be retracted, and the computation will proceed.
\begin{description}
\item[{\texttt{(p:amb cell)}, \texttt{(e:amb)}}] \leavevmode 
A propagator that emits a TMS consisting of a pair of contingencies.
One contains the information \texttt{{\#}t} contingent on one fresh
hypothetical premise, and the other contains the information \texttt{{\#}f}
contingent on anther.  \texttt{amb} also tries to maintain the invariant
that exactly one of those premises is believed.  If doing so
does not cause the current worldview to believe a known nogood set,
\texttt{amb} can just \texttt{bring-in!} one premise or the other.  If the current
worldview is such that bringing either premise in will cause a known
nogood set to be believed, then, by performing a cut, the \texttt{amb}
discovers and signals a new nogood set that does not include either
of them.  Together with the reaction of the system to nogood sets,
this induces an emergent satisfiability solver by the resolution
principle.

\item[{\texttt{(p:require cell)}, \texttt{(e:require)}}] \leavevmode 
A propagator that requires its given cell to be true (to wit,
signals contradictions if it is not).

\item[{\texttt{(p:forbid cell)}, \texttt{(e:forbid)}}] \leavevmode 
A propagator that forbids its given cell from being true (to wit,
signals contradictions if it is).

\item[{\texttt{(p:one-of input ... output)}, \texttt{(e:one-of input ...)}}] \leavevmode 
An n-ary version of \texttt{amb}.  Picks one of the objects in the given
input cells using an appropriate collection of \texttt{amb} and
\texttt{switch} propagators and puts it into its output cell.

\item[{\texttt{(require-distinct cells)}}] \leavevmode 
Requires all of the objects in its list of input cells to be
distinct (in the sense of \texttt{eqv?})

\end{description}


%___________________________________________________________________________

\hypertarget{making-new-kinds-of-partial-information}{}
\pdfbookmark[0]{Making New Kinds of Partial Information}{making-new-kinds-of-partial-information}
@section{Making New Kinds of Partial Information}
\label{making-new-kinds-of-partial-information}

The procedures defining the behavior of partial information are
generic, and therefore extensible.  The ones that define the
actual partial information types are \texttt{equivalent?}, \texttt{merge}, and
\texttt{contradictory?}, which test whether two information structures
represent the same information, merge given information structures,
and test whether a given information structure represents an
impossible state, respectively.  In addition, the primitive
propagators are equipped with generic operations for giving them
custom behaviors on the various information structures.  The
generic operation \texttt{binary-map} is very useful for the circumstance
when all the strict propagators should handle a particular
information type uniformly.

To create your own partial information structure, you should create an
appropriate Scheme data structure to represent it, and then add
handlers to the operations \texttt{equivalent?}, \texttt{merge}, and
\texttt{contradictory?} to define that data structure's interpretation as
information.  In order to do anything useful with your new information
structure, you will also need to make sure that the propagators you
intend to use with it can deal with it appropriately.  You can of
course create custom propagators that handle your partial information
structure.  Standard generic operations are also provided for
extending the built-in primitive propagators to handle new partial
information types.  Compound propagators are a non-issue because they
will just pass the relevant structures around to the appropriate
primitives.

It is also important to make sure that your new partial information
structure intermixes and interoperates properly with the existing
ones (see Section~\ref{built-in-partial-information-structures}).

Method addition in the generic operation system used in
Scheme-Propagators is done with the \texttt{defhandler} procedure:
\begin{quote}{\ttfamily \raggedright \noindent
(defhandler~operation~handler~arg-predicate~...)
}\end{quote}

The generic operations system is a predicate dispatch system.  Every
handler is keyed by a bunch of predicates that must accept the
arguments to the generic procedure in turn; if they do, that handler
is invoked.  For example, merging two intervals with each other
can be defined as:
\begin{quote}{\ttfamily \raggedright \noindent
(defhandler~merge~intersect-intervals~interval?~interval?)
}\end{quote}

You can also define your own generic operations, but that is not
relevant here.


%___________________________________________________________________________

\hypertarget{an-example-adding-interval-arithmetic}{}
\pdfbookmark[1]{An Example: Adding Interval Arithmetic}{an-example-adding-interval-arithmetic}
@subsection{An Example: Adding Interval Arithmetic}
\label{an-example-adding-interval-arithmetic}

The first step is to define a data structure to represent an interval.
Intervals have upper and lower bounds, so a Scheme record structure
with constructor \texttt{make-interval}, accessors \texttt{interval-low} and
\texttt{interval-high}, and predicate \texttt{interval?} will do.

The second step is to define handlers for the generic operations that
every partial information structure must implement.  Assuming
appropriate procedures for intersecting intervals and for testing them
for equality and emptiness, those handlers would be:
\begin{quote}{\ttfamily \raggedright \noindent
(defhandler~equivalent?~interval-equal?~interval?~interval?)~\\
(defhandler~merge~intersect-intervals~interval?~interval?)~\\
(defhandler~contradictory?~empty-interval?~interval?)
}\end{quote}

To make intervals interoperate with numbers in the same network,
we can add a few more handlers:
\begin{quote}{\ttfamily \raggedright \noindent
(define~(number=interval?~number~interval)~\\
~~(=~number~(interval-low~interval)~(interval-high~interval)))~\\
(defhandler~equivalent?~number=interval?~number?~interval?)~\\
(defhandler~equivalent?~(binary-flip~number=interval?)~interval?~number?)~\\
~\\
(define~(number-in-interval~number~interval)~\\
~~(if~(<=~(interval-low~interval)~number~(interval-high~interval))~\\
~~~~~~number~\\
~~~~~~the-contradiction))~\\
(defhandler~merge~number-in-interval~number?~interval?)~\\
(defhandler~merge~(binary-flip~number-in-interval)~interval?~number?)
}\end{quote}

The third step is to teach the arithmetic propagators to handle
intervals.  Interval arithmetic does not fit into the \texttt{binary-map}
worldview (see Section~\ref{uniform-applicative-extension-of-propagators})
so the only way to do intervals is to
individually add the appropriate handlers to the generic procedures
underlying the primitive propagators:
\begin{quote}{\ttfamily \raggedright \noindent
(defhandler~generic-+~add-interval~interval?~interval?)~\\
(defhandler~generic-{}-~sub-interval~interval?~interval?)~\\
(defhandler~generic-*~mul-interval~interval?~interval?)~\\
(defhandler~generic-/~div-interval~interval?~interval?)~\\
(defhandler~generic-sqrt~sqrt-interval~interval?)~\\
;;~...
}\end{quote}

In order for the binary propagators to handle the situation where that
propagator has an interval on one input and a number on the other,
further handlers need to be added that tell it what to do in those
circumstances.  The generic procedure system has been extended
with support for automatic coercions for this purpose.


%___________________________________________________________________________

\hypertarget{generic-coercions}{}
\pdfbookmark[1]{Generic Coercions}{generic-coercions}
@subsection{Generic Coercions}
\label{generic-coercions}

Every number can be seen as an interval (whose lower and upper bounds
are equal).  The definition of arithmetic on mixed intervals and
numbers can be deduced from the definitions of arithmetic on just
intervals, arithmetic on just numbers, and this procedure for viewing
numbers as intervals.  The generic operations system provided with
Scheme-Propagators has explicit support for this idea.
\begin{description}
\item[{\texttt{(declare-coercion-target type {[} default-coercion {]})}}] \leavevmode 
This is a Scheme macro that expands into the definitions needed to
declare \texttt{type} as something that other objects may be coerced
into.  If supplied, it also registers a default coercion from
anything declared coercible to \texttt{type}.

\texttt{declare-coercion-target} defines the procedure \texttt{type-able?},
which tests whether a given object has been declared to be coercible
to \texttt{type}, and the procedure \texttt{->type}, which does that coercion.
These rely on the type-tester for \texttt{type} already being defined and
named \texttt{type?}.  For example:
\begin{quote}{\ttfamily \raggedright \noindent
(declare-coercion-target~interval)
}\end{quote}
relies on the procedure \texttt{interval?} and defines the procedures
\texttt{->interval} and \texttt{interval-able?}.  This call does not declare a
default means of coercing arbitrary objects into intervals.

\item[{\texttt{(declare-coercion from-type to-coercer {[} mechanism {]})}}] \leavevmode 
Declares that the given \texttt{from-type} is coercible by the given
coercer operation, either by the given \texttt{mechanism} if supplied or
by the default mechanism declared in the definition of the given
coercer.  For example:
\begin{quote}{\ttfamily \raggedright \noindent
(declare-coercion~number?~->interval~(lambda~(x)~(make-interval~x~x)))
}\end{quote}
declares that Scheme number objects may be coerced to intervals
whose lower and upper bounds are equal to that number.  After this
declaration, \texttt{interval-able?} will return true on numbers, and
\texttt{->interval} will make intervals out of numbers.

\item[{\texttt{(defhandler-coercing operation handler coercer)}}] \leavevmode 
The given generic operation must be binary.  Defines handlers for
the given generic operation that have two effects: \texttt{handler} is
invoked if that operation is given two arguments of the type
corresponding to \texttt{coercer}; and if one argument is of that type
and the other has been declared coercable to that type it will be so
coerced, and then handler will be invoked.  For example:
\begin{quote}{\ttfamily \raggedright \noindent
(defhandler-coercing~generic-+~add-interval~->interval)
}\end{quote}
declares that intervals should be added by \texttt{add-interval}, and
that anything \texttt{interval-able?} can be added to an interval by
first coercing it into an interval with \texttt{->interval} and then
doing \texttt{add-interval}.  This subsumes
\begin{quote}{\ttfamily \raggedright \noindent
(defhandler generic-+ add-interval interval? interval?)
}\end{quote}

\texttt{defhandler-coercing} may only be called after a call to
\texttt{declare-coercion-target} defining the appropriate coercer and
coercability tester procedures (but the various specific coercions
may be declared later).

\end{description}


%___________________________________________________________________________

\hypertarget{the-partial-information-generics}{}
\pdfbookmark[1]{The Partial Information Generics}{the-partial-information-generics}
@subsection{The Partial Information Generics}
\label{the-partial-information-generics}

\texttt{(equivalent? info1 info2)  ==>  {\#}t or {\#}f}

The \texttt{equivalent?} procedure is used by cells to determine whether
their content has actually changed after an update.  Its job is to
ascertain, for any two partial information structures, whether they
represent the same information.  As a fast path, any two \texttt{eqv?}
objects are assumed to represent equivalent information structures.
The default operation on \texttt{equivalent?} returns false for any two
non-\texttt{eqv?} objects.

A handler for \texttt{equivalent?} is expected to accept two partial
information structures and return \texttt{{\#}t} if they represent
semantically the same information, and \texttt{{\#}f} if they do not.

The built-in \texttt{equivalent?} determines an equivalence relation.
Extensions to it must maintain this invariant.

\texttt{(merge info1 info2)  ==>  new-info}

The \texttt{merge} procedure is the key to the propagation idea.  Its job
is to take any two partial information structures, and produce a new
one that represents all the information present in both of the
input structures.  This happens every time a propagator gives a cell
some new information.  Any two \texttt{equivalent?} information structures
merge to identically the first of them.  The default operation for
\texttt{merge} on a pair of non-\texttt{equivalent?} structures that the handlers for
\texttt{merge} do not recognize is to assume that they cannot be usefully
merged, and return \texttt{the-contradiction}.

A handler for \texttt{merge} is expected to accept two partial
information structures and return another partial information
structure that semantically includes all the information present in
both input structures.  The handler may return
\texttt{the-contradiction} to indicate that the two given partial
information structures are completely mutually exclusive.

\texttt{merge} is expected to determine a (semi-)lattice (up to equivalence
by \texttt{equivalent?}).  That is
\begin{itemize}
\item {} 
associativity:
\begin{quote}{\ttfamily \raggedright \noindent
(merge~X~(merge~Y~Z))~~{\textasciitilde}~~(merge~(merge~X~Y)~Z)~\\
(equivalent?~(merge~X~(merge~Y~Z))~(merge~(merge~X~Y)~Z))~==>~{\#}t
}\end{quote}
\item {} 
commutativity:
\begin{quote}{\ttfamily \raggedright \noindent
(merge~X~Y)~~{\textasciitilde}~~(merge~Y~X)~\\
(equivalent?~(merge~X~Y)~(merge~Y~X))~==>~{\#}t
}\end{quote}
\item {} 
idempotence:
\begin{quote}{\ttfamily \raggedright \noindent
(X~{\textasciitilde}~Y)~implies~(X~{\textasciitilde}~(merge~X~Y))~\\
(or~(not~(equivalent?~X~Y))~(equivalent?~X~(merge~X~Y)))~==>~{\#}t
}\end{quote}
\end{itemize}

\texttt{(contradictory? info)  ==>  {\#}t or {\#}f}

The \texttt{contradictory?} procedure tests whether a given information
structure represents an impossible situation.  \texttt{contradictory?}
states of information may arise in the computation without causing
errors.  For example, a TMS (see Section~\ref{truth-maintenance-systems})
may contain a contradiction in
a contingent context, without itself being \texttt{contradictory?}.  But if
a \texttt{contradictory?} object gets to the top level, that is if a cell
discovers that it directly contains a \texttt{contradictory?} state of
information, it will signal an error and stop the computation.

A handler for \texttt{contradictory?} is expected to accept a partial
information structure, and to return \texttt{{\#}t} if it represents an
impossible situation (such as an empty interval) or \texttt{{\#}f} if it does
not.


%___________________________________________________________________________

\hypertarget{the-full-story-on-merge}{}
\pdfbookmark[2]{The Full Story on Merge}{the-full-story-on-merge}
\subsubsection{The Full Story on Merge}
\label{the-full-story-on-merge}

The description of \texttt{merge} as always returning a new partial
information structure is an approximation.  Sometimes, \texttt{merge} may
return a new partial information structure together with instructions
for an additional effect that needs to be carried out.  For example,
when merging two propagator cells
(see Section~\ref{propagator-cells-as-partial-information}),
the new information is just one of those cells, but the two cells also
need to be connected with propagators that will synchronize their
contents.  For another example, in Scheme-Propagators, if a merge
produces a TMS (see Section~\ref{truth-maintenance-systems})
that contains a contingent contradiction,
the premises that contradiction depends upon must be signalled as a
nogood set (that this requires signalling and is not just another
partial information structure is a consequence of an implementation
decision of TMSes in Scheme-Propagators).

The fully nuanced question that \texttt{merge} answers is
\begin{quote}

``What do I need to do to the network in order to make it reflect
the discovery that these two information structures are about the
same object?''
\end{quote}

In the common case, the answer to this question is going to be
``Record: that object is best described by this information structure''.
This answer is represented by returning the relevant information
structure directly.  Another possible answer is ``These two information
structures cannot describe the same object.''  This answer is
represented by returning \texttt{the-contradiction}.  Other answers, such
as ``Record this information structure and connect these two cells with
synchronizing propagators'', are represented by the \texttt{effectful} data
structure, which has one field for a new partial information structure
to record, and one field for a list of other effects to carry out.
These instructions are represented as explicit objects returned from
\texttt{merge} rather than being carried out directly because this allows
recursive calls to \texttt{merge} to modify the effects to account for the
context in which that \texttt{merge} occurs.  For example, if a merge of
two cells occurs in a contingent context inside a merge of two
TMSes, then the instructions to connect those two cells must be
adjusted to make the connection also contingent on the appropriate
premises.
\begin{description}
\item[{\texttt{(make-effectful info effects)}}] \leavevmode 
Constructs a new effectful result of merge, with the given new
partial information structure and the given list of effects to carry
out.  If the resulting effectful object reaches the top level in a
cell, those effects will be executed in the order they appear in the
list.

\item[{\texttt{(effectful-info effectful)}}] \leavevmode 
Returns the new information content carried in the given
effectful object.

\item[{\texttt{(effectful-effects effectful)}}] \leavevmode 
Returns the list of effects that this effectful object carries.

\item[{\texttt{(effectful? thing)}}] \leavevmode 
Tells whether the given object is an effectful object.

\item[{\texttt{(->effectful thing)}}] \leavevmode 
Coerces a possibly-effectless information structure into an
effectful object.  If the \texttt{thing} was already effectful,
returns it, otherwise wraps it into an effectful object
with an empty list of effects.

\item[{\texttt{(effectful-> effectful)}}] \leavevmode 
Attempts to coerce an effectful object into an explicitly effectless
one.  If the given effectful object was not carrying any effects
that would have any effect when executed, returns just the
information structure it was carrying.  Otherwise, returns
the given effectful object.

\item[{\texttt{(effectful-bind effectful func)}}] \leavevmode 
Runs the given \texttt{func} on the information content in the given
\texttt{effectful} object, and reattaches any effects.  The effectful
object may actually be a partial information structure without
explicit effects.  The func may return a new partial information
structure or a new effectful object.  The overall result of
\texttt{effectful-bind} is the information returned by the call to
\texttt{func}, together with all the effects in the original effectful
object, and any effects in the return value of the \texttt{func}.  The
former effects are listed first.

\item[{\texttt{(effectful-list-bind effectfuls func)}}] \leavevmode 
Like \texttt{effectful-bind}, but accepts a list of effectful objects,
and calls the \texttt{func} on the list of their information contents.

\end{description}

There are two reasons why this matters to a user of the system.
First, callers of \texttt{merge} (for example recursive ones in contexts
where a new partial information structure is defined that may contain
arbitrary other ones) must be aware that \texttt{merge} may return an
\texttt{effectful} object.  In this case, it is the responsibility of the
caller to \texttt{merge} to shepherd the effects appropriately, adjusting
them if necessary.  For example, the \texttt{merge} handler for two pairs
recursively merges the cars and cdrs of the pairs.  If either of those
recursive merges produces effects, the pair merge forwards all of
them.  Here is the code that does that:
\begin{quote}{\ttfamily \raggedright \noindent
(define~(pair-merge~pair1~pair2)~\\
~~(effectful-bind~(merge~(car~pair1)~(car~pair2))~\\
~~~~(lambda~(car-answer)~\\
~~~~~~(effectful-bind~(merge~(cdr~pair1)~(cdr~pair2))~\\
~~~~~~~~(lambda~(cdr-answer)~\\
~~~~~~~~~~(cons~car-answer~cdr-answer))))))~\\
~\\
(defhandler~merge~pair-merge~pair?~pair?)
}\end{quote}

N.B.: The car merge and the cdr merge may both produce effects.  If
so, these effects will be executed in FIFO order, that is, car effects
first, then cdr effects.  This order is an arbitrary decision that we
as the designers of Scheme-Propagators are not committed to.  All
effects built into Scheme-Propagators are independent, in that their
executions commute.

Scheme-Propagators has two built-in effect types:
\texttt{cell-join-effect}, defined in \texttt{core/cells.scm}, instructs the
system to make sure two cells are joined by synchronizing propagators;
\texttt{nogood-effect}, defined in \texttt{core/contradictions.scm}, instructs
the system to record that a list of premises constitutes a nogood set.
(The error that the system signals when discovering a toplevel
contradiction is not an effect in this sense).

Second, a new partial information structure may want to have some
side-effect when merged.  This must be accomplished through returning
an appropriate \texttt{effectful} object containing appropriate
instructions.  New types of effects can be defined for that purpose.
For example, the built-in TMSes are added to the system through this
mechanism.

The handling of effects is extensible through two generic procedures.
\begin{description}
\item[{\texttt{(execute-effect effect)}}] \leavevmode 
The \texttt{execute-effect} procedure is used by cells to actually
execute any effects that reach the top level.  A handler for
\texttt{execute-effect} should execute the effect specified by the given
effect object.  The return value of \texttt{execute-effect} is not used.

\item[{\texttt{(redundant-effect? effect)  ==>  {\#}t or {\#}f}}] \leavevmode 
The \texttt{redundant-effect?} procedure is used to determine which
effects will predictably have no effect if executed, so they may be
removed.  For example, synchronizing a cell to itself, or
synchronizing two cells that are already synchronized, are redundant
effects.  Detecting redundant effects is important for testing
network quiescence.

The default operation of \texttt{redundant-effect?} is to return \texttt{{\#}f}
for all effects, which is conservative but could lead to excess
computation in the network.  A handler for \texttt{redundant-effect?} is
expected to return \texttt{{\#}t} if the effect will provably have no
consequence on any values to be computed in the future, or \texttt{{\#}f} if
the effect may have consequences.

\end{description}

If an effect is generated by a \texttt{merge} that occurs in a contingent
context in a TMS, the TMS will modify the effect to incorporate the
contingency.  This mechanism is also extensible.  To teach TMSes
about making new effects contingent, add handlers to the generic
operation \texttt{generic-attach-premises}.
\begin{description}
\item[{\texttt{((generic-attach-premises effect) premises)  ==>  new-effect}}] \leavevmode 
The \texttt{generic-attach-premises} procedure is used by the TMS
machinery to modify effects produced by merges of contingent
information.  A handler for \texttt{generic-attach-premises} must return
a procedure that will accept a list of premises and return a new
effect, which represents the same action but appropriately
contingent on those premises.  In particular, the consequences of
the action must be properly undone or made irrelevant if any
premises supporting that action are retracted.  For example, the
instruction to join two cells by synchronizing propagators is made
contingent on premises by causing those synchronizing propagators to
synchronize contingently.

\end{description}


%___________________________________________________________________________

\hypertarget{individual-propagator-generics}{}
\pdfbookmark[1]{Individual Propagator Generics}{individual-propagator-generics}
@subsection{Individual Propagator Generics}
\label{individual-propagator-generics}

Most primitive propagators are actually built from generic Scheme functions.
Those propagators can therefore be extended to new
partial information types just by adding appropriate methods to their
Scheme generic operations.  This is what we did in the interval example.
\begin{description}
\item[{\texttt{(generic-foo argument ...)  ==>  result}}] \leavevmode 
A generic procedure for carrying out the \texttt{foo} job over any
desired partial information inputs, producing an appropriately
partial result.  \texttt{generic-abs}, \texttt{generic-square},
\texttt{generic-sqrt}, \texttt{generic-not}, \texttt{generic-pair?}, and
\texttt{generic-null?} accept one input.
\texttt{generic-+}, \texttt{generic-{}-}, \texttt{generic-*}, \texttt{generic-/},
\texttt{generic-=}, \texttt{generic-<}, \texttt{generic->}, \texttt{generic-<=},
\texttt{generic->=}, \texttt{generic-and}, \texttt{generic-or}, \texttt{generic-eq?},
\texttt{generic-eqv?}, \texttt{generic-expt}, and \texttt{generic-switch} accept two inputs.

\end{description}

Don't forget to teach the propagators what to do if they encounter
a partial information structure on one input and a different one on
another -{}-{}- if both represent states of knowledge about compatible
ultimate values, it should be possible to produce a state of knowledge
about the results of the computation (though in extreme cases that
state of knowledge might be \texttt{nothing}, implying no new information
produced by the propagator).


%___________________________________________________________________________

\hypertarget{uniform-applicative-extension-of-propagators}{}
\pdfbookmark[1]{Uniform Applicative Extension of Propagators}{uniform-applicative-extension-of-propagators}
@subsection{Uniform Applicative Extension of Propagators}
\label{uniform-applicative-extension-of-propagators}

Also, almost all primitive propagators are wrapped
with the \texttt{nary-mapping} wrapper function around their underlying
generic operation.  This wrapper function is an implementation of the
idea of applicative functors \cite{mcbride-paterson-2008-applicative-functors},
so if your partial information structure is an applicative functor, you can
use this to teach most propagators how to handle it.

The propagators wrapped in \texttt{nary-mapping} are exactly the strict
propagators.  This includes all the built-in propagators except
\texttt{:deposit}, \texttt{:examine}, \texttt{:cons}, \texttt{:car}, and \texttt{:cdr} because
those operate on cells rather than their contents, and \texttt{:amb}
because it essentially has no inputs.

\texttt{((binary-map info1 info2) f)  ==>  new-info}
The generic procedure \texttt{binary-map} encodes how to apply a strict
function to partial information arguments.  \texttt{binary-map} itself is
generic over the two information arguments, and is expected to return
a handler that will accept the desired function \texttt{f} and properly
apply it.  For example, consider contingent information.  A strict
operation on the underlying information that is actually contingent
should be applied by collecting the premises that both inputs are
contingent on, applying the function, and wrapping the result up in a
new contingency object that contains the result of the function
contingent upon the set-union of the premises from both inputs:
\begin{quote}{\ttfamily \raggedright \noindent
(define~(contingency-binary-map~c1~c2)~\\
~~(lambda~(f)~\\
~~~~(contingent~\\
~~~~~(f~(contingent-info~c1)~(contingent-info~c2))~\\
~~~~~(set-union~(contingent-premises~c1)~(contingent-premises~c2)))))~\\
~\\
(defhandler~binary-map~contingency-binary-map~contingency?~contingency?)
}\end{quote}

Note that the information inside a contingency object may itself be
partial, and so perhaps necessitate a recursive call to
\texttt{binary-map}.  This recursion is handled by the given function
\texttt{f}, and need not the invoked explicitly in handlers for
\texttt{binary-map}.

A handler for \texttt{binary-map} is expected to accept two partial
information structures and return a procedure of one argument that
will accept a binary function.  It is free to apply that function as
many or as few times as necessary, and is expected to produce the
appropriate result of ``mapping'' that function over the information in
the input partial information structures to produce a new partial
information structure, encoding all the appropriate uncertainty from
both inputs.  The given function \texttt{f}, for example as a result of
\texttt{(nary-mapping generic-switch)}, may return \texttt{nothing} even when
both of its inputs are non-\texttt{nothing}.

The \texttt{nary-mapping} wrapper works by repeated use of \texttt{binary-map}
on arguments of arity greater than two.  For unary arguments,
\texttt{nary-mapping} invokes \texttt{binary-map} with a bogus second argument.
Therefore, handlers for \texttt{binary-map} must handle
applications thereof that have your new partial information structure
as one argument, and a raw Scheme object as the other (this is a good
idea anyway, and saves the trouble of writing handlers for an explicit
\texttt{unary-map} operation).


%___________________________________________________________________________

\hypertarget{interoperation-with-existing-partial-information-types}{}
\pdfbookmark[1]{Interoperation with Existing Partial Information Types}{interoperation-with-existing-partial-information-types}
@subsection{Interoperation with Existing Partial Information Types}
\label{interoperation-with-existing-partial-information-types}

A new partial information structure may interact with an existing one
in two ways:
\begin{itemize}
\item {} 
as arguments to merge or to binary propagators

\item {} 
by containment (of and by)

\end{itemize}

The first is in general handled by making sure that \texttt{merge},
\texttt{binary-map}, and all appropriate individual propagator generic
operations have methods that can handle any combinations that may
arise.  Often, the way to deal with two information structures of
different but compatible types is to realize that one of them can be
seen as an instance of the other type.  The coercion machinery
(see Section~\ref{generic-coercions})
allows one to declare when this situation obtains so that
\texttt{defhandler-coercing} does the right thing.  The specific touch
points for this are the type testers and coercers of the existing
partial information types:
\begin{quote}{\ttfamily \raggedright \noindent
|~Type~~~~~~~~~~~~~~~~|~Predicate~~~~~~|~Coercer~~~~~~|~\\
|-{}-{}-{}-{}-{}-{}-{}-{}-{}-{}-{}-{}-{}-{}-{}-{}-{}-{}-{}-{}-+-{}-{}-{}-{}-{}-{}-{}-{}-{}-{}-{}-{}-{}-{}-{}-+-{}-{}-{}-{}-{}-{}-{}-{}-{}-{}-{}-{}-{}-|~\\
|~Nothing~~~~~~~~~~~~~|~nothing?~~~~~~~|~-{}-~~~~~~~~~~~|~\\
|~Raw~Scheme~object~~~|~various~~~~~~~~|~-{}-~~~~~~~~~~~|~\\
|~Numerical~interval~~|~interval?~~~~~~|~->interval~~~|~\\
|~Propagator~cells~~~~|~cell?~~~~~~~~~~|~-{}-~~~~~~~~~~~|~\\
|~Scheme~pairs~~~~~~~~|~pair?~~~~~~~~~~|~-{}-~~~~~~~~~~~|~\\
|~Propagator~closures~|~closure?~~~~~~~|~-{}-~~~~~~~~~~~|~\\
|~Contingency~object~~|~contingent?~~~~|~->contingent~|~\\
|~TMS~~~~~~~~~~~~~~~~~|~tms?~~~~~~~~~~~|~->tms~~~~~~~~|~\\
|~Contradiction~~~~~~~|~contradictory?~|~-{}-~~~~~~~~~~~|~\\
|-{}-{}-{}-{}-{}-{}-{}-{}-{}-{}-{}-{}-{}-{}-{}-{}-{}-{}-{}-{}-+-{}-{}-{}-{}-{}-{}-{}-{}-{}-{}-{}-{}-{}-{}-{}-+-{}-{}-{}-{}-{}-{}-{}-{}-{}-{}-{}-{}-{}-|
}\end{quote}

Notes:
\begin{itemize}
\item {} 
The \texttt{nothing} information structure defines methods on \texttt{merge}
and the propagators that do the right thing for any other object, so
does not require any additional effort.

\item {} 
TMSes automatically coerce to TMS any object that is declared
coercible to a raw contingency object.

\end{itemize}

For example:
\begin{quote}{\ttfamily \raggedright \noindent
(declare-coercion~interval?~->contingent)
}\end{quote}
allows raw intervals to be seen as TMSes.  This has the effect that if
a binary operation (either \texttt{merge} or a primitive propagator subject
to \texttt{nary-mapping}) encounter a TMS on one input and an interval on
the other, it will coerce the interval to a TMS containing exactly
that interval contingent on the empty set of premises, and then
operate on those two structures as on TMSes.

The second kind of interoperation is handled by correctly dealing with
merge effects (see Section~\ref{the-full-story-on-merge}).
If you make a new partial information
structure that contains others, you must make sure to handle any merge
effects that may arise when recursively merging the partial
information your structure contains.  If you make a new partial
information structure that may need to have effects performed on
merge, you should return those as appropriate merge effects in an
\texttt{effectful} structure, and, if you need to create new kinds of
effects in addition to the built-in ones, you should extend the
generic operations \texttt{execute-effect}, \texttt{redundant-effect?}, and
\texttt{generic-attach-premises} (Section~\ref{the-full-story-on-merge}).


%___________________________________________________________________________

\hypertarget{making-new-primitive-propagators}{}
\pdfbookmark[0]{Making New Primitive Propagators}{making-new-primitive-propagators}
@section{Making New Primitive Propagators}
\label{making-new-primitive-propagators}

Almost all definition of new primitive propagators can be handled
correctly either by \texttt{propagatify} or by
\texttt{define-propagator-structure} (see Section~\ref{id1}).
We discuss the
lower-level tools first, however.


%___________________________________________________________________________

\hypertarget{direct-construction-from-functions}{}
\pdfbookmark[1]{Direct Construction from Functions}{direct-construction-from-functions}
@subsection{Direct Construction from Functions}
\label{direct-construction-from-functions}

The fundamental way to make your own primitive propagators is
the procedure \texttt{function->propagator-constructor}.  It takes a Scheme
function, and makes a propagator construction procedure out of it that
makes a propagator that does the job implemented by that Scheme
function.  The propagator constructor in question takes one more
argument than the original function, the extra argument being the cell
into which to write the output.  So the result of
\texttt{function->propagator-constructor} is a diagram-style procedure
(complete with (most of) the debugging information, and the constant
conversion).  The return value of \texttt{function->propagator-constructor}
can be put into a cell, just same way that a Scheme procedure
can be the value of a Scheme variable.  For example, you might define:
\begin{quote}{\ttfamily \raggedright \noindent
(define-cell~p:my-primitive~(function->propagator-constructor~do-it))
}\end{quote}
where \texttt{do-it} is the appropriate Scheme function.

Something important to pay attention to: \texttt{function->propagator-constructor}
wraps the given function up into a propagator directly, and it is up
to the function itself to handle any interesting partial information
type that might come out of its argument cells.  Notably, \texttt{nothing}
might show up in the arguments of that function when it is called.
Therefore, it may be appropriate the make the function itself generic,
and/or wrap it in \texttt{nary-mapping}.

For example, let us walk through the implementation of the provided
primitive \texttt{p:and} in \texttt{core/standard-propagators.scm}.  First, we
make a generic version of the Scheme procedure \texttt{boolean/and} to
serve as a point of future extension:
\begin{quote}{\ttfamily \raggedright \noindent
(define~generic-and~(make-generic-operator~2~'and~boolean/and))
}\end{quote}

Then we wrap that generic procedure with \texttt{nary-mapping} to make it
process all partial information types that have declared applicative
functor behavior, and then we give the result to
\texttt{function->propagator-constructor} to make a propagator
constructor:
\begin{quote}{\ttfamily \raggedright \noindent
(define-cell~p:and~\\
~~(function->propagator-constructor~(nary-mapping~generic-and)))
}\end{quote}

Another detail to think about is metadata.
\texttt{function->propagator-constructor} can supply all the metadata that
the debugger uses except the name of your function.  If your function
is generic, the generic machinery already expects a name; otherwise,
you need to supply the name yourself, with \texttt{(name!  your-function
'some-name)}.


%___________________________________________________________________________

\hypertarget{expression-style-variants}{}
\pdfbookmark[2]{Expression Style Variants}{expression-style-variants}
\subsubsection{Expression Style Variants}
\label{expression-style-variants}

Once you've made a diagram-style propagator constructor, you can make
a variant that likes to be applied in expression style with
\texttt{expression-style-variant}.  For example, \texttt{e:and} is actually
defined as:
\begin{quote}{\ttfamily \raggedright \noindent
(define-cell~e:and~(expression-style-variant~p:and))
}\end{quote}


%___________________________________________________________________________

\hypertarget{propagatify}{}
\pdfbookmark[1]{Propagatify}{propagatify}
@subsection{Propagatify}
\label{propagatify}

All that wrapping in \texttt{nary-mapping}, and naming your propagator
functions with \texttt{name!}, and calling \texttt{expression-style-variant} to
convert them to expression-style versions can get tedious.  This whole
shebang is automated by the \texttt{propagatify} macro:
\begin{quote}{\ttfamily \raggedright \noindent
(propagatify~+)
}\end{quote}
turns into
\begin{quote}{\ttfamily \raggedright \noindent
(define~generic-+~(make-generic-operator~2~'+~+))~\\
(define-cell~p:+~\\
~(function->propagator-constructor~(nary-mapping~generic-+)))~\\
(define-cell~e:+~(expression-style-variant~p:+))
}\end{quote}

The easy syntax covers the common case.  You can also specify an
explicit arity for the generic operation to construct (because
sometimes \texttt{propagatify} will guess wrong).  The above is also
equivalent to \texttt{(propagatify + 2)}.  Sometimes you may want to avoid
constructing the generic operation.  That can be done also:
\begin{quote}{\ttfamily \raggedright \noindent
(propagatify~+~'no-generic)
}\end{quote}
becomes
\begin{quote}{\ttfamily \raggedright \noindent
(define-cell~p:+~\\
~(function->propagator-constructor~(nary-mapping~+)))~\\
(define-cell~e:+~(expression-style-variant~p:+))
}\end{quote}

Finally, in the case where you want completely custom handling of
partial information, even the \texttt{nary-mapping} can be avoided with
\begin{quote}

(propagatify-raw +)
\end{quote}
which becomes
\begin{quote}{\ttfamily \raggedright \noindent
(define-cell~p:+~(function->propagator-constructor~+))~\\
(define-cell~e:+~(expression-style-variant~p:+))
}\end{quote}

Note that \texttt{propagatify} follows the naming convention that the
Scheme procedure \texttt{foo} becomes a generic procedure named
\texttt{generic-foo} and then turns into propagators \texttt{p:foo} and
\texttt{e:foo}.


%___________________________________________________________________________

\hypertarget{compound-cell-carrier-construction}{}
\pdfbookmark[1]{Compound Cell Carrier Construction}{compound-cell-carrier-construction}
@subsection{Compound Cell Carrier Construction}
\label{compound-cell-carrier-construction}

\texttt{p:cons} is an interesting propagator, because while it performs the
job of a Scheme procedure (to wit, \texttt{cons}), it operates directly on
the cells that are its arguments, rather than on their contents.
Other compound data structures can be made partial information that
behaves like pairs using \texttt{define-propagator-structure}.
\begin{description}
\item[{\texttt{(define-propagator-structure type constructor accessor ...)}}] \leavevmode 
Declares that additional Scheme data structures are partial
information like pairs, and defines appropriate propagators
that handle them.  For example:
\begin{quote}{\ttfamily \raggedright \noindent
(define-propagator-structure~pair?~cons~car~cdr)
}\end{quote}
defines the propagators \texttt{p:pair?}, \texttt{e:pair?}, \texttt{p:cons},
\texttt{e:cons}, \texttt{p:car}, and \texttt{e:cdr} (and also makes pairs
a partial information structure).

\end{description}

Defining \texttt{p:cons} to operate on its argument cells constitutes a
decision to follow the ``carrying cells'' rather than the ``copying data''
strategy from the propagator thesis.


%___________________________________________________________________________

\hypertarget{fully-manual-low-level-propagator-construction}{}
\pdfbookmark[1]{Fully-manual Low-level Propagator Construction}{fully-manual-low-level-propagator-construction}
@subsection{Fully-manual Low-level Propagator Construction}
\label{fully-manual-low-level-propagator-construction}

Finally, when the thing you want your propagator to do is so low-level and
interesting that it doesn't even correspond to a Scheme function,
there's always the \texttt{propagator} procedure.  This is the lowest level
interface to asking cells to notify a propagator when they change.
\texttt{propagator} expects a list of cells that your propagator is
interested in, and a thunk that implements the job that propagator is
supposed to do.  The scheduler will execute your thunk from time to
time -{}-{}- the only promise is that it will run at least once after the
last time any cell in the supplied neighbor list gains any new
information.  For example:
\begin{quote}{\ttfamily \raggedright \noindent
(define~(my-hairy-thing~cell1~cell2)~\\
~~(propagator~(list~cell1~cell2)~\\
~~~~(lambda~()~\\
~~~~~~do-something-presumably-with-cell1-and-cell2)))
}\end{quote}

The \texttt{propagator} procedure being the lowest possible level, it has
no access to any useful sources of metadata, so you will need to
provide yourself any metadata you want to be able to access later.
For an example of how this facility is used, see the implementations
of \texttt{function->propagator-constructor} and
\texttt{delayed-propagator-constructor} in \texttt{core/propagators.scm}.


%___________________________________________________________________________

\hypertarget{debugging}{}
\pdfbookmark[0]{Debugging}{debugging}
@section{Debugging}
\label{debugging}

There is no stand-alone ``propagator debugger''; if something goes
wrong, the underlying Scheme debugger is your friend.  Some effort
has, however, been expended on making your life easier.

In normal operation, Scheme-Propagators keeps track of some metadata
about the network that is running.  This metadata can be invaluable
for debugging propagator networks.  The specific data it tries to
track is:
\begin{itemize}
\item {} 
The names (non-unique but semantic) of all the cells and
propagators.  This is in contrast with the unique but non-semantic
object hashes of all the cells and propagators that MIT Scheme
tracks anyway.

\item {} 
Which propagators are connected to which cells.

\item {} 
Whether the connections are input, output, or both.

\end{itemize}

To make sure that your network tracks this metadata well, you should
use the high level interfaces to making cells, propagators, and
propagator constructors when possible (\texttt{define-cell}, \texttt{let-cells},
\texttt{define-propagator}, \texttt{propagatify}, etc).  Any gaps not
filled by use of these interfaces must either be accepted as gaps or
be filled by hand.

In order to use the metadata for debugging, you must be able to read
it.  Inspection procedures using the metadata are provided:
\begin{description}
\item[{name}] \leavevmode 
the name of an object, or the object itself if it is not named

\item[{cell?}] \leavevmode 
whether something is a cell or not

\item[{content}] \leavevmode 
the information content of a cell

\item[{propagator?}] \leavevmode 
whether something is a propagator or not

\item[{propagator-inputs}] \leavevmode 
the inputs of a propagator (a list of cells)

\item[{propagator-outputs}] \leavevmode 
the outputs of a propagator (a list of cells)

\item[{neighbors}] \leavevmode 
the readers of a cell (a list of propagators)

\item[{cell-non-readers}] \leavevmode 
other propagators somehow associated with a cell (presumably ones
that write to it)

\item[{cell-connections}] \leavevmode 
all propagators around a cell (the append of the neighbors
and the non-readers)

\end{description}

You can use these at least somewhat to wander around a network you are
debugging.  Be advised that cells are represented as Scheme entities
and propagators are represented as Scheme procedures, so neither print
very nicely at the REPL.

If you find yourself doing something strange that circumvents the
usual metadata tracking mechanisms, you can add the desired metadata
yourself.  All the metadata collection procedures are defined in
\texttt{core/metadata.scm}; they generally use the \texttt{eq-properties}
mechanism in \texttt{support/eq-properties.scm} to track the metadata, so
you can use it to add more.  In particular, see the definition of, say,
\texttt{function->propagator-constructor} or \texttt{define-propagator}
for examples of how this is done.


%___________________________________________________________________________

\hypertarget{miscellany}{}
\pdfbookmark[0]{Miscellany}{miscellany}
@section{Miscellany}
\label{miscellany}


%___________________________________________________________________________

\hypertarget{macrology}{}
\pdfbookmark[1]{Macrology}{macrology}
@subsection{Macrology}
\label{macrology}

Sometimes you will need to make something that looks like a macro to
Scheme-Propagators.  The macro language of Scheme-Propagators is
Scheme.  For example:
\begin{quote}{\ttfamily \raggedright \noindent
(define~(my-diagram~x~y~z)~\\
~~(p:+~x~y~z)~\\
~~(p:-~z~y~x)~\\
~~(p:-~z~x~y))
}\end{quote}

\texttt{my-diagram} is a Scheme-Propagators macro that, when given three
cells, wires up three arithmetic propagators to them.  This simple
example of course gains nothing from being a macro rather
than a normal compound propagator, but using Scheme as a macro
language lets you do more interesting things:
\begin{quote}{\ttfamily \raggedright \noindent
(define~(require-distinct~cells)~\\
~~(for-each-distinct-pair~\\
~~~(lambda~(c1~c2)~\\
~~~~~(forbid~(e:=~c1~c2)))~\\
~~~cells))
}\end{quote}

This \texttt{require-distinct} uses a Scheme iterator to perform a
repetitive task over a bunch of Scheme-Propagators cells.

This is quite convenient, but sometimes one wants the debugging data
provided by \texttt{define-propagator}.  This is what
\texttt{define-propagator-syntax} is for.  Just change \texttt{define} to
\texttt{define-propagator-syntax}:
\begin{quote}{\ttfamily \raggedright \noindent
(define-propagator-syntax~(require-distinct~cells)~\\
~~(for-each-distinct-pair~\\
~~~(lambda~(c1~c2)~\\
~~~~~(forbid~(e:=~c1~c2)))~\\
~~~cells))
}\end{quote}


%___________________________________________________________________________

\hypertarget{reboots}{}
\pdfbookmark[1]{Reboots}{reboots}
@subsection{Reboots}
\label{reboots}

The procedure \texttt{initialize-scheduler} wipes out an existing
propagator network and lets you start afresh:
\begin{quote}{\ttfamily \raggedright \noindent
build~lots~of~network~\\
...~\\
(initialize-scheduler)~\\
(run)~-{}-{}-~nothing~happens;~no~propagators~to~run!
}\end{quote}

This is the lightest-weight way to restart your Scheme-Propagators
session.  You can of course also restart the underlying Scheme or just
reload Scheme-Propagators if you need to blow away your state.


%___________________________________________________________________________

\hypertarget{compiling}{}
\pdfbookmark[1]{Compiling}{compiling}
@subsection{Compiling}
\label{compiling}

It turns out that \texttt{make-cell} and \texttt{cell?} are also MIT Scheme
primitives, so if you want to compile your Scheme-Propagators
code with the MIT-Scheme compiler, be sure to put
\begin{quote}{\ttfamily \raggedright \noindent
(declare~(usual-integrations~make-cell~cell?))
}\end{quote}
at the top of your source files.  Also, of course, you need to be
suitably careful to make sure that the defined macros are available to
the syntaxer when it processes your file.  See
\texttt{support/auto-compilation.scm} for how I do this, and, say,
\texttt{core/load.scm} for how I use the compiler.


%___________________________________________________________________________

\hypertarget{scmutils}{}
\pdfbookmark[1]{Scmutils}{scmutils}
@subsection{Scmutils}
\label{scmutils}

The \href{http://groups.csail.mit.edu/mac/users/gjs/6946/linux-install.htm}{Scmutils} system built by Gerald Jay Sussman and friends for
thinking about physics can be very useful for many purposes.  Among
other things, it knows about units and dimensions, about symbolic
algebra, about solving systems of equations, etc.  Scheme-Propagators
runs in Scmutils just as well as in MIT Scheme.  Some
Scheme-Propagators examples that depend upon the ability to manipulate
symbolic expressions and solve symbolic systems of equations are
included.


%___________________________________________________________________________

\hypertarget{editing}{}
\pdfbookmark[1]{Editing}{editing}
@subsection{Editing}
\label{editing}

We edit code in Emacs.  You should edit code in Emacs too.  Emacs of
course has a Scheme mode; nothing more need be said about that here.

If you are going to edit any parenthesized source code in Emacs,
\href{http://www.emacswiki.org/emacs/ParEdit}{Paredit mode} is an option you should not overlook.

In addition to the above, we find it very useful to have Emacs
highlight and indent some of the Scheme-Propagators macros we have
defined the same way as their Scheme analogues; notably
\texttt{define-propagator} and \texttt{let-cells}.  Sadly the
Emacs Scheme mode does not do this by default, so you need to tweak
the Emacs config to do that.  The file \texttt{support/scm-propagators.el}
contains a dump of the relevant portion of my Emacs configuration.

There is at present no Emacs mode for Scheme-Propagators as distinct
from Scheme.


%___________________________________________________________________________

\hypertarget{hacking}{}
\pdfbookmark[1]{Hacking}{hacking}
@subsection{Hacking}
\label{hacking}

Scheme-Propagators is a work in progress.  Be aware that we will
continue to hack it.  Likewise, feel free to hack it as well -{}-{}- let
us know if you invent or implement something interesting.  May the
Source be with you.


%___________________________________________________________________________

\hypertarget{arbitrary-choices}{}
\pdfbookmark[1]{Arbitrary Choices}{arbitrary-choices}
@subsection{Arbitrary Choices}
\label{arbitrary-choices}

Several language design choices affecting the structure of
Scheme-Propagators appeared arbitrary at the time they were made.


%___________________________________________________________________________

\hypertarget{default-application-and-definition-style}{}
\pdfbookmark[2]{Default Application and Definition Style}{default-application-and-definition-style}
\subsubsection{Default Application and Definition Style}
\label{default-application-and-definition-style}

Diagram style application was picked as the default over
expression style when applying cells whose contents are not yet known,
and for defining compound propagators when the style is not specified
more clearly.  The main rationale for this decision was an attempt to
emphasize the interesting property of Scheme-Propagators and the
propagator programming model.  The unusual expressive power of fan-in
that the propagator model offers can be taken advantage of only if at
least some of one's code actually has fan-in, and writing code with
fan-in requires diagram style.


%___________________________________________________________________________

\hypertarget{locus-of-delayed-construction}{}
\pdfbookmark[2]{Locus of Delayed Construction}{locus-of-delayed-construction}
\subsubsection{Locus of Delayed Construction}
\label{locus-of-delayed-construction}

There was a choice about where to put the delaying of pieces
of propagator network that should be constructed only conditionally.
Every recursion traverses an abstraction boundary and a conditional
statement every time it goes around.  Every recursion must encounter
at least one delay barrier every time it goes around, or the
construction of the network may generate spurious infinite regresses.
But where should that barrier go?  There were three plausible
alternatives: the first idea was to put the barrier around the
application of recursive compound propagators; the second was to
generalize this to put it around the application of all compound
propagators; and the third was to capture the bodies of conditional
expressions like \texttt{p:if} and delay only their construction.  During
most of the development of Scheme-Propagators, we were using option 1,
on the grounds that it sufficed and was easy to implement.  Doing this
had the effect that in order to actually make a proper recursive
propagator, one had to manually ``guard'', using a hand-crafted pile of
\texttt{switch} propagators, all the i/o of a recursive call to prevent it
from being expanded prematurely.  For example, a recursive factorial
network written in that style would have looked something like:
\begin{quote}{\ttfamily \raggedright \noindent
(define-propagator~(p:factorial~n~n!)~\\
~~(let-cells~((done?~(e:=~n~0))~n-again~n!-again)~\\
~~~~(p:conditional-wire~(e:not~done?)~n~n-again)~\\
~~~~(p:conditional-wire~(e:not~done?)~n!~n!-again)~\\
~~~~(p:*~(e:factorial~(e:-~n-again~1))~n-again~n!-again)~\\
~~~~(p:conditional-wire~done?~1~n!)))
}\end{quote}
with the added caveat that it would need to be marked as being
recursive, so the expansion of the internal factorial would be delayed
until it got some information on its boundary (which would be
prevented from happening in the base case by the \texttt{conditional-wire}
propagators).  As the system matured, we decided to write a
series of macros (\texttt{p:when}, \texttt{p:unless}, \texttt{p:if}, and their
expression-style variants) that automated the process of constructing
those \texttt{conditional-wire} propagators.  On making these macros work,
we realized that adjusting \texttt{p:when} and company to delay their
interior would be just as easy as delaying the opening of
abstractions.  At that point we decided to switch to doing it that
way, on the grounds that, since \texttt{if} is special in all other computer
languages, so it might as well be special here too, and we will leave
the operation of abstractions relatively simple.  (Partial information
makes abstractions complicated enough as it is!)  This has the further
nice feature that it sidesteps a possible bug with delayed
abstractions: if one wanted to create a nullary
abstraction, automatic delay of its expansion would presumably not be
what one wanted.


%___________________________________________________________________________

\hypertarget{strategy-for-compound-data}{}
\pdfbookmark[2]{Strategy for Compound Data}{strategy-for-compound-data}
\subsubsection{Strategy for Compound Data}
\label{strategy-for-compound-data}

The decision to go with the carrying cells strategy for
compound data felt, while not really arbitrary, at least enough not
forced by the rest of the design to be worth some mention.  The topic
is discussed at length elsewhere, and the available options detailed;
so here we will just note why we ended up choosing carrying cells.
For a long time, copying data seemed like the right choice, because it
avoided spooky ``action at a distance''; and merges did not require
changing the structure of the network.  The downside of copying data,
namely the cost of the copying, seemed small enough to ignore.  Then
we tried to write a program for thinking about electrical circuits.

The specific killer part of the electrical circuits program was that
we tried to equip it with observers that built a data structure for
every circuit element containing its various parameters and state
variables, and for every subcircuit a data structure containing its
circuit elements, all the way up.  When this program turned out to be
horribly slow, we realized that copying data actually produces a
quadratic amount of work: every time any circuit variable is updated,
the whole chain of communication all the way from resistor to complete
breadboard is activated, and they repeat merges of all the compounds
that they had accumulated, just to push that one little piece of
information all the way to the toplevel observer.  In addition, these
summary structures turned out to be less useful for debugging than we
had hoped, because the updates of the summary structures would be
propagator operations just like the main computation, so when the
latter would stop for some strange reason, we always had to wonder
whether the summaries were up to date.

Carrying cells seemed an appealing solution to both problems.  If the
summaries carried cells instead of copying data, then updates to those
cells would not have to trouble the whole pipe by which the cells were
carried, but would just be transmitted through those cells.  Also, if
we played our cards right, we should have been able to arrange for
exactly the cells where the computation was actually happening to be
the ones carried all the way to where we could get them from those
summary structures, so that the summaries would always be up to date
with the underlying computation.  But what about the pesky fact that
merging structures that carry cells requires side effects on the
network?  What if that merge is contingent on some premises because
the cell-carriers are in some TMS?

That was when merge effects were invented.  We realized that merging
really should have legitimate side effects on the network, but should
package those effects up in manipulable objects that it returns,
instead of trying to just execute them.  So the question that merge
answers was changed from
\begin{quote}

What is the least-commitment information structure that captures
all the knowledge in these two information structures?
\end{quote}
to
\begin{quote}

What needs to be done to the network in order to make it reflect the
discovery that these two information structures are about the same
object?
\end{quote}

The latter nicely subsumes the former: a normal merge is just the
answer ``record in the appropriate cell that the object of interest is
described by this information structure''.  So everything fell into
place.  The strange \texttt{set!} in the most basic definition of the cell
is, indeed, an effect that needs to be performed on the network to
acknowledge the discovery that two particular information structures
are about the same object.  The even stranger error signalled on
contradiction is an effect too: the thing that needs to be done to the
network to reflect the discovery that two completely incompatible
information structures describe the same object is to crash.  And now
both merging cells carried by compound structures and signalling
nogoods by TMSes become perfectly reasonable, respectable citizens of
the propagator world; and they can interoperate with being contingent
by the enclosing TMS modifying the effects to reflect the context in
which they were generated before passing them on up out of its own
call to merge.

With that change of perspective on merging, a whole chunk of problems
suddenly collapsed.  Cells could be merged with a simple ``link these
two with (conditional) identity propagators''.  Therefore compound data
could be merged by recursively merging their fields, regardless of
whether they were carrying cells or other partial information
structures.  Closures fell into place -{}-{}- they were just a particular
kind of compound data, and merged the way compound data merges.
Closures had been a conceptual problem for the copying data view of
the world, because closures really felt like they wanted to able to
attach their interior propagators to cells closed over from the
enclosing lexical environment; but for that, it seemed that the
lexical environment would need to be a cell-carrying data structure.
But now that carrying cells works, there is no problem.  It was on
that wave of euphoria that the carrying cells strategy rode into its
current place as the standard way to make compound structures in the
propagator world.  Carrying cells certainly still feels cleaner and
nicer than copying data; but it may be that copying data really could
still be made to work in all the scenarios where carrying cells is
currently winning.  We just decided not to pursue that path.

And on the note of copying data being preferable because it preserves
locality, maybe \texttt{cons} really should be the locality-breaking object.


%___________________________________________________________________________

\hypertarget{how-this-supports-the-goal}{}
\pdfbookmark[0]{How this supports the goal}{how-this-supports-the-goal}
@section{How this supports the goal}
\label{how-this-supports-the-goal}

We started with the goal of making it easier for people to build
systems that are additive.  A system should not become so
interdependent that it is difficult to extend its behavior to
accommodate new requirements.  Small changes to the behavior should
entail only small changes to the implementation.  These are tough
goals to achieve.

Systems built on the Propagator Model of computation can approach some
of these goals.

A key idea is to allow fan-in, merging partial results.  A result may
be computed in multiple ways, by complementary processes.  There may
be multiple ways to partially contribute to a result; these
contributions are merged to make better approximations to the desired
result.  Partial results can be used as a base for further
computations, which may further refine known values or partially
determine new ones.  So we can make effective use of methods that give
only part of an answer, depending on other methods to fill in missing
details.  This ability to absorb redundant and partial computations
contributes to additivity: it is easy to add new propagators that
implement additional ways to compute any part of the information about
a value in a cell.

The Propagator Model is intrinsically parallel.  Each component may be
thought of as continually polling its neighbor cells and doing what it
can to improve the state of knowledge.  Any parallel system will have
race conditions, but the paradigm of monotonically accumulating
information makes them irrelevant to the final results of a
computation.

A propagator network can incorporate redundant ways to compute each
result.  These can contribute to integrity and resiliency:
computations can proceed along multiple variant paths and invariants
can be cross-checked to assure integrity.

Dependency tracking and truth maintenance contribute to additivity in
a different way.  If you want to add a new pile of stuff, you don't
need to worry too much about whether or not it will be compatible with
the old: just make it contingent on a fresh premise.  If the addition
turns out to conflict with what was already there, it (or the
offending old thing) can be ignored, locally and dynamically, by
retracting a premise.  Dependency tracking also decreases the amount
each module needs to know about its interlocutors; for example,
instead of having to guess which square root a client wants, the
\texttt{sqrt} routine can return both of them, contingent on different
premises, and let the eventual users decide which ones they wanted.

Dependency tracking is natural in the propagator model.  By contrast
with a traditional computational model, the propagator model has no
defined order of computation, except as dictated by the data flow.
Thus, no spurious dependencies arise from the ordering of operations,
making the real dependencies easier to track.

A propagator program is analogous to an electrical circuit diagram,
whereas a program written for a more traditional model is more like a
system diagram: the intellectual viewpoint of the Propagator Model of
computation is not the composition of functions, as in traditional
models, but is rather the construction of mechanisms.  The difference
is profound:
\begin{quote}
\newcounter{listcnt0}
\begin{list}{\arabic{listcnt0}.}
{
\usecounter{listcnt0}
\setlength{\rightmargin}{\leftmargin}
}
\item {} 
circuit models are multidirectional; system diagrams compute
from inputs to outputs.

\item {} 
circuit models are abstractions of physics; system diagrams
are abstractions of process.

\end{list}
\end{quote}

The circuit diagram viewpoint gives us powerful ways to think.  We can
modify a circuit diagram by clipping out a part, or by installing a
different version.  We can temporarily carry information from one
place to another using a clip lead.  We have lots of places to connect
various kinds of meters for monitoring and debugging.

Now for something completely different!  Scheme-Propagators is built
with dynamically-extensible generic operations.  The pervasive
\texttt{merge} operation, as well as all the primitive propagators, are
generic, and this makes it easier for us to add new forms of partial
information.  Adding new forms of partial information is a way to
extend the capabilities of the propagation infrastructure to novel
circumstances.  With appropriate foresight, new partial information
structures can interoperate with old, and additively extend the
capabilities of existing systems -{}-{}- a way to teach old dogs new
tricks.  Of course, such power is dangerous: if a network that depends
on commutativity of multiplication of numbers meets an extension to
square matrices, we will get wrong answers.  But then, cross-checking
across complementary methods, together with dependency tracking,
simplifies the task of debugging such errors.

\bibliographystyle{plain}
\bibliography{revised-auto}

\end{document}
