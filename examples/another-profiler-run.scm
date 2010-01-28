MIT/GNU Scheme running under GNU/Linux
Type `^C' (control-C) followed by `H' to obtain information about interrupts.

Copyright (C) 1986, 1987, 1988, 1989, 1990, 1991, 1992, 1993, 1994,
    1995, 1996, 1997, 1998, 1999, 2000, 2001, 2002, 2003, 2004, 2005,
    2006, 2007 Massachusetts Institute of Technology
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

Image saved on Wednesday May 9, 2007 at 11:01:27 AM
  Release 7.7.90.+ || Microcode 14.18 || Runtime 15.7 || SF 4.41 || LIAR 4.118
  Edwin 3.116
;Loading "/home/axch/.scheme.init"... 
;  Loading "/home/axch/lib/require-ideas.scm"... done
;... done

1 ]=> (pwd)

;Value 11: #[pathname 11 "/home/axch/phd/thesis/new-art/"]

1 ]=> (cd "..")

;Value 12: #[pathname 12 "/home/axch/phd/thesis/"]

1 ]=> (load "extensions/load")

;Loading "extensions/load.scm"... 
;  Loading "../testing/load.com"... done
;  Loading "portability.scm"... 
;    Loading "mitscheme-conditions.scm"... done
;    Loading "load.scm"... 
;      Loading "sos-unx.pkd"... done
;      Loading "slot.com"... done
;      Loading "class.com"... done
;      Loading "instance.com"... done
;      Loading "method.com"... done
;      Loading "printer.com"... done
;      Loading "macros.com"... done
;    ... done
;  ... done
;  Loading "ordered-map.scm"... done
;  Loading "matching.scm"... done
;  Loading "assertions.scm"... done
;  Loading "test-runner.scm"... done
;  Loading "test-group.scm"... done
;  Loading "testing.scm"... done
;  Loading "../load.scm"... 
;    Loading "profiler.com"... done
;    Loading "new-art/load.scm"... 
;      Loading "../testing/load.com"... done
;      Loading "portability.scm"... 
;        Loading "mitscheme-conditions.scm"... done
;      ... done
;      Loading "ordered-map.scm"... done
;      Loading "matching.scm"... done
;      Loading "assertions.scm"... done
;      Loading "test-runner.scm"... done
;      Loading "test-group.scm"... done
;      Loading "testing.scm"... done
;      Loading "utils.com"... done
;      Loading "ghelper.com"... done
;      Loading "../literate/load.com"... done
;      Loading "regex-literals.scm"... done
;      Loading "read.scm"... done
;      Loading "test-support.scm"... done
;      Loading "scheduler.com"... done
;      Loading "data-structure-definitions.com"... done
;      Loading "art.com"... done
;      Loading "naive-primitives.com"... done
;      Loading "generic-primitives.com"... done
;      Loading "generic-primitives-1-1.com"... done
;      Loading "generic-primitives-2.com"... done
;      Loading "generic-primitives-3.com"... done
;      Loading "masyu.com"... done
;    ... done
;    Loading "conditionals.com"... done
;    Loading "abstraction.com"... done
;    Loading "compound-data.com"... done
;    Loading "test/load.scm"... 
;      Loading "profiler-test.scm"... done
;      Loading "partial-compounds-test.scm"... done
;      Loading "switches-test.scm"... done
;      Loading "compound-merges-test.scm"... done
;    ... done
;  ... done
;  Loading "eq-properties.scm"... done
;  Loading "art-expression-language.scm"... done
;  Loading "constraints.scm"... done
;  Loading "electric-parts.scm"... done
;  Loading "solve.scm"... done
;  Loading "symbolics.scm"... done
;  Loading "functional-reactivity.scm"... done
;  Loading "test/load.scm"... 
;    Loading "symbolics-test.scm"... done
;    Loading "voltage-divider-test.scm"... done
;    Loading "functional-reactive-test.scm"... done
;  ... done
;... done
;Value 13: #[test-group 13]

1 ]=> (load "examples/sudoku")

;Loading "examples/sudoku.scm"... done
;Unspecified return value

1 ]=> 
;Value: prof:with-reset

1 ]=> (prof:with-reset
    (lambda ()
      (do-sudoku
       '((0 0 7 0 0 0 6 5 0)
	 (8 4 6 0 0 5 1 0 9)
	 (0 0 9 0 0 0 0 0 3)
	 (1 0 0 5 6 0 0 9 4)
	 (0 0 0 9 4 8 0 0 0)
	 (4 9 0 0 1 2 0 0 5)
	 (7 0 0 0 0 0 9 0 0)
	 (9 0 5 2 0 0 4 1 7)
	 (0 3 1 0 0 0 5 0 0)))))
327194658
846325179
519687243
172563894
653948721
498712365
764851932
985236417
231479586
process time: 232880 (221180 RUN + 11700 GC); real time: 244440
()
;Value 14: #[sudoku-board 14]

1 ]=> (load "extensions/load")

;Loading "extensions/load.scm"... 
;  Loading "../testing/load.com"... done
;  Loading "portability.scm"... 
;    Loading "mitscheme-conditions.scm"... done
;  ... done
;  Loading "ordered-map.scm"... done
;  Loading "matching.scm"... done
;  Loading "assertions.scm"... done
;  Loading "test-runner.scm"... done
;  Loading "test-group.scm"... done
;  Loading "testing.scm"... done
;  Loading "../load.scm"... 
;    Generating SCode for file: "profiler.scm" => "profiler.bin"... 
;      Dumping "profiler.bin"... done
;    ... done
;    Compiling file: "profiler.bin" => "profiler.com"... 
;      Loading "profiler.bin"... done
;      Compiling procedure: prof:make-node... done
;      Compiling procedure: prof:node-increment... done
;      Compiling procedure: prof:node-add-child!... done
;      Compiling procedure: prof:node-children-as-alist... done
;      Compiling procedure: prof:node-reset!... done
;      Compiling procedure: prof:node-get-child... done
;      Compiling procedure: prof:subnode... done
;      Compiling procedure: prof:node-child-test... done
;      Compiling procedure: |#[unnamed-procedure]|... done
;      Compiling procedure: incrementation-form... done
;      Compiling procedure: node-access-form... done
;      Compiling procedure: fresh-symbol... done
;      Compiling procedure: emit-unevaluated-reference... done
;      Compiling procedure: node-access-form... done
;      Compiling procedure: prof:stats... done
;      Compiling procedure: prof:node-as-alists... done
;      Compiling procedure: prof:node-clean-copy... done
;      Compiling procedure: prof:show-stats... done
;      Compiling procedure: prof:reset-stats!... done
;      Compiling procedure: prof:with-reset... done
;      Compiling procedure: prof:clear-stats!... done
;      Compiling procedure: prof:node-clear!... done
;      Dumping "profiler.bci"... done
;      Dumping "profiler.com"... done
;    ... done
;    Loading "profiler.com"... done
;    Loading "new-art/load.scm"... 
;      Loading "../testing/load.com"... done
;      Loading "portability.scm"... 
;        Loading "mitscheme-conditions.scm"... done
;      ... done
;      Loading "ordered-map.scm"... done
;      Loading "matching.scm"... done
;      Loading "assertions.scm"... done
;      Loading "test-runner.scm"... done
;      Loading "test-group.scm"... done
;      Loading "testing.scm"... done
;      Loading "utils.com"... done
;      Loading "ghelper.com"... done
;      Loading "../literate/load.com"... done
;      Loading "regex-literals.scm"... done
;      Loading "read.scm"... done
;      Loading "test-support.scm"... done
;      Loading "scheduler.com"... done
;      Loading "data-structure-definitions.com"... done
;      Generating SCode for file: "art.scm" => "art.bin"... 
;Warning: Unreferenced bound variable: content (|#[unnamed-procedure]|)
;Warning: Unreferenced bound variable: increment (|#[unnamed-procedure]|)
;        Dumping "art.bin"... done
;      ... done
;      Compiling file: "art.bin" => "art.com"... 
;        Loading "art.bin"... done
;        Compiling procedure: fahrenheit->celsius... done
;        Compiling procedure: |#[unnamed-procedure]|... done
;        Compiling procedure: nothing?... done
;        Compiling procedure: content... done
;        Compiling procedure: add-content... done
;        Compiling procedure: new-neighbor!... done
;        Compiling procedure: make-cell... done
;        Compiling procedure: propagator... done
;        Compiling procedure: function->propagator-constructor... done
;        Compiling procedure: handling-nothings... done
;        Compiling procedure: constant... done
;        Compiling procedure: sum... done
;        Compiling procedure: product... done
;        Compiling procedure: quadratic... done
;        Compiling procedure: fahrenheit-celsius... done
;        Compiling procedure: |#[unnamed-procedure]|... done
;        Compiling procedure: fall-duration... done
;        Compiling procedure: |#[unnamed-procedure]|... done
;        Compiling procedure: similar-triangles... done
;        Compiling procedure: |#[unnamed-procedure]|... done
;        Compiling procedure: mul-interval... done
;        Compiling procedure: div-interval... done
;        Compiling procedure: square-interval... done
;        Compiling procedure: sqrt-interval... done
;        Compiling procedure: empty-interval?... done
;        Compiling procedure: intersect-intervals... done
;        Compiling procedure: make-cell... done
;        Compiling procedure: make-cell... done
;        Compiling procedure: |#[unnamed-procedure]|... done
;        Compiling procedure: contradictory?... done
;        Compiling procedure: |#[unnamed-procedure]|... done
;        Compiling procedure: |#[unnamed-procedure]|... done
;        Compiling procedure: |#[unnamed-procedure]|... done
;        Compiling procedure: ensure-inside... done
;        Compiling procedure: |#[unnamed-procedure]|... done
;        Compiling procedure: |#[unnamed-procedure]|... done
;        Compiling procedure: |#[unnamed-procedure]|... done
;        Compiling procedure: |#[unnamed-procedure]|... 
;Warning: Coalescing two copies of constant object (shadows)
;Warning: Coalescing two copies of constant object (shadows)
;Warning: Coalescing two copies of constant object #(supported #(interval 44.514 48.978) (shadows))
;        ... done
;        Compiling procedure: v&s-merge... done
;        Compiling procedure: implies?... done
;        Compiling procedure: |#[unnamed-procedure]|... done
;        Compiling procedure: |#[unnamed-procedure]|... done
;        Compiling procedure: |#[unnamed-procedure]|... 
;Warning: Coalescing two copies of constant object (shadows)
;Warning: Coalescing two copies of constant object (shadows)
;Warning: Coalescing two copies of constant object #(supported 45 (superintendent))
;Warning: Coalescing two copies of constant object #(supported #(interval .3 .30328) (superintendent shadows))
;Warning: Coalescing two copies of constant object #(supported #(interval .3 .30328) (superintendent shadows))
;Warning: Coalescing two copies of constant object #(supported #(interval .3 .30328) (superintendent shadows))
;Warning: Coalescing two copies of constant object #(supported 45 (superintendent))
;        ... done
;        Compiling procedure: tms-merge... done
;        Compiling procedure: tms-assimilate... done
;        Compiling procedure: subsumes?... done
;        Compiling procedure: tms-assimilate-one... done
;        Compiling procedure: strongest-consequence... done
;        Compiling procedure: all-premises-in?... done
;        Compiling procedure: check-consistent!... done
;        Compiling procedure: tms-query... done
;        Compiling procedure: kick-out!... done
;        Compiling procedure: bring-in!... done
;        Compiling procedure: process-nogood!... done
;        Compiling procedure: |#[unnamed-procedure]|... done
;        Compiling procedure: binary-amb... done
;        Compiling procedure: process-contradictions... done
;        Compiling procedure: process-one-contradiction... done
;        Compiling procedure: assimilate-nogood!... done
;        Compiling procedure: process-nogood!... done
;        Compiling procedure: require... done
;        Compiling procedure: abhor... done
;        Compiling procedure: require-distinct... done
;        Compiling procedure: one-of... done
;        Compiling procedure: one-of-the-cells... done
;        Compiling procedure: |#[unnamed-procedure]|... done
;        Compiling procedure: conditional... done
;        Dumping "art.bci"... done
;        Dumping "art.com"... done
;      ... done
;      Loading "art.com"... done
;      Loading "naive-primitives.com"... done
;      Loading "generic-primitives.com"... done
;      Loading "generic-primitives-1-1.com"... done
;      Loading "generic-primitives-2.com"... done
;      Loading "generic-primitives-3.com"... done
;      Loading "masyu.com"... done
;    ... done
;    Loading "conditionals.com"... done
;    Loading "abstraction.com"... done
;    Loading "compound-data.com"... done
;    Loading "test/load.scm"... 
;      Loading "profiler-test.scm"... done
;      Loading "partial-compounds-test.scm"... done
;      Loading "switches-test.scm"... done
;      Loading "compound-merges-test.scm"... done
;    ... done
;  ... done
;  Loading "eq-properties.scm"... done
;  Loading "art-expression-language.scm"... done
;  Loading "constraints.scm"... done
;  Loading "electric-parts.scm"... done
;  Loading "solve.scm"... done
;  Loading "symbolics.scm"... done
;  Loading "functional-reactivity.scm"... done
;  Loading "test/load.scm"... 
;    Loading "symbolics-test.scm"... done
;    Loading "voltage-divider-test.scm"... done
;    Loading "functional-reactive-test.scm"... done
;  ... done
;... done
;Value 179: #[test-group 179]

1 ]=> (load "examples/sudoku")

;Loading "examples/sudoku.scm"... done
;Unspecified return value

1 ]=> (prof:with-reset
    (lambda ()
      (do-sudoku
       '((0 0 7 0 0 0 6 5 0)
	 (8 4 6 0 0 5 1 0 9)
	 (0 0 9 0 0 0 0 0 3)
	 (1 0 0 5 6 0 0 9 4)
	 (0 0 0 9 4 8 0 0 0)
	 (4 9 0 0 1 2 0 0 5)
	 (7 0 0 0 0 0 9 0 0)
	 (9 0 5 2 0 0 4 1 7)
	 (0 3 1 0 0 0 5 0 0)))))
327194658
846325179
519687243
172563894
653948721
498712365
764851932
985236417
231479586
process time: 242390 (230630 RUN + 11760 GC); real time: 257654
((nogood (by-resolution 7745) (assimilate 55483) (by-computation 629))
 (invocation (amb-choose 201296))
 (tms (subsume 6962933) (assimilate 3871017)))
;Value 180: #[sudoku-board 180]

1 ]=> *prof:statistics*

;Value 181: (0 ((nogood 0 ((by-resolution 7745 () #(#f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f)) (assimilate 55483 () #(#f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f)) (by-computation 629 () #(#f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f))) #(#f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f)) (invocation 0 ((amb-choose 201296 () #(#f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f))) #(#f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f)) (tms 0 ((subsume 6962933 () #(#f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f)) (assimilate 3871017 () #(#f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f))) #(#f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f))) #(#f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f))

1 ]=> (cf "examples/foo")

;Generating SCode for file: "examples/foo.scm" => "examples/foo.bin"... 
;  Dumping "examples/foo.bin"... done
;... done
;Compiling file: "examples/foo.bin" => "examples/foo.com"... 
;  Loading "examples/foo.bin"... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Dumping "examples/foo.bci"... done
;  Dumping "examples/foo.com"... done
;... done
;Unspecified return value

1 ]=> (load "examples/foo")

;Loading "examples/foo.com"... done
process time: 220 (220 RUN + 0 GC); real time: 236
process time: 140 (140 RUN + 0 GC); real time: 160
process time: 150 (150 RUN + 0 GC); real time: 163
process time: 160 (160 RUN + 0 GC); real time: 173
(9 . 10000081)
process time: 4260 (4260 RUN + 0 GC); real time: 4400
10000081
process time: 290 (290 RUN + 0 GC); real time: 326
10000081
process time: 2460 (2460 RUN + 0 GC); real time: 2571
10000081
process time: 820 (820 RUN + 0 GC); real time: 875
20000081
process time: 2960 (2960 RUN + 0 GC); real time: 3086
process time: 60 (60 RUN + 0 GC); real time: 74
;Value: 7000000

1 ]=> (cf "examples/foo")

;Generating SCode for file: "examples/foo.scm" => "examples/foo.bin"... 
;  Dumping "examples/foo.bin"... done
;... done
;Compiling file: "examples/foo.bin" => "examples/foo.com"... 
;  Loading "examples/foo.bin"... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Dumping "examples/foo.bci"... done
;  Dumping "examples/foo.com"... done
;... done
;Unspecified return value

1 ]=> (load "examples/foo")

;Loading "examples/foo.com"... done
process time: 190 (190 RUN + 0 GC); real time: 213
process time: 150 (150 RUN + 0 GC); real time: 162
process time: 150 (150 RUN + 0 GC); real time: 158
process time: 160 (160 RUN + 0 GC); real time: 169
(9 . 10000081)
process time: 4320 (4320 RUN + 0 GC); real time: 4553
10000081
process time: 290 (290 RUN + 0 GC); real time: 320
10000081
process time: 2520 (2520 RUN + 0 GC); real time: 2622
10000081
process time: 840 (840 RUN + 0 GC); real time: 872
20000081
process time: 3050 (3050 RUN + 0 GC); real time: 3105
;Aborting!: maximum recursion depth exceeded

1 ]=> (cf "examples/foo")

;Generating SCode for file: "examples/foo.scm" => "examples/foo.bin"... 
;  Dumping "examples/foo.bin"... done
;... done
;Compiling file: "examples/foo.bin" => "examples/foo.com"... 
;  Loading "examples/foo.bin"... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Dumping "examples/foo.bci"... done
;  Dumping "examples/foo.com"... done
;... done
;Unspecified return value

1 ]=> (load "examples/foo")

;Loading "examples/foo.com"... done
process time: 190 (190 RUN + 0 GC); real time: 199
process time: 150 (150 RUN + 0 GC); real time: 161
process time: 150 (150 RUN + 0 GC); real time: 160
process time: 160 (160 RUN + 0 GC); real time: 171
(9 . 1000081)
process time: 440 (440 RUN + 0 GC); real time: 454
1000081
process time: 30 (30 RUN + 0 GC); real time: 30
1000081
process time: 240 (240 RUN + 0 GC); real time: 273
1000081
process time: 90 (90 RUN + 0 GC); real time: 102
2000081
process time: 300 (300 RUN + 0 GC); real time: 325
process time: 60 (60 RUN + 0 GC); real time: 72
;Unbound variable: subsume
;To continue, call RESTART with an option number:
; (RESTART 3) => Specify a value to use instead of subsume.
; (RESTART 2) => Define subsume to a given value.
; (RESTART 1) => Return to read-eval-print level 1.

2 error>   C-c C-c
;Quit!

1 ]=> (load-compiled "examples/foo")

;Generating SCode for file: "examples/foo.scm" => "examples/foo.bin"... 
;  Dumping "examples/foo.bin"... done
;... done
;Compiling file: "examples/foo.bin" => "examples/foo.com"... 
;  Loading "examples/foo.bin"... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Dumping "examples/foo.bci"... done
;  Dumping "examples/foo.com"... done
;... done
;Loading "examples/foo.com"... done
process time: 170 (170 RUN + 0 GC); real time: 188
process time: 140 (140 RUN + 0 GC); real time: 189
process time: 140 (140 RUN + 0 GC); real time: 157
process time: 160 (160 RUN + 0 GC); real time: 172
(9 . 1000081)
process time: 440 (440 RUN + 0 GC); real time: 455
1000081
process time: 30 (30 RUN + 0 GC); real time: 30
1000081
process time: 250 (250 RUN + 0 GC); real time: 275
1000081
process time: 80 (80 RUN + 0 GC); real time: 94
2000081
process time: 310 (310 RUN + 0 GC); real time: 324
process time: 60 (60 RUN + 0 GC); real time: 72
process time: 4420 (4420 RUN + 0 GC); real time: 4498
;Value: 7000000

1 ]=> (load "extensions/load")

;Loading "extensions/load.scm"... 
;  Loading "../testing/load.com"... done
;  Loading "portability.scm"... 
;    Loading "mitscheme-conditions.scm"... done
;  ... done
;  Loading "ordered-map.scm"... done
;  Loading "matching.scm"... done
;  Loading "assertions.scm"... done
;  Loading "test-runner.scm"... done
;  Loading "test-group.scm"... done
;  Loading "testing.scm"... done
;  Loading "../load.scm"... 
;    Loading "profiler.com"... done
;    Loading "new-art/load.scm"... 
;      Loading "../testing/load.com"... done
;      Loading "portability.scm"... 
;        Loading "mitscheme-conditions.scm"... done
;      ... done
;      Loading "ordered-map.scm"... done
;      Loading "matching.scm"... done
;      Loading "assertions.scm"... done
;      Loading "test-runner.scm"... done
;      Loading "test-group.scm"... done
;      Loading "testing.scm"... done
;      Loading "utils.com"... done
;      Loading "ghelper.com"... done
;      Loading "../literate/load.com"... done
;      Loading "regex-literals.scm"... done
;      Loading "read.scm"... done
;      Loading "test-support.scm"... done
;      Loading "scheduler.com"... done
;      Loading "data-structure-definitions.com"... done
;      Generating SCode for file: "art.scm" => "art.bin"... 
;Warning: Unreferenced bound variable: content (|#[unnamed-procedure]|)
;Warning: Unreferenced bound variable: increment (|#[unnamed-procedure]|)
;        Dumping "art.bin"... done
;      ... done
;      Compiling file: "art.bin" => "art.com"... 
;        Loading "art.bin"... done
;        Compiling procedure: fahrenheit->celsius... done
;        Compiling procedure: |#[unnamed-procedure]|... done
;        Compiling procedure: nothing?... done
;        Compiling procedure: content... done
;        Compiling procedure: add-content... done
;        Compiling procedure: new-neighbor!... done
;        Compiling procedure: make-cell... done
;        Compiling procedure: propagator... done
;        Compiling procedure: function->propagator-constructor... done
;        Compiling procedure: handling-nothings... done
;        Compiling procedure: constant... done
;        Compiling procedure: sum... done
;        Compiling procedure: product... done
;        Compiling procedure: quadratic... done
;        Compiling procedure: fahrenheit-celsius... done
;        Compiling procedure: |#[unnamed-procedure]|... done
;        Compiling procedure: fall-duration... done
;        Compiling procedure: |#[unnamed-procedure]|... done
;        Compiling procedure: similar-triangles... done
;        Compiling procedure: |#[unnamed-procedure]|... done
;        Compiling procedure: mul-interval... done
;        Compiling procedure: div-interval... done
;        Compiling procedure: square-interval... done
;        Compiling procedure: sqrt-interval... done
;        Compiling procedure: empty-interval?... done
;        Compiling procedure: intersect-intervals... done
;        Compiling procedure: make-cell... done
;        Compiling procedure: make-cell... done
;        Compiling procedure: |#[unnamed-procedure]|... done
;        Compiling procedure: contradictory?... done
;        Compiling procedure: |#[unnamed-procedure]|... done
;        Compiling procedure: |#[unnamed-procedure]|... done
;        Compiling procedure: |#[unnamed-procedure]|... done
;        Compiling procedure: ensure-inside... done
;        Compiling procedure: |#[unnamed-procedure]|... done
;        Compiling procedure: |#[unnamed-procedure]|... done
;        Compiling procedure: |#[unnamed-procedure]|... done
;        Compiling procedure: |#[unnamed-procedure]|... 
;Warning: Coalescing two copies of constant object (shadows)
;Warning: Coalescing two copies of constant object (shadows)
;Warning: Coalescing two copies of constant object #(supported #(interval 44.514 48.978) (shadows))
;        ... done
;        Compiling procedure: v&s-merge... done
;        Compiling procedure: implies?... done
;        Compiling procedure: |#[unnamed-procedure]|... done
;        Compiling procedure: |#[unnamed-procedure]|... done
;        Compiling procedure: |#[unnamed-procedure]|... 
;Warning: Coalescing two copies of constant object (shadows)
;Warning: Coalescing two copies of constant object (shadows)
;Warning: Coalescing two copies of constant object #(supported 45 (superintendent))
;Warning: Coalescing two copies of constant object #(supported #(interval .3 .30328) (superintendent shadows))
;Warning: Coalescing two copies of constant object #(supported #(interval .3 .30328) (superintendent shadows))
;Warning: Coalescing two copies of constant object #(supported #(interval .3 .30328) (superintendent shadows))
;Warning: Coalescing two copies of constant object #(supported 45 (superintendent))
;        ... done
;        Compiling procedure: tms-merge... done
;        Compiling procedure: tms-assimilate... done
;        Compiling procedure: subsumes?... done
;        Compiling procedure: tms-assimilate-one... done
;        Compiling procedure: strongest-consequence... done
;        Compiling procedure: all-premises-in?... done
;        Compiling procedure: check-consistent!... done
;        Compiling procedure: tms-query... done
;        Compiling procedure: kick-out!... done
;        Compiling procedure: bring-in!... done
;        Compiling procedure: process-nogood!... done
;        Compiling procedure: |#[unnamed-procedure]|... done
;        Compiling procedure: binary-amb... done
;        Compiling procedure: process-contradictions... done
;        Compiling procedure: process-one-contradiction... done
;        Compiling procedure: assimilate-nogood!... done
;        Compiling procedure: process-nogood!... done
;        Compiling procedure: require... done
;        Compiling procedure: abhor... done
;        Compiling procedure: require-distinct... done
;        Compiling procedure: one-of... done
;        Compiling procedure: one-of-the-cells... done
;        Compiling procedure: |#[unnamed-procedure]|... done
;        Compiling procedure: conditional... done
;        Dumping "art.bci"... done
;        Dumping "art.com"... done
;      ... done
;      Loading "art.com"... done
;      Loading "naive-primitives.com"... done
;      Loading "generic-primitives.com"... done
;      Loading "generic-primitives-1-1.com"... done
;      Loading "generic-primitives-2.com"... done
;      Loading "generic-primitives-3.com"... done
;      Loading "masyu.com"... done
;    ... done
;    Loading "conditionals.com"... done
;    Loading "abstraction.com"... done
;    Loading "compound-data.com"... done
;    Loading "test/load.scm"... 
;      Loading "profiler-test.scm"... done
;      Loading "partial-compounds-test.scm"... done
;      Loading "switches-test.scm"... done
;      Loading "compound-merges-test.scm"... done
;    ... done
;  ... done
;  Loading "eq-properties.scm"... done
;  Loading "art-expression-language.scm"... done
;  Loading "constraints.scm"... done
;  Loading "electric-parts.scm"... done
;  Loading "solve.scm"... done
;  Loading "symbolics.scm"... done
;  Loading "functional-reactivity.scm"... done
;  Loading "test/load.scm"... 
;    Loading "symbolics-test.scm"... done
;    Loading "voltage-divider-test.scm"... done
;    Loading "functional-reactive-test.scm"... done
;  ... done
;... done
;Value 373: #[test-group 373]

1 ]=> (load "examples/sudoku")

;Loading "examples/sudoku.scm"... done
;Unspecified return value

1 ]=> (prof:with-reset
    (lambda ()
      (do-sudoku
       '((0 0 7 0 0 0 6 5 0)
	 (8 4 6 0 0 5 1 0 9)
	 (0 0 9 0 0 0 0 0 3)
	 (1 0 0 5 6 0 0 9 4)
	 (0 0 0 9 4 8 0 0 0)
	 (4 9 0 0 1 2 0 0 5)
	 (7 0 0 0 0 0 9 0 0)
	 (9 0 5 2 0 0 4 1 7)
	 (0 3 1 0 0 0 5 0 0)))))
327194658
846325179
519687243
172563894
653948721
498712365
764851932
985236417
231479586
process time: 232240 (220430 RUN + 11810 GC); real time: 242722
()
;Value 374: #[sudoku-board 374]

1 ]=> (load-compiled "examples/foo")

;Generating SCode for file: "examples/foo.scm" => "examples/foo.bin"... 
;  Dumping "examples/foo.bin"... done
;... done
;Compiling file: "examples/foo.bin" => "examples/foo.com"... 
;  Loading "examples/foo.bin"... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Dumping "examples/foo.bci"... done
;  Dumping "examples/foo.com"... done
;... done
;Loading "examples/foo.com"... done
process time: 180 (180 RUN + 0 GC); real time: 189
process time: 150 (150 RUN + 0 GC); real time: 158
process time: 150 (150 RUN + 0 GC); real time: 156
process time: 160 (160 RUN + 0 GC); real time: 170
(9 . 1000081)
process time: 440 (440 RUN + 0 GC); real time: 450
1000081
process time: 30 (30 RUN + 0 GC); real time: 31
1000081
process time: 260 (260 RUN + 0 GC); real time: 279
1000081
process time: 90 (90 RUN + 0 GC); real time: 94
2000081
process time: 310 (310 RUN + 0 GC); real time: 329
process time: 90 (90 RUN + 0 GC); real time: 105
process time: 4230 (4230 RUN + 0 GC); real time: 4319
;Value: 3800000

1 ]=> (load-compiled "examples/foo")

;Generating SCode for file: "examples/foo.scm" => "examples/foo.bin"... 
;  Dumping "examples/foo.bin"... done
;... done
;Compiling file: "examples/foo.bin" => "examples/foo.com"... 
;  Loading "examples/foo.bin"... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Dumping "examples/foo.bci"... done
;  Dumping "examples/foo.com"... done
;... done
;Loading "examples/foo.com"... done
process time: 180 (180 RUN + 0 GC); real time: 188
process time: 150 (150 RUN + 0 GC); real time: 160
process time: 150 (150 RUN + 0 GC); real time: 159
process time: 160 (160 RUN + 0 GC); real time: 173
(9 . 1000081)
process time: 430 (430 RUN + 0 GC); real time: 453
1000081
process time: 20 (20 RUN + 0 GC); real time: 30
1000081
process time: 260 (260 RUN + 0 GC); real time: 276
1000081
process time: 80 (80 RUN + 0 GC); real time: 94
2000081
process time: 300 (300 RUN + 0 GC); real time: 325
process time: 100 (100 RUN + 0 GC); real time: 106
process time: 3490 (3490 RUN + 0 GC); real time: 3542
;Value: 3800000

1 ]=> (load-compiled "examples/foo")

;Generating SCode for file: "examples/foo.scm" => "examples/foo.bin"... 
;  Dumping "examples/foo.bin"... done
;... done
;Compiling file: "examples/foo.bin" => "examples/foo.com"... 
;  Loading "examples/foo.bin"... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Dumping "examples/foo.bci"... done
;  Dumping "examples/foo.com"... done
;... done
;Loading "examples/foo.com"... done
process time: 180 (180 RUN + 0 GC); real time: 189
process time: 140 (140 RUN + 0 GC); real time: 159
process time: 150 (150 RUN + 0 GC); real time: 158
process time: 160 (160 RUN + 0 GC); real time: 170
(9 . 1000081)
process time: 430 (430 RUN + 0 GC); real time: 456
1000081
process time: 30 (30 RUN + 0 GC); real time: 31
1000081
process time: 260 (260 RUN + 0 GC); real time: 276
1000081
process time: 80 (80 RUN + 0 GC); real time: 94
2000081
process time: 300 (300 RUN + 0 GC); real time: 329
process time: 100 (100 RUN + 0 GC); real time: 106
process time: 1540 (1540 RUN + 0 GC); real time: 1609
;Value: 3800000

1 ]=> (load "extensions/load")

;Loading "extensions/load.scm"... 
;  Loading "../testing/load.com"... done
;  Loading "portability.scm"... 
;    Loading "mitscheme-conditions.scm"... done
;  ... done
;  Loading "ordered-map.scm"... done
;  Loading "matching.scm"... done
;  Loading "assertions.scm"... done
;  Loading "test-runner.scm"... done
;  Loading "test-group.scm"... done
;  Loading "testing.scm"... done
;  Loading "../load.scm"... 
;    Loading "profiler.com"... done
;    Loading "new-art/load.scm"... 
;      Loading "../testing/load.com"... done
;      Loading "portability.scm"... 
;        Loading "mitscheme-conditions.scm"... done
;      ... done
;      Loading "ordered-map.scm"... done
;      Loading "matching.scm"... done
;      Loading "assertions.scm"... done
;      Loading "test-runner.scm"... done
;      Loading "test-group.scm"... done
;      Loading "testing.scm"... done
;      Loading "utils.com"... done
;      Loading "ghelper.com"... done
;      Loading "../literate/load.com"... done
;      Loading "regex-literals.scm"... done
;      Loading "read.scm"... done
;      Loading "test-support.scm"... done
;      Loading "scheduler.com"... done
;      Loading "data-structure-definitions.com"... done
;      Generating SCode for file: "art.scm" => "art.bin"... 
;Warning: Unreferenced bound variable: content (|#[unnamed-procedure]|)
;Warning: Unreferenced bound variable: increment (|#[unnamed-procedure]|)
;        Dumping "art.bin"... done
;      ... done
;      Compiling file: "art.bin" => "art.com"... 
;        Loading "art.bin"... done
;        Compiling procedure: fahrenheit->celsius... done
;        Compiling procedure: |#[unnamed-procedure]|... done
;        Compiling procedure: nothing?... done
;        Compiling procedure: content... done
;        Compiling procedure: add-content... done
;        Compiling procedure: new-neighbor!... done
;        Compiling procedure: make-cell... done
;        Compiling procedure: propagator... done
;        Compiling procedure: function->propagator-constructor... done
;        Compiling procedure: handling-nothings... done
;        Compiling procedure: constant... done
;        Compiling procedure: sum... done
;        Compiling procedure: product... done
;        Compiling procedure: quadratic... done
;        Compiling procedure: fahrenheit-celsius... done
;        Compiling procedure: |#[unnamed-procedure]|... done
;        Compiling procedure: fall-duration... done
;        Compiling procedure: |#[unnamed-procedure]|... done
;        Compiling procedure: similar-triangles... done
;        Compiling procedure: |#[unnamed-procedure]|... done
;        Compiling procedure: mul-interval... done
;        Compiling procedure: div-interval... done
;        Compiling procedure: square-interval... done
;        Compiling procedure: sqrt-interval... done
;        Compiling procedure: empty-interval?... done
;        Compiling procedure: intersect-intervals... done
;        Compiling procedure: make-cell... done
;        Compiling procedure: make-cell... done
;        Compiling procedure: |#[unnamed-procedure]|... done
;        Compiling procedure: contradictory?... done
;        Compiling procedure: |#[unnamed-procedure]|... done
;        Compiling procedure: |#[unnamed-procedure]|... done
;        Compiling procedure: |#[unnamed-procedure]|... done
;        Compiling procedure: ensure-inside... done
;        Compiling procedure: |#[unnamed-procedure]|... done
;        Compiling procedure: |#[unnamed-procedure]|... done
;        Compiling procedure: |#[unnamed-procedure]|... done
;        Compiling procedure: |#[unnamed-procedure]|... 
;Warning: Coalescing two copies of constant object (shadows)
;Warning: Coalescing two copies of constant object (shadows)
;Warning: Coalescing two copies of constant object #(supported #(interval 44.514 48.978) (shadows))
;        ... done
;        Compiling procedure: v&s-merge... done
;        Compiling procedure: implies?... done
;        Compiling procedure: |#[unnamed-procedure]|... done
;        Compiling procedure: |#[unnamed-procedure]|... done
;        Compiling procedure: |#[unnamed-procedure]|... 
;Warning: Coalescing two copies of constant object (shadows)
;Warning: Coalescing two copies of constant object (shadows)
;Warning: Coalescing two copies of constant object #(supported 45 (superintendent))
;Warning: Coalescing two copies of constant object #(supported #(interval .3 .30328) (superintendent shadows))
;Warning: Coalescing two copies of constant object #(supported #(interval .3 .30328) (superintendent shadows))
;Warning: Coalescing two copies of constant object #(supported #(interval .3 .30328) (superintendent shadows))
;Warning: Coalescing two copies of constant object #(supported 45 (superintendent))
;        ... done
;        Compiling procedure: tms-merge... done
;        Compiling procedure: tms-assimilate... done
;        Compiling procedure: subsumes?... done
;        Compiling procedure: tms-assimilate-one... done
;        Compiling procedure: strongest-consequence... done
;        Compiling procedure: all-premises-in?... done
;        Compiling procedure: check-consistent!... done
;        Compiling procedure: tms-query... done
;        Compiling procedure: kick-out!... done
;        Compiling procedure: bring-in!... done
;        Compiling procedure: process-nogood!... done
;        Compiling procedure: |#[unnamed-procedure]|... done
;        Compiling procedure: binary-amb... done
;        Compiling procedure: process-contradictions... done
;        Compiling procedure: process-one-contradiction... done
;        Compiling procedure: assimilate-nogood!... done
;        Compiling procedure: process-nogood!... done
;        Compiling procedure: require... done
;        Compiling procedure: abhor... done
;        Compiling procedure: require-distinct... done
;        Compiling procedure: one-of... done
;        Compiling procedure: one-of-the-cells... done
;        Compiling procedure: |#[unnamed-procedure]|... done
;        Compiling procedure: conditional... done
;        Dumping "art.bci"... done
;        Dumping "art.com"... done
;      ... done
;      Loading "art.com"... done
;      Loading "naive-primitives.com"... done
;      Loading "generic-primitives.com"... done
;      Loading "generic-primitives-1-1.com"... done
;      Loading "generic-primitives-2.com"... done
;      Loading "generic-primitives-3.com"... done
;      Loading "masyu.com"... done
;    ... done
;    Loading "conditionals.com"... done
;    Loading "abstraction.com"... done
;    Loading "compound-data.com"... done
;    Loading "test/load.scm"... 
;      Loading "profiler-test.scm"... done
;      Loading "partial-compounds-test.scm"... done
;      Loading "switches-test.scm"... done
;      Loading "compound-merges-test.scm"... done
;    ... done
;  ... done
;  Loading "eq-properties.scm"... done
;  Loading "art-expression-language.scm"... done
;  Loading "constraints.scm"... done
;  Loading "electric-parts.scm"... done
;  Loading "solve.scm"... done
;  Loading "symbolics.scm"... done
;  Loading "functional-reactivity.scm"... done
;  Loading "test/load.scm"... 
;    Loading "symbolics-test.scm"... done
;    Loading "voltage-divider-test.scm"... done
;    Loading "functional-reactive-test.scm"... done
;  ... done
;... done
;Value 561: #[test-group 561]

1 ]=> (load "examples/sudoku")

;Loading "examples/sudoku.scm"... done
;Unspecified return value

1 ]=> (prof:with-reset
    (lambda ()
      (do-sudoku
       '((0 0 7 0 0 0 6 5 0)
	 (8 4 6 0 0 5 1 0 9)
	 (0 0 9 0 0 0 0 0 3)
	 (1 0 0 5 6 0 0 9 4)
	 (0 0 0 9 4 8 0 0 0)
	 (4 9 0 0 1 2 0 0 5)
	 (7 0 0 0 0 0 9 0 0)
	 (9 0 5 2 0 0 4 1 7)
	 (0 3 1 0 0 0 5 0 0)))))
327194658
846325179
519687243
172563894
653948721
498712365
764851932
985236417
231479586
process time: 240510 (228560 RUN + 11950 GC); real time: 251620
((nogood (by-resolution 7745) (assimilate 55483) (by-computation 629))
 (invocation (amb-choose 201296))
 (tms (subsume 6962933) (assimilate 3871017)))
;Value 562: #[sudoku-board 562]

1 ]=> (load-compiled "examples/foo")

;Loading "examples/foo.com"... done
process time: 220 (220 RUN + 0 GC); real time: 226
process time: 150 (150 RUN + 0 GC); real time: 157
process time: 150 (150 RUN + 0 GC); real time: 159
process time: 150 (150 RUN + 0 GC); real time: 170
(9 . 1000081)
process time: 420 (420 RUN + 0 GC); real time: 456
1000081
process time: 40 (40 RUN + 0 GC); real time: 30
1000081
process time: 250 (250 RUN + 0 GC); real time: 279
1000081
process time: 90 (90 RUN + 0 GC); real time: 95
2000081
process time: 300 (300 RUN + 0 GC); real time: 324
process time: 90 (90 RUN + 0 GC); real time: 108
process time: 2720 (2720 RUN + 0 GC); real time: 2780
;Value: 3800000

1 ]=> (prof:with-reset
    (lambda ()
      (do-sudoku
       '((0 0 7 0 0 0 6 5 0)
	 (8 4 6 0 0 5 1 0 9)
	 (0 0 9 0 0 0 0 0 3)
	 (1 0 0 5 6 0 0 9 4)
	 (0 0 0 9 4 8 0 0 0)
	 (4 9 0 0 1 2 0 0 5)
	 (7 0 0 0 0 0 9 0 0)
	 (9 0 5 2 0 0 4 1 7)
	 (0 3 1 0 0 0 5 0 0)))))
327194658
846325179
519687243
172563894
653948721
498712365
764851932
985236417
231479586
process time: 244010 (231050 RUN + 12960 GC); real time: 252724
((nogood (by-resolution 7745) (assimilate 55483) (by-computation 629))
 (invocation (amb-choose 201296))
 (tms (subsume 6962933) (assimilate 3871017)))
;Value 563: #[sudoku-board 563]

1 ]=> (load-compiled "examples/foo")

;Generating SCode for file: "examples/foo.scm" => "examples/foo.bin"... 
;  Dumping "examples/foo.bin"... done
;... done
;Compiling file: "examples/foo.bin" => "examples/foo.com"... 
;  Loading "examples/foo.bin"... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Dumping "examples/foo.bci"... done
;  Dumping "examples/foo.com"... done
;... done
;Loading "examples/foo.com"... done
process time: 170 (170 RUN + 0 GC); real time: 190
process time: 150 (150 RUN + 0 GC); real time: 157
process time: 160 (160 RUN + 0 GC); real time: 157
process time: 160 (160 RUN + 0 GC); real time: 170
(9 . 1000081)
process time: 440 (440 RUN + 0 GC); real time: 452
1000081
process time: 30 (30 RUN + 0 GC); real time: 31
1000081
process time: 250 (250 RUN + 0 GC); real time: 278
1000081
process time: 80 (80 RUN + 0 GC); real time: 92
2000081
process time: 310 (310 RUN + 0 GC); real time: 327
process time: 100 (100 RUN + 0 GC); real time: 106
process time: 6850 (6850 RUN + 0 GC); real time: 7043
;Value: 3800000

1 ]=> (expt 3 14)

;Value: 4782969

1 ]=> 
