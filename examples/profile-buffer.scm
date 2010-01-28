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

;Value 11: #[pathname 11 "/home/axch/phd/thesis/examples/"]

1 ]=> (load "../extensions/load.scm")

;Loading "../extensions/load.scm"... 
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
;    Loading "test/load.scm"... done
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
;Value 12: #[test-group 12]

1 ]=> (load "riddle-of-the-knights")

;Loading "riddle-of-the-knights.scm"... done
;Value 13: #[test-group 13]

1 ]=> (load "albatross-conundrum")

;Loading "albatross-conundrum.scm"... done
;Value: find-solution

1 ]=> (define answer (show-time find-solution))

;Unbound variable: p:deck-maker
;To continue, call RESTART with an option number:
; (RESTART 3) => Specify a value to use instead of p:deck-maker.
; (RESTART 2) => Define p:deck-maker to a given value.
; (RESTART 1) => Return to read-eval-print level 1.

2 error>   C-c C-c
;Quit!

1 ]=> (load "albatross-conundrum")

;Loading "albatross-conundrum.scm"... done
;Value: find-solution

1 ]=> (define answer (show-time find-solution))
process time: 150 (150 RUN + 0 GC); real time: 154
;Value: answer

1 ]=> (pp (map tms-values answer))
(((nothing #[weak-cons 27]
           #[weak-cons 26]
           #[weak-cons 25]
           #[weak-cons 24]
           #[weak-cons 23]
           #[weak-cons 22]
           #[weak-cons 21]
           #[weak-cons 20])
  (nothing #[weak-cons 19])
  (nothing #[weak-cons 18])
  (nothing #[weak-cons 17])
  (nothing #[weak-cons 16])
  (nothing #[weak-cons 15])
  (nothing #[weak-cons 14]))
 ((nothing #[weak-cons 27]
           #[weak-cons 26]
           #[weak-cons 25]
           #[weak-cons 24]
           #[weak-cons 23]
           #[weak-cons 22]
           #[weak-cons 21]
           #[weak-cons 20])
  (nothing #[weak-cons 19])
  (nothing #[weak-cons 18])
  (nothing #[weak-cons 17])
  (nothing #[weak-cons 16])
  (nothing #[weak-cons 15])
  (nothing #[weak-cons 14]))
 ((nothing #[weak-cons 27]
           #[weak-cons 26]
           #[weak-cons 25]
           #[weak-cons 24]
           #[weak-cons 23]
           #[weak-cons 22]
           #[weak-cons 21]
           #[weak-cons 20])
  (nothing #[weak-cons 19])
  (nothing #[weak-cons 18])
  (nothing #[weak-cons 17])
  (nothing #[weak-cons 16])
  (nothing #[weak-cons 15])
  (nothing #[weak-cons 14]))
 ((nothing #[weak-cons 27]
           #[weak-cons 26]
           #[weak-cons 25]
           #[weak-cons 24]
           #[weak-cons 23]
           #[weak-cons 22]
           #[weak-cons 21]
           #[weak-cons 20])
  (nothing #[weak-cons 19])
  (nothing #[weak-cons 18])
  (nothing #[weak-cons 17])
  (nothing #[weak-cons 16])
  (nothing #[weak-cons 15])
  (nothing #[weak-cons 14]))
 ((nothing #[weak-cons 27]
           #[weak-cons 26]
           #[weak-cons 25]
           #[weak-cons 24]
           #[weak-cons 23]
           #[weak-cons 22]
           #[weak-cons 21]
           #[weak-cons 20])
  (nothing #[weak-cons 19])
  (nothing #[weak-cons 18])
  (nothing #[weak-cons 17])
  (nothing #[weak-cons 16])
  (nothing #[weak-cons 15])
  (nothing #[weak-cons 14])))
;Unspecified return value

1 ]=> (pp (map tms-query answer))

;This should never happen
;To continue, call RESTART with an option number:
; (RESTART 1) => Return to read-eval-print level 1.

2 error>   C-c C-c
;Quit!

1 ]=> (pp (map tms? answer))
(#f #f #f #f #f)
;Unspecified return value

1 ]=> (pp answer)
(#(*the-nothing*) #(*the-nothing*)
                  #(*the-nothing*)
                  #(*the-nothing*)
                  #(*the-nothing*))
;Unspecified return value

1 ]=> (the-alerted-propagators)

;Value: ()

1 ]=> (flat? 'foo)

;Value: #t

1 ]=> (initialize-scheduler)

;Value 28: #[hash-table 28]

1 ]=> (define cells (build-network))

;Value: cells

1 ]=> (run)

;Value: done

1 ]=> (pp (map content decks))

;Unbound variable: decks
;To continue, call RESTART with an option number:
; (RESTART 3) => Specify a value to use instead of decks.
; (RESTART 2) => Define decks to a given value.
; (RESTART 1) => Return to read-eval-print level 1.

2 error>   C-c C-c
;Quit!

1 ]=> (pp (map content cells))
(#(*the-nothing*) #(*the-nothing*)
                  #(*the-nothing*)
                  #(*the-nothing*)
                  #(*the-nothing*))
;Unspecified return value

1 ]=> *propagators-ever-alerted-list*

;Value 29: (*propagators-ever-alerted-list* #[compiled-closure 30 ("art" #x9) #x12c #x97008c #xa63094] #[compiled-closure 31 ("art" #x9) #x12c #x97008c #xa7097c] #[compiled-closure 32 ("art" #x9) #x12c #x97008c #xa7a9cc] #[compiled-closure 33 ("art" #x9) #x12c #x97008c #xa837d8] #[compiled-closure 34 ("art" #x9) #x12c #x97008c #xa8a8e0] #[compiled-closure 35 ("art" #x9) #x12c #x97008c #xa90a24] #[compiled-closure 36 ("art" #x9) #x12c #x97008c #xa95d5c] #[compiled-closure 37 ("art" #x9) #x12c #x97008c #xa9a65c] #[compiled-closure 38 ("art" #x9) #x12c #x97008c #xa9de54] #[compiled-closure 39 ("art" #x9) #x12c #x97008c #xaa11cc] #[compiled-closure 40 ("art" #x9) #x12c #x97008c #xaa41c8] #[compiled-closure 41 ("art" #x9) #x12c #x97008c #xaa6c08] #[compiled-closure 42 ("art" #x9) #x12c #x97008c #xaa94ec] #[compiled-closure 43 ("art" #x9) #x12c #x97008c #xaabbe8] #[compiled-closure 44 ("art" #x9) #x12c #x97008c #xaae138] #[compiled-closure 45 ("art" #x9) #x12c #x97008c #xab0424] #[compiled-closure 46 ("art" #x9) #x12c #x97008c #xab2364] #[compiled-closure 47 ("art" #x9) #x12c #x97008c #xab3f1c] #[compiled-closure 48 ("art" #x9) #x12c #x97008c #xab57c0] #[compiled-closure 49 ("art" #x9) #x12c #x97008c #xab6de0] #[compiled-closure 50 ("art" #x9) #x12c #x97008c #xab8178] #[compiled-closure 51 ("art" #x9) #x12c #x97008c #xab9208] #[compiled-closure 52 ("art" #x9) #x12c #x97008c #xaba0a4] #[compiled-closure 53 ("art" #x9) #x12c #x97008c #xabac98] #[compiled-closure 54 ("art" #x9) #x12c #x97008c #xabb630] #[compiled-closure 55 ("art" #x9) #x12c #x97008c #xabbf00] #[compiled-closure 56 ("art" #x9) #x12c #x97008c #xabc6f0] #[compiled-closure 57 ("art" #x9) #x12c #x97008c #xabce24] #[compiled-closure 58 ("art" #x9) #x12c #x97008c #xabd548] #[compiled-closure 59 ("art" #x9) #x12c #x97008c #xabdc40] #[compiled-closure 60 ("art" #x9) #x12c #x97008c #xabe2a8] #[compiled-closure 61 ("art" #x9) #x12c #x97008c #xabe82c] #[compiled-closure 62 ("art" #x9) #x12c #x97008c #xabedac] #[compiled-closure 63 ("art" #x9) #x12c #x97008c #xabf31c] #[compiled-closure 64 ("art" #x9) #x12c #x97008c #xabf89c] #[compiled-closure 65 ("art" #x9) #x12c #x97008c #xabfdf4] #[compiled-closure 66 ("art" #x9) #x12c #x97008c #xac02e0] #[compiled-closure 67 ("art" #x9) #x12c #x97008c #xac0754] #[compiled-closure 68 ("art" #x9) #x12c #x97008c #xac0be0] #[compiled-closure 69 ("art" #x9) #x12c #x97008c #xac1074] #[compiled-closure 70 ("art" #x9) #x12c #x97008c #xac14ac] #[compiled-closure 71 ("art" #x9) #x12c #x97008c #xac188c] #[compiled-closure 72 ("art" #x9) #x12c #x97008c #xac1c84] #[compiled-closure 73 ("art" #x9) #x12c #x97008c #xac2098] #[compiled-closure 74 ("art" #x9) #x12c #x97008c #xac2448] #[compiled-closure 75 ("art" #x9) #x12c #x97008c #xac27f0] #[compiled-closure 76 ("art" #x9) #x12c #x97008c #xac2b9c] #[compiled-closure 77 ("art" #x9) #x12c #x97008c #xac2f24] #[compiled-closure 78 ("art" #x9) #x12c #x97008c #xac32b0] #[compiled-closure 79 ("art" #x9) #x12c #x97008c #xac3620] #[compiled-closure 80 ("art" #x9) #x12c #x97008c #xac3970] #[compiled-closure 81 ("art" #x9) #x12c #x97008c #xac3c68] #[compiled-closure 82 ("art" #x9) #x12c #x97008c #xac3f94] #[compiled-closure 83 ("art" #x9) #x12c #x97008c #xac42e8] #[compiled-closure 84 ("art" #x9) #x12c #x97008c #xac4650] #[compiled-closure 85 ("art" #x9) #x12c #x97008c #xac49c8] #[compiled-closure 86 ("art" #x9) #x12c #x97008c #xac4d00] #[compiled-closure 87 ("art" #x9) #x12c #x97008c #xac4ff8] #[compiled-closure 88 ("art" #x9) #x12c #x97008c #xac532c] #[compiled-closure 89 ("art" #x9) #x12c #x97008c #xac5698] #[compiled-closure 90 ("art" #x9) #x12c #x97008c #xac59b8] #[compiled-closure 91 ("art" #x9) #x12c #x97008c #xac5c80] #[compiled-closure 92 ("art" #x9) #x12c #x97008c #xac5f58] #[compiled-closure 93 ("art" #x9) #x12c #x97008c #xac624c] #[compiled-closure 94 ("art" #x9) #x12c #x97008c #xac64f4] #[compiled-closure 95 ("art" #x9) #x12c #x97008c #xac677c] #[compiled-closure 96 ("art" #x9) #x12c #x97008c #xac6a30] #[compiled-closure 97 ("art" #x9) #x12c #x97008c #xac6cc0] #[compiled-closure 98 ("art" #x9) #x12c #x97008c #xac6f6c] #[compiled-closure 99 ("art" #x9) #x12c #x97008c #xac7224] #[compiled-closure 100 ("art" #x9) #x12c #x97008c #xac74f4] #[compiled-closure 101 ("art" #x9) #x12c #x97008c #xac7764] #[compiled-closure 102 ("art" #x9) #x12c #x97008c #xac79a4] #[compiled-closure 103 ("art" #x9) #x12c #x97008c #xac7c5c] #[compiled-closure 104 ("art" #x9) #x12c #x97008c #xac7f1c] #[compiled-closure 105 ("art" #x9) #x12c #x97008c #xac81dc] #[compiled-closure 106 ("art" #x9) #x12c #x97008c #xac8464] #[compiled-closure 107 ("art" #x9) #x12c #x97008c #xac86e4] #[compiled-closure 108 ("art" #x9) #x12c #x97008c #xac8970] #[compiled-closure 109 ("art" #x9) #x12c #x97008c #xac8bd0] #[compiled-closure 110 ("art" #x9) #x12c #x97008c #xac8e5c] #[compiled-closure 111 ("art" #x9) #x12c #x97008c #xac90a4] #[compiled-closure 112 ("art" #x9) #x12c #x97008c #xac9314] #[compiled-closure 113 ("art" #x9) #x12c #x97008c #xac95b8] #[compiled-closure 114 ("art" #x9) #x12c #x97008c #xac9838] #[compiled-closure 115 ("art" #x9) #x12c #x97008c #xac9a88] #[compiled-closure 116 ("art" #x9) #x12c #x97008c #xac9cb0] #[compiled-closure 117 ("art" #x9) #x12c #x97008c #xac9f14] #[compiled-closure 118 ("art" #x9) #x12c #x97008c #xaca180] #[compiled-closure 119 ("art" #x9) #x12c #x97008c #xaca3f0] #[compiled-closure 120 ("art" #x9) #x12c #x97008c #xaca690] #[compiled-closure 121 ("art" #x9) #x12c #x97008c #xaca8f0] #[compiled-closure 122 ("art" #x9) #x12c #x97008c #xacaaf8] #[compiled-closure 123 ("art" #x9) #x12c #x97008c #xacad14] #[compiled-closure 124 ("art" #x9) #x12c #x97008c #xacaf90] #[compiled-closure 125 ("art" #x9) #x12c #x97008c #xacb1f0] #[compiled-closure 126 ("art" #x9) #x12c #x97008c #xacb410] #[compiled-closure 127 ("art" #x9) #x12c #x97008c #xacb600] #[compiled-closure 128 ("art" #x9) #x12c #x97008c #xacb7f4] #[compiled-closure 129 ("art" #x9) #x12c #x97008c #xacb9a8] #[compiled-closure 130 ("art" #x9) #x12c #x97008c #xacbb44] #[compiled-closure 131 ("art" #x9) #x12c #x97008c #xacbd14] #[compiled-closure 132 ("art" #x9) #x12c #x97008c #xacbed0] #[compiled-closure 133 ("art" #x9) #x12c #x97008c #xacc084] #[compiled-closure 134 ("art" #x9) #x12c #x97008c #xacc248] #[compiled-closure 135 ("art" #x9) #x12c #x97008c #xacc404] #[compiled-closure 136 ("art" #x9) #x12c #x97008c #xacc598] #[compiled-closure 137 ("art" #x9) #x12c #x97008c #xacc70c] #[compiled-closure 138 ("art" #x9) #x12c #x97008c #xacc8cc] #[compiled-closure 139 ("art" #x9) #x12c #x97008c #xacca70] #[compiled-closure 140 ("art" #x9) #x12c #x97008c #xaccc24] #[compiled-closure 141 ("art" #x9) #x12c #x97008c #xaccde0] #[compiled-closure 142 ("art" #x9) #x12c #x97008c #xaccf9c] #[compiled-closure 143 ("art" #x9) #x12c #x97008c #xacd118] #[compiled-closure 144 ("art" #x9) #x12c #x97008c #xacd264] #[compiled-closure 145 ("art" #x9) #x12c #x97008c #xacd3f4] #[compiled-closure 146 ("art" #x9) #x12c #x97008c #xacd588] #[compiled-closure 147 ("art" #x9) #x12c #x97008c #xacd714] #[compiled-closure 148 ("art" #x9) #x12c #x97008c #xacd8b8] #[compiled-closure 149 ("art" #x9) #x12c #x97008c #xacda54] #[compiled-closure 150 ("art" #x9) #x12c #x97008c #xacdbc8] #[compiled-closure 151 ("art" #x9) #x12c #x97008c #xacdd1c] #[compiled-closure 152 ("art" #x9) #x12c #x97008c #xacde9c] #[compiled-closure 153 ("art" #x9) #x12c #x97008c #xace028] #[compiled-closure 154 ("art" #x9) #x12c #x97008c #xace1d4] #[compiled-closure 155 ("art" #x9) #x12c #x97008c #xace370] #[compiled-closure 156 ("art" #x9) #x12c #x97008c #xace4f4] #[compiled-closure 157 ("art" #x9) #x12c #x97008c #xace648] #[compiled-closure 158 ("art" #x9) #x12c #x97008c #xace7c4] #[compiled-closure 159 ("art" #x9) #x12c #x97008c #xace974] #[compiled-closure 160 ("art" #x9) #x12c #x97008c #xaceae0] #[compiled-closure 161 ("art" #x9) #x12c #x97008c #xacec54] #[compiled-closure 162 ("art" #x9) #x12c #x97008c #xacedf8] #[compiled-closure 163 ("art" #x9) #x12c #x97008c #xacefb4] #[compiled-closure 164 ("art" #x9) #x12c #x97008c #xacf120] #[compiled-closure 165 ("art" #x9) #x12c #x97008c #xacf25c] #[compiled-closure 166 ("art" #x9) #x12c #x97008c #xacf3fc] #[compiled-closure 167 ("art" #x9) #x12c #x97008c #xacf580] #[compiled-closure 168 ("art" #x9) #x12c #x97008c #xacf714] #[compiled-closure 169 ("art" #x9) #x12c #x97008c #xacf8a8] #[compiled-closure 170 ("art" #x9) #x12c #x97008c #xacfa3c] #[compiled-closure 171 ("art" #x9) #x12c #x97008c #xacfb98] #[compiled-closure 172 ("art" #x9) #x12c #x97008c #xacfcc4] #[compiled-closure 173 ("art" #x9) #x12c #x97008c #xacfe54] #[compiled-closure 174 ("art" #x9) #x12c #x97008c #xacffe8] #[compiled-closure 175 ("art" #x9) #x12c #x97008c #xad0164] #[compiled-closure 176 ("art" #x9) #x12c #x97008c #xad02d8] #[compiled-closure 177 ("art" #x9) #x12c #x97008c #xad044c] #[compiled-closure 178 ("art" #x9) #x12c #x97008c #xad05d0] #[compiled-closure 179 ("art" #x9) #x12c #x97008c #xad072c] #[compiled-closure 180 ("art" #x9) #x12c #x97008c #xad089c] #[compiled-closure 181 ("art" #x9) #x12c #x97008c #xad09f8] #[compiled-closure 182 ("art" #x9) #x12c #x97008c #xad0b7c] #[compiled-closure 183 ("art" #x9) #x12c #x97008c #xad0d28] #[compiled-closure 184 ("art" #x9) #x12c #x97008c #xad0eb4] #[compiled-closure 185 ("art" #x9) #x12c #x97008c #xad0ff8] #[compiled-closure 186 ("art" #x9) #x12c #x97008c #xad1144] #[compiled-closure 187 ("art" #x9) #x12c #x97008c #xad12cc] #[compiled-closure 188 ("art" #x9) #x12c #x97008c #xad1440] #[compiled-closure 189 ("art" #x9) #x12c #x97008c #xad15ac] #[compiled-closure 190 ("art" #x9) #x12c #x97008c #xad1730] #[compiled-closure 191 ("art" #x9) #x12c #x97008c #xad18ac] #[compiled-closure 192 ("art" #x9) #x12c #x97008c #xad19e0] #[compiled-closure 193 ("art" #x9) #x12c #x97008c #xad1b1c] #[compiled-closure 194 ("art" #x9) #x12c #x97008c #xad1cd4] #[compiled-closure 195 ("art" #x9) #x12c #x97008c #xad1e48] #[compiled-closure 196 ("art" #x9) #x12c #x97008c #xad1f94] #[compiled-closure 197 ("art" #x9) #x12c #x97008c #xad20f0] #[compiled-closure 198 ("art" #x9) #x12c #x97008c #xad228c] #[compiled-closure 199 ("art" #x9) #x12c #x97008c #xad23e8] #[compiled-closure 200 ("art" #x9) #x12c #x97008c #xad2504] #[compiled-closure 201 ("art" #x9) #x12c #x97008c #xad267c] #[compiled-closure 202 ("art" #x9) #x12c #x97008c #xad2838] #[compiled-closure 203 ("art" #x9) #x12c #x97008c #xad29b8] #[compiled-closure 204 ("art" #x9) #x12c #x97008c #xad2b1c] #[compiled-closure 205 ("art" #x9) #x12c #x97008c #xad2c48] #[compiled-closure 206 ("art" #x9) #x12c #x97008c #xad2db4] #[compiled-closure 207 ("art" #x9) #x12c #x97008c #xad2f2c] #[compiled-closure 208 ("art" #x9) #x12c #x97008c #xad3070] #[compiled-closure 209 ("art" #x9) #x12c #x97008c #xad31cc] #[compiled-closure 210 ("art" #x9) #x12c #x97008c #xad3368] #[compiled-closure 211 ("art" #x9) #x12c #x97008c #xad34c4] #[compiled-closure 212 ("art" #x9) #x12c #x97008c #xad35f0] #[compiled-closure 213 ("art" #x9) #x12c #x97008c #xad3730] #[compiled-closure 214 ("art" #x9) #x12c #x97008c #xad38b4] #[compiled-closure 215 ("art" #x9) #x12c #x97008c #xad3a40] #[compiled-closure 216 ("art" #x9) #x12c #x97008c #xaa89f0] #[compiled-closure 217 ("art" #x9) #x12c #x97008c #xaa5f44] #[compiled-closure 218 ("art" #x9) #x12c #x97008c #xaa33c8] #[compiled-closure 219 ("art" #x9) #x12c #x97008c #xa9cb78] #[compiled-closure 220 ("art" #x9) #x12c #x97008c #xad3f00] #[compiled-closure 221 ("art" #x9) #x12c #x97008c #xaab17c] #[compiled-closure 222 ("art" #x9) #x12c #x97008c #xaa8900] #[compiled-closure 223 ("art" #x9) #x12c #x97008c #xaa5e54] #[compiled-closure 224 ("art" #x9) #x12c #x97008c #xaa003c] #[compiled-closure 225 ("art" #x9) #x12c #x97008c #xad4350] #[compiled-closure 226 ("art" #x9) #x12c #x97008c #xaad720] #[compiled-closure 227 ("art" #x9) #x12c #x97008c #xaab024] #[compiled-closure 228 ("art" #x9) #x12c #x97008c #xaa87a8] #[compiled-closure 229 ("art" #x9) #x12c #x97008c #xaa310c] #[compiled-closure 230 ("art" #x9) #x12c #x97008c #xad4730] #[compiled-closure 231 ("art" #x9) #x12c #x97008c #xaafa80] #[compiled-closure 232 ("art" #x9) #x12c #x97008c #xaad548] #[compiled-closure 233 ("art" #x9) #x12c #x97008c #xaaae4c] #[compiled-closure 234 ("art" #x9) #x12c #x97008c #xaa5af0] #[compiled-closure 235 ("art" #x9) #x12c #x97008c #xad49f8] #[compiled-closure 236 ("art" #x9) #x12c #x97008c #xab1a78] #[compiled-closure 237 ("art" #x9) #x12c #x97008c #xaaf874] #[compiled-closure 238 ("art" #x9) #x12c #x97008c #xaad33c] #[compiled-closure 239 ("art" #x9) #x12c #x97008c #xaa8394] #[compiled-closure 240 ("art" #x9) #x12c #x97008c #xad4c60] #[compiled-closure 241 ("art" #x9) #x12c #x97008c #xaab13c] #[compiled-closure 242 ("art" #x9) #x12c #x97008c #xaad6e0] #[compiled-closure 243 ("art" #x9) #x12c #x97008c #xaafa40] #[compiled-closure 244 ("art" #x9) #x12c #x97008c #xab1a38] #[compiled-closure 245 ("art" #x9) #x12c #x97008c #xad4ec0] #[compiled-closure 246 ("art" #x9) #x12c #x97008c #xaa88c0] #[compiled-closure 247 ("art" #x9) #x12c #x97008c #xaaafe4] #[compiled-closure 248 ("art" #x9) #x12c #x97008c #xaad508] #[compiled-closure 249 ("art" #x9) #x12c #x97008c #xaaf834] #[compiled-closure 250 ("art" #x9) #x12c #x97008c #xad5140] #[compiled-closure 251 ("art" #x9) #x12c #x97008c #xaa5e14] #[compiled-closure 252 ("art" #x9) #x12c #x97008c #xaa8768] #[compiled-closure 253 ("art" #x9) #x12c #x97008c #xaaae0c] #[compiled-closure 254 ("art" #x9) #x12c #x97008c #xaad2fc] #[compiled-closure 255 ("art" #x9) #x12c #x97008c #xad53b8] #[compiled-closure 256 ("art" #x9) #x12c #x97008c #xaa32b8] #[compiled-closure 257 ("art" #x9) #x12c #x97008c #xaa5cdc] #[compiled-closure 258 ("art" #x9) #x12c #x97008c #xaa85b0] #[compiled-closure 259 ("art" #x9) #x12c #x97008c #xaaac20] #[compiled-closure 260 ("art" #x9) #x12c #x97008c #xad55d8] #[compiled-closure 261 ("art" #x9) #x12c #x97008c #xa9ffc4] #[compiled-closure 262 ("art" #x9) #x12c #x97008c #xaa3094] #[compiled-closure 263 ("art" #x9) #x12c #x97008c #xaa5a78] #[compiled-closure 264 ("art" #x9) #x12c #x97008c #xaa831c] #[compiled-closure 265 ("art" #x9) #x12c #x97008c #xa98f58] #[compiled-closure 266 ("art" #x9) #x12c #x97008c #xa947c4] #[compiled-closure 267 ("art" #x38) #x169 #xa415fd #xab1920] #[compiled-closure 268 ("art" #x9) #x12c #x97008c #xad5900] #[compiled-closure 269 ("art" #x9) #x12c #x97008c #xa9cbf8] #[compiled-closure 270 ("art" #x9) #x12c #x97008c #xa99214] #[compiled-closure 271 ("art" #x38) #x169 #xa415fd #xab358c] #[compiled-closure 272 ("art" #x9) #x12c #x97008c #xad5ab0] #[compiled-closure 273 ("art" #x9) #x12c #x97008c #xaa00bc] #[compiled-closure 274 ("art" #x9) #x12c #x97008c #xa9cf34] #[compiled-closure 275 ("art" #x38) #x169 #xa415fd #xab4e6c] #[compiled-closure 276 ("art" #x9) #x12c #x97008c #xad5c60] #[compiled-closure 277 ("art" #x9) #x12c #x97008c #xaa318c] #[compiled-closure 278 ("art" #x9) #x12c #x97008c #xaa0470] #[compiled-closure 279 ("art" #x38) #x169 #xa415fd #xab6520] #[compiled-closure 280 ("art" #x9) #x12c #x97008c #xad5cf0] #[compiled-closure 281 ("art" #x9) #x12c #x97008c #xaa5b70] #[compiled-closure 282 ("art" #x9) #x12c #x97008c #xaa35e0] #[compiled-closure 283 ("art" #x38) #x169 #xa415fd #xab78a0] #[compiled-closure 284 ("art" #x9) #x12c #x97008c #xad5b40] #[compiled-closure 285 ("art" #x9) #x12c #x97008c #xa9cbc0] #[compiled-closure 286 ("art" #x9) #x12c #x97008c #xa8f0b0] #[compiled-closure 287 ("art" #x38) #x169 #xa415fd #xaaf71c] #[compiled-closure 288 ("art" #x9) #x12c #x97008c #xad5990] #[compiled-closure 289 ("art" #x9) #x12c #x97008c #xaa0084] #[compiled-closure 290 ("art" #x9) #x12c #x97008c #xa9479c] #[compiled-closure 291 ("art" #x38) #x169 #xa415fd #xab171c] #[compiled-closure 292 ("art" #x9) #x12c #x97008c #xad57e0] #[compiled-closure 293 ("art" #x9) #x12c #x97008c #xaa3154] #[compiled-closure 294 ("art" #x9) #x12c #x97008c #xa991e4] #[compiled-closure 295 ("art" #x38) #x169 #xa415fd #xab33b8] #[compiled-closure 296 ("art" #x9) #x12c #x97008c #xad5668] #[compiled-closure 297 ("art" #x9) #x12c #x97008c #xaa5b38] #[compiled-closure 298 ("art" #x9) #x12c #x97008c #xa9cedc] #[compiled-closure 299 ("art" #x38) #x169 #xa415fd #xab4ce0] #[compiled-closure 300 ("art" #x9) #x12c #x97008c #xad54b8] #[compiled-closure 301 ("art" #x9) #x12c #x97008c #xaa83dc] #[compiled-closure 302 ("art" #x9) #x12c #x97008c #xaa03e0] #[compiled-closure 303 ("art" #x38) #x169 #xa415fd #xab636c] #[compiled-closure 304 ("art" #x9) #x12c #x97008c #xad52b8] #[compiled-closure 305 ("art" #x9) #x12c #x97008c #xaa0014] #[compiled-closure 306 ("art" #x9) #x12c #x97008c #xa88e1c] #[compiled-closure 307 ("art" #x38) #x169 #xa415fd #xaad1e4] #[compiled-closure 308 ("art" #x9) #x12c #x97008c #xad50b0] #[compiled-closure 309 ("art" #x9) #x12c #x97008c #xaa30e4] #[compiled-closure 310 ("art" #x9) #x12c #x97008c #xa8f088] #[compiled-closure 311 ("art" #x38) #x169 #xa415fd #xaaf510] #[compiled-closure 312 ("art" #x9) #x12c #x97008c #xad4ee8] #[compiled-closure 313 ("art" #x9) #x12c #x97008c #xaa5ac8] #[compiled-closure 314 ("art" #x9) #x12c #x97008c #xa9476c] #[compiled-closure 315 ("art" #x38) #x169 #xa415fd #xab1540] #[compiled-closure 316 ("art" #x9) #x12c #x97008c #xad4d10] #[compiled-closure 317 ("art" #x9) #x12c #x97008c #xaa836c] #[compiled-closure 318 ("art" #x9) #x12c #x97008c #xa9918c] #[compiled-closure 319 ("art" #x38) #x169 #xa415fd #xab3224] #[compiled-closure 320 ("art" #x9) #x12c #x97008c #xad4b08] #[compiled-closure 321 ("art" #x9) #x12c #x97008c #xaaa9e4] #[compiled-closure 322 ("art" #x9) #x12c #x97008c #xa9ce4c] #[compiled-closure 323 ("art" #x38) #x169 #xa415fd #xab4b24] #[compiled-closure 324 ("art" #x9) #x12c #x97008c #xad48d8] #[compiled-closure 325 ("art" #x9) #x12c #x97008c #xaa3044] #[compiled-closure 326 ("art" #x9) #x12c #x97008c #xa81810] #[compiled-closure 327 ("art" #x38) #x169 #xa415fd #xaaab74] #[compiled-closure 328 ("art" #x9) #x12c #x97008c #xad4670] #[compiled-closure 329 ("art" #x9) #x12c #x97008c #xaa5a28] #[compiled-closure 330 ("art" #x9) #x12c #x97008c #xa88df4] #[compiled-closure 331 ("art" #x38) #x169 #xa415fd #xaad064] #[compiled-closure 332 ("art" #x9) #x12c #x97008c #xad4378] #[compiled-closure 333 ("art" #x9) #x12c #x97008c #xaa82cc] #[compiled-closure 334 ("art" #x9) #x12c #x97008c #xa8f058] #[compiled-closure 335 ("art" #x38) #x169 #xa415fd #xaaf3c0] #[compiled-closure 336 ("art" #x9) #x12c #x97008c #xad4000] #[compiled-closure 337 ("art" #x9) #x12c #x97008c #xaaa964] #[compiled-closure 338 ("art" #x9) #x12c #x97008c #xa94714] #[compiled-closure 339 ("art" #x38) #x169 #xa415fd #xab1418] #[compiled-closure 340 ("art" #x9) #x12c #x97008c #xad3c50] #[compiled-closure 341 ("art" #x9) #x12c #x97008c #xaace94] #[compiled-closure 342 ("art" #x9) #x12c #x97008c #xa990fc] #[compiled-closure 343 ("art" #x38) #x169 #xa415fd #xab30cc] #[compiled-closure 344 ("art" #x9) #x12c #x97008c #xad3758] #[compiled-closure 345 ("art" #x9) #x12c #x97008c #xaa2ffc] #[compiled-closure 346 ("art" #x9) #x12c #x97008c #xa7770c] #[compiled-closure 347 ("art" #x38) #x169 #xa415fd #xaa818c] #[compiled-closure 348 ("art" #x9) #x12c #x97008c #xad31f4] #[compiled-closure 349 ("art" #x9) #x12c #x97008c #xaa59e0] #[compiled-closure 350 ("art" #x9) #x12c #x97008c #xa817e8] #[compiled-closure 351 ("art" #x38) #x169 #xa415fd #xaaa824] #[compiled-closure 352 ("art" #x9) #x12c #x97008c #xad2c70] #[compiled-closure 353 ("art" #x9) #x12c #x97008c #xaa8284] #[compiled-closure 354 ("art" #x9) #x12c #x97008c #xa88dc4] #[compiled-closure 355 ("art" #x38) #x169 #xa415fd #xaacd7c] #[compiled-closure 356 ("art" #x9) #x12c #x97008c #xad26a4] #[compiled-closure 357 ("art" #x9) #x12c #x97008c #xaaa91c] #[compiled-closure 358 ("art" #x9) #x12c #x97008c #xa8f000] #[compiled-closure 359 ("art" #x38) #x169 #xa415fd #xaaf104] #[compiled-closure 360 ("art" #x9) #x12c #x97008c #xad2118] #[compiled-closure 361 ("art" #x9) #x12c #x97008c #xaace4c] #[compiled-closure 362 ("art" #x9) #x12c #x97008c #xa94684] #[compiled-closure 363 ("art" #x38) #x169 #xa415fd #xab1134] #[compiled-closure 364 ("art" #x9) #x12c #x97008c #xad1b5c] #[compiled-closure 365 ("art" #x9) #x12c #x97008c #xad1a08] #[compiled-closure 366 ("art" #x9) #x12c #x97008c #xab36c4] #[compiled-closure 367 ("art" #x9) #x12c #x97008c #xab1854] #[compiled-closure 368 ("art" #x9) #x12c #x97008c #xaaf648] #[compiled-closure 369 ("art" #x9) #x12c #x97008c #xaaaa0c] #[compiled-closure 370 ("art" #x9) #x12c #x97008c #xad12f4] #[compiled-closure 371 ("art" #x9) #x12c #x97008c #xab4f9c] #[compiled-closure 372 ("art" #x9) #x12c #x97008c #xab34e8] #[compiled-closure 373 ("art" #x9) #x12c #x97008c #xab1670] #[compiled-closure 374 ("art" #x9) #x12c #x97008c #xaacf5c] #[compiled-closure 375 ("art" #x9) #x12c #x97008c #xad0ba4] #[compiled-closure 376 ("art" #x9) #x12c #x97008c #xab6638] #[compiled-closure 377 ("art" #x9) #x12c #x97008c #xab4df8] #[compiled-closure 378 ("art" #x9) #x12c #x97008c #xab333c] #[compiled-closure 379 ("art" #x9) #x12c #x97008c #xaaf2cc] #[compiled-closure 380 ("art" #x9) #x12c #x97008c #xad0474] #[compiled-closure 381 ("art" #x9) #x12c #x97008c #xab79f8] #[compiled-closure 382 ("art" #x9) #x12c #x97008c #xab64c4] #[compiled-closure 383 ("art" #x9) #x12c #x97008c #xab4c7c] #[compiled-closure 384 ("art" #x9) #x12c #x97008c #xab133c] #[compiled-closure 385 ("art" #x9) #x12c #x97008c #xacfcec] #[compiled-closure 386 ("art" #x9) #x12c #x97008c #xab8ae4] #[compiled-closure 387 ("art" #x9) #x12c #x97008c #xab7858] #[compiled-closure 388 ("art" #x9) #x12c #x97008c #xab631c] #[compiled-closure 389 ("art" #x9) #x12c #x97008c #xab3044] #[compiled-closure 390 ("art" #x9) #x12c #x97008c #xacf5a8] #[compiled-closure 391 ("art" #x9) #x12c #x97008c #xab4f5c] #[compiled-closure 392 ("art" #x9) #x12c #x97008c #xab65f8] #[compiled-closure 393 ("art" #x9) #x12c #x97008c #xab79b8] #[compiled-closure 394 ("art" #x9) #x12c #x97008c #xab8aa4] #[compiled-closure 395 ("art" #x9) #x12c #x97008c #xacee20] #[compiled-closure 396 ("art" #x9) #x12c #x97008c #xab34a8] #[compiled-closure 397 ("art" #x9) #x12c #x97008c #xab4db8] #[compiled-closure 398 ("art" #x9) #x12c #x97008c #xab6484] #[compiled-closure 399 ("art" #x9) #x12c #x97008c #xab7818] #[compiled-closure 400 ("art" #x9) #x12c #x97008c #xace670] #[compiled-closure 401 ("art" #x9) #x12c #x97008c #xab1630] #[compiled-closure 402 ("art" #x9) #x12c #x97008c #xab32fc] #[compiled-closure 403 ("art" #x9) #x12c #x97008c #xab4c3c] #[compiled-closure 404 ("art" #x9) #x12c #x97008c #xab62dc] #[compiled-closure 405 ("art" #x9) #x12c #x97008c #xacdec4] #[compiled-closure 406 ("art" #x9) #x12c #x97008c #xaaf444] #[compiled-closure 407 ("art" #x9) #x12c #x97008c #xab1484] #[compiled-closure 408 ("art" #x9) #x12c #x97008c #xab3178] #[compiled-closure 409 ("art" #x9) #x12c #x97008c #xab4aa4] #[compiled-closure 410 ("art" #x9) #x12c #x97008c #xacd73c] #[compiled-closure 411 ("art" #x9) #x12c #x97008c #xaacee4] #[compiled-closure 412 ("art" #x9) #x12c #x97008c #xaaf254] #[compiled-closure 413 ("art" #x9) #x12c #x97008c #xab12c4] #[compiled-closure 414 ("art" #x9) #x12c #x97008c #xab2fcc] #[compiled-closure 415 ("art" #x9) #x12c #x97008c #xaa8414] #[compiled-closure 416 ("art" #x9) #x12c #x97008c #xaa60bc] #[compiled-closure 417 ("art" #x38) #x169 #xa415fd #xab898c] #[compiled-closure 418 ("art" #x9) #x12c #x97008c #xacca98] #[compiled-closure 419 ("art" #x9) #x12c #x97008c #xaaaa8c] #[compiled-closure 420 ("art" #x9) #x12c #x97008c #xaa8ab8] #[compiled-closure 421 ("art" #x38) #x169 #xa415fd #xab98bc] #[compiled-closure 422 ("art" #x9) #x12c #x97008c #xacc42c] #[compiled-closure 423 ("art" #x9) #x12c #x97008c #xaacfdc] #[compiled-closure 424 ("art" #x9) #x12c #x97008c #xaab244] #[compiled-closure 425 ("art" #x38) #x169 #xa415fd #xaba598] #[compiled-closure 426 ("art" #x9) #x12c #x97008c #xacbd3c] #[compiled-closure 427 ("art" #x9) #x12c #x97008c #xaaf34c] #[compiled-closure 428 ("art" #x9) #x12c #x97008c #xaad7e8] #[compiled-closure 429 ("art" #x38) #x169 #xa415fd #xabb044] #[compiled-closure 430 ("art" #x9) #x12c #x97008c #xacb628] #[compiled-closure 431 ("art" #x9) #x12c #x97008c #xab13bc] #[compiled-closure 432 ("art" #x9) #x12c #x97008c #xaafb48] #[compiled-closure 433 ("art" #x38) #x169 #xa415fd #xabb950] #[compiled-closure 434 ("art" #x9) #x12c #x97008c #xacad3c] #[compiled-closure 435 ("art" #x9) #x12c #x97008c #xaaaa54] #[compiled-closure 436 ("art" #x9) #x12c #x97008c #xaa3540] #[compiled-closure 437 ("art" #x38) #x169 #xa415fd #xab7700] #[compiled-closure 438 ("art" #x9) #x12c #x97008c #xaca418] #[compiled-closure 439 ("art" #x9) #x12c #x97008c #xaacfa4] #[compiled-closure 440 ("art" #x9) #x12c #x97008c #xaa600c] #[compiled-closure 441 ("art" #x38) #x169 #xa415fd #xab8850] #[compiled-closure 442 ("art" #x9) #x12c #x97008c #xac9ab0] #[compiled-closure 443 ("art" #x9) #x12c #x97008c #xaaf314] #[compiled-closure 444 ("art" #x9) #x12c #x97008c #xaa89c8] #[compiled-closure 445 ("art" #x38) #x169 #xa415fd #xab97f0] #[compiled-closure 446 ("art" #x9) #x12c #x97008c #xac90cc] #[compiled-closure 447 ("art" #x9) #x12c #x97008c #xab1384] #[compiled-closure 448 ("art" #x9) #x12c #x97008c #xaab0ec] #[compiled-closure 449 ("art" #x38) #x169 #xa415fd #xaba55c] #[compiled-closure 450 ("art" #x9) #x12c #x97008c #xac870c] #[compiled-closure 451 ("art" #x9) #x12c #x97008c #xab308c] #[compiled-closure 452 ("art" #x9) #x12c #x97008c #xaad610] #[compiled-closure 453 ("art" #x38) #x169 #xa415fd #xabb01c] #[compiled-closure 454 ("art" #x9) #x12c #x97008c #xac7c84] #[compiled-closure 455 ("art" #x9) #x12c #x97008c #xaacf34] #[compiled-closure 456 ("art" #x9) #x12c #x97008c #xaa0340] #[compiled-closure 457 ("art" #x38) #x169 #xa415fd #xab61c4] #[compiled-closure 458 ("art" #x9) #x12c #x97008c #xac724c] #[compiled-closure 459 ("art" #x9) #x12c #x97008c #xaaf2a4] #[compiled-closure 460 ("art" #x9) #x12c #x97008c #xaa3490] #[compiled-closure 461 ("art" #x38) #x169 #xa415fd #xab75bc] #[compiled-closure 462 ("art" #x9) #x12c #x97008c #xac67a4] #[compiled-closure 463 ("art" #x9) #x12c #x97008c #xab1314] #[compiled-closure 464 ("art" #x9) #x12c #x97008c #xaa5f1c] #[compiled-closure 465 ("art" #x38) #x169 #xa415fd #xab877c] #[compiled-closure 466 ("art" #x9) #x12c #x97008c #xac5ca8] #[compiled-closure 467 ("art" #x9) #x12c #x97008c #xab301c] #[compiled-closure 468 ("art" #x9) #x12c #x97008c #xaa8870] #[compiled-closure 469 ("art" #x38) #x169 #xa415fd #xab97ac] #[compiled-closure 470 ("art" #x9) #x12c #x97008c #xac5020] #[compiled-closure 471 ("art" #x9) #x12c #x97008c #xab49a4] #[compiled-closure 472 ("art" #x9) #x12c #x97008c #xaaaf14] #[compiled-closure 473 ("art" #x38) #x169 #xa415fd #xaba52c] #[compiled-closure 474 ("art" #x9) #x12c #x97008c #xac4310] #[compiled-closure 475 ("art" #x9) #x12c #x97008c #xaaf204] #[compiled-closure 476 ("art" #x9) #x12c #x97008c #xa9cdac] #[compiled-closure 477 ("art" #x38) #x169 #xa415fd #xab49f8] #[compiled-closure 478 ("art" #x9) #x12c #x97008c #xac3648] #[compiled-closure 479 ("art" #x9) #x12c #x97008c #xab1274] #[compiled-closure 480 ("art" #x9) #x12c #x97008c #xaa0290] #[compiled-closure 481 ("art" #x38) #x169 #xa415fd #xab60c4] #[compiled-closure 482 ("art" #x9) #x12c #x97008c #xac2818] #[compiled-closure 483 ("art" #x9) #x12c #x97008c #xab2f7c] #[compiled-closure 484 ("art" #x9) #x12c #x97008c #xaa33a0] #[compiled-closure 485 ("art" #x38) #x169 #xa415fd #xab74f4] #[compiled-closure 486 ("art" #x9) #x12c #x97008c #xac18b4] #[compiled-closure 487 ("art" #x9) #x12c #x97008c #xab4924] #[compiled-closure 488 ("art" #x9) #x12c #x97008c #xaa5dc4] #[compiled-closure 489 ("art" #x38) #x169 #xa415fd #xab872c] #[compiled-closure 490 ("art" #x9) #x12c #x97008c #xac077c] #[compiled-closure 491 ("art" #x9) #x12c #x97008c #xab6060] #[compiled-closure 492 ("art" #x9) #x12c #x97008c #xaa8698] #[compiled-closure 493 ("art" #x38) #x169 #xa415fd #xab976c] #[compiled-closure 494 ("art" #x9) #x12c #x97008c #xabf344] #[compiled-closure 495 ("art" #x9) #x12c #x97008c #xaaf1bc] #[compiled-closure 496 ("art" #x9) #x12c #x97008c #xa9905c] #[compiled-closure 497 ("art" #x38) #x169 #xa415fd #xab2e3c] #[compiled-closure 498 ("art" #x9) #x12c #x97008c #xabdc68] #[compiled-closure 499 ("art" #x9) #x12c #x97008c #xab122c] #[compiled-closure 500 ("art" #x9) #x12c #x97008c #xa9ccfc] #[compiled-closure 501 ("art" #x38) #x169 #xa415fd #xab47e4] #[compiled-closure 502 ("art" #x9) #x12c #x97008c #xabbf28] #[compiled-closure 503 ("art" #x9) #x12c #x97008c #xab2f34] #[compiled-closure 504 ("art" #x9) #x12c #x97008c #xaa01c0] #[compiled-closure 505 ("art" #x38) #x169 #xa415fd #xab5f70] #[compiled-closure 506 ("art" #x9) #x12c #x97008c #xab9264] #[compiled-closure 507 ("art" #x9) #x12c #x97008c #xab48dc] #[compiled-closure 508 ("art" #x9) #x12c #x97008c #xaa3290] #[compiled-closure 509 ("art" #x38) #x169 #xa415fd #xab5868] #[compiled-closure 510 ("art" #x9) #x12c #x97008c #xab3f9c] #[compiled-closure 511 ("art" #x9) #x12c #x97008c #xab23ac] #[compiled-closure 512 ("art" #x9) #x12c #x97008c #xaa5c74] #[compiled-closure 513 ("art" #x38) #x169 #xa415fd #xaae1e8] #[compiled-closure 514 ("art" #x9) #x12c #x97008c #xaabc70] #[compiled-closure 515 ("art" #x9) #x12c #x97008c #xaa955c] #[compiled-closure 516 ("art" #x9) #x12c #x97008c #xa9a9c8] #[compiled-closure 517 ("art" #x9) #x12c #x97008c #xa9aa08] #[compiled-closure 518 ("art" #x9) #x12c #x97008c #xa9aa48] #[compiled-closure 519 ("art" #x9) #x12c #x97008c #xa9aa88] #[compiled-closure 520 ("art" #x9) #x12c #x97008c #xa9a818] #[compiled-closure 521 ("art" #x9) #x12c #x97008c #xa95f00] #[compiled-closure 522 ("art" #x9) #x12c #x97008c #xa90c1c] #[compiled-closure 523 ("art" #x9) #x12c #x97008c #xa8aab0] #[compiled-closure 524 ("art" #x9) #x12c #x97008c #xa839e4] #[compiled-closure 525 ("art" #x9) #x12c #x97008c #xa7abd0] #[compiled-closure 526 ("art" #x9) #x12c #x97008c #xa70b20] #[compiled-closure 527 ("art" #x9) #x12c #x97008c #xa631bc] #[compiled-closure 528 ("art" #x9) #x12c #x97008c #xa53844] #[compiled-closure 529 ("art" #x9) #x12c #x97008c #xa3a3cc] #[compiled-closure 530 ("art" #x9) #x12c #x97008c #xa14870] #[compiled-closure 531 ("art" #x9) #x12c #x97008c #x9e270c] #[compiled-closure 532 ("art" #x9) #x12c #x97008c #x970180] #[compiled-closure 533 ("art" #x9) #x12c #x97008c #xa631e4] #[compiled-closure 534 ("art" #x9) #x12c #x97008c #xab3f44] #[compiled-closure 535 ("art" #x9) #x12c #x97008c #xad5350] #[compiled-closure 536 ("art" #x9) #x12c #x97008c #xa70b50] #[compiled-closure 537 ("art" #x9) #x12c #x97008c #xa70d20] #[compiled-closure 538 ("art" #x9) #x12c #x97008c #xa70c58] #[compiled-closure 539 ("art" #x9) #x12c #x97008c #xab9724] #[compiled-closure 540 ("art" #x9) #x12c #x97008c #xad50d8] #[compiled-closure 541 ("art" #x9) #x12c #x97008c #xa70c78] #[compiled-closure 542 ("art" #x9) #x12c #x97008c #xa70bb8] #[compiled-closure 543 ("art" #x9) #x12c #x97008c #xa70d40] #[compiled-closure 544 ("art" #x9) #x12c #x97008c #xa838b8] #[compiled-closure 545 ("art" #x9) #x12c #x97008c #xad4e58] #[compiled-closure 546 ("art" #x9) #x12c #x97008c #xa70c98] #[compiled-closure 547 ("art" #x9) #x12c #x97008c #xa70bd8] #[compiled-closure 548 ("art" #x9) #x12c #x97008c #xa70d60] #[compiled-closure 549 ("art" #x9) #x12c #x97008c #xa70a04] #[compiled-closure 550 ("art" #x9) #x12c #x97008c #xad4bf8] #[compiled-closure 551 ("art" #x9) #x12c #x97008c #xa70cb8] #[compiled-closure 552 ("art" #x9) #x12c #x97008c #xa70bf8] #[compiled-closure 553 ("art" #x9) #x12c #x97008c #xa70d80] #[compiled-closure 554 ("art" #x9) #x12c #x97008c #xa9a840] #[compiled-closure 555 ("art" #x9) #x12c #x97008c #xad4980] #[compiled-closure 556 ("art" #x9) #x12c #x97008c #xa70cd8] #[compiled-closure 557 ("art" #x9) #x12c #x97008c #xa70c18] #[compiled-closure 558 ("art" #x9) #x12c #x97008c #xa70da0] #[compiled-closure 559 ("art" #x9) #x12c #x97008c #xab57f0] #[compiled-closure 560 ("art" #x9) #x12c #x97008c #xad4698] #[compiled-closure 561 ("art" #x9) #x12c #x97008c #xa70cf8] #[compiled-closure 562 ("art" #x9) #x12c #x97008c #xa70c38] #[compiled-closure 563 ("art" #x9) #x12c #x97008c #xa70b98] #[compiled-closure 564 ("art" #x9) #x12c #x97008c #xab6e28] #[compiled-closure 565 ("art" #x9) #x12c #x97008c #xaa1578] #[compiled-closure 566 ("art" #x9) #x12c #x97008c #xaa4460] #[compiled-closure 567 ("art" #x38) #x169 #xa415fd #xaa6e60] #[compiled-closure 568 ("art" #x9) #x12c #x97008c #xad4028] #[compiled-closure 569 ("art" #x9) #x12c #x97008c #xaa13c0] #[compiled-closure 570 ("art" #x9) #x12c #x97008c #xaa4304] #[compiled-closure 571 ("art" #x38) #x169 #xa415fd #xaa6d38] #[compiled-closure 572 ("art" #x9) #x12c #x97008c #xad3c78] #[compiled-closure 573 ("art" #x9) #x12c #x97008c #xaa12e4] #[compiled-closure 574 ("art" #x9) #x12c #x97008c #xaa4250] #[compiled-closure 575 ("art" #x38) #x169 #xa415fd #xaa6c88] #[compiled-closure 576 ("art" #x9) #x12c #x97008c #xad3780] #[compiled-closure 577 ("art" #x9) #x12c #x97008c #xa8a9bc] #[compiled-closure 578 ("art" #x9) #x12c #x97008c #xa90b04] #[compiled-closure 579 ("art" #x38) #x169 #xa415fd #xa95dd0] #[compiled-closure 580 ("art" #x9) #x12c #x97008c #xad321c] #[compiled-closure 581 ("art" #x9) #x12c #x97008c #xaa1370] #[compiled-closure 582 ("art" #x9) #x12c #x97008c #xaa42bc] #[compiled-closure 583 ("art" #x38) #x169 #xa415fd #xaa6ce4] #[compiled-closure 584 ("art" #x9) #x12c #x97008c #xad2c98] #[compiled-closure 585 ("art" #x9) #x12c #x97008c #xaa15f0] #[compiled-closure 586 ("art" #x9) #x12c #x97008c #xaa449c] #[compiled-closure 587 ("art" #x38) #x169 #xa415fd #xaa6e94] #[compiled-closure 588 ("art" #x9) #x12c #x97008c #xad26cc] #[compiled-closure 589 ("art" #x9) #x12c #x97008c #xaa1400] #[compiled-closure 590 ("art" #x9) #x12c #x97008c #xaa433c] #[compiled-closure 591 ("art" #x38) #x169 #xa415fd #xaa6d64] #[compiled-closure 592 ("art" #x9) #x12c #x97008c #xad2140] #[compiled-closure 593 ("art" #x9) #x12c #x97008c #xa9df68] #[compiled-closure 594 ("art" #x9) #x12c #x97008c #xaa12b4] #[compiled-closure 595 ("art" #x38) #x169 #xa415fd #xaa422c] #[compiled-closure 596 ("art" #x9) #x12c #x97008c #xad1b84] #[compiled-closure 597 ("art" #x9) #x12c #x97008c #xa7aa74] #[compiled-closure 598 ("art" #x9) #x12c #x97008c #xa83890] #[compiled-closure 599 ("art" #x38) #x169 #xa415fd #xa8a978] #[compiled-closure 600 ("art" #x9) #x12c #x97008c #xad15dc] #[compiled-closure 601 ("art" #x9) #x12c #x97008c #xaa1750] #[compiled-closure 602 ("art" #x9) #x12c #x97008c #xaa4584] #[compiled-closure 603 ("art" #x38) #x169 #xa415fd #xaa6f54] #[compiled-closure 604 ("art" #x9) #x12c #x97008c #xad1028] #[compiled-closure 605 ("art" #x9) #x12c #x97008c #xaa1668] #[compiled-closure 606 ("art" #x9) #x12c #x97008c #xaa44d8] #[compiled-closure 607 ("art" #x38) #x169 #xa415fd #xaa6ec8] #[compiled-closure 608 ("art" #x9) #x12c #x97008c #xad0a28] #[compiled-closure 609 ("art" #x9) #x12c #x97008c #xaa1440] #[compiled-closure 610 ("art" #x9) #x12c #x97008c #xaa4374] #[compiled-closure 611 ("art" #x38) #x169 #xa415fd #xaa6d90] #[compiled-closure 612 ("art" #x9) #x12c #x97008c #xad049c] #[compiled-closure 613 ("art" #x9) #x12c #x97008c #xa9a72c] #[compiled-closure 614 ("art" #x9) #x12c #x97008c #xa9df38] #[compiled-closure 615 ("art" #x38) #x169 #xa415fd #xaa1290] #[compiled-closure 616 ("art" #x9) #x12c #x97008c #xacfe9c] #[compiled-closure 617 ("art" #x9) #x12c #x97008c #xa9e034] #[compiled-closure 618 ("art" #x9) #x12c #x97008c #xaa1338] #[compiled-closure 619 ("art" #x38) #x169 #xa415fd #xaa4298] #[compiled-closure 620 ("art" #x9) #x12c #x97008c #xacf8d8] #[compiled-closure 621 ("art" #x9) #x12c #x97008c #xaa1500] #[compiled-closure 622 ("art" #x9) #x12c #x97008c #xaa441c] #[compiled-closure 623 ("art" #x38) #x169 #xa415fd #xaa6e14] #[compiled-closure 624 ("art" #x9) #x12c #x97008c #xacf28c] #[compiled-closure 625 ("art" #x9) #x12c #x97008c #xaa16e0] #[compiled-closure 626 ("art" #x9) #x12c #x97008c #xaa4514] #[compiled-closure 627 ("art" #x38) #x169 #xa415fd #xaa6efc] #[compiled-closure 628 ("art" #x9) #x12c #x97008c #xacec84] #[compiled-closure 629 ("art" #x9) #x12c #x97008c #xaa1480] #[compiled-closure 630 ("art" #x9) #x12c #x97008c #xaa43ac] #[compiled-closure 631 ("art" #x38) #x169 #xa415fd #xaa6dbc] #[compiled-closure 632 ("art" #x9) #x12c #x97008c #xace698] #[compiled-closure 633 ("art" #x9) #x12c #x97008c #xa95dec] #[compiled-closure 634 ("art" #x9) #x12c #x97008c #xa9a6c4] #[compiled-closure 635 ("art" #x38) #x169 #xa415fd #xa9dedc] #[compiled-closure 636 ("art" #x9) #x12c #x97008c #xace070] #[compiled-closure 637 ("art" #x9) #x12c #x97008c #xaa6c40] #[compiled-closure 638 ("art" #x9) #x12c #x97008c #xab1504] #[compiled-closure 639 ("art" #x38) #x169 #xa415fd #xab9230] #[compiled-closure 640 ("art" #x9) #x12c #x97008c #xacda84] #[compiled-closure 641 ("art" #x9) #x12c #x97008c #xab588c] #[compiled-closure 642 ("art" #x9) #x12c #x97008c #xab31f0] #[compiled-closure 643 ("art" #x38) #x169 #xa415fd #xabc8d0] #[compiled-closure 644 ("art" #x9) #x12c #x97008c #xacd424] #[compiled-closure 645 ("art" #x9) #x12c #x97008c #xaa1718] #[compiled-closure 646 ("art" #x9) #x12c #x97008c #xaa454c] #[compiled-closure 647 ("art" #x38) #x169 #xa415fd #xaa6f28] #[compiled-closure 648 ("art" #x9) #x12c #x97008c #xacce10] #[compiled-closure 649 ("art" #x9) #x12c #x97008c #xaa14c0] #[compiled-closure 650 ("art" #x9) #x12c #x97008c #xaa43e4] #[compiled-closure 651 ("art" #x38) #x169 #xa415fd #xaa6de8] #[compiled-closure 652 ("art" #x9) #x12c #x97008c #xacc73c] #[compiled-closure 653 ("art" #x9) #x12c #x97008c #xa9a6f4] #[compiled-closure 654 ("art" #x9) #x12c #x97008c #xa9df00] #[compiled-closure 655 ("art" #x38) #x169 #xa415fd #xaa1264] #[compiled-closure 656 ("art" #x9) #x12c #x97008c #xacc0b4] #[compiled-closure 657 ("art" #x9) #x12c #x97008c #xaa952c] #[compiled-closure 658 ("art" #x9) #x12c #x97008c #xaaf38c] #[compiled-closure 659 ("art" #x38) #x169 #xa415fd #xaba0cc] #[compiled-closure 660 ("art" #x9) #x12c #x97008c #xacb9d8] #[compiled-closure 661 ("art" #x9) #x12c #x97008c #xab6e70] #[compiled-closure 662 ("art" #x9) #x12c #x97008c #xab13ec] #[compiled-closure 663 ("art" #x38) #x169 #xa415fd #xabc17c] #[compiled-closure 664 ("art" #x9) #x12c #x97008c #xacb26c] #[compiled-closure 665 ("art" #x9) #x12c #x97008c #xacb054] #[compiled-closure 666 ("art" #x9) #x12c #x97008c #xacade0] #[compiled-closure 667 ("art" #x9) #x12c #x97008c #xacaba8] #[compiled-closure 668 ("art" #x9) #x12c #x97008c #xaca96c] #[compiled-closure 669 ("art" #x9) #x12c #x97008c #xaca724] #[compiled-closure 670 ("art" #x9) #x12c #x97008c #xaca4bc] #[compiled-closure 671 ("art" #x9) #x12c #x97008c #xaca22c] #[compiled-closure 672 ("art" #x9) #x12c #x97008c #xac9fc4] #[compiled-closure 673 ("art" #x9) #x12c #x97008c #xac9d44] #[compiled-closure 674 ("art" #x9) #x12c #x97008c #xac9b24] #[compiled-closure 675 ("art" #x9) #x12c #x97008c #xac98e4] #[compiled-closure 676 ("art" #x9) #x12c #x97008c #xac9664] #[compiled-closure 677 ("art" #x9) #x12c #x97008c #xac93dc] #[compiled-closure 678 ("art" #x9) #x12c #x97008c #xac9140] #[compiled-closure 679 ("art" #x9) #x12c #x97008c #xac8ed8] #[compiled-closure 680 ("art" #x9) #x12c #x97008c #xac8c7c] #[compiled-closure 681 ("art" #x9) #x12c #x97008c #xac8a34] #[compiled-closure 682 ("art" #x9) #x12c #x97008c #xac87b4] #[compiled-closure 683 ("art" #x9) #x12c #x97008c #xac84e0] #[compiled-closure 684 ("art" #x9) #x12c #x97008c #xac8258] #[compiled-closure 685 ("art" #x9) #x12c #x97008c #xac7fe0] #[compiled-closure 686 ("art" #x9) #x12c #x97008c #xac7d28] #[compiled-closure 687 ("art" #x9) #x12c #x97008c #xac7a54] #[compiled-closure 688 ("art" #x9) #x12c #x97008c #xac77e0] #[compiled-closure 689 ("art" #x9) #x12c #x97008c #xac7588] #[compiled-closure 690 ("art" #x9) #x12c #x97008c #xac72f0] #[compiled-closure 691 ("art" #x9) #x12c #x97008c #xac7018] #[compiled-closure 692 ("art" #x9) #x12c #x97008c #xac6d70] #[compiled-closure 693 ("art" #x9) #x12c #x97008c #xac6ac4] #[compiled-closure 694 ("art" #x9) #x12c #x97008c #xac6818] #[compiled-closure 695 ("art" #x9) #x12c #x97008c #xac65a0] #[compiled-closure 696 ("art" #x9) #x12c #x97008c #xac62f8] #[compiled-closure 697 ("art" #x9) #x12c #x97008c #xac6020] #[compiled-closure 698 ("art" #x9) #x12c #x97008c #xac5d1c] #[compiled-closure 699 ("art" #x9) #x12c #x97008c #xac5a34] #[compiled-closure 700 ("art" #x9) #x12c #x97008c #xac5744] #[compiled-closure 701 ("art" #x9) #x12c #x97008c #xac53f0] #[compiled-closure 702 ("art" #x9) #x12c #x97008c #xac50c8] #[compiled-closure 703 ("art" #x9) #x12c #x97008c #xac4d7c] #[compiled-closure 704 ("art" #x9) #x12c #x97008c #xac4a44] #[compiled-closure 705 ("art" #x9) #x12c #x97008c #xac4714] #[compiled-closure 706 ("art" #x9) #x12c #x97008c #xac43b4] #[compiled-closure 707 ("art" #x9) #x12c #x97008c #xac4044] #[compiled-closure 708 ("art" #x9) #x12c #x97008c #xac3ce4] #[compiled-closure 709 ("art" #x9) #x12c #x97008c #xac3a04] #[compiled-closure 710 ("art" #x9) #x12c #x97008c #xac36ec] #[compiled-closure 711 ("art" #x9) #x12c #x97008c #xac335c] #[compiled-closure 712 ("art" #x9) #x12c #x97008c #xac2fd4] #[compiled-closure 713 ("art" #x9) #x12c #x97008c #xac2c30] #[compiled-closure 714 ("art" #x9) #x12c #x97008c #xac288c] #[compiled-closure 715 ("art" #x9) #x12c #x97008c #xac24f4] #[compiled-closure 716 ("art" #x9) #x12c #x97008c #xac2144] #[compiled-closure 717 ("art" #x9) #x12c #x97008c #xac1d4c] #[compiled-closure 718 ("art" #x9) #x12c #x97008c #xac1928] #[compiled-closure 719 ("art" #x9) #x12c #x97008c #xac1528] #[compiled-closure 720 ("art" #x9) #x12c #x97008c #xac1120] #[compiled-closure 721 ("art" #x9) #x12c #x97008c #xac0ca4] #[compiled-closure 722 ("art" #x9) #x12c #x97008c #xac0824] #[compiled-closure 723 ("art" #x9) #x12c #x97008c #xac035c] #[compiled-closure 724 ("art" #x9) #x12c #x97008c #xabfe70] #[compiled-closure 725 ("art" #x9) #x12c #x97008c #xabf960] #[compiled-closure 726 ("art" #x9) #x12c #x97008c #xabf3e8] #[compiled-closure 727 ("art" #x9) #x12c #x97008c #xabee5c] #[compiled-closure 728 ("art" #x9) #x12c #x97008c #xabe8a8] #[compiled-closure 729 ("art" #x9) #x12c #x97008c #xabe33c] #[compiled-closure 730 ("art" #x9) #x12c #x97008c #xabdd0c] #[compiled-closure 731 ("art" #x9) #x12c #x97008c #xabd5f4] #[compiled-closure 732 ("art" #x9) #x12c #x97008c #xabced4] #[compiled-closure 733 ("art" #x9) #x12c #x97008c #xabc784] #[compiled-closure 734 ("art" #x9) #x12c #x97008c #xabbf9c] #[compiled-closure 735 ("art" #x9) #x12c #x97008c #xabb6dc] #[compiled-closure 736 ("art" #x9) #x12c #x97008c #xabad44] #[compiled-closure 737 ("art" #x9) #x12c #x97008c #xaba188] #[compiled-closure 738 ("art" #x9) #x12c #x97008c #xab92e0] #[compiled-closure 739 ("art" #x9) #x12c #x97008c #xab8234] #[compiled-closure 740 ("art" #x9) #x12c #x97008c #xab6f0c] #[compiled-closure 741 ("art" #x9) #x12c #x97008c #xab5940] #[compiled-closure 742 ("art" #x9) #x12c #x97008c #xab4064] #[compiled-closure 743 ("art" #x9) #x12c #x97008c #xab2440] #[compiled-closure 744 ("art" #x9) #x12c #x97008c #xab0520] #[compiled-closure 745 ("art" #x9) #x12c #x97008c #xaae2a8] #[compiled-closure 746 ("art" #x9) #x12c #x97008c #xaabd28] #[compiled-closure 747 ("art" #x9) #x12c #x97008c #xaa971c] #[compiled-closure 748 ("art" #x9) #x12c #x97008c #xaa6fbc] #[compiled-closure 749 ("art" #x9) #x12c #x97008c #xaa4600] #[compiled-closure 750 ("art" #x9) #x12c #x97008c #xaa1814] #[compiled-closure 751 ("art" #x9) #x12c #x97008c #xa9e3e8] #[compiled-closure 752 ("art" #x9) #x12c #x97008c #xa9abd0] #[compiled-closure 753 ("art" #x9) #x12c #x97008c #xa961dc] #[compiled-closure 754 ("art" #x9) #x12c #x97008c #xa90f58] #[compiled-closure 755 ("art" #x9) #x12c #x97008c #xa8b01c] #[compiled-closure 756 ("art" #x9) #x12c #x97008c #xa84118] #[compiled-closure 757 ("art" #x9) #x12c #x97008c #xa7afa0] #[compiled-closure 758 ("art" #x9) #x12c #x97008c #xa70e3c] #[compiled-closure 759 ("art" #x9) #x12c #x97008c #xa63340] #[compiled-closure 760 ("art" #x9) #x12c #x97008c #xa539c4] #[compiled-closure 761 ("art" #x9) #x12c #x97008c #xa3a56c] #[compiled-closure 762 ("art" #x9) #x12c #x97008c #xa14a44] #[compiled-closure 763 ("art" #x9) #x12c #x97008c #x9e28dc] #[compiled-closure 764 ("art" #x9) #x12c #x97008c #x9a455c])

1 ]=> (length *propagators-ever-alerted-list*)

;Value: 736

1 ]=> (define a-deck (p:make-deck 'gun nothing nothing nothing))

;Value: a-deck

1 ]=> (run)

;Value: done

1 ]=> (content a-deck)

;Value 765: #(*the-nothing*)

1 ]=> (load "albatross-conundrum")

;Loading "albatross-conundrum.scm"... done
;Value: find-solution

1 ]=> (define answer (show-time find-solution))
process time: 312440 (307240 RUN + 5200 GC); real time: 715349
;Value: answer

1 ]=> *number-of-calls-to-fail*

;Value: 1586

1 ]=> (map tms? answer)

;Value 766: (#t #t #t #t #t)

1 ]=> (map tms-query answer)

;Value 767: (#(supported #[deck 768] (#(hypothetical) #(hypothetical) #(hypothetical))) #(supported #[deck 769] (#(hypothetical) #(hypothetical) #(hypothetical))) #(supported #[deck 770] (#(hypothetical) #(hypothetical) #(hypothetical))) #(supported #[deck 771] (#(hypothetical) #(hypothetical) #(hypothetical))) #(supported #[deck 772] (#(hypothetical) #(hypothetical) #(hypothetical))))

1 ]=> (pp (map v&s-value (map tms-query answer)))
(#[deck 768] #[deck 769] #[deck 770] #[deck 771] #[deck 772])
;Unspecified return value

1 ]=> 
;Unspecified return value

1 ]=> (pp (map v&s-value (map tms-query answer)))
(#[deck 768] #[deck 769] #[deck 770] #[deck 771] #[deck 772])
;Unspecified return value

1 ]=> (map (lambda (deck)
	       (list (deck-name deck)
		     (deck-commander deck)
		     (deck-treasure deck)
		     (deck-supply deck))) (map v&s-value (map tms-query answer)))

;Value 773: ((poop windlass galliard-lute rum) (quarter bosun tamarind-jewels biscuits) (main draconio calypso-figure firearms) (gun scurvy casket-of-magenta ropes) (lower kraken goldenhall-talisman spare-sails))

1 ]=> (pp (map (lambda (deck)
	       (list (deck-name deck)
		     (deck-commander deck)
		     (deck-treasure deck)
		     (deck-supply deck))) (map v&s-value (map tms-query answer))))
((poop windlass galliard-lute rum)
 (quarter bosun tamarind-jewels biscuits)
 (main draconio calypso-figure firearms)
 (gun scurvy casket-of-magenta ropes)
 (lower kraken goldenhall-talisman spare-sails))
;Unspecified return value

1 ]=> 
;Unspecified return value

1 ]=> (pp assv)
(named-lambda (assv key alist)
  (let ((lose (lambda () (error:not-alist alist (quote assv)))))
    ((let ()
       (define loop
         (lambda (alist)
           (if (pair? alist)
               (begin
                (if (not (pair? (car alist)))
                    (lose))
                (if (eqv? (caar alist) key)
                    (car alist)
                    (loop (cdr alist))))
               (begin (if (not (null? alist)) (lose)) #f))))
       loop)
     alist)))
;Unspecified return value

1 ]=> (pwd)

;Value 11: #[pathname 11 "/home/axch/phd/thesis/examples/"]

1 ]=> (cd "..")

;Value 774: #[pathname 774 "/home/axch/phd/thesis/"]

1 ]=> (load "profiler")

;Loading "profiler.scm"... done
;Value: prof:subnode

1 ]=> 
;Value: root

1 ]=> 
;The object foo, passed as the first argument to cdr, is not the correct type.
;To continue, call RESTART with an option number:
; (RESTART 2) => Specify an argument to use in its place.
; (RESTART 1) => Return to read-eval-print level 1.

2 error>   C-c C-c
;Quit!

1 ]=> 
;Value: prof:subnode

1 ]=> 
;Unbound variable: prof:node-add-child!
;To continue, call RESTART with an option number:
; (RESTART 3) => Specify a value to use instead of prof:node-add-child!.
; (RESTART 2) => Define prof:node-add-child! to a given value.
; (RESTART 1) => Return to read-eval-print level 1.

2 error>   C-c C-c
;Quit!

1 ]=> 
;Value: prof:node-add-child!

1 ]=> 
;Value: sub

1 ]=> (case (+ 3 4) (2 'foo))

;Ill-formed clause: (2 (quote foo))
;To continue, call RESTART with an option number:
; (RESTART 1) => Return to read-eval-print level 1.

2 error>   C-c C-c
;Quit!

1 ]=> (case (+ 3 4) ((2) 'foo))

;Unspecified return value

1 ]=> (pp close-syntax)
(named-lambda (close-syntax form environment)
  (make-syntactic-closure environment (quote ()) form))
;Unspecified return value

1 ]=> 
;Loading "profiler.scm"... done
;Value: node-access-form

1 ]=> (pp (syntax '(prof:increment) (the-environment)))
(prof:node-increment (#[compound-procedure 775]) 1)
;Unspecified return value

1 ]=> (pp *prof:statistics*)
(0)
;Unspecified return value

1 ]=> (prof:increment)

;Unspecified return value

1 ]=> (pp *prof:statistics*)
(1)
;Unspecified return value

1 ]=> (pp (syntax '(prof:increment '(foo bar)) (the-environment)))

;The procedure #[compound-procedure 776 loop] has been called with 2 arguments; it requires exactly 1 argument.
;To continue, call RESTART with an option number:
; (RESTART 1) => Return to read-eval-print level 1.

2 error>   C-c C-c
;Quit!

1 ]=> (pp (syntax '(prof:increment '(foo bar)) (the-environment)))

;The procedure #[compound-procedure 777 loop] has been called with 2 arguments; it requires exactly 1 argument.
;To continue, call RESTART with an option number:
; (RESTART 1) => Return to read-eval-print level 1.

2 error>   C-c C-c
;Quit!

1 ]=> 
;Value: node-access-form

1 ]=> (pp (syntax '(prof:increment '(foo bar)) (the-environment)))
(prof:node-increment (#[compound-procedure 778]) 1)
;Unspecified return value

1 ]=> (pp *prof:statistics*)
(1 (quote 0 ((foo bar) 0)))
;Unspecified return value

1 ]=> (prof:node-increment '(foo bar))

;The procedure #[compound-procedure 779 prof:node-increment] has been called with 1 argument; it requires exactly 2 arguments.
;To continue, call RESTART with an option number:
; (RESTART 1) => Return to read-eval-print level 1.

2 error>   C-c C-c
;Quit!

1 ]=> (prof:increment '(foo bar))

;Unspecified return value

1 ]=> (pp *prof:statistics*)
(1 (quote 0 ((foo bar) 1) ((foo bar) 0)))
;Unspecified return value

1 ]=> (prof:increment (foo bar))

;Unspecified return value

1 ]=> (pp *prof:statistics*)
(1 (foo 0 (bar 1)) (quote 0 ((foo bar) 1) ((foo bar) 0)))
;Unspecified return value

1 ]=> (prof:increment (foo bar))

;Unspecified return value

1 ]=> (pp *prof:statistics*)
(1 (foo 0 (bar 2)) (quote 0 ((foo bar) 1) ((foo bar) 0)))
;Unspecified return value

1 ]=> (define quux 5)

;Value: quux

1 ]=> (pp (syntax '(prof:increment (foo ,quux)) (the-environment)))
(prof:node-increment
 (prof:subnode (#[compound-procedure 780]) (close-syntax path-form use-env))
 1)
;Unspecified return value

1 ]=> (prof:increment (foo ,quux))

;Unbound variable: use-env
;To continue, call RESTART with an option number:
; (RESTART 3) => Specify a value to use instead of use-env.
; (RESTART 2) => Define use-env to a given value.
; (RESTART 1) => Return to read-eval-print level 1.

2 error>   C-c C-c
;Quit!

1 ]=> 
;Value: node-access-form

1 ]=> (pp (syntax '(prof:increment (foo ,quux)) (the-environment)))
(prof:node-increment
 (prof:subnode (#[compound-procedure 781]) (quote ((unquote quux))))
 1)
;Unspecified return value

1 ]=> (prof:increment (foo ,quux))

;Unspecified return value

1 ]=> (pp *prof:statistics*)
(1 (foo 0 ((unquote quux) 1) (bar 2)) (quote 0 ((foo bar) 1) ((foo bar) 0)))
;Unspecified return value

1 ]=> (pp (syntax '(prof:increment (foo ,quux)) (the-environment)))
(prof:node-increment
 (prof:subnode (#[compound-procedure 782]) (quote ((unquote quux))))
 1)
;Unspecified return value

1 ]=> 
;Value: node-access-form

1 ]=> (pp (syntax '(prof:increment (foo ,quux)) (the-environment)))
(prof:node-increment (prof:subnode (#[compound-procedure 783]) (list quux)) 1)
;Unspecified return value

1 ]=> (prof:increment (foo ,quux))

;Unspecified return value

1 ]=> (pp *prof:statistics*)
(1 (foo 0 (5 1) ((unquote quux) 1) (bar 2))
   (quote 0 ((foo bar) 1) ((foo bar) 0)))
;Unspecified return value

1 ]=> (prof:increment (foo ,quux))

;Unspecified return value

1 ]=> (pp *prof:statistics*)
(1 (foo 0 (5 2) ((unquote quux) 1) (bar 2))
   (quote 0 ((foo bar) 1) ((foo bar) 0)))
;Unspecified return value

1 ]=> (set! quux 3)

;Value: 5

1 ]=> (prof:increment (foo ,quux))

;Unspecified return value

1 ]=> (pp *prof:statistics*)
(1 (foo 0 (3 1) (5 2) ((unquote quux) 1) (bar 2))
   (quote 0 ((foo bar) 1) ((foo bar) 0)))
;Unspecified return value

1 ]=> (define *prof:statistics* (prof:make-node))

;Value: *prof:statistics*

1 ]=> 
;Unspecified return value

1 ]=> (pp *prof:statistics*)
(0 (macro 0 (foo 1)))
;Unspecified return value

1 ]=> 
;Unspecified return value

1 ]=> (pp *prof:statistics*)
(0 (macro 0 (bar 2) (foo 1)))
;Unspecified return value

1 ]=> (pp (syntax '(prof:increment (hairy-macro-test data ,datum)) (the-environment)))
(prof:node-increment (prof:subnode (#[compound-procedure 784]) (list datum)) 1)
;Unspecified return value

1 ]=> (pp *prof:statistics*)
(0 (hairy-macro-test 0 (data 0)) (macro 0 (bar 2) (foo 1)))
;Unspecified return value

1 ]=> (prof:with-reset (lambda () (prof:increment)))

;Unbound variable: prof:with-reset
;To continue, call RESTART with an option number:
; (RESTART 3) => Specify a value to use instead of prof:with-reset.
; (RESTART 2) => Define prof:with-reset to a given value.
; (RESTART 1) => Return to read-eval-print level 1.

2 error>   C-c C-c
;Quit!

1 ]=> 
;Unbound variable: compile
;To continue, call RESTART with an option number:
; (RESTART 3) => Specify a value to use instead of compile.
; (RESTART 2) => Define compile to a given value.
; (RESTART 1) => Return to read-eval-print level 1.

2 error>   C-c C-c
;Quit!

1 ]=> 
;Loading "profiler.scm"... done
;Value: prof:node-clear!

1 ]=> (prof:with-reset (lambda () (prof:increment)))
(1)
;Unspecified return value

1 ]=> (pp *prof:statistics*)
(1)
;Unspecified return value

1 ]=> (pwd)

;Value 774: #[pathname 774 "/home/axch/phd/thesis/"]

1 ]=> (load "load")

;Loading "load.scm"... 
;  Loading "profiler.com"... done
;  Loading "new-art/load.scm"... 
;    Loading "../testing/load.com"... done
;    Loading "portability.scm"... 
;      Loading "mitscheme-conditions.scm"... done
;    ... done
;    Loading "ordered-map.scm"... done
;    Loading "matching.scm"... done
;    Loading "assertions.scm"... done
;    Loading "test-runner.scm"... done
;    Loading "test-group.scm"... done
;    Loading "testing.scm"... done
;    Loading "utils.com"... done
;    Loading "ghelper.com"... done
;    Loading "../literate/load.com"... done
;    Loading "regex-literals.scm"... done
;    Loading "read.scm"... done
;    Loading "test-support.scm"... done
;    Generating SCode for file: "scheduler.scm" => "scheduler.bin"... 
;Warning: Unreferenced bound variable: value (|#[unnamed-procedure]| order-preserving-insert)
;      Dumping "scheduler.bin"... 
;Object cannot be dumped because it contains an environment: #[comment 785]
;To continue, call RESTART with an option number:
; (RESTART 1) => Return to read-eval-print level 1.

2 error> (pp #@785)
(begin
 (define *alerted-propagators*)
 (define *alerted-propagator-list*)
 (define *abort-process*)
 (define *last-value-of-run*)
 (define *propagators-ever-alerted*)
 (define *propagators-ever-alerted-list*)
 (define (initialize-scheduler)
   (clear-alerted-propagators!)
   (set! *abort-process* #f)
   (set! *last-value-of-run* (quote done))
   (set! *propagators-ever-alerted* (make-eq-hash-table))
   (set! *propagators-ever-alerted-list*
         (cons (quote *propagators-ever-alerted-list*) (quote ())))
   (quote ok))
 (define (any-propagators-alerted?)
   (positive? (hash-table/count *alerted-propagators*)))
 (define (clear-alerted-propagators!)
   (set! *alerted-propagators* (make-strong-eq-hash-table))
   (set! *alerted-propagator-list*
         (cons (quote *alerted-propagator-list*) (quote ()))))
 (define *reproducible-run-order*
   #t)
 (define (order-preserving-insert thing table lst)
   (hash-table/lookup
    table
    thing
    (lambda (value)
      (quote ok))
    (lambda ()
      (hash-table/put! table thing #t)
      (push! lst thing))))
 (define (push! headed-list thing)
   (set-cdr! headed-list (cons thing (cdr headed-list))))
 (define (ordered-key-list table lst)
   (if *reproducible-run-order*
       (list-copy (cdr lst))
       (hash-table/key-list table)))
 (define (alert-propagators propagators)
   (for-each
    (lambda (propagator)
      (if (not (procedure? propagator))
          (error "Alerting a non-procedure" propagator))
      (order-preserving-insert propagator
                               *propagators-ever-alerted*
                               *propagators-ever-alerted-list*)
      (order-preserving-insert propagator
                               *alerted-propagators*
                               *alerted-propagator-list*))
    (listify propagators))
   #f)
 (define alert-propagator
   alert-propagators)
 (define (alert-all-propagators!)
   (alert-propagators
    (ordered-key-list *propagators-ever-alerted*
                      *propagators-ever-alerted-list*)))
 (define (the-alerted-propagators)
   (ordered-key-list *alerted-propagators* *alerted-propagator-list*))
 (define (with-process-abortion thunk)
   (call-with-current-continuation
    (lambda (k)
      (let ((in-temp k) (out-temp))
        (shallow-fluid-bind
         (lambda ()
           (set! out-temp (set! *abort-process* (set! in-temp)))
           #!unspecific)
         (lambda ()
           (thunk))
         (lambda ()
           (set! in-temp (set! *abort-process* (set! out-temp)))
           #!unspecific))))))
 (define termination-trace
   #f)
 (define (abort-process value)
   (if termination-trace
       (ppc
        (cons
         (quote calling)
         (cons
          (quote abort-process)
          (cons
           (quote with)
           (cons value
                 (cons (quote and) (cons *abort-process* (quote ())))))))))
   (if *abort-process*
       (begin (clear-alerted-propagators!) (*abort-process* value))
       (begin (clear-alerted-propagators!) (set! *last-value-of-run* value))))
 (define (run-alerted)
   (let ((temp (the-alerted-propagators)))
     (clear-alerted-propagators!)
     (for-each
      (lambda (propagator)
        (prof:node-increment
         (#[compiled-closure 786 ("profiler" #x9) #x279 #xa84281 #xe257dc])
         1)
        (propagator))
      temp))
   (if (any-propagators-alerted?)
       (run-alerted)
       (quote done)))
 (define (run)
   (if (any-propagators-alerted?)
       (set! *last-value-of-run* (with-process-abortion run-alerted)))
   *last-value-of-run*))
;Unspecified return value

2 error>   C-c C-c
;Quit!

1 ]=> (load "load")

;Loading "load.scm"... 
;  Generating SCode for file: "profiler.scm" => "profiler.bin"... 
;    Dumping "profiler.bin"... done
;  ... done
;  Compiling file: "profiler.bin" => "profiler.com"... 
;    Loading "profiler.bin"... done
;    Compiling procedure: prof:make-node... done
;    Compiling procedure: prof:node-increment... done
;    Compiling procedure: prof:node-add-child!... done
;    Compiling procedure: prof:node-get-child... done
;    Compiling procedure: prof:subnode... done
;    Compiling procedure: prof:node-child-test... done
;    Compiling procedure: |#[unnamed-procedure]|... done
;    Compiling procedure: incrementation-form... done
;    Compiling procedure: node-access-form... done
;    Compiling procedure: prof:stats... done
;    Compiling procedure: prof:node-clean-copy... done
;    Compiling procedure: prof:interesting-node?... done
;    Compiling procedure: prof:show-stats... done
;    Compiling procedure: prof:reset-stats!... done
;    Compiling procedure: prof:node-reset!... done
;    Compiling procedure: prof:with-reset... 
;Warning: Possible inapplicable operator ()
;    ... done
;    Compiling procedure: prof:clear-stats!... done
;    Compiling procedure: prof:node-clear!... done
;    Dumping "profiler.bci"... done
;    Dumping "profiler.com"... done
;  ... done
;  Loading "profiler.com"... done
;  Loading "new-art/load.scm"... 
;    Loading "../testing/load.com"... done
;    Loading "portability.scm"... 
;      Loading "mitscheme-conditions.scm"... done
;    ... done
;    Loading "ordered-map.scm"... done
;    Loading "matching.scm"... done
;    Loading "assertions.scm"... done
;    Loading "test-runner.scm"... done
;    Loading "test-group.scm"... done
;    Loading "testing.scm"... done
;    Loading "utils.com"... done
;    Loading "ghelper.com"... done
;    Loading "../literate/load.com"... done
;    Loading "regex-literals.scm"... done
;    Loading "read.scm"... done
;    Loading "test-support.scm"... done
;    Generating SCode for file: "scheduler.scm" => "scheduler.bin"... 
;Warning: Unreferenced bound variable: value (|#[unnamed-procedure]| order-preserving-insert)
;      Dumping "scheduler.bin"... done
;    ... done
;    Compiling file: "scheduler.bin" => "scheduler.com"... 
;      Loading "scheduler.bin"... done
;      Compiling procedure: initialize-scheduler... done
;      Compiling procedure: any-propagators-alerted?... done
;      Compiling procedure: clear-alerted-propagators!... done
;      Compiling procedure: order-preserving-insert... done
;      Compiling procedure: push!... done
;      Compiling procedure: ordered-key-list... done
;      Compiling procedure: alert-propagators... done
;      Compiling procedure: alert-all-propagators!... done
;      Compiling procedure: the-alerted-propagators... done
;      Compiling procedure: with-process-abortion... done
;      Compiling procedure: abort-process... done
;      Compiling procedure: run-alerted... done
;      Compiling procedure: run... done
;      Dumping "scheduler.bci"... done
;      Dumping "scheduler.com"... done
;    ... done
;    Loading "scheduler.com"... done
;    Loading "data-structure-definitions.com"... done
;    Generating SCode for file: "art.scm" => "art.bin"... 
;Warning: Unreferenced bound variable: content (|#[unnamed-procedure]|)
;Warning: Unreferenced bound variable: increment (|#[unnamed-procedure]|)
;      Dumping "art.bin"... 
;Object cannot be dumped because it contains an environment: #[comment 815]
;To continue, call RESTART with an option number:
; (RESTART 1) => Return to read-eval-print level 1.

2 error>   C-c C-c
;Quit!

1 ]=> (load "load")

;Loading "load.scm"... 
;  Generating SCode for file: "profiler.scm" => "profiler.bin"... 
;    Dumping "profiler.bin"... done
;  ... done
;  Compiling file: "profiler.bin" => "profiler.com"... 
;    Loading "profiler.bin"... done
;    Compiling procedure: prof:make-node... done
;    Compiling procedure: prof:node-increment... done
;    Compiling procedure: prof:node-add-child!... done
;    Compiling procedure: prof:node-get-child... done
;    Compiling procedure: prof:subnode... done
;    Compiling procedure: prof:node-child-test... done
;    Compiling procedure: |#[unnamed-procedure]|... done
;    Compiling procedure: incrementation-form... done
;    Compiling procedure: node-access-form... done
;    Compiling procedure: prof:stats... done
;    Compiling procedure: prof:node-clean-copy... done
;    Compiling procedure: prof:interesting-node?... done
;    Compiling procedure: prof:show-stats... done
;    Compiling procedure: prof:reset-stats!... done
;    Compiling procedure: prof:node-reset!... done
;    Compiling procedure: prof:with-reset... 
;Warning: Possible inapplicable operator ()
;    ... done
;    Compiling procedure: prof:clear-stats!... done
;    Compiling procedure: prof:node-clear!... done
;    Dumping "profiler.bci"... done
;    Dumping "profiler.com"... done
;  ... done
;  Loading "profiler.com"... done
;  Loading "new-art/load.scm"... 
;    Loading "../testing/load.com"... done
;    Loading "portability.scm"... 
;      Loading "mitscheme-conditions.scm"... done
;    ... done
;    Loading "ordered-map.scm"... done
;    Loading "matching.scm"... done
;    Loading "assertions.scm"... done
;    Loading "test-runner.scm"... done
;    Loading "test-group.scm"... done
;    Loading "testing.scm"... done
;    Loading "utils.com"... done
;    Loading "ghelper.com"... done
;    Loading "../literate/load.com"... done
;    Loading "regex-literals.scm"... done
;    Loading "read.scm"... done
;    Loading "test-support.scm"... done
;    Loading "scheduler.com"... done
;    Loading "data-structure-definitions.com"... done
;    Generating SCode for file: "art.scm" => "art.bin"... 
;Warning: Unreferenced bound variable: content (|#[unnamed-procedure]|)
;Warning: Unreferenced bound variable: increment (|#[unnamed-procedure]|)
;      Dumping "art.bin"... done
;    ... done
;    Compiling file: "art.bin" => "art.com"... 
;      Loading "art.bin"... done
;      Compiling procedure: fahrenheit->celsius... done
;      Compiling procedure: |#[unnamed-procedure]|... done
;      Compiling procedure: nothing?... done
;      Compiling procedure: content... done
;      Compiling procedure: add-content... done
;      Compiling procedure: new-neighbor!... done
;      Compiling procedure: make-cell... done
;      Compiling procedure: propagator... done
;      Compiling procedure: function->propagator-constructor... done
;      Compiling procedure: handling-nothings... done
;      Compiling procedure: constant... done
;      Compiling procedure: sum... done
;      Compiling procedure: product... done
;      Compiling procedure: quadratic... done
;      Compiling procedure: fahrenheit-celsius... done
;      Compiling procedure: |#[unnamed-procedure]|... done
;      Compiling procedure: fall-duration... done
;      Compiling procedure: |#[unnamed-procedure]|... done
;      Compiling procedure: similar-triangles... done
;      Compiling procedure: |#[unnamed-procedure]|... done
;      Compiling procedure: mul-interval... done
;      Compiling procedure: div-interval... done
;      Compiling procedure: square-interval... done
;      Compiling procedure: sqrt-interval... done
;      Compiling procedure: empty-interval?... done
;      Compiling procedure: intersect-intervals... done
;      Compiling procedure: make-cell... done
;      Compiling procedure: make-cell... done
;      Compiling procedure: |#[unnamed-procedure]|... done
;      Compiling procedure: contradictory?... done
;      Compiling procedure: |#[unnamed-procedure]|... done
;      Compiling procedure: |#[unnamed-procedure]|... done
;      Compiling procedure: |#[unnamed-procedure]|... done
;      Compiling procedure: ensure-inside... done
;      Compiling procedure: |#[unnamed-procedure]|... done
;      Compiling procedure: |#[unnamed-procedure]|... done
;      Compiling procedure: |#[unnamed-procedure]|... done
;      Compiling procedure: |#[unnamed-procedure]|... 
;Warning: Coalescing two copies of constant object (shadows)
;Warning: Coalescing two copies of constant object (shadows)
;Warning: Coalescing two copies of constant object #(supported #(interval 44.514 48.978) (shadows))
;      ... done
;      Compiling procedure: v&s-merge... done
;      Compiling procedure: implies?... done
;      Compiling procedure: |#[unnamed-procedure]|... done
;      Compiling procedure: |#[unnamed-procedure]|... done
;      Compiling procedure: |#[unnamed-procedure]|... 
;Warning: Coalescing two copies of constant object (shadows)
;Warning: Coalescing two copies of constant object (shadows)
;Warning: Coalescing two copies of constant object #(supported 45 (superintendent))
;Warning: Coalescing two copies of constant object #(supported #(interval .3 .30328) (superintendent shadows))
;Warning: Coalescing two copies of constant object #(supported #(interval .3 .30328) (superintendent shadows))
;Warning: Coalescing two copies of constant object #(supported #(interval .3 .30328) (superintendent shadows))
;Warning: Coalescing two copies of constant object #(supported 45 (superintendent))
;      ... done
;      Compiling procedure: tms-merge... done
;      Compiling procedure: tms-assimilate... done
;      Compiling procedure: subsumes?... done
;      Compiling procedure: tms-assimilate-one... done
;      Compiling procedure: strongest-consequence... done
;      Compiling procedure: all-premises-in?... done
;      Compiling procedure: check-consistent!... done
;      Compiling procedure: tms-query... done
;      Compiling procedure: kick-out!... done
;      Compiling procedure: bring-in!... done
;      Compiling procedure: process-nogood!... done
;      Compiling procedure: |#[unnamed-procedure]|... done
;      Compiling procedure: binary-amb... done
;      Compiling procedure: process-contradictions... done
;      Compiling procedure: process-one-contradiction... done
;      Compiling procedure: assimilate-nogood!... done
;      Compiling procedure: process-nogood!... done
;      Compiling procedure: require... done
;      Compiling procedure: abhor... done
;      Compiling procedure: require-distinct... done
;      Compiling procedure: one-of... done
;      Compiling procedure: one-of-the-cells... done
;      Compiling procedure: |#[unnamed-procedure]|... done
;      Compiling procedure: conditional... done
;      Dumping "art.bci"... done
;      Dumping "art.com"... done
;    ... done
;    Loading "art.com"... done
;    Loading "naive-primitives.com"... done
;The object #[compound-procedure 963 node], passed as the first argument to car, is not the correct type.
;To continue, call RESTART with an option number:
; (RESTART 1) => Return to read-eval-print level 1.

2 error> (pp #@963)
(named-lambda (node n)
  (let ((e (make-cell))
        (is
         (let lp ((n n))
           (cond ((= n 1) (let ((i (make-cell))) (list i i)))
                 ((= n 2)
                  (let ((i1 (make-cell)) (i2 (make-cell)) (i (make-cell)))
                    (sum-constraint i1 i2 i)
                    (list i i1 i2)))
                 ((even? n)
                  (let ((a1 (lp (/ n 2))) (a2 (lp (/ n 2))) (a (make-cell)))
                    (sum-constraint (car a1) (car a2) a)
                    (cons a (append (cdr a1) (cdr a2)))))
                 ((odd? n)
                  (let ((a1 (lp (- n 1))) (i2 (make-cell)) (a (make-cell)))
                    (sum-constraint (car a1) i2 a)
                    (cons a (cons i2 (cdr a1)))))
                 (else (error))))))
    ((constant 0) (car is))
    (map (lambda (i) (make-terminal i e)) (cdr is))))
;Unspecified return value

2 error>   C-c C-c
;Quit!

1 ]=> (eval #(foozd) (the-environment))

;Value 964: #(foozd)

1 ]=> (eval `,#(foozd) (the-environment))

;Value 965: #(foozd)

1 ]=> (eval `(vector-ref ,#(foozd) 0) (the-environment))

;Value: foozd

1 ]=> (symbol? (eval `(vector-ref ,#(foozd) 0) (the-environment)))

;Value: #t

1 ]=> (symbol? (eval `(vector-ref ,#((foozd bazd)) 0) (the-environment)))

;Value: #f

1 ]=> (pair? (eval `(vector-ref ,#((foozd bazd)) 0) (the-environment)))

;Value: #t

1 ]=> (eval `(vector-ref ,#((foozd bazd)) 0) (the-environment))

;Value 966: (foozd bazd)

1 ]=> 
;Loading "profiler.scm"... done
;Value: prof:node-clear!

1 ]=> (pp (syntax '(prof:count (frobozz)) (the-environment)))
(prof:node-increment (vector-ref (quote #((0))) 0) 1)
;Unspecified return value

1 ]=> (prof:count (frobozz))

;Unspecified return value

1 ]=> *prof:statistics*

;Value 967: (0 (frobozz 1))

1 ]=> (prof:count (frobozz))

;Unspecified return value

1 ]=> *prof:statistics*

;Value 967: (0 (frobozz 2))

1 ]=> (load "profiler")

;Loading "profiler.com"... done
;Value: prof:node-clear!

1 ]=> (prof:count (frobozz))

;Unspecified return value

1 ]=> *prof:statistics*

;Value 968: (0 (frobozz 1))

1 ]=> (prof:count (frobozz))

;Unspecified return value

1 ]=> *prof:statistics*

;Value 968: (0 (frobozz 2))

1 ]=> (define variable 4)

;Value: variable

1 ]=> (prof:count (frobozz ,variable))

;The object (#(#[compound-procedure 963 node]) 0), passed as an argument to assv, is not an association list.
;To continue, call RESTART with an option number:
; (RESTART 1) => Return to read-eval-print level 1.

2 error>   C-c C-c
;Quit!

1 ]=> (pp (syntax '(prof:count (frobozz ,variable)) (the-environment)))
(prof:node-increment
 (prof:subnode (list (quote vector-ref) (vector node) 0) (list variable))
 1)
;Unspecified return value

1 ]=> 
;Value: node-access-form

1 ]=> (pp (syntax '(prof:count (frobozz ,variable)) (the-environment)))
(prof:node-increment
 (prof:subnode (vector-ref (quote #((2))) 0) (list variable))
 1)
;Unspecified return value

1 ]=> '(prof:count (frobozz ,variable))

;Value 969: (prof:count (frobozz (unquote variable)))

1 ]=> (prof:count (frobozz ,variable))

;Unspecified return value

1 ]=> *prof:statistics*

;Value 968: (0 (frobozz 2 (4 1)))

1 ]=> (prof:count (frobozz ,variable))

;Unspecified return value

1 ]=> *prof:statistics*

;Value 968: (0 (frobozz 2 (4 2)))

1 ]=> (set! variable 2)

;Value: 4

1 ]=> (prof:count (frobozz ,variable))

;Unspecified return value

1 ]=> *prof:statistics*

;Value 968: (0 (frobozz 2 (2 1) (4 2)))

1 ]=> (load "load")

;Loading "load.scm"... 
;  Loading "profiler.com"... done
;  Loading "new-art/load.scm"... 
;    Loading "../testing/load.com"... done
;    Loading "portability.scm"... 
;      Loading "mitscheme-conditions.scm"... done
;    ... done
;    Loading "ordered-map.scm"... done
;    Loading "matching.scm"... done
;    Loading "assertions.scm"... done
;    Loading "test-runner.scm"... done
;    Loading "test-group.scm"... done
;    Loading "testing.scm"... done
;    Loading "utils.com"... done
;    Loading "ghelper.com"... done
;    Loading "../literate/load.com"... done
;    Loading "regex-literals.scm"... done
;    Loading "read.scm"... done
;    Loading "test-support.scm"... done
;    Loading "scheduler.com"... done
;    Loading "data-structure-definitions.com"... done
;    Loading "art.com"... done
;    Loading "naive-primitives.com"... done
;The object #[compound-procedure 963 node], passed as the first argument to car, is not the correct type.
;To continue, call RESTART with an option number:
; (RESTART 1) => Return to read-eval-print level 1.

2 error>   C-c C-c
;Quit!

1 ]=> (load "load")

;Loading "load.scm"... 
;  Loading "profiler.com"... done
;  Loading "new-art/load.scm"... 
;    Loading "../testing/load.com"... done
;    Loading "portability.scm"... 
;      Loading "mitscheme-conditions.scm"... done
;    ... done
;    Loading "ordered-map.scm"... done
;    Loading "matching.scm"... done
;    Loading "assertions.scm"... done
;    Loading "test-runner.scm"... done
;    Loading "test-group.scm"... done
;    Loading "testing.scm"... done
;    Loading "utils.com"... done
;    Loading "ghelper.com"... done
;    Loading "../literate/load.com"... done
;    Loading "regex-literals.scm"... done
;    Loading "read.scm"... done
;    Loading "test-support.scm"... done
;    Loading "scheduler.com"... done
;    Loading "data-structure-definitions.com"... done
;    Loading "art.com"... done
;    Loading "naive-primitives.com"... done
;The object #[compound-procedure 963 node], passed as the first argument to car, is not the correct type.
;To continue, call RESTART with an option number:
; (RESTART 1) => Return to read-eval-print level 1.

2 error>   C-c C-c
;Quit!

1 ]=> (load "load")

;Loading "load.scm"... 
;  Loading "profiler.com"... done
;  Loading "new-art/load.scm"... 
;    Loading "../testing/load.com"... done
;    Loading "portability.scm"... 
;      Loading "mitscheme-conditions.scm"... done
;    ... done
;    Loading "ordered-map.scm"... done
;    Loading "matching.scm"... done
;    Loading "assertions.scm"... done
;    Loading "test-runner.scm"... done
;    Loading "test-group.scm"... done
;    Loading "testing.scm"... done
;    Loading "utils.com"... done
;    Loading "ghelper.com"... done
;    Loading "../literate/load.com"... done
;    Loading "regex-literals.scm"... done
;    Loading "read.scm"... done
;    Loading "test-support.scm"... done
;    Generating SCode for file: "scheduler.scm" => "scheduler.bin"... 
;Warning: Unreferenced bound variable: value (|#[unnamed-procedure]| order-preserving-insert)
;      Dumping "scheduler.bin"... done
;    ... done
;    Compiling file: "scheduler.bin" => "scheduler.com"... 
;      Loading "scheduler.bin"... done
;      Compiling procedure: initialize-scheduler... done
;      Compiling procedure: any-propagators-alerted?... done
;      Compiling procedure: clear-alerted-propagators!... done
;      Compiling procedure: order-preserving-insert... done
;      Compiling procedure: push!... done
;      Compiling procedure: ordered-key-list... done
;      Compiling procedure: alert-propagators... done
;      Compiling procedure: alert-all-propagators!... done
;      Compiling procedure: the-alerted-propagators... done
;      Compiling procedure: with-process-abortion... done
;      Compiling procedure: abort-process... done
;      Compiling procedure: run-alerted... done
;      Compiling procedure: run... done
;      Dumping "scheduler.bci"... done
;      Dumping "scheduler.com"... done
;    ... done
;    Loading "scheduler.com"... done
;    Loading "data-structure-definitions.com"... done
;    Generating SCode for file: "art.scm" => "art.bin"... 
;Warning: Unreferenced bound variable: content (|#[unnamed-procedure]|)
;Warning: Unreferenced bound variable: increment (|#[unnamed-procedure]|)
;      Dumping "art.bin"... done
;    ... done
;    Compiling file: "art.bin" => "art.com"... 
;      Loading "art.bin"... done
;      Compiling procedure: fahrenheit->celsius... done
;      Compiling procedure: |#[unnamed-procedure]|... done
;      Compiling procedure: nothing?... done
;      Compiling procedure: content... done
;      Compiling procedure: add-content... done
;      Compiling procedure: new-neighbor!... done
;      Compiling procedure: make-cell... done
;      Compiling procedure: propagator... done
;      Compiling procedure: function->propagator-constructor... done
;      Compiling procedure: handling-nothings... done
;      Compiling procedure: constant... done
;      Compiling procedure: sum... done
;      Compiling procedure: product... done
;      Compiling procedure: quadratic... done
;      Compiling procedure: fahrenheit-celsius... done
;      Compiling procedure: |#[unnamed-procedure]|... done
;      Compiling procedure: fall-duration... done
;      Compiling procedure: |#[unnamed-procedure]|... done
;      Compiling procedure: similar-triangles... done
;      Compiling procedure: |#[unnamed-procedure]|... done
;      Compiling procedure: mul-interval... done
;      Compiling procedure: div-interval... done
;      Compiling procedure: square-interval... done
;      Compiling procedure: sqrt-interval... done
;      Compiling procedure: empty-interval?... done
;      Compiling procedure: intersect-intervals... done
;      Compiling procedure: make-cell... done
;      Compiling procedure: make-cell... done
;      Compiling procedure: |#[unnamed-procedure]|... done
;      Compiling procedure: contradictory?... done
;      Compiling procedure: |#[unnamed-procedure]|... done
;      Compiling procedure: |#[unnamed-procedure]|... done
;      Compiling procedure: |#[unnamed-procedure]|... done
;      Compiling procedure: ensure-inside... done
;      Compiling procedure: |#[unnamed-procedure]|... done
;      Compiling procedure: |#[unnamed-procedure]|... done
;      Compiling procedure: |#[unnamed-procedure]|... done
;      Compiling procedure: |#[unnamed-procedure]|... 
;Warning: Coalescing two copies of constant object (shadows)
;Warning: Coalescing two copies of constant object (shadows)
;Warning: Coalescing two copies of constant object #(supported #(interval 44.514 48.978) (shadows))
;      ... done
;      Compiling procedure: v&s-merge... done
;      Compiling procedure: implies?... done
;      Compiling procedure: |#[unnamed-procedure]|... done
;      Compiling procedure: |#[unnamed-procedure]|... done
;      Compiling procedure: |#[unnamed-procedure]|... 
;Warning: Coalescing two copies of constant object (shadows)
;Warning: Coalescing two copies of constant object (shadows)
;Warning: Coalescing two copies of constant object #(supported 45 (superintendent))
;Warning: Coalescing two copies of constant object #(supported #(interval .3 .30328) (superintendent shadows))
;Warning: Coalescing two copies of constant object #(supported #(interval .3 .30328) (superintendent shadows))
;Warning: Coalescing two copies of constant object #(supported #(interval .3 .30328) (superintendent shadows))
;Warning: Coalescing two copies of constant object #(supported 45 (superintendent))
;      ... done
;      Compiling procedure: tms-merge... done
;      Compiling procedure: tms-assimilate... done
;      Compiling procedure: subsumes?... done
;      Compiling procedure: tms-assimilate-one... done
;      Compiling procedure: strongest-consequence... done
;      Compiling procedure: all-premises-in?... done
;      Compiling procedure: check-consistent!... done
;      Compiling procedure: tms-query... done
;      Compiling procedure: kick-out!... done
;      Compiling procedure: bring-in!... done
;      Compiling procedure: process-nogood!... done
;      Compiling procedure: |#[unnamed-procedure]|... done
;      Compiling procedure: binary-amb... 
;Warning: Coalescing two copies of constant object (0)
;Warning: Coalescing two copies of constant object (0)
;      ... done
;      Compiling procedure: process-contradictions... done
;      Compiling procedure: process-one-contradiction... done
;      Compiling procedure: assimilate-nogood!... done
;      Compiling procedure: process-nogood!... done
;      Compiling procedure: require... done
;      Compiling procedure: abhor... done
;      Compiling procedure: require-distinct... done
;      Compiling procedure: one-of... done
;      Compiling procedure: one-of-the-cells... done
;      Compiling procedure: |#[unnamed-procedure]|... done
;      Compiling procedure: conditional... done
;      Dumping "art.bci"... done
;      Dumping "art.com"... done
;    ... done
;    Loading "art.com"... done
;    Loading "naive-primitives.com"... done
;    Loading "generic-primitives.com"... done
;    Loading "generic-primitives-1-1.com"... done
;    Loading "generic-primitives-2.com"... done
;    Loading "generic-primitives-3.com"... done
;    Loading "masyu.com"... done
;  ... done
;  Loading "conditionals.com"... done
;  Loading "abstraction.com"... done
;  Loading "compound-data.com"... done
;  Loading "test/load.scm"... 
;    Loading "profiler-test.scm"... done
;    Loading "partial-compounds-test.scm"... done
;    Loading "switches-test.scm"... done
;    Loading "compound-merges-test.scm"... done
;  ... done
;... done
;Unspecified return value

1 ]=> (run-registered-tests)
............................................................

60 tests, 0 failures, 0 errors.
;Value: 0

1 ]=> *prof:statistics*

;Value 1110: (0 (hairy-macro-test 0 (data 0) (bar 2) (foo 4)) (nogood 0 (by-computation 0) (assimilate 0) (length 0) (by-resolution 0)) (pairwise-union 0) (tms 0 (assimilate 0)) (invocation 0 (amb-choose 0)))

1 ]=> (prof:show-stats)
(0 (hairy-macro-test 0 (bar 2) (foo 4)))
;Unspecified return value

1 ]=> (do-puzzle '(
"X O  OO   "
"   O    OO"
"X XO  O   "
"   X XO   "
"OOO  X OX "
"      X X "
" X  O    O"
"     XO   "
" OOO OXOO "
"      O   "))
Checking loops in #[board 1111]
+ + + + + + + + + + +
 X---O-\ /-O-O-\ /-\ 
+|+ + +|+|+ + +|+|+|+
 |     O \-\ /-/ O O 
+|+ + +|+ +|+|+ +|+|+
 X---X O   | O   | | 
+ + +|+|+ +|+|+ +|+|+
 /-\ | X---X O   | | 
+|+|+|+ + + +|+ +|+|+
 O O O /---X \-O-X | 
+|+|+|+|+ +|+ + + +|+
 | | \-/   | X---X | 
+|+|+ + + +|+|+ +|+|+
 | X-----O-/ |   | O 
+|+ + + + + +|+ +|+|+
 | /-\ /---X O   \-/ 
+|+|+|+|+ +|+|+ + + +
 | O O O   O X-O-O-\ 
+|+|+|+|+ +|+ + + +|+
 \-/ \-/   \-O-----/ 
+ + + + + + + + + + +
Finished #[board 1111]
+ + + + + + + + + + +
 X---O-\ /-O-O-\ /-\ 
+|+ + +|+|+ + +|+|+|+
 |     O \-\ /-/ O O 
+|+ + +|+ +|+|+ +|+|+
 X---X O   | O   | | 
+ + +|+|+ +|+|+ +|+|+
 /-\ | X---X O   | | 
+|+|+|+ + + +|+ +|+|+
 O O O /---X \-O-X | 
+|+|+|+|+ +|+ + + +|+
 | | \-/   | X---X | 
+|+|+ + + +|+|+ +|+|+
 | X-----O-/ |   | O 
+|+ + + + + +|+ +|+|+
 | /-\ /---X O   \-/ 
+|+|+|+|+ +|+|+ + + +
 | O O O   O X-O-O-\ 
+|+|+|+|+ +|+ + + +|+
 \-/ \-/   \-O-----/ 
+ + + + + + + + + + +
process time: 2160 (2050 RUN + 110 GC); real time: 2790
;Value 1111: #[board 1111]

1 ]=> (prof:show-stats)
(0 (hairy-macro-test 0 (bar 2) (foo 4)))
;Unspecified return value

1 ]=> *number-of-calls-to-fail*

;Value: 520

1 ]=> *prof:statistics*

;Value 1110: (0 (hairy-macro-test 0 (data 0) (bar 2) (foo 4)) (nogood 0 (by-computation 0) (assimilate 0) (length 0) (by-resolution 0)) (pairwise-union 0) (tms 0 (assimilate 0)) (invocation 0 (amb-choose 0)))

1 ]=> 
;Value 1112: #[compound-procedure 1112]

1 ]=> (prof:count (mumble))
  C-c C-c
;Quit!

1 ]=> 
;Value: node-access-form

1 ]=> (prof:count (mumble))
#[environment 1113]
;The object #[compound-procedure 963 node], passed as the first argument to car, is not the correct type.
;To continue, call RESTART with an option number:
; (RESTART 1) => Return to read-eval-print level 1.

2 error> #@1113

;Value 1113: #[environment 1113]

2 error> #@1113

;Value 1113: #[environment 1113]

2 error> (apropos "environment")

#[package 1114 (user)]
#[package 1115 ()]
*make-environment
->environment
access-environment
breakpoint/environment
capture-syntactic-environment
compiled-code-block/environment
compiled-procedure/environment
compiler:optimize-environments?
condition-type:fasdump-environment
debugging-info/undefined-environment?
delete-environment-variable!
environment->package
environment-arguments
environment-assign!
environment-assignable?
environment-assigned?
environment-bindings
environment-bound-names
environment-bound?
environment-definable?
environment-define
environment-define-macro
environment-extension-aux-list
environment-extension-parent
environment-extension-procedure
environment-extension?
environment-has-parent?
environment-lambda
environment-link-name
environment-lookup
environment-lookup-macro
environment-macro-names
environment-parent
environment-procedure-name
environment-reference-type
environment-safe-lookup
environment?
extend-ic-environment
extend-top-level-environment
get-environment-variable
guarantee-environment
guarantee-syntactic-environment
ic-environment?
interpreter-environment?
make-null-interpreter-environment
make-root-top-level-environment
make-the-environment
make-top-level-environment
nearest-repl/environment
package/environment
procedure-environment
process-environment-bind
promise-environment
repl/environment
reverse-syntactic-environments
scheme-subprocess-environment
set-environment-extension-parent!
set-environment-variable!
set-repl/environment!
syntactic-closure/environment
syntactic-environment->environment
syntactic-environment/lookup
syntactic-environment/top-level?
syntactic-environment?
system-global-environment
system-global-environment?
the-environment
the-environment?
top-level-environment?
user-initial-environment
;Unspecified return value

2 error> (syntactic-environment? #@1113)

;Value: #t

2 error> (environment-bindings #@1113)
*** output flushed ***
2 error>   C-c C-c
;Quit!

1 ]=> (load "load")

;Loading "load.scm"... 
;  Loading "profiler.com"... done
;  Loading "new-art/load.scm"... 
;    Loading "../testing/load.com"... done
;    Loading "portability.scm"... 
;      Loading "mitscheme-conditions.scm"... done
;    ... done
;    Loading "ordered-map.scm"... done
;    Loading "matching.scm"... done
;    Loading "assertions.scm"... done
;    Loading "test-runner.scm"... done
;    Loading "test-group.scm"... done
;    Loading "testing.scm"... done
;    Loading "utils.com"... done
;    Loading "ghelper.com"... done
;    Loading "../literate/load.com"... done
;    Loading "regex-literals.scm"... done
;    Loading "read.scm"... done
;    Loading "test-support.scm"... done
;    Generating SCode for file: "scheduler.scm" => "scheduler.bin"... 
;Warning: Unreferenced bound variable: value (|#[unnamed-procedure]| order-preserving-insert)
;      Dumping "scheduler.bin"... done
;    ... done
;    Compiling file: "scheduler.bin" => "scheduler.com"... 
;      Loading "scheduler.bin"... done
;      Compiling procedure: initialize-scheduler... done
;      Compiling procedure: any-propagators-alerted?... done
;      Compiling procedure: clear-alerted-propagators!... done
;      Compiling procedure: order-preserving-insert... done
;      Compiling procedure: push!... done
;      Compiling procedure: ordered-key-list... done
;      Compiling procedure: alert-propagators... done
;      Compiling procedure: alert-all-propagators!... done
;      Compiling procedure: the-alerted-propagators... done
;      Compiling procedure: with-process-abortion... done
;      Compiling procedure: abort-process... done
;      Compiling procedure: run-alerted... done
;      Compiling procedure: run... done
;      Dumping "scheduler.bci"... done
;      Dumping "scheduler.com"... done
;    ... done
;    Loading "scheduler.com"... done
;    Loading "data-structure-definitions.com"... done
;    Generating SCode for file: "art.scm" => "art.bin"... 
;Warning: Unreferenced bound variable: content (|#[unnamed-procedure]|)
;Warning: Unreferenced bound variable: increment (|#[unnamed-procedure]|)
;      Dumping "art.bin"... done
;    ... done
;    Compiling file: "art.bin" => "art.com"... 
;      Loading "art.bin"... done
;      Compiling procedure: fahrenheit->celsius... done
;      Compiling procedure: |#[unnamed-procedure]|... done
;      Compiling procedure: nothing?... done
;      Compiling procedure: content... done
;      Compiling procedure: add-content... done
;      Compiling procedure: new-neighbor!... done
;      Compiling procedure: make-cell... done
;      Compiling procedure: propagator... done
;      Compiling procedure: function->propagator-constructor... done
;      Compiling procedure: handling-nothings... done
;      Compiling procedure: constant... done
;      Compiling procedure: sum... done
;      Compiling procedure: product... done
;      Compiling procedure: quadratic... done
;      Compiling procedure: fahrenheit-celsius... done
;      Compiling procedure: |#[unnamed-procedure]|... done
;      Compiling procedure: fall-duration... done
;      Compiling procedure: |#[unnamed-procedure]|... done
;      Compiling procedure: similar-triangles... done
;      Compiling procedure: |#[unnamed-procedure]|... done
;      Compiling procedure: mul-interval... done
;      Compiling procedure: div-interval... done
;      Compiling procedure: square-interval... done
;      Compiling procedure: sqrt-interval... done
;      Compiling procedure: empty-interval?... done
;      Compiling procedure: intersect-intervals... done
;      Compiling procedure: make-cell... done
;      Compiling procedure: make-cell... done
;      Compiling procedure: |#[unnamed-procedure]|... done
;      Compiling procedure: contradictory?... done
;      Compiling procedure: |#[unnamed-procedure]|... done
;      Compiling procedure: |#[unnamed-procedure]|... done
;      Compiling procedure: |#[unnamed-procedure]|... done
;      Compiling procedure: ensure-inside... done
;      Compiling procedure: |#[unnamed-procedure]|... done
;      Compiling procedure: |#[unnamed-procedure]|... done
;      Compiling procedure: |#[unnamed-procedure]|... done
;      Compiling procedure: |#[unnamed-procedure]|... 
;Warning: Coalescing two copies of constant object (shadows)
;Warning: Coalescing two copies of constant object (shadows)
;Warning: Coalescing two copies of constant object #(supported #(interval 44.514 48.978) (shadows))
;      ... done
;      Compiling procedure: v&s-merge... done
;      Compiling procedure: implies?... done
;      Compiling procedure: |#[unnamed-procedure]|... done
;      Compiling procedure: |#[unnamed-procedure]|... done
;      Compiling procedure: |#[unnamed-procedure]|... 
;Warning: Coalescing two copies of constant object (shadows)
;Warning: Coalescing two copies of constant object (shadows)
;Warning: Coalescing two copies of constant object #(supported 45 (superintendent))
;Warning: Coalescing two copies of constant object #(supported #(interval .3 .30328) (superintendent shadows))
;Warning: Coalescing two copies of constant object #(supported #(interval .3 .30328) (superintendent shadows))
;Warning: Coalescing two copies of constant object #(supported #(interval .3 .30328) (superintendent shadows))
;Warning: Coalescing two copies of constant object #(supported 45 (superintendent))
;      ... done
;      Compiling procedure: tms-merge... done
;      Compiling procedure: tms-assimilate... done
;      Compiling procedure: subsumes?... done
;      Compiling procedure: tms-assimilate-one... done
;      Compiling procedure: strongest-consequence... done
;      Compiling procedure: all-premises-in?... done
;      Compiling procedure: check-consistent!... done
;      Compiling procedure: tms-query... done
;      Compiling procedure: kick-out!... done
;      Compiling procedure: bring-in!... done
;      Compiling procedure: process-nogood!... done
;      Compiling procedure: |#[unnamed-procedure]|... done
;      Compiling procedure: binary-amb... done
;      Compiling procedure: process-contradictions... done
;      Compiling procedure: process-one-contradiction... done
;      Compiling procedure: assimilate-nogood!... done
;      Compiling procedure: process-nogood!... done
;      Compiling procedure: require... done
;      Compiling procedure: abhor... done
;      Compiling procedure: require-distinct... done
;      Compiling procedure: one-of... done
;      Compiling procedure: one-of-the-cells... done
;      Compiling procedure: |#[unnamed-procedure]|... done
;      Compiling procedure: conditional... done
;      Dumping "art.bci"... done
;      Dumping "art.com"... done
;    ... done
;    Loading "art.com"... done
;    Loading "naive-primitives.com"... done
;    Loading "generic-primitives.com"... done
;    Loading "generic-primitives-1-1.com"... done
;    Loading "generic-primitives-2.com"... done
;    Loading "generic-primitives-3.com"... done
;    Loading "masyu.com"... done
;  ... done
;  Loading "conditionals.com"... done
;  Loading "abstraction.com"... done
;  Loading "compound-data.com"... done
;  Loading "test/load.scm"... 
;    Loading "profiler-test.scm"... done
;    Loading "partial-compounds-test.scm"... done
;    Loading "switches-test.scm"... done
;    Loading "compound-merges-test.scm"... done
;  ... done
;... done
;Unspecified return value

1 ]=> *prof:statistics*

;Value 3920: (0 (pairwise-union 0 (8 0 (4 1)) (5 0 (4 1) (1 7) (5 1) (2 1)) (6 0 (2 1) (6 1) (1 7) (3 2)) (4 0 (2 4) (1 8) (4 2) (3 4)) (2 0 (5 1) (3 10) (4 2) (1 65) (2 29)) (3 0 (4 2) (5 1) (2 11) (3 9) (1 37)) (1 0 (8 1) (5 2) (6 1) (4 4) (3 15) (2 43) (1 242))) (nogood 0 (by-resolution 515) (assimilate 2802 (10 0 (into 0 (14 2) (32 1) (40 1) (23 1) (27 1) (24 1) (31 1) (49 1) (15 1) (44 1))) (0 0 (into 0 (14 1) (13 1) (15 1) (3 2) (22 1))) (8 0 (into 0 (16 1) (40 1) (31 1) (28 2) (39 1) (29 2) (38 1) (18 1) (12 1) (11 2) (19 1) (21 1) (30 2) (7 4) (5 2) (9 2) (15 4) (27 2) (14 4) (6 2) (8 3) (13 3) (1 1) (20 1))) (7 0 (into 0 (37 2) (48 1) (46 1) (38 4) (42 1) (41 7) (45 1) (44 1) (34 2) (43 2) (27 4) (53 2) (32 4) (50 2) (29 8) (30 3) (40 3) (39 3) (36 3) (20 9) (26 4) (35 4) (25 5) (24 4) (33 5) (23 8) (22 8) (19 10) (18 11) (17 13) (21 9) (31 8) (28 7) (14 12) (13 10) (15 14) (5 9) (11 9) (6 12) (12 10) (16 12) (1 5) (4 6) (10 13) (9 10) (3 7) (2 7) (7 13) (0 8) (8 12))) (6 0 (into 0 (55 1) (50 1) (52 1) (40 7) (48 2) (39 6) (31 6) (38 3) (35 7) (44 2) (54 5) (33 6) (51 5) (30 19) (49 5) (29 12) (21 10) (47 3) (46 4) (23 6) (42 7) (26 14) (25 10) (41 7) (24 13) (37 7) (22 13) (36 9) (34 10) (15 17) (32 11) (28 7) (19 14) (18 16) (14 13) (27 8) (16 20) (11 14) (20 16) (3 7) (8 23) (12 23) (17 13) (9 24) (10 14) (2 6) (13 14) (1 6) (6 8) (5 14) (4 11) (0 2) (7 16))) (5 0 (into 0 (51 2) (46 1) (45 2) (40 6) (33 13) (41 7) (31 9) (38 5) (43 3) (42 15) (47 3) (44 2) (48 4) (25 11) (35 9) (55 3) (34 9) (50 3) (18 13) (30 12) (49 7) (26 10) (27 13) (39 2) (23 14) (37 10) (20 11) (36 5) (19 13) (32 9) (16 7) (29 8) (28 7) (24 5) (22 13) (13 17) (21 10) (14 21) (17 14) (11 11) (7 15) (15 14) (12 24) (1 7) (9 21) (8 12) (0 7) (10 23) (3 11) (6 18) (5 9) (2 16) (4 18))) (4 0 (into 0 (42 13) (41 7) (39 4) (37 3) (44 8) (43 7) (35 5) (50 5) (24 8) (48 3) (18 6) (47 7) (27 14) (46 2) (36 3) (54 3) (55 2) (23 8) (34 13) (51 3) (32 8) (30 8) (52 1) (31 8) (49 3) (45 3) (40 9) (25 10) (17 17) (38 6) (21 11) (33 12) (12 14) (14 21) (29 11) (28 2) (26 8) (22 13) (20 23) (19 16) (16 7) (8 12) (15 11) (13 18) (10 22) (11 17) (9 16) (7 8) (3 6) (6 9) (5 14) (2 9) (1 10) (0 6) (4 17))) (2 0 (into 0 (1 1) (38 1) (51 1) (36 1) (33 4) (35 3) (30 1) (39 3) (47 2) (9 5) (29 1) (34 4) (17 8) (31 1) (40 3) (18 7) (41 2) (42 5) (44 1) (43 5) (20 4) (37 4) (50 5) (46 1) (48 2) (27 5) (56 1) (54 2) (14 15) (49 5) (32 4) (28 6) (25 7) (24 2) (19 10) (23 7) (11 9) (12 12) (22 5) (21 4) (16 7) (15 11) (8 11) (13 21) (7 14) (10 13) (6 12) (3 4) (5 7) (4 8) (2 5))) (3 0 (into 0 (51 1) (55 1) (38 1) (40 5) (32 1) (30 5) (39 2) (34 11) (33 7) (17 11) (37 5) (41 5) (42 6) (26 5) (50 4) (20 10) (36 3) (47 4) (24 8) (56 1) (16 7) (35 5) (53 1) (52 1) (49 5) (25 8) (48 6) (46 4) (45 6) (22 9) (44 3) (43 10) (31 6) (28 5) (29 8) (27 11) (23 5) (21 7) (12 22) (19 12) (18 6) (9 12) (15 13) (14 21) (13 16) (11 20) (10 19) (8 11) (7 17) (6 22) (5 15) (4 13) (3 9) (2 19) (1 10) (0 12))) (1 0 (into 0 (49 1) (20 2) (17 1) (32 1) (19 2) (22 2) (11 2) (18 3) (28 1) (8 1) (12 3) (7 3) (5 2) (6 5) (23 2) (14 6) (25 2) (10 7) (29 1) (15 7) (33 2) (16 3) (37 1) (46 1) (9 3) (50 2) (55 1) (13 11) (3 3) (2 5) (1 5) (0 5)))) (length 0 (11 1) (1 6) (9 5) (8 41) (7 74) (6 89) (5 102) (3 94) (4 118) (2 48)) (by-computation 63)) (tms 0 (assimilate 79570 (8 0 (into 0 (11 3) (8 4) (5 25) (7 10) (6 12) (4 14) (3 12) (2 3))) (7 0 (into 0 (11 3) (9 29) (8 24) (7 14) (6 16) (5 58) (4 76) (3 27) (1 2) (2 11))) (6 0 (into 0 (11 8) (12 150) (9 36) (8 204) (7 37) (6 46) (5 141) (4 197) (3 32) (2 29) (1 3))) (5 0 (into 0 (10 1) (12 196) (11 32) (9 2) (8 1) (5 51) (7 46) (6 64) (4 83) (3 23) (1 8) (2 152))) (4 0 (into 0 (12 72) (11 6) (10 10) (9 2) (8 1) (7 14) (6 44) (5 1599) (4 152) (3 17) (2 183) (1 545))) (3 0 (into 0 (9 1) (11 4) (10 3) (5 821) (7 9) (6 9) (2 202) (1 619) (4 933) (3 566))) (0 0 (into 0 (11 267) (10 8) (9 76) (8 6) (7 581) (6 965) (5 2051) (4 2366) (3 812) (2 3772) (1 1566))) (2 0 (into 0 (7 22) (6 28) (5 1419) (4 593) (1 1130) (3 1516) (2 653))) (1 0 (into 0 (5 620) (7 7) (4 926) (2 42439) (3 1430) (1 8620))))) (invocation 51705 (amb-choose 6180)))

1 ]=> (prof:show-stats)
(0
 (pairwise-union 0
                 (8 0 (4 1))
                 (5 0 (4 1) (1 7) (5 1) (2 1))
                 (6 0 (2 1) (6 1) (1 7) (3 2))
                 (4 0 (2 4) (1 8) (4 2) (3 4))
                 (2 0 (5 1) (3 10) (4 2) (1 65) (2 29))
                 (3 0 (4 2) (5 1) (2 11) (3 9) (1 37))
                 (1 0 (8 1) (5 2) (6 1) (4 4) (3 15) (2 43) (1 242)))
 (nogood
  0
  (by-resolution 515)
  (assimilate
   2802
   (10
    0
    (into 0
          (14 2)
          (32 1)
          (40 1)
          (23 1)
          (27 1)
          (24 1)
          (31 1)
          (49 1)
          (15 1)
          (44 1)))
   (0 0 (into 0 (14 1) (13 1) (15 1) (3 2) (22 1)))
   (8
    0
    (into 0
          (16 1)
          (40 1)
          (31 1)
          (28 2)
          (39 1)
          (29 2)
          (38 1)
          (18 1)
          (12 1)
          (11 2)
          (19 1)
          (21 1)
          (30 2)
          (7 4)
          (5 2)
          (9 2)
          (15 4)
          (27 2)
          (14 4)
          (6 2)
          (8 3)
          (13 3)
          (1 1)
          (20 1)))
   (7
    0
    (into 0
          (37 2)
          (48 1)
          (46 1)
          (38 4)
          (42 1)
          (41 7)
          (45 1)
          (44 1)
          (34 2)
          (43 2)
          (27 4)
          (53 2)
          (32 4)
          (50 2)
          (29 8)
          (30 3)
          (40 3)
          (39 3)
          (36 3)
          (20 9)
          (26 4)
          (35 4)
          (25 5)
          (24 4)
          (33 5)
          (23 8)
          (22 8)
          (19 10)
          (18 11)
          (17 13)
          (21 9)
          (31 8)
          (28 7)
          (14 12)
          (13 10)
          (15 14)
          (5 9)
          (11 9)
          (6 12)
          (12 10)
          (16 12)
          (1 5)
          (4 6)
          (10 13)
          (9 10)
          (3 7)
          (2 7)
          (7 13)
          (0 8)
          (8 12)))
   (6
    0
    (into 0
          (55 1)
          (50 1)
          (52 1)
          (40 7)
          (48 2)
          (39 6)
          (31 6)
          (38 3)
          (35 7)
          (44 2)
          (54 5)
          (33 6)
          (51 5)
          (30 19)
          (49 5)
          (29 12)
          (21 10)
          (47 3)
          (46 4)
          (23 6)
          (42 7)
          (26 14)
          (25 10)
          (41 7)
          (24 13)
          (37 7)
          (22 13)
          (36 9)
          (34 10)
          (15 17)
          (32 11)
          (28 7)
          (19 14)
          (18 16)
          (14 13)
          (27 8)
          (16 20)
          (11 14)
          (20 16)
          (3 7)
          (8 23)
          (12 23)
          (17 13)
          (9 24)
          (10 14)
          (2 6)
          (13 14)
          (1 6)
          (6 8)
          (5 14)
          (4 11)
          (0 2)
          (7 16)))
   (5
    0
    (into 0
          (51 2)
          (46 1)
          (45 2)
          (40 6)
          (33 13)
          (41 7)
          (31 9)
          (38 5)
          (43 3)
          (42 15)
          (47 3)
          (44 2)
          (48 4)
          (25 11)
          (35 9)
          (55 3)
          (34 9)
          (50 3)
          (18 13)
          (30 12)
          (49 7)
          (26 10)
          (27 13)
          (39 2)
          (23 14)
          (37 10)
          (20 11)
          (36 5)
          (19 13)
          (32 9)
          (16 7)
          (29 8)
          (28 7)
          (24 5)
          (22 13)
          (13 17)
          (21 10)
          (14 21)
          (17 14)
          (11 11)
          (7 15)
          (15 14)
          (12 24)
          (1 7)
          (9 21)
          (8 12)
          (0 7)
          (10 23)
          (3 11)
          (6 18)
          (5 9)
          (2 16)
          (4 18)))
   (4
    0
    (into 0
          (42 13)
          (41 7)
          (39 4)
          (37 3)
          (44 8)
          (43 7)
          (35 5)
          (50 5)
          (24 8)
          (48 3)
          (18 6)
          (47 7)
          (27 14)
          (46 2)
          (36 3)
          (54 3)
          (55 2)
          (23 8)
          (34 13)
          (51 3)
          (32 8)
          (30 8)
          (52 1)
          (31 8)
          (49 3)
          (45 3)
          (40 9)
          (25 10)
          (17 17)
          (38 6)
          (21 11)
          (33 12)
          (12 14)
          (14 21)
          (29 11)
          (28 2)
          (26 8)
          (22 13)
          (20 23)
          (19 16)
          (16 7)
          (8 12)
          (15 11)
          (13 18)
          (10 22)
          (11 17)
          (9 16)
          (7 8)
          (3 6)
          (6 9)
          (5 14)
          (2 9)
          (1 10)
          (0 6)
          (4 17)))
   (2
    0
    (into 0
          (1 1)
          (38 1)
          (51 1)
          (36 1)
          (33 4)
          (35 3)
          (30 1)
          (39 3)
          (47 2)
          (9 5)
          (29 1)
          (34 4)
          (17 8)
          (31 1)
          (40 3)
          (18 7)
          (41 2)
          (42 5)
          (44 1)
          (43 5)
          (20 4)
          (37 4)
          (50 5)
          (46 1)
          (48 2)
          (27 5)
          (56 1)
          (54 2)
          (14 15)
          (49 5)
          (32 4)
          (28 6)
          (25 7)
          (24 2)
          (19 10)
          (23 7)
          (11 9)
          (12 12)
          (22 5)
          (21 4)
          (16 7)
          (15 11)
          (8 11)
          (13 21)
          (7 14)
          (10 13)
          (6 12)
          (3 4)
          (5 7)
          (4 8)
          (2 5)))
   (3
    0
    (into 0
          (51 1)
          (55 1)
          (38 1)
          (40 5)
          (32 1)
          (30 5)
          (39 2)
          (34 11)
          (33 7)
          (17 11)
          (37 5)
          (41 5)
          (42 6)
          (26 5)
          (50 4)
          (20 10)
          (36 3)
          (47 4)
          (24 8)
          (56 1)
          (16 7)
          (35 5)
          (53 1)
          (52 1)
          (49 5)
          (25 8)
          (48 6)
          (46 4)
          (45 6)
          (22 9)
          (44 3)
          (43 10)
          (31 6)
          (28 5)
          (29 8)
          (27 11)
          (23 5)
          (21 7)
          (12 22)
          (19 12)
          (18 6)
          (9 12)
          (15 13)
          (14 21)
          (13 16)
          (11 20)
          (10 19)
          (8 11)
          (7 17)
          (6 22)
          (5 15)
          (4 13)
          (3 9)
          (2 19)
          (1 10)
          (0 12)))
   (1
    0
    (into 0
          (49 1)
          (20 2)
          (17 1)
          (32 1)
          (19 2)
          (22 2)
          (11 2)
          (18 3)
          (28 1)
          (8 1)
          (12 3)
          (7 3)
          (5 2)
          (6 5)
          (23 2)
          (14 6)
          (25 2)
          (10 7)
          (29 1)
          (15 7)
          (33 2)
          (16 3)
          (37 1)
          (46 1)
          (9 3)
          (50 2)
          (55 1)
          (13 11)
          (3 3)
          (2 5)
          (1 5)
          (0 5))))
  (length 0
          (11 1)
          (1 6)
          (9 5)
          (8 41)
          (7 74)
          (6 89)
          (5 102)
          (3 94)
          (4 118)
          (2 48))
  (by-computation 63))
 (tms
  0
  (assimilate
   79570
   (8 0 (into 0 (11 3) (8 4) (5 25) (7 10) (6 12) (4 14) (3 12) (2 3)))
   (7
    0
    (into 0
          (11 3)
          (9 29)
          (8 24)
          (7 14)
          (6 16)
          (5 58)
          (4 76)
          (3 27)
          (1 2)
          (2 11)))
   (6
    0
    (into 0
          (11 8)
          (12 150)
          (9 36)
          (8 204)
          (7 37)
          (6 46)
          (5 141)
          (4 197)
          (3 32)
          (2 29)
          (1 3)))
   (5
    0
    (into 0
          (10 1)
          (12 196)
          (11 32)
          (9 2)
          (8 1)
          (5 51)
          (7 46)
          (6 64)
          (4 83)
          (3 23)
          (1 8)
          (2 152)))
   (4
    0
    (into 0
          (12 72)
          (11 6)
          (10 10)
          (9 2)
          (8 1)
          (7 14)
          (6 44)
          (5 1599)
          (4 152)
          (3 17)
          (2 183)
          (1 545)))
   (3
    0
    (into 0
          (9 1)
          (11 4)
          (10 3)
          (5 821)
          (7 9)
          (6 9)
          (2 202)
          (1 619)
          (4 933)
          (3 566)))
   (0
    0
    (into 0
          (11 267)
          (10 8)
          (9 76)
          (8 6)
          (7 581)
          (6 965)
          (5 2051)
          (4 2366)
          (3 812)
          (2 3772)
          (1 1566)))
   (2 0 (into 0 (7 22) (6 28) (5 1419) (4 593) (1 1130) (3 1516) (2 653)))
   (1 0 (into 0 (5 620) (7 7) (4 926) (2 42439) (3 1430) (1 8620)))))
 (invocation 51705 (amb-choose 6180)))
;Unspecified return value

1 ]=> (load "load")

;Loading "load.scm"... 
;  Generating SCode for file: "profiler.scm" => "profiler.bin"... 
;    Dumping "profiler.bin"... done
;  ... done
;  Compiling file: "profiler.bin" => "profiler.com"... 
;    Loading "profiler.bin"... done
;    Compiling procedure: prof:make-node... done
;    Compiling procedure: prof:node-increment... done
;    Compiling procedure: prof:node-add-child!... done
;    Compiling procedure: prof:node-get-child... done
;    Compiling procedure: prof:subnode... done
;    Compiling procedure: prof:node-child-test... done
;    Compiling procedure: |#[unnamed-procedure]|... done
;    Compiling procedure: incrementation-form... done
;    Compiling procedure: node-access-form... done
;    Compiling procedure: node-access-form... done
;    Compiling procedure: prof:stats... done
;    Compiling procedure: prof:node-clean-copy... done
;    Compiling procedure: prof:interesting-node?... done
;    Compiling procedure: prof:show-stats... done
;    Compiling procedure: prof:reset-stats!... done
;    Compiling procedure: prof:node-reset!... done
;    Compiling procedure: prof:with-reset... 
;Warning: Possible inapplicable operator ()
;    ... done
;    Compiling procedure: prof:clear-stats!... done
;    Compiling procedure: prof:node-clear!... done
;    Dumping "profiler.bci"... done
;    Dumping "profiler.com"... done
;  ... done
;  Loading "profiler.com"... done
;  Loading "new-art/load.scm"... 
;    Loading "../testing/load.com"... done
;    Loading "portability.scm"... 
;      Loading "mitscheme-conditions.scm"... done
;    ... done
;    Loading "ordered-map.scm"... done
;    Loading "matching.scm"... done
;    Loading "assertions.scm"... done
;    Loading "test-runner.scm"... done
;    Loading "test-group.scm"... done
;    Loading "testing.scm"... done
;    Loading "utils.com"... done
;    Loading "ghelper.com"... done
;    Loading "../literate/load.com"... done
;    Loading "regex-literals.scm"... done
;    Loading "read.scm"... done
;    Loading "test-support.scm"... done
;    Loading "scheduler.com"... done
;    Loading "data-structure-definitions.com"... done
;    Generating SCode for file: "art.scm" => "art.bin"... 
;Warning: Unreferenced bound variable: content (|#[unnamed-procedure]|)
;Warning: Unreferenced bound variable: increment (|#[unnamed-procedure]|)
;      Dumping "art.bin"... done
;    ... done
;    Compiling file: "art.bin" => "art.com"... 
;      Loading "art.bin"... done
;      Compiling procedure: fahrenheit->celsius... done
;      Compiling procedure: |#[unnamed-procedure]|... done
;      Compiling procedure: nothing?... done
;      Compiling procedure: content... done
;      Compiling procedure: add-content... done
;      Compiling procedure: new-neighbor!... done
;      Compiling procedure: make-cell... done
;      Compiling procedure: propagator... done
;      Compiling procedure: function->propagator-constructor... done
;      Compiling procedure: handling-nothings... done
;      Compiling procedure: constant... done
;      Compiling procedure: sum... done
;      Compiling procedure: product... done
;      Compiling procedure: quadratic... done
;      Compiling procedure: fahrenheit-celsius... done
;      Compiling procedure: |#[unnamed-procedure]|... done
;      Compiling procedure: fall-duration... done
;      Compiling procedure: |#[unnamed-procedure]|... done
;      Compiling procedure: similar-triangles... done
;      Compiling procedure: |#[unnamed-procedure]|... done
;      Compiling procedure: mul-interval... done
;      Compiling procedure: div-interval... done
;      Compiling procedure: square-interval... done
;      Compiling procedure: sqrt-interval... done
;      Compiling procedure: empty-interval?... done
;      Compiling procedure: intersect-intervals... done
;      Compiling procedure: make-cell... done
;      Compiling procedure: make-cell... done
;      Compiling procedure: |#[unnamed-procedure]|... done
;      Compiling procedure: contradictory?... done
;      Compiling procedure: |#[unnamed-procedure]|... done
;      Compiling procedure: |#[unnamed-procedure]|... done
;      Compiling procedure: |#[unnamed-procedure]|... done
;      Compiling procedure: ensure-inside... done
;      Compiling procedure: |#[unnamed-procedure]|... done
;      Compiling procedure: |#[unnamed-procedure]|... done
;      Compiling procedure: |#[unnamed-procedure]|... done
;      Compiling procedure: |#[unnamed-procedure]|... 
;Warning: Coalescing two copies of constant object (shadows)
;Warning: Coalescing two copies of constant object (shadows)
;Warning: Coalescing two copies of constant object #(supported #(interval 44.514 48.978) (shadows))
;      ... done
;      Compiling procedure: v&s-merge... done
;      Compiling procedure: implies?... done
;      Compiling procedure: |#[unnamed-procedure]|... done
;      Compiling procedure: |#[unnamed-procedure]|... done
;      Compiling procedure: |#[unnamed-procedure]|... 
;Warning: Coalescing two copies of constant object (shadows)
;Warning: Coalescing two copies of constant object (shadows)
;Warning: Coalescing two copies of constant object #(supported 45 (superintendent))
;Warning: Coalescing two copies of constant object #(supported #(interval .3 .30328) (superintendent shadows))
;Warning: Coalescing two copies of constant object #(supported #(interval .3 .30328) (superintendent shadows))
;Warning: Coalescing two copies of constant object #(supported #(interval .3 .30328) (superintendent shadows))
;Warning: Coalescing two copies of constant object #(supported 45 (superintendent))
;      ... done
;      Compiling procedure: tms-merge... done
;      Compiling procedure: tms-assimilate... done
;      Compiling procedure: subsumes?... done
;      Compiling procedure: tms-assimilate-one... done
;      Compiling procedure: strongest-consequence... done
;      Compiling procedure: all-premises-in?... done
;      Compiling procedure: check-consistent!... done
;      Compiling procedure: tms-query... done
;      Compiling procedure: kick-out!... done
;      Compiling procedure: bring-in!... done
;      Compiling procedure: process-nogood!... done
;      Compiling procedure: |#[unnamed-procedure]|... done
;      Compiling procedure: binary-amb... done
;      Compiling procedure: process-contradictions... done
;      Compiling procedure: process-one-contradiction... done
;      Compiling procedure: assimilate-nogood!... done
;      Compiling procedure: process-nogood!... done
;      Compiling procedure: require... done
;      Compiling procedure: abhor... done
;      Compiling procedure: require-distinct... done
;      Compiling procedure: one-of... done
;      Compiling procedure: one-of-the-cells... done
;      Compiling procedure: |#[unnamed-procedure]|... done
;      Compiling procedure: conditional... done
;      Dumping "art.bci"... done
;      Dumping "art.com"... done
;    ... done
;    Loading "art.com"... done
;    Loading "naive-primitives.com"... done
;    Loading "generic-primitives.com"... done
;    Loading "generic-primitives-1-1.com"... done
;    Loading "generic-primitives-2.com"... done
;    Loading "generic-primitives-3.com"... done
;    Loading "masyu.com"... done
;  ... done
;  Loading "conditionals.com"... done
;  Loading "abstraction.com"... done
;  Loading "compound-data.com"... done
;  Loading "test/load.scm"... 
;    Loading "profiler-test.scm"... done
;    Loading "partial-compounds-test.scm"... done
;    Loading "switches-test.scm"... done
;    Loading "compound-merges-test.scm"... done
;  ... done
;... done
;Unspecified return value

1 ]=> (prof:show-stats)
(0
 (pairwise-union 0
                 (8 0 (4 1))
                 (5 0 (4 1) (1 7) (5 1) (2 1))
                 (6 0 (2 1) (6 1) (1 7) (3 2))
                 (4 0 (2 4) (1 8) (4 2) (3 4))
                 (2 0 (5 1) (3 10) (4 2) (1 65) (2 29))
                 (3 0 (4 2) (5 1) (2 11) (3 9) (1 37))
                 (1 0 (8 1) (5 2) (6 1) (4 4) (3 15) (2 43) (1 242)))
 (nogood
  0
  (by-resolution 515)
  (assimilate 2802
              ((2 into 1) 1)
              ((7 into 37) 2)
              ((2 into 38) 1)
              ((6 into 55) 1)
              ((0 into 14) 1)
              ((1 into 49) 1)
              ((2 into 51) 1)
              ((3 into 51) 1)
              ((6 into 50) 1)
              ((3 into 55) 1)
              ((1 into 20) 2)
              ((1 into 17) 1)
              ((2 into 36) 1)
              ((7 into 48) 1)
              ((6 into 52) 1)
              ((1 into 32) 1)
              ((0 into 13) 1)
              ((2 into 33) 4)
              ((1 into 19) 2)
              ((5 into 51) 2)
              ((7 into 46) 1)
              ((10 into 14) 2)
              ((10 into 32) 1)
              ((10 into 40) 1)
              ((10 into 23) 1)
              ((10 into 27) 1)
              ((10 into 24) 1)
              ((10 into 31) 1)
              ((10 into 49) 1)
              ((10 into 15) 1)
              ((10 into 44) 1)
              ((6 into 40) 7)
              ((1 into 22) 2)
              ((2 into 35) 3)
              ((7 into 38) 4)
              ((7 into 42) 1)
              ((6 into 48) 2)
              ((1 into 11) 2)
              ((4 into 42) 13)
              ((1 into 18) 3)
              ((2 into 30) 1)
              ((0 into 15) 1)
              ((1 into 28) 1)
              ((1 into 8) 1)
              ((2 into 39) 3)
              ((2 into 47) 2)
              ((5 into 46) 1)
              ((5 into 45) 2)
              ((1 into 12) 3)
              ((7 into 41) 7)
              ((8 into 16) 1)
              ((8 into 40) 1)
              ((8 into 31) 1)
              ((8 into 28) 2)
              ((8 into 39) 1)
              ((8 into 29) 2)
              ((6 into 39) 6)
              ((3 into 38) 1)
              ((3 into 40) 5)
              ((3 into 32) 1)
              ((5 into 40) 6)
              ((4 into 41) 7)
              ((5 into 33) 13)
              ((5 into 41) 7)
              ((6 into 31) 6)
              ((2 into 9) 5)
              ((3 into 30) 5)
              ((1 into 7) 3)
              ((3 into 39) 2)
              ((1 into 5) 2)
              ((1 into 6) 5)
              ((0 into 3) 2)
              ((0 into 22) 1)
              ((1 into 23) 2)
              ((1 into 14) 6)
              ((1 into 25) 2)
              ((1 into 10) 7)
              ((1 into 29) 1)
              ((1 into 15) 7)
              ((2 into 29) 1)
              ((4 into 39) 4)
              ((6 into 38) 3)
              ((1 into 33) 2)
              ((1 into 16) 3)
              ((2 into 34) 4)
              ((2 into 17) 8)
              ((3 into 34) 11)
              ((3 into 33) 7)
              ((3 into 17) 11)
              ((3 into 37) 5)
              ((2 into 31) 1)
              ((4 into 37) 3)
              ((5 into 31) 9)
              ((5 into 38) 5)
              ((1 into 37) 1)
              ((2 into 40) 3)
              ((2 into 18) 7)
              ((2 into 41) 2)
              ((2 into 42) 5)
              ((3 into 41) 5)
              ((3 into 42) 6)
              ((5 into 43) 3)
              ((2 into 44) 1)
              ((3 into 26) 5)
              ((4 into 44) 8)
              ((6 into 35) 7)
              ((5 into 42) 15)
              ((2 into 43) 5)
              ((2 into 20) 4)
              ((4 into 43) 7)
              ((4 into 35) 5)
              ((1 into 46) 1)
              ((1 into 9) 3)
              ((4 into 50) 5)
              ((4 into 24) 8)
              ((2 into 37) 4)
              ((3 into 50) 4)
              ((3 into 20) 10)
              ((4 into 48) 3)
              ((4 into 18) 6)
              ((4 into 47) 7)
              ((4 into 27) 14)
              ((5 into 47) 3)
              ((3 into 36) 3)
              ((4 into 46) 2)
              ((4 into 36) 3)
              ((7 into 45) 1)
              ((7 into 44) 1)
              ((7 into 34) 2)
              ((5 into 44) 2)
              ((6 into 44) 2)
              ((7 into 43) 2)
              ((7 into 27) 4)
              ((1 into 50) 2)
              ((2 into 50) 5)
              ((5 into 48) 4)
              ((5 into 25) 11)
              ((5 into 35) 9)
              ((3 into 47) 4)
              ((2 into 46) 1)
              ((2 into 48) 2)
              ((2 into 27) 5)
              ((3 into 24) 8)
              ((1 into 55) 1)
              ((1 into 13) 11)
              ((2 into 56) 1)
              ((3 into 56) 1)
              ((3 into 16) 7)
              ((3 into 35) 5)
              ((4 into 54) 3)
              ((4 into 55) 2)
              ((4 into 23) 8)
              ((4 into 34) 13)
              ((5 into 55) 3)
              ((5 into 34) 9)
              ((6 into 54) 5)
              ((6 into 33) 6)
              ((7 into 53) 2)
              ((7 into 32) 4)
              ((2 into 54) 2)
              ((2 into 14) 15)
              ((3 into 53) 1)
              ((3 into 52) 1)
              ((4 into 51) 3)
              ((4 into 32) 8)
              ((4 into 30) 8)
              ((4 into 52) 1)
              ((4 into 31) 8)
              ((6 into 51) 5)
              ((6 into 30) 19)
              ((7 into 50) 2)
              ((7 into 29) 8)
              ((7 into 30) 3)
              ((5 into 50) 3)
              ((5 into 18) 13)
              ((5 into 30) 12)
              ((6 into 49) 5)
              ((6 into 29) 12)
              ((6 into 21) 10)
              ((3 into 49) 5)
              ((2 into 49) 5)
              ((4 into 49) 3)
              ((5 into 49) 7)
              ((5 into 26) 10)
              ((5 into 27) 13)
              ((3 into 25) 8)
              ((3 into 48) 6)
              ((6 into 47) 3)
              ((6 into 46) 4)
              ((6 into 23) 6)
              ((3 into 46) 4)
              ((4 into 45) 3)
              ((3 into 45) 6)
              ((3 into 22) 9)
              ((3 into 44) 3)
              ((3 into 43) 10)
              ((6 into 42) 7)
              ((6 into 26) 14)
              ((6 into 25) 10)
              ((6 into 41) 7)
              ((6 into 24) 13)
              ((7 into 40) 3)
              ((4 into 40) 9)
              ((4 into 25) 10)
              ((4 into 17) 17)
              ((5 into 39) 2)
              ((5 into 23) 14)
              ((7 into 39) 3)
              ((8 into 38) 1)
              ((8 into 18) 1)
              ((8 into 12) 1)
              ((8 into 11) 2)
              ((8 into 19) 1)
              ((8 into 21) 1)
              ((4 into 38) 6)
              ((4 into 21) 11)
              ((5 into 37) 10)
              ((5 into 20) 11)
              ((6 into 37) 7)
              ((6 into 22) 13)
              ((7 into 36) 3)
              ((7 into 20) 9)
              ((7 into 26) 4)
              ((5 into 36) 5)
              ((5 into 19) 13)
              ((6 into 36) 9)
              ((7 into 35) 4)
              ((7 into 25) 5)
              ((7 into 24) 4)
              ((6 into 34) 10)
              ((6 into 15) 17)
              ((7 into 33) 5)
              ((7 into 23) 8)
              ((7 into 22) 8)
              ((7 into 19) 10)
              ((7 into 18) 11)
              ((4 into 33) 12)
              ((4 into 12) 14)
              ((4 into 14) 21)
              ((5 into 32) 9)
              ((5 into 16) 7)
              ((6 into 32) 11)
              ((7 into 17) 13)
              ((7 into 21) 9)
              ((2 into 32) 4)
              ((3 into 31) 6)
              ((7 into 31) 8)
              ((8 into 30) 2)
              ((8 into 7) 4)
              ((8 into 5) 2)
              ((8 into 9) 2)
              ((8 into 15) 4)
              ((3 into 28) 5)
              ((2 into 28) 6)
              ((7 into 28) 7)
              ((7 into 14) 12)
              ((8 into 27) 2)
              ((8 into 14) 4)
              ((8 into 6) 2)
              ((8 into 8) 3)
              ((8 into 13) 3)
              ((8 into 1) 1)
              ((8 into 20) 1)
              ((3 into 29) 8)
              ((4 into 29) 11)
              ((5 into 29) 8)
              ((6 into 28) 7)
              ((6 into 19) 14)
              ((6 into 18) 16)
              ((6 into 14) 13)
              ((4 into 28) 2)
              ((5 into 28) 7)
              ((6 into 27) 8)
              ((6 into 16) 20)
              ((6 into 11) 14)
              ((7 into 13) 10)
              ((3 into 27) 11)
              ((7 into 15) 14)
              ((7 into 5) 9)
              ((7 into 11) 9)
              ((7 into 6) 12)
              ((7 into 12) 10)
              ((4 into 26) 8)
              ((2 into 25) 7)
              ((5 into 24) 5)
              ((2 into 24) 2)
              ((5 into 22) 13)
              ((5 into 13) 17)
              ((5 into 21) 10)
              ((5 into 14) 21)
              ((6 into 20) 16)
              ((6 into 3) 7)
              ((6 into 8) 23)
              ((6 into 12) 23)
              ((2 into 19) 10)
              ((2 into 23) 7)
              ((2 into 11) 9)
              ((2 into 12) 12)
              ((3 into 23) 5)
              ((4 into 22) 13)
              ((2 into 22) 5)
              ((2 into 21) 4)
              ((3 into 21) 7)
              ((3 into 12) 22)
              ((4 into 20) 23)
              ((3 into 19) 12)
              ((4 into 19) 16)
              ((3 into 18) 6)
              ((3 into 9) 12)
              ((5 into 17) 14)
              ((6 into 17) 13)
              ((6 into 9) 24)
              ((6 into 10) 14)
              ((6 into 2) 6)
              ((7 into 16) 12)
              ((7 into 1) 5)
              ((7 into 4) 6)
              ((7 into 10) 13)
              ((7 into 9) 10)
              ((7 into 3) 7)
              ((7 into 2) 7)
              ((7 into 7) 13)
              ((7 into 0) 8)
              ((7 into 8) 12)
              ((2 into 16) 7)
              ((4 into 16) 7)
              ((4 into 8) 12)
              ((5 into 11) 11)
              ((5 into 7) 15)
              ((3 into 15) 13)
              ((4 into 15) 11)
              ((5 into 15) 14)
              ((2 into 15) 11)
              ((2 into 8) 11)
              ((3 into 14) 21)
              ((6 into 13) 14)
              ((6 into 1) 6)
              ((6 into 6) 8)
              ((6 into 5) 14)
              ((6 into 4) 11)
              ((6 into 0) 2)
              ((6 into 7) 16)
              ((2 into 13) 21)
              ((2 into 7) 14)
              ((2 into 10) 13)
              ((4 into 13) 18)
              ((4 into 10) 22)
              ((3 into 13) 16)
              ((5 into 12) 24)
              ((5 into 1) 7)
              ((5 into 9) 21)
              ((5 into 8) 12)
              ((5 into 0) 7)
              ((3 into 11) 20)
              ((4 into 11) 17)
              ((5 into 10) 23)
              ((5 into 3) 11)
              ((5 into 6) 18)
              ((3 into 10) 19)
              ((4 into 9) 16)
              ((5 into 5) 9)
              ((5 into 2) 16)
              ((5 into 4) 18)
              ((3 into 8) 11)
              ((4 into 7) 8)
              ((4 into 3) 6)
              ((3 into 7) 17)
              ((3 into 6) 22)
              ((4 into 6) 9)
              ((4 into 5) 14)
              ((4 into 2) 9)
              ((4 into 1) 10)
              ((4 into 0) 6)
              ((4 into 4) 17)
              ((2 into 6) 12)
              ((2 into 3) 4)
              ((3 into 5) 15)
              ((2 into 5) 7)
              ((2 into 4) 8)
              ((2 into 2) 5)
              ((3 into 4) 13)
              ((3 into 3) 9)
              ((3 into 2) 19)
              ((3 into 1) 10)
              ((3 into 0) 12)
              ((1 into 3) 3)
              ((1 into 2) 5)
              ((1 into 1) 5)
              ((1 into 0) 5))
  (length 0
          (11 1)
          (1 6)
          (9 5)
          (8 41)
          (7 74)
          (6 89)
          (5 102)
          (3 94)
          (4 118)
          (2 48))
  (by-computation 63))
 (tms
  0
  (assimilate 79570
              ((6 into 11) 8)
              ((7 into 11) 3)
              ((8 into 11) 3)
              ((0 into 11) 267)
              ((5 into 10) 1)
              ((6 into 12) 150)
              ((0 into 10) 8)
              ((3 into 9) 1)
              ((4 into 12) 72)
              ((5 into 12) 196)
              ((5 into 11) 32)
              ((4 into 11) 6)
              ((3 into 11) 4)
              ((3 into 10) 3)
              ((4 into 10) 10)
              ((4 into 9) 2)
              ((0 into 9) 76)
              ((5 into 9) 2)
              ((5 into 8) 1)
              ((0 into 8) 6)
              ((4 into 8) 1)
              ((4 into 7) 14)
              ((4 into 6) 44)
              ((1 into 5) 620)
              ((6 into 9) 36)
              ((7 into 9) 29)
              ((7 into 8) 24)
              ((6 into 8) 204)
              ((8 into 8) 4)
              ((6 into 7) 37)
              ((5 into 5) 51)
              ((5 into 7) 46)
              ((5 into 6) 64)
              ((6 into 6) 46)
              ((7 into 7) 14)
              ((5 into 4) 83)
              ((8 into 5) 25)
              ((0 into 7) 581)
              ((8 into 7) 10)
              ((8 into 6) 12)
              ((6 into 5) 141)
              ((0 into 6) 965)
              ((7 into 6) 16)
              ((0 into 5) 2051)
              ((7 into 5) 58)
              ((8 into 4) 14)
              ((6 into 4) 197)
              ((0 into 4) 2366)
              ((7 into 4) 76)
              ((8 into 3) 12)
              ((8 into 2) 3)
              ((4 into 5) 1599)
              ((5 into 3) 23)
              ((7 into 3) 27)
              ((7 into 1) 2)
              ((6 into 3) 32)
              ((7 into 2) 11)
              ((4 into 4) 152)
              ((4 into 3) 17)
              ((6 into 2) 29)
              ((6 into 1) 3)
              ((5 into 1) 8)
              ((5 into 2) 152)
              ((4 into 2) 183)
              ((4 into 1) 545)
              ((1 into 7) 7)
              ((3 into 5) 821)
              ((3 into 7) 9)
              ((3 into 6) 9)
              ((2 into 7) 22)
              ((2 into 6) 28)
              ((3 into 2) 202)
              ((3 into 1) 619)
              ((3 into 4) 933)
              ((3 into 3) 566)
              ((0 into 3) 812)
              ((2 into 5) 1419)
              ((2 into 4) 593)
              ((1 into 4) 926)
              ((0 into 2) 3772)
              ((1 into 2) 42439)
              ((1 into 3) 1430)
              ((0 into 1) 1566)
              ((2 into 1) 1130)
              ((2 into 3) 1516)
              ((2 into 2) 653)
              ((1 into 1) 8620)))
 (invocation 51705 (amb-choose 6180)))
;Unspecified return value

1 ]=> (load "load")

;Loading "load.scm"... 
;  Loading "profiler.com"... done
;  Loading "new-art/load.scm"... 
;    Loading "../testing/load.com"... done
;    Loading "portability.scm"... 
;      Loading "mitscheme-conditions.scm"... done
;    ... done
;    Loading "ordered-map.scm"... done
;    Loading "matching.scm"... done
;    Loading "assertions.scm"... done
;    Loading "test-runner.scm"... done
;    Loading "test-group.scm"... done
;    Loading "testing.scm"... done
;    Loading "utils.com"... done
;    Loading "ghelper.com"... done
;    Loading "../literate/load.com"... done
;    Loading "regex-literals.scm"... done
;    Loading "read.scm"... done
;    Loading "test-support.scm"... done
;    Loading "scheduler.com"... done
;    Loading "data-structure-definitions.com"... done
;    Generating SCode for file: "art.scm" => "art.bin"... 
;Warning: Unreferenced bound variable: content (|#[unnamed-procedure]|)
;Warning: Unreferenced bound variable: increment (|#[unnamed-procedure]|)
;      Dumping "art.bin"... done
;    ... done
;    Compiling file: "art.bin" => "art.com"... 
;      Loading "art.bin"... done
;      Compiling procedure: fahrenheit->celsius... done
;      Compiling procedure: |#[unnamed-procedure]|... done
;      Compiling procedure: nothing?... done
;      Compiling procedure: content... done
;      Compiling procedure: add-content... done
;      Compiling procedure: new-neighbor!... done
;      Compiling procedure: make-cell... done
;      Compiling procedure: propagator... done
;      Compiling procedure: function->propagator-constructor... done
;      Compiling procedure: handling-nothings... done
;      Compiling procedure: constant... done
;      Compiling procedure: sum... done
;      Compiling procedure: product... done
;      Compiling procedure: quadratic... done
;      Compiling procedure: fahrenheit-celsius... done
;      Compiling procedure: |#[unnamed-procedure]|... done
;      Compiling procedure: fall-duration... done
;      Compiling procedure: |#[unnamed-procedure]|... done
;      Compiling procedure: similar-triangles... done
;      Compiling procedure: |#[unnamed-procedure]|... done
;      Compiling procedure: mul-interval... done
;      Compiling procedure: div-interval... done
;      Compiling procedure: square-interval... done
;      Compiling procedure: sqrt-interval... done
;      Compiling procedure: empty-interval?... done
;      Compiling procedure: intersect-intervals... done
;      Compiling procedure: make-cell... done
;      Compiling procedure: make-cell... done
;      Compiling procedure: |#[unnamed-procedure]|... done
;      Compiling procedure: contradictory?... done
;      Compiling procedure: |#[unnamed-procedure]|... done
;      Compiling procedure: |#[unnamed-procedure]|... done
;      Compiling procedure: |#[unnamed-procedure]|... done
;      Compiling procedure: ensure-inside... done
;      Compiling procedure: |#[unnamed-procedure]|... done
;      Compiling procedure: |#[unnamed-procedure]|... done
;      Compiling procedure: |#[unnamed-procedure]|... done
;      Compiling procedure: |#[unnamed-procedure]|... 
;Warning: Coalescing two copies of constant object (shadows)
;Warning: Coalescing two copies of constant object (shadows)
;Warning: Coalescing two copies of constant object #(supported #(interval 44.514 48.978) (shadows))
;      ... done
;      Compiling procedure: v&s-merge... done
;      Compiling procedure: implies?... done
;      Compiling procedure: |#[unnamed-procedure]|... done
;      Compiling procedure: |#[unnamed-procedure]|... done
;      Compiling procedure: |#[unnamed-procedure]|... 
;Warning: Coalescing two copies of constant object (shadows)
;Warning: Coalescing two copies of constant object (shadows)
;Warning: Coalescing two copies of constant object #(supported 45 (superintendent))
;Warning: Coalescing two copies of constant object #(supported #(interval .3 .30328) (superintendent shadows))
;Warning: Coalescing two copies of constant object #(supported #(interval .3 .30328) (superintendent shadows))
;Warning: Coalescing two copies of constant object #(supported #(interval .3 .30328) (superintendent shadows))
;Warning: Coalescing two copies of constant object #(supported 45 (superintendent))
;      ... done
;      Compiling procedure: tms-merge... done
;      Compiling procedure: tms-assimilate... done
;      Compiling procedure: subsumes?... done
;      Compiling procedure: tms-assimilate-one... done
;      Compiling procedure: strongest-consequence... done
;      Compiling procedure: all-premises-in?... done
;      Compiling procedure: check-consistent!... done
;      Compiling procedure: tms-query... done
;      Compiling procedure: kick-out!... done
;      Compiling procedure: bring-in!... done
;      Compiling procedure: process-nogood!... done
;      Compiling procedure: |#[unnamed-procedure]|... done
;      Compiling procedure: binary-amb... done
;      Compiling procedure: process-contradictions... done
;      Compiling procedure: process-one-contradiction... done
;      Compiling procedure: assimilate-nogood!... done
;      Compiling procedure: process-nogood!... done
;      Compiling procedure: require... done
;      Compiling procedure: abhor... done
;      Compiling procedure: require-distinct... done
;      Compiling procedure: one-of... done
;      Compiling procedure: one-of-the-cells... done
;      Compiling procedure: |#[unnamed-procedure]|... done
;      Compiling procedure: conditional... done
;      Dumping "art.bci"... done
;      Dumping "art.com"... done
;    ... done
;    Loading "art.com"... done
;    Loading "naive-primitives.com"... done
;    Loading "generic-primitives.com"... done
;    Loading "generic-primitives-1-1.com"... done
;    Loading "generic-primitives-2.com"... done
;    Loading "generic-primitives-3.com"... done
;    Loading "masyu.com"... done
;  ... done
;  Loading "conditionals.com"... done
;  Loading "abstraction.com"... done
;  Loading "compound-data.com"... done
;  Loading "test/load.scm"... 
;    Loading "profiler-test.scm"... done
;    Loading "partial-compounds-test.scm"... done
;    Loading "switches-test.scm"... done
;    Loading "compound-merges-test.scm"... done
;  ... done
;... done
;Unspecified return value

1 ]=> (prof:show-stats)
(0
 (pairwise-union 0
                 ((1 with 8) 1)
                 ((1 with 5) 2)
                 ((1 with 6) 1)
                 ((2 with 5) 1)
                 ((1 with 4) 4)
                 ((3 with 4) 2)
                 ((5 with 4) 1)
                 ((8 with 4) 1)
                 ((3 with 5) 1)
                 ((5 with 1) 7)
                 ((6 with 2) 1)
                 ((4 with 2) 4)
                 ((6 with 6) 1)
                 ((5 with 5) 1)
                 ((6 with 1) 7)
                 ((3 with 2) 11)
                 ((5 with 2) 1)
                 ((4 with 1) 8)
                 ((6 with 3) 2)
                 ((4 with 4) 2)
                 ((4 with 3) 4)
                 ((1 with 3) 15)
                 ((3 with 3) 9)
                 ((2 with 3) 10)
                 ((2 with 4) 2)
                 ((2 with 1) 65)
                 ((2 with 2) 29)
                 ((3 with 1) 37)
                 ((1 with 2) 43)
                 ((1 with 1) 242))
 (nogood
  0
  (by-resolution 515)
  (assimilate 2802
              ((2 into 1) 1)
              ((7 into 37) 2)
              ((2 into 38) 1)
              ((6 into 55) 1)
              ((0 into 14) 1)
              ((1 into 49) 1)
              ((2 into 51) 1)
              ((3 into 51) 1)
              ((6 into 50) 1)
              ((3 into 55) 1)
              ((1 into 20) 2)
              ((1 into 17) 1)
              ((2 into 36) 1)
              ((7 into 48) 1)
              ((6 into 52) 1)
              ((1 into 32) 1)
              ((0 into 13) 1)
              ((2 into 33) 4)
              ((1 into 19) 2)
              ((5 into 51) 2)
              ((7 into 46) 1)
              ((10 into 14) 2)
              ((10 into 32) 1)
              ((10 into 40) 1)
              ((10 into 23) 1)
              ((10 into 27) 1)
              ((10 into 24) 1)
              ((10 into 31) 1)
              ((10 into 49) 1)
              ((10 into 15) 1)
              ((10 into 44) 1)
              ((6 into 40) 7)
              ((1 into 22) 2)
              ((2 into 35) 3)
              ((7 into 38) 4)
              ((7 into 42) 1)
              ((6 into 48) 2)
              ((1 into 11) 2)
              ((4 into 42) 13)
              ((1 into 18) 3)
              ((2 into 30) 1)
              ((0 into 15) 1)
              ((1 into 28) 1)
              ((1 into 8) 1)
              ((2 into 39) 3)
              ((2 into 47) 2)
              ((5 into 46) 1)
              ((5 into 45) 2)
              ((1 into 12) 3)
              ((7 into 41) 7)
              ((8 into 16) 1)
              ((8 into 40) 1)
              ((8 into 31) 1)
              ((8 into 28) 2)
              ((8 into 39) 1)
              ((8 into 29) 2)
              ((6 into 39) 6)
              ((3 into 38) 1)
              ((3 into 40) 5)
              ((3 into 32) 1)
              ((5 into 40) 6)
              ((4 into 41) 7)
              ((5 into 33) 13)
              ((5 into 41) 7)
              ((6 into 31) 6)
              ((2 into 9) 5)
              ((3 into 30) 5)
              ((1 into 7) 3)
              ((3 into 39) 2)
              ((1 into 5) 2)
              ((1 into 6) 5)
              ((0 into 3) 2)
              ((0 into 22) 1)
              ((1 into 23) 2)
              ((1 into 14) 6)
              ((1 into 25) 2)
              ((1 into 10) 7)
              ((1 into 29) 1)
              ((1 into 15) 7)
              ((2 into 29) 1)
              ((4 into 39) 4)
              ((6 into 38) 3)
              ((1 into 33) 2)
              ((1 into 16) 3)
              ((2 into 34) 4)
              ((2 into 17) 8)
              ((3 into 34) 11)
              ((3 into 33) 7)
              ((3 into 17) 11)
              ((3 into 37) 5)
              ((2 into 31) 1)
              ((4 into 37) 3)
              ((5 into 31) 9)
              ((5 into 38) 5)
              ((1 into 37) 1)
              ((2 into 40) 3)
              ((2 into 18) 7)
              ((2 into 41) 2)
              ((2 into 42) 5)
              ((3 into 41) 5)
              ((3 into 42) 6)
              ((5 into 43) 3)
              ((2 into 44) 1)
              ((3 into 26) 5)
              ((4 into 44) 8)
              ((6 into 35) 7)
              ((5 into 42) 15)
              ((2 into 43) 5)
              ((2 into 20) 4)
              ((4 into 43) 7)
              ((4 into 35) 5)
              ((1 into 46) 1)
              ((1 into 9) 3)
              ((4 into 50) 5)
              ((4 into 24) 8)
              ((2 into 37) 4)
              ((3 into 50) 4)
              ((3 into 20) 10)
              ((4 into 48) 3)
              ((4 into 18) 6)
              ((4 into 47) 7)
              ((4 into 27) 14)
              ((5 into 47) 3)
              ((3 into 36) 3)
              ((4 into 46) 2)
              ((4 into 36) 3)
              ((7 into 45) 1)
              ((7 into 44) 1)
              ((7 into 34) 2)
              ((5 into 44) 2)
              ((6 into 44) 2)
              ((7 into 43) 2)
              ((7 into 27) 4)
              ((1 into 50) 2)
              ((2 into 50) 5)
              ((5 into 48) 4)
              ((5 into 25) 11)
              ((5 into 35) 9)
              ((3 into 47) 4)
              ((2 into 46) 1)
              ((2 into 48) 2)
              ((2 into 27) 5)
              ((3 into 24) 8)
              ((1 into 55) 1)
              ((1 into 13) 11)
              ((2 into 56) 1)
              ((3 into 56) 1)
              ((3 into 16) 7)
              ((3 into 35) 5)
              ((4 into 54) 3)
              ((4 into 55) 2)
              ((4 into 23) 8)
              ((4 into 34) 13)
              ((5 into 55) 3)
              ((5 into 34) 9)
              ((6 into 54) 5)
              ((6 into 33) 6)
              ((7 into 53) 2)
              ((7 into 32) 4)
              ((2 into 54) 2)
              ((2 into 14) 15)
              ((3 into 53) 1)
              ((3 into 52) 1)
              ((4 into 51) 3)
              ((4 into 32) 8)
              ((4 into 30) 8)
              ((4 into 52) 1)
              ((4 into 31) 8)
              ((6 into 51) 5)
              ((6 into 30) 19)
              ((7 into 50) 2)
              ((7 into 29) 8)
              ((7 into 30) 3)
              ((5 into 50) 3)
              ((5 into 18) 13)
              ((5 into 30) 12)
              ((6 into 49) 5)
              ((6 into 29) 12)
              ((6 into 21) 10)
              ((3 into 49) 5)
              ((2 into 49) 5)
              ((4 into 49) 3)
              ((5 into 49) 7)
              ((5 into 26) 10)
              ((5 into 27) 13)
              ((3 into 25) 8)
              ((3 into 48) 6)
              ((6 into 47) 3)
              ((6 into 46) 4)
              ((6 into 23) 6)
              ((3 into 46) 4)
              ((4 into 45) 3)
              ((3 into 45) 6)
              ((3 into 22) 9)
              ((3 into 44) 3)
              ((3 into 43) 10)
              ((6 into 42) 7)
              ((6 into 26) 14)
              ((6 into 25) 10)
              ((6 into 41) 7)
              ((6 into 24) 13)
              ((7 into 40) 3)
              ((4 into 40) 9)
              ((4 into 25) 10)
              ((4 into 17) 17)
              ((5 into 39) 2)
              ((5 into 23) 14)
              ((7 into 39) 3)
              ((8 into 38) 1)
              ((8 into 18) 1)
              ((8 into 12) 1)
              ((8 into 11) 2)
              ((8 into 19) 1)
              ((8 into 21) 1)
              ((4 into 38) 6)
              ((4 into 21) 11)
              ((5 into 37) 10)
              ((5 into 20) 11)
              ((6 into 37) 7)
              ((6 into 22) 13)
              ((7 into 36) 3)
              ((7 into 20) 9)
              ((7 into 26) 4)
              ((5 into 36) 5)
              ((5 into 19) 13)
              ((6 into 36) 9)
              ((7 into 35) 4)
              ((7 into 25) 5)
              ((7 into 24) 4)
              ((6 into 34) 10)
              ((6 into 15) 17)
              ((7 into 33) 5)
              ((7 into 23) 8)
              ((7 into 22) 8)
              ((7 into 19) 10)
              ((7 into 18) 11)
              ((4 into 33) 12)
              ((4 into 12) 14)
              ((4 into 14) 21)
              ((5 into 32) 9)
              ((5 into 16) 7)
              ((6 into 32) 11)
              ((7 into 17) 13)
              ((7 into 21) 9)
              ((2 into 32) 4)
              ((3 into 31) 6)
              ((7 into 31) 8)
              ((8 into 30) 2)
              ((8 into 7) 4)
              ((8 into 5) 2)
              ((8 into 9) 2)
              ((8 into 15) 4)
              ((3 into 28) 5)
              ((2 into 28) 6)
              ((7 into 28) 7)
              ((7 into 14) 12)
              ((8 into 27) 2)
              ((8 into 14) 4)
              ((8 into 6) 2)
              ((8 into 8) 3)
              ((8 into 13) 3)
              ((8 into 1) 1)
              ((8 into 20) 1)
              ((3 into 29) 8)
              ((4 into 29) 11)
              ((5 into 29) 8)
              ((6 into 28) 7)
              ((6 into 19) 14)
              ((6 into 18) 16)
              ((6 into 14) 13)
              ((4 into 28) 2)
              ((5 into 28) 7)
              ((6 into 27) 8)
              ((6 into 16) 20)
              ((6 into 11) 14)
              ((7 into 13) 10)
              ((3 into 27) 11)
              ((7 into 15) 14)
              ((7 into 5) 9)
              ((7 into 11) 9)
              ((7 into 6) 12)
              ((7 into 12) 10)
              ((4 into 26) 8)
              ((2 into 25) 7)
              ((5 into 24) 5)
              ((2 into 24) 2)
              ((5 into 22) 13)
              ((5 into 13) 17)
              ((5 into 21) 10)
              ((5 into 14) 21)
              ((6 into 20) 16)
              ((6 into 3) 7)
              ((6 into 8) 23)
              ((6 into 12) 23)
              ((2 into 19) 10)
              ((2 into 23) 7)
              ((2 into 11) 9)
              ((2 into 12) 12)
              ((3 into 23) 5)
              ((4 into 22) 13)
              ((2 into 22) 5)
              ((2 into 21) 4)
              ((3 into 21) 7)
              ((3 into 12) 22)
              ((4 into 20) 23)
              ((3 into 19) 12)
              ((4 into 19) 16)
              ((3 into 18) 6)
              ((3 into 9) 12)
              ((5 into 17) 14)
              ((6 into 17) 13)
              ((6 into 9) 24)
              ((6 into 10) 14)
              ((6 into 2) 6)
              ((7 into 16) 12)
              ((7 into 1) 5)
              ((7 into 4) 6)
              ((7 into 10) 13)
              ((7 into 9) 10)
              ((7 into 3) 7)
              ((7 into 2) 7)
              ((7 into 7) 13)
              ((7 into 0) 8)
              ((7 into 8) 12)
              ((2 into 16) 7)
              ((4 into 16) 7)
              ((4 into 8) 12)
              ((5 into 11) 11)
              ((5 into 7) 15)
              ((3 into 15) 13)
              ((4 into 15) 11)
              ((5 into 15) 14)
              ((2 into 15) 11)
              ((2 into 8) 11)
              ((3 into 14) 21)
              ((6 into 13) 14)
              ((6 into 1) 6)
              ((6 into 6) 8)
              ((6 into 5) 14)
              ((6 into 4) 11)
              ((6 into 0) 2)
              ((6 into 7) 16)
              ((2 into 13) 21)
              ((2 into 7) 14)
              ((2 into 10) 13)
              ((4 into 13) 18)
              ((4 into 10) 22)
              ((3 into 13) 16)
              ((5 into 12) 24)
              ((5 into 1) 7)
              ((5 into 9) 21)
              ((5 into 8) 12)
              ((5 into 0) 7)
              ((3 into 11) 20)
              ((4 into 11) 17)
              ((5 into 10) 23)
              ((5 into 3) 11)
              ((5 into 6) 18)
              ((3 into 10) 19)
              ((4 into 9) 16)
              ((5 into 5) 9)
              ((5 into 2) 16)
              ((5 into 4) 18)
              ((3 into 8) 11)
              ((4 into 7) 8)
              ((4 into 3) 6)
              ((3 into 7) 17)
              ((3 into 6) 22)
              ((4 into 6) 9)
              ((4 into 5) 14)
              ((4 into 2) 9)
              ((4 into 1) 10)
              ((4 into 0) 6)
              ((4 into 4) 17)
              ((2 into 6) 12)
              ((2 into 3) 4)
              ((3 into 5) 15)
              ((2 into 5) 7)
              ((2 into 4) 8)
              ((2 into 2) 5)
              ((3 into 4) 13)
              ((3 into 3) 9)
              ((3 into 2) 19)
              ((3 into 1) 10)
              ((3 into 0) 12)
              ((1 into 3) 3)
              ((1 into 2) 5)
              ((1 into 1) 5)
              ((1 into 0) 5))
  (length 0
          (11 1)
          (1 6)
          (9 5)
          (8 41)
          (7 74)
          (6 89)
          (5 102)
          (3 94)
          (4 118)
          (2 48))
  (by-computation 63))
 (tms
  0
  (assimilate 79570
              ((6 into 11) 8)
              ((7 into 11) 3)
              ((8 into 11) 3)
              ((0 into 11) 267)
              ((5 into 10) 1)
              ((6 into 12) 150)
              ((0 into 10) 8)
              ((3 into 9) 1)
              ((4 into 12) 72)
              ((5 into 12) 196)
              ((5 into 11) 32)
              ((4 into 11) 6)
              ((3 into 11) 4)
              ((3 into 10) 3)
              ((4 into 10) 10)
              ((4 into 9) 2)
              ((0 into 9) 76)
              ((5 into 9) 2)
              ((5 into 8) 1)
              ((0 into 8) 6)
              ((4 into 8) 1)
              ((4 into 7) 14)
              ((4 into 6) 44)
              ((1 into 5) 620)
              ((6 into 9) 36)
              ((7 into 9) 29)
              ((7 into 8) 24)
              ((6 into 8) 204)
              ((8 into 8) 4)
              ((6 into 7) 37)
              ((5 into 5) 51)
              ((5 into 7) 46)
              ((5 into 6) 64)
              ((6 into 6) 46)
              ((7 into 7) 14)
              ((5 into 4) 83)
              ((8 into 5) 25)
              ((0 into 7) 581)
              ((8 into 7) 10)
              ((8 into 6) 12)
              ((6 into 5) 141)
              ((0 into 6) 965)
              ((7 into 6) 16)
              ((0 into 5) 2051)
              ((7 into 5) 58)
              ((8 into 4) 14)
              ((6 into 4) 197)
              ((0 into 4) 2366)
              ((7 into 4) 76)
              ((8 into 3) 12)
              ((8 into 2) 3)
              ((4 into 5) 1599)
              ((5 into 3) 23)
              ((7 into 3) 27)
              ((7 into 1) 2)
              ((6 into 3) 32)
              ((7 into 2) 11)
              ((4 into 4) 152)
              ((4 into 3) 17)
              ((6 into 2) 29)
              ((6 into 1) 3)
              ((5 into 1) 8)
              ((5 into 2) 152)
              ((4 into 2) 183)
              ((4 into 1) 545)
              ((1 into 7) 7)
              ((3 into 5) 821)
              ((3 into 7) 9)
              ((3 into 6) 9)
              ((2 into 7) 22)
              ((2 into 6) 28)
              ((3 into 2) 202)
              ((3 into 1) 619)
              ((3 into 4) 933)
              ((3 into 3) 566)
              ((0 into 3) 812)
              ((2 into 5) 1419)
              ((2 into 4) 593)
              ((1 into 4) 926)
              ((0 into 2) 3772)
              ((1 into 2) 42439)
              ((1 into 3) 1430)
              ((0 into 1) 1566)
              ((2 into 1) 1130)
              ((2 into 3) 1516)
              ((2 into 2) 653)
              ((1 into 1) 8620)))
 (invocation 51705 (amb-choose 6180)))
;Unspecified return value

1 ]=> (prof:reset-stats!)

;Unspecified return value

1 ]=> (prof:show-stats)
(0)
;Unspecified return value

1 ]=> *prof:statistics*

;Value 4206: (0 (pairwise-union 0 ((1 with 8) 0) ((1 with 5) 0) ((1 with 6) 0) ((2 with 5) 0) ((1 with 4) 0) ((3 with 4) 0) ((5 with 4) 0) ((8 with 4) 0) ((3 with 5) 0) ((5 with 1) 0) ((6 with 2) 0) ((4 with 2) 0) ((6 with 6) 0) ((5 with 5) 0) ((6 with 1) 0) ((3 with 2) 0) ((5 with 2) 0) ((4 with 1) 0) ((6 with 3) 0) ((4 with 4) 0) ((4 with 3) 0) ((1 with 3) 0) ((3 with 3) 0) ((2 with 3) 0) ((2 with 4) 0) ((2 with 1) 0) ((2 with 2) 0) ((3 with 1) 0) ((1 with 2) 0) ((1 with 1) 0)) (nogood 0 (by-resolution 0) (assimilate 0 ((2 into 1) 0) ((7 into 37) 0) ((2 into 38) 0) ((6 into 55) 0) ((0 into 14) 0) ((1 into 49) 0) ((2 into 51) 0) ((3 into 51) 0) ((6 into 50) 0) ((3 into 55) 0) ((1 into 20) 0) ((1 into 17) 0) ((2 into 36) 0) ((7 into 48) 0) ((6 into 52) 0) ((1 into 32) 0) ((0 into 13) 0) ((2 into 33) 0) ((1 into 19) 0) ((5 into 51) 0) ((7 into 46) 0) ((10 into 14) 0) ((10 into 32) 0) ((10 into 40) 0) ((10 into 23) 0) ((10 into 27) 0) ((10 into 24) 0) ((10 into 31) 0) ((10 into 49) 0) ((10 into 15) 0) ((10 into 44) 0) ((6 into 40) 0) ((1 into 22) 0) ((2 into 35) 0) ((7 into 38) 0) ((7 into 42) 0) ((6 into 48) 0) ((1 into 11) 0) ((4 into 42) 0) ((1 into 18) 0) ((2 into 30) 0) ((0 into 15) 0) ((1 into 28) 0) ((1 into 8) 0) ((2 into 39) 0) ((2 into 47) 0) ((5 into 46) 0) ((5 into 45) 0) ((1 into 12) 0) ((7 into 41) 0) ((8 into 16) 0) ((8 into 40) 0) ((8 into 31) 0) ((8 into 28) 0) ((8 into 39) 0) ((8 into 29) 0) ((6 into 39) 0) ((3 into 38) 0) ((3 into 40) 0) ((3 into 32) 0) ((5 into 40) 0) ((4 into 41) 0) ((5 into 33) 0) ((5 into 41) 0) ((6 into 31) 0) ((2 into 9) 0) ((3 into 30) 0) ((1 into 7) 0) ((3 into 39) 0) ((1 into 5) 0) ((1 into 6) 0) ((0 into 3) 0) ((0 into 22) 0) ((1 into 23) 0) ((1 into 14) 0) ((1 into 25) 0) ((1 into 10) 0) ((1 into 29) 0) ((1 into 15) 0) ((2 into 29) 0) ((4 into 39) 0) ((6 into 38) 0) ((1 into 33) 0) ((1 into 16) 0) ((2 into 34) 0) ((2 into 17) 0) ((3 into 34) 0) ((3 into 33) 0) ((3 into 17) 0) ((3 into 37) 0) ((2 into 31) 0) ((4 into 37) 0) ((5 into 31) 0) ((5 into 38) 0) ((1 into 37) 0) ((2 into 40) 0) ((2 into 18) 0) ((2 into 41) 0) ((2 into 42) 0) ((3 into 41) 0) ((3 into 42) 0) ((5 into 43) 0) ((2 into 44) 0) ((3 into 26) 0) ((4 into 44) 0) ((6 into 35) 0) ((5 into 42) 0) ((2 into 43) 0) ((2 into 20) 0) ((4 into 43) 0) ((4 into 35) 0) ((1 into 46) 0) ((1 into 9) 0) ((4 into 50) 0) ((4 into 24) 0) ((2 into 37) 0) ((3 into 50) 0) ((3 into 20) 0) ((4 into 48) 0) ((4 into 18) 0) ((4 into 47) 0) ((4 into 27) 0) ((5 into 47) 0) ((3 into 36) 0) ((4 into 46) 0) ((4 into 36) 0) ((7 into 45) 0) ((7 into 44) 0) ((7 into 34) 0) ((5 into 44) 0) ((6 into 44) 0) ((7 into 43) 0) ((7 into 27) 0) ((1 into 50) 0) ((2 into 50) 0) ((5 into 48) 0) ((5 into 25) 0) ((5 into 35) 0) ((3 into 47) 0) ((2 into 46) 0) ((2 into 48) 0) ((2 into 27) 0) ((3 into 24) 0) ((1 into 55) 0) ((1 into 13) 0) ((2 into 56) 0) ((3 into 56) 0) ((3 into 16) 0) ((3 into 35) 0) ((4 into 54) 0) ((4 into 55) 0) ((4 into 23) 0) ((4 into 34) 0) ((5 into 55) 0) ((5 into 34) 0) ((6 into 54) 0) ((6 into 33) 0) ((7 into 53) 0) ((7 into 32) 0) ((2 into 54) 0) ((2 into 14) 0) ((3 into 53) 0) ((3 into 52) 0) ((4 into 51) 0) ((4 into 32) 0) ((4 into 30) 0) ((4 into 52) 0) ((4 into 31) 0) ((6 into 51) 0) ((6 into 30) 0) ((7 into 50) 0) ((7 into 29) 0) ((7 into 30) 0) ((5 into 50) 0) ((5 into 18) 0) ((5 into 30) 0) ((6 into 49) 0) ((6 into 29) 0) ((6 into 21) 0) ((3 into 49) 0) ((2 into 49) 0) ((4 into 49) 0) ((5 into 49) 0) ((5 into 26) 0) ((5 into 27) 0) ((3 into 25) 0) ((3 into 48) 0) ((6 into 47) 0) ((6 into 46) 0) ((6 into 23) 0) ((3 into 46) 0) ((4 into 45) 0) ((3 into 45) 0) ((3 into 22) 0) ((3 into 44) 0) ((3 into 43) 0) ((6 into 42) 0) ((6 into 26) 0) ((6 into 25) 0) ((6 into 41) 0) ((6 into 24) 0) ((7 into 40) 0) ((4 into 40) 0) ((4 into 25) 0) ((4 into 17) 0) ((5 into 39) 0) ((5 into 23) 0) ((7 into 39) 0) ((8 into 38) 0) ((8 into 18) 0) ((8 into 12) 0) ((8 into 11) 0) ((8 into 19) 0) ((8 into 21) 0) ((4 into 38) 0) ((4 into 21) 0) ((5 into 37) 0) ((5 into 20) 0) ((6 into 37) 0) ((6 into 22) 0) ((7 into 36) 0) ((7 into 20) 0) ((7 into 26) 0) ((5 into 36) 0) ((5 into 19) 0) ((6 into 36) 0) ((7 into 35) 0) ((7 into 25) 0) ((7 into 24) 0) ((6 into 34) 0) ((6 into 15) 0) ((7 into 33) 0) ((7 into 23) 0) ((7 into 22) 0) ((7 into 19) 0) ((7 into 18) 0) ((4 into 33) 0) ((4 into 12) 0) ((4 into 14) 0) ((5 into 32) 0) ((5 into 16) 0) ((6 into 32) 0) ((7 into 17) 0) ((7 into 21) 0) ((2 into 32) 0) ((3 into 31) 0) ((7 into 31) 0) ((8 into 30) 0) ((8 into 7) 0) ((8 into 5) 0) ((8 into 9) 0) ((8 into 15) 0) ((3 into 28) 0) ((2 into 28) 0) ((7 into 28) 0) ((7 into 14) 0) ((8 into 27) 0) ((8 into 14) 0) ((8 into 6) 0) ((8 into 8) 0) ((8 into 13) 0) ((8 into 1) 0) ((8 into 20) 0) ((3 into 29) 0) ((4 into 29) 0) ((5 into 29) 0) ((6 into 28) 0) ((6 into 19) 0) ((6 into 18) 0) ((6 into 14) 0) ((4 into 28) 0) ((5 into 28) 0) ((6 into 27) 0) ((6 into 16) 0) ((6 into 11) 0) ((7 into 13) 0) ((3 into 27) 0) ((7 into 15) 0) ((7 into 5) 0) ((7 into 11) 0) ((7 into 6) 0) ((7 into 12) 0) ((4 into 26) 0) ((2 into 25) 0) ((5 into 24) 0) ((2 into 24) 0) ((5 into 22) 0) ((5 into 13) 0) ((5 into 21) 0) ((5 into 14) 0) ((6 into 20) 0) ((6 into 3) 0) ((6 into 8) 0) ((6 into 12) 0) ((2 into 19) 0) ((2 into 23) 0) ((2 into 11) 0) ((2 into 12) 0) ((3 into 23) 0) ((4 into 22) 0) ((2 into 22) 0) ((2 into 21) 0) ((3 into 21) 0) ((3 into 12) 0) ((4 into 20) 0) ((3 into 19) 0) ((4 into 19) 0) ((3 into 18) 0) ((3 into 9) 0) ((5 into 17) 0) ((6 into 17) 0) ((6 into 9) 0) ((6 into 10) 0) ((6 into 2) 0) ((7 into 16) 0) ((7 into 1) 0) ((7 into 4) 0) ((7 into 10) 0) ((7 into 9) 0) ((7 into 3) 0) ((7 into 2) 0) ((7 into 7) 0) ((7 into 0) 0) ((7 into 8) 0) ((2 into 16) 0) ((4 into 16) 0) ((4 into 8) 0) ((5 into 11) 0) ((5 into 7) 0) ((3 into 15) 0) ((4 into 15) 0) ((5 into 15) 0) ((2 into 15) 0) ((2 into 8) 0) ((3 into 14) 0) ((6 into 13) 0) ((6 into 1) 0) ((6 into 6) 0) ((6 into 5) 0) ((6 into 4) 0) ((6 into 0) 0) ((6 into 7) 0) ((2 into 13) 0) ((2 into 7) 0) ((2 into 10) 0) ((4 into 13) 0) ((4 into 10) 0) ((3 into 13) 0) ((5 into 12) 0) ((5 into 1) 0) ((5 into 9) 0) ((5 into 8) 0) ((5 into 0) 0) ((3 into 11) 0) ((4 into 11) 0) ((5 into 10) 0) ((5 into 3) 0) ((5 into 6) 0) ((3 into 10) 0) ((4 into 9) 0) ((5 into 5) 0) ((5 into 2) 0) ((5 into 4) 0) ((3 into 8) 0) ((4 into 7) 0) ((4 into 3) 0) ((3 into 7) 0) ((3 into 6) 0) ((4 into 6) 0) ((4 into 5) 0) ((4 into 2) 0) ((4 into 1) 0) ((4 into 0) 0) ((4 into 4) 0) ((2 into 6) 0) ((2 into 3) 0) ((3 into 5) 0) ((2 into 5) 0) ((2 into 4) 0) ((2 into 2) 0) ((3 into 4) 0) ((3 into 3) 0) ((3 into 2) 0) ((3 into 1) 0) ((3 into 0) 0) ((1 into 3) 0) ((1 into 2) 0) ((1 into 1) 0) ((1 into 0) 0)) (length 0 (11 0) (1 0) (9 0) (8 0) (7 0) (6 0) (5 0) (3 0) (4 0) (2 0)) (by-computation 0)) (tms 0 (assimilate 0 ((6 into 11) 0) ((7 into 11) 0) ((8 into 11) 0) ((0 into 11) 0) ((5 into 10) 0) ((6 into 12) 0) ((0 into 10) 0) ((3 into 9) 0) ((4 into 12) 0) ((5 into 12) 0) ((5 into 11) 0) ((4 into 11) 0) ((3 into 11) 0) ((3 into 10) 0) ((4 into 10) 0) ((4 into 9) 0) ((0 into 9) 0) ((5 into 9) 0) ((5 into 8) 0) ((0 into 8) 0) ((4 into 8) 0) ((4 into 7) 0) ((4 into 6) 0) ((1 into 5) 0) ((6 into 9) 0) ((7 into 9) 0) ((7 into 8) 0) ((6 into 8) 0) ((8 into 8) 0) ((6 into 7) 0) ((5 into 5) 0) ((5 into 7) 0) ((5 into 6) 0) ((6 into 6) 0) ((7 into 7) 0) ((5 into 4) 0) ((8 into 5) 0) ((0 into 7) 0) ((8 into 7) 0) ((8 into 6) 0) ((6 into 5) 0) ((0 into 6) 0) ((7 into 6) 0) ((0 into 5) 0) ((7 into 5) 0) ((8 into 4) 0) ((6 into 4) 0) ((0 into 4) 0) ((7 into 4) 0) ((8 into 3) 0) ((8 into 2) 0) ((4 into 5) 0) ((5 into 3) 0) ((7 into 3) 0) ((7 into 1) 0) ((6 into 3) 0) ((7 into 2) 0) ((4 into 4) 0) ((4 into 3) 0) ((6 into 2) 0) ((6 into 1) 0) ((5 into 1) 0) ((5 into 2) 0) ((4 into 2) 0) ((4 into 1) 0) ((1 into 7) 0) ((3 into 5) 0) ((3 into 7) 0) ((3 into 6) 0) ((2 into 7) 0) ((2 into 6) 0) ((3 into 2) 0) ((3 into 1) 0) ((3 into 4) 0) ((3 into 3) 0) ((0 into 3) 0) ((2 into 5) 0) ((2 into 4) 0) ((1 into 4) 0) ((0 into 2) 0) ((1 into 2) 0) ((1 into 3) 0) ((0 into 1) 0) ((2 into 1) 0) ((2 into 3) 0) ((2 into 2) 0) ((1 into 1) 0))) (invocation 0 (amb-choose 0)))

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
;Value 4207: #[test-group 4207]

1 ]=> (prof:reset-stats!)

;Unspecified return value

1 ]=> 
;Loading "examples/sudoku.scm"... done
;Unspecified return value

1 ]=> (show-time
 (lambda ()
   (prof:with-reset
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
	 (0 3 1 0 0 0 5 0 0)))))))
327194658
846325179
519687243
172563894
653948721
498712365
764851932
985236417
231479586
(0
 (pairwise-union 0
                 ((41 with 3) 1)
                 ((54 with 3) 1)
                 ((47 with 1) 1)
                 ((58 with 3) 1)
                 ((7 with 28) 1)
                 ((19 with 3) 1)
                 ((20 with 6) 1)
                 ((10 with 33) 1)
                 ((12 with 20) 1)
                 ((12 with 26) 1)
                 ((8 with 16) 1)
                 ((13 with 17) 1)
                 ((10 with 20) 1)
                 ((7 with 11) 1)
                 ((2 with 14) 1)
                 ((13 with 8) 1)
                 ((19 with 12) 1)
                 ((14 with 4) 1)
                 ((2 with 20) 1)
                 ((2 with 26) 2)
                 ((1 with 24) 1)
                 ((2 with 22) 2)
                 ((6 with 23) 1)
                 ((16 with 11) 1)
                 ((10 with 12) 2)
                 ((3 with 17) 2)
                 ((14 with 6) 1)
                 ((2 with 17) 1)
                 ((14 with 7) 1)
                 ((2 with 23) 3)
                 ((15 with 3) 3)
                 ((7 with 17) 1)
                 ((1 with 25) 3)
                 ((19 with 9) 1)
                 ((35 with 2) 1)
                 ((27 with 3) 1)
                 ((16 with 6) 1)
                 ((25 with 4) 1)
                 ((21 with 3) 1)
                 ((21 with 4) 1)
                 ((28 with 1) 1)
                 ((25 with 1) 2)
                 ((26 with 2) 3)
                 ((17 with 2) 1)
                 ((33 with 4) 1)
                 ((17 with 11) 1)
                 ((36 with 4) 1)
                 ((28 with 5) 1)
                 ((24 with 6) 1)
                 ((27 with 2) 1)
                 ((17 with 6) 1)
                 ((18 with 5) 1)
                 ((26 with 1) 1)
                 ((19 with 6) 1)
                 ((38 with 4) 1)
                 ((16 with 5) 1)
                 ((2 with 21) 1)
                 ((14 with 12) 2)
                 ((4 with 12) 2)
                 ((9 with 9) 1)
                 ((8 with 10) 2)
                 ((24 with 3) 1)
                 ((2 with 15) 1)
                 ((8 with 6) 2)
                 ((11 with 8) 2)
                 ((5 with 21) 1)
                 ((15 with 17) 1)
                 ((15 with 14) 1)
                 ((17 with 3) 3)
                 ((18 with 1) 5)
                 ((10 with 7) 3)
                 ((7 with 9) 4)
                 ((12 with 10) 1)
                 ((9 with 7) 2)
                 ((19 with 1) 5)
                 ((6 with 13) 1)
                 ((13 with 7) 3)
                 ((5 with 13) 3)
                 ((4 with 17) 3)
                 ((11 with 7) 1)
                 ((11 with 5) 6)
                 ((3 with 13) 2)
                 ((4 with 16) 1)
                 ((1 with 22) 4)
                 ((8 with 11) 2)
                 ((7 with 10) 2)
                 ((23 with 1) 3)
                 ((18 with 6) 1)
                 ((16 with 3) 1)
                 ((2 with 12) 4)
                 ((25 with 2) 2)
                 ((15 with 8) 2)
                 ((13 with 4) 2)
                 ((27 with 10) 1)
                 ((13 with 13) 1)
                 ((12 with 6) 3)
                 ((7 with 14) 1)
                 ((17 with 7) 1)
                 ((19 with 2) 3)
                 ((17 with 15) 1)
                 ((20 with 1) 6)
                 ((26 with 3) 2)
                 ((19 with 4) 2)
                 ((14 with 3) 2)
                 ((20 with 3) 1)
                 ((48 with 20) 1)
                 ((37 with 1) 1)
                 ((34 with 15) 1)
                 ((37 with 6) 1)
                 ((45 with 15) 1)
                 ((24 with 10) 1)
                 ((38 with 12) 1)
                 ((30 with 21) 2)
                 ((13 with 3) 4)
                 ((9 with 6) 4)
                 ((12 with 8) 3)
                 ((9 with 11) 2)
                 ((12 with 11) 1)
                 ((18 with 7) 2)
                 ((12 with 7) 5)
                 ((13 with 10) 1)
                 ((9 with 5) 4)
                 ((22 with 3) 1)
                 ((22 with 2) 2)
                 ((23 with 3) 1)
                 ((4 with 14) 2)
                 ((3 with 11) 7)
                 ((14 with 5) 1)
                 ((20 with 5) 1)
                 ((1 with 14) 5)
                 ((10 with 6) 2)
                 ((2 with 18) 1)
                 ((2 with 19) 3)
                 ((24 with 5) 1)
                 ((1 with 18) 4)
                 ((8 with 7) 1)
                 ((4 with 15) 2)
                 ((5 with 24) 1)
                 ((5 with 9) 7)
                 ((18 with 4) 3)
                 ((34 with 3) 1)
                 ((6 with 9) 2)
                 ((11 with 6) 3)
                 ((17 with 4) 4)
                 ((3 with 8) 8)
                 ((3 with 14) 3)
                 ((15 with 7) 1)
                 ((15 with 5) 3)
                 ((10 with 5) 5)
                 ((26 with 4) 2)
                 ((2 with 16) 1)
                 ((12 with 5) 2)
                 ((16 with 2) 2)
                 ((40 with 1) 1)
                 ((27 with 1) 1)
                 ((45 with 1) 1)
                 ((25 with 3) 1)
                 ((31 with 3) 1)
                 ((35 with 3) 1)
                 ((3 with 10) 5)
                 ((30 with 2) 3)
                 ((17 with 1) 9)
                 ((3 with 16) 1)
                 ((1 with 23) 4)
                 ((3 with 15) 4)
                 ((1 with 20) 3)
                 ((7 with 18) 1)
                 ((8 with 13) 1)
                 ((1 with 17) 11)
                 ((1 with 19) 5)
                 ((1 with 16) 7)
                 ((7 with 12) 4)
                 ((10 with 4) 7)
                 ((15 with 4) 2)
                 ((9 with 12) 2)
                 ((5 with 15) 1)
                 ((3 with 19) 1)
                 ((12 with 3) 2)
                 ((2 with 13) 3)
                 ((8 with 8) 3)
                 ((7 with 7) 5)
                 ((13 with 5) 2)
                 ((6 with 8) 8)
                 ((12 with 4) 5)
                 ((9 with 3) 8)
                 ((4 with 13) 1)
                 ((4 with 11) 3)
                 ((2 with 9) 12)
                 ((10 with 3) 9)
                 ((15 with 1) 16)
                 ((13 with 2) 11)
                 ((6 with 10) 5)
                 ((7 with 5) 7)
                 ((8 with 9) 1)
                 ((15 with 2) 5)
                 ((8 with 5) 10)
                 ((18 with 2) 1)
                 ((1 with 10) 21)
                 ((21 with 1) 3)
                 ((9 with 4) 8)
                 ((22 with 1) 5)
                 ((5 with 8) 8)
                 ((14 with 1) 18)
                 ((1 with 12) 7)
                 ((7 with 4) 17)
                 ((1 with 15) 10)
                 ((2 with 11) 5)
                 ((1 with 13) 10)
                 ((6 with 4) 19)
                 ((16 with 1) 14)
                 ((8 with 3) 16)
                 ((4 with 9) 4)
                 ((7 with 8) 3)
                 ((2 with 8) 16)
                 ((3 with 7) 16)
                 ((3 with 12) 7)
                 ((3 with 6) 17)
                 ((14 with 2) 7)
                 ((5 with 12) 4)
                 ((3 with 9) 6)
                 ((11 with 3) 12)
                 ((12 with 2) 15)
                 ((4 with 8) 16)
                 ((7 with 6) 5)
                 ((8 with 2) 38)
                 ((11 with 4) 3)
                 ((6 with 5) 19)
                 ((4 with 7) 13)
                 ((4 with 10) 5)
                 ((2 with 7) 18)
                 ((5 with 7) 9)
                 ((5 with 10) 5)
                 ((5 with 6) 14)
                 ((6 with 7) 9)
                 ((10 with 2) 14)
                 ((7 with 2) 33)
                 ((2 with 6) 21)
                 ((11 with 2) 20)
                 ((1 with 11) 20)
                 ((2 with 10) 11)
                 ((4 with 5) 30)
                 ((4 with 6) 20)
                 ((1 with 9) 23)
                 ((7 with 3) 27)
                 ((5 with 3) 50)
                 ((9 with 2) 36)
                 ((1 with 7) 50)
                 ((12 with 1) 37)
                 ((9 with 1) 67)
                 ((10 with 1) 52)
                 ((8 with 1) 86)
                 ((13 with 1) 36)
                 ((11 with 1) 40)
                 ((7 with 1) 119)
                 ((1 with 8) 38)
                 ((1 with 5) 96)
                 ((1 with 6) 60)
                 ((2 with 5) 32)
                 ((1 with 4) 137)
                 ((3 with 4) 52)
                 ((5 with 4) 29)
                 ((8 with 4) 10)
                 ((3 with 5) 34)
                 ((5 with 1) 254)
                 ((6 with 2) 68)
                 ((4 with 2) 136)
                 ((6 with 6) 10)
                 ((5 with 5) 22)
                 ((6 with 1) 173)
                 ((3 with 2) 178)
                 ((5 with 2) 82)
                 ((4 with 1) 318)
                 ((6 with 3) 26)
                 ((4 with 4) 34)
                 ((4 with 3) 70)
                 ((1 with 3) 260)
                 ((3 with 3) 96)
                 ((2 with 3) 124)
                 ((2 with 4) 54)
                 ((2 with 1) 589)
                 ((2 with 2) 232)
                 ((3 with 1) 437)
                 ((1 with 2) 451)
                 ((1 with 1) 1942))
 (nogood
  0
  (by-resolution 7745)
  (assimilate 55483
              ((4 into 183) 1)
              ((4 into 182) 1)
              ((4 into 184) 1)
              ((5 into 286) 1)
              ((7 into 284) 1)
              ((6 into 283) 1)
              ((10 into 220) 1)
              ((10 into 236) 1)
              ((10 into 281) 1)
              ((10 into 358) 1)
              ((10 into 235) 1)
              ((10 into 201) 1)
              ((10 into 357) 1)
              ((10 into 219) 1)
              ((10 into 279) 1)
              ((10 into 200) 1)
              ((10 into 278) 1)
              ((9 into 277) 1)
              ((12 into 218) 1)
              ((12 into 276) 1)
              ((13 into 217) 1)
              ((13 into 174) 1)
              ((11 into 216) 1)
              ((11 into 273) 1)
              ((8 into 215) 1)
              ((9 into 271) 1)
              ((9 into 213) 1)
              ((9 into 269) 1)
              ((9 into 268) 1)
              ((9 into 267) 1)
              ((8 into 265) 1)
              ((7 into 210) 1)
              ((8 into 233) 1)
              ((8 into 232) 1)
              ((7 into 264) 1)
              ((7 into 263) 1)
              ((4 into 161) 1)
              ((8 into 207) 1)
              ((8 into 228) 1)
              ((8 into 262) 1)
              ((8 into 192) 1)
              ((2 into 160) 1)
              ((7 into 226) 1)
              ((7 into 206) 1)
              ((1 into 65) 1)
              ((7 into 356) 1)
              ((5 into 224) 1)
              ((5 into 205) 1)
              ((5 into 185) 1)
              ((10 into 205) 1)
              ((7 into 355) 1)
              ((11 into 183) 1)
              ((11 into 143) 1)
              ((6 into 203) 1)
              ((11 into 202) 1)
              ((4 into 179) 1)
              ((10 into 195) 1)
              ((6 into 219) 1)
              ((5 into 354) 1)
              ((5 into 218) 1)
              ((5 into 199) 1)
              ((4 into 217) 1)
              ((5 into 216) 1)
              ((8 into 171) 2)
              ((5 into 172) 1)
              ((9 into 353) 1)
              ((9 into 209) 1)
              ((7 into 352) 1)
              ((13 into 172) 1)
              ((13 into 170) 1)
              ((13 into 156) 1)
              ((13 into 184) 1)
              ((13 into 167) 2)
              ((12 into 172) 1)
              ((12 into 156) 1)
              ((12 into 184) 1)
              ((13 into 155) 1)
              ((13 into 169) 1)
              ((13 into 171) 1)
              ((13 into 166) 2)
              ((11 into 190) 1)
              ((11 into 158) 1)
              ((11 into 258) 1)
              ((11 into 351) 1)
              ((11 into 154) 1)
              ((10 into 271) 1)
              ((10 into 241) 1)
              ((10 into 181) 1)
              ((10 into 351) 1)
              ((11 into 350) 1)
              ((7 into 194) 1)
              ((18 into 156) 1)
              ((18 into 215) 1)
              ((18 into 100) 1)
              ((18 into 123) 1)
              ((18 into 50) 2)
              ((18 into 112) 1)
              ((18 into 349) 1)
              ((18 into 114) 1)
              ((18 into 192) 1)
              ((18 into 152) 1)
              ((18 into 178) 1)
              ((18 into 122) 1)
              ((10 into 158) 2)
              ((10 into 193) 3)
              ((10 into 151) 3)
              ((10 into 240) 1)
              ((10 into 270) 1)
              ((8 into 193) 1)
              ((4 into 192) 1)
              ((4 into 157) 2)
              ((4 into 155) 1)
              ((6 into 348) 1)
              ((16 into 155) 1)
              ((16 into 120) 1)
              ((16 into 176) 1)
              ((16 into 190) 1)
              ((16 into 347) 1)
              ((16 into 122) 1)
              ((16 into 214) 1)
              ((16 into 158) 1)
              ((10 into 239) 1)
              ((10 into 269) 1)
              ((4 into 191) 1)
              ((6 into 346) 1)
              ((4 into 213) 1)
              ((4 into 212) 1)
              ((3 into 144) 1)
              ((7 into 199) 1)
              ((7 into 188) 1)
              ((5 into 166) 3)
              ((7 into 197) 2)
              ((3 into 149) 1)
              ((7 into 187) 2)
              ((10 into 186) 1)
              ((10 into 162) 3)
              ((7 into 186) 2)
              ((13 into 161) 1)
              ((13 into 185) 2)
              ((11 into 255) 1)
              ((11 into 155) 1)
              ((11 into 238) 1)
              ((11 into 268) 1)
              ((11 into 193) 1)
              ((3 into 192) 1)
              ((8 into 252) 1)
              ((11 into 251) 2)
              ((6 into 345) 1)
              ((6 into 344) 1)
              ((12 into 250) 1)
              ((12 into 118) 1)
              ((12 into 266) 1)
              ((12 into 235) 1)
              ((6 into 343) 1)
              ((4 into 342) 1)
              ((7 into 341) 1)
              ((7 into 249) 1)
              ((4 into 340) 1)
              ((9 into 339) 1)
              ((6 into 338) 1)
              ((2 into 109) 1)
              ((7 into 247) 1)
              ((9 into 337) 1)
              ((9 into 145) 1)
              ((8 into 336) 1)
              ((6 into 335) 1)
              ((9 into 334) 1)
              ((8 into 132) 1)
              ((8 into 333) 1)
              ((6 into 246) 2)
              ((9 into 332) 1)
              ((9 into 175) 1)
              ((6 into 331) 1)
              ((8 into 243) 1)
              ((6 into 330) 1)
              ((8 into 329) 1)
              ((5 into 242) 1)
              ((6 into 328) 1)
              ((6 into 327) 1)
              ((6 into 326) 1)
              ((6 into 325) 1)
              ((7 into 240) 1)
              ((4 into 324) 1)
              ((10 into 180) 1)
              ((10 into 188) 1)
              ((10 into 189) 2)
              ((10 into 265) 1)
              ((10 into 234) 1)
              ((8 into 178) 2)
              ((8 into 323) 1)
              ((8 into 322) 1)
              ((5 into 321) 1)
              ((5 into 238) 1)
              ((8 into 320) 1)
              ((5 into 319) 1)
              ((6 into 175) 2)
              ((6 into 237) 1)
              ((7 into 236) 1)
              ((6 into 318) 1)
              ((6 into 235) 1)
              ((6 into 317) 1)
              ((6 into 316) 1)
              ((13 into 189) 1)
              ((13 into 193) 1)
              ((13 into 188) 1)
              ((13 into 192) 1)
              ((12 into 169) 1)
              ((12 into 192) 1)
              ((6 into 315) 1)
              ((12 into 191) 1)
              ((6 into 314) 1)
              ((13 into 190) 1)
              ((10 into 167) 2)
              ((5 into 313) 1)
              ((5 into 206) 1)
              ((5 into 312) 1)
              ((9 into 164) 1)
              ((9 into 144) 1)
              ((3 into 206) 1)
              ((6 into 311) 1)
              ((6 into 208) 1)
              ((11 into 206) 1)
              ((3 into 205) 2)
              ((11 into 163) 2)
              ((3 into 204) 1)
              ((3 into 120) 2)
              ((3 into 170) 2)
              ((5 into 310) 1)
              ((5 into 309) 1)
              ((6 into 264) 1)
              ((9 into 186) 1)
              ((9 into 263) 2)
              ((4 into 308) 1)
              ((4 into 307) 1)
              ((1 into 88) 1)
              ((7 into 262) 1)
              ((7 into 231) 2)
              ((8 into 162) 2)
              ((15 into 173) 1)
              ((15 into 136) 1)
              ((15 into 307) 1)
              ((15 into 165) 1)
              ((15 into 294) 1)
              ((15 into 105) 1)
              ((4 into 130) 2)
              ((4 into 151) 3)
              ((6 into 306) 1)
              ((16 into 172) 1)
              ((16 into 135) 1)
              ((16 into 305) 1)
              ((16 into 164) 1)
              ((16 into 293) 1)
              ((9 into 179) 2)
              ((1 into 89) 1)
              ((3 into 121) 2)
              ((5 into 304) 1)
              ((6 into 292) 1)
              ((7 into 172) 2)
              ((7 into 169) 3)
              ((7 into 178) 1)
              ((3 into 165) 1)
              ((5 into 170) 2)
              ((5 into 303) 1)
              ((6 into 182) 3)
              ((6 into 291) 1)
              ((2 into 132) 1)
              ((5 into 302) 1)
              ((6 into 290) 1)
              ((2 into 152) 1)
              ((10 into 178) 2)
              ((6 into 289) 1)
              ((4 into 168) 1)
              ((7 into 170) 3)
              ((12 into 178) 1)
              ((12 into 141) 1)
              ((7 into 301) 1)
              ((7 into 300) 1)
              ((6 into 287) 1)
              ((13 into 178) 1)
              ((13 into 104) 3)
              ((1 into 78) 1)
              ((7 into 286) 1)
              ((7 into 177) 2)
              ((6 into 299) 1)
              ((5 into 298) 1)
              ((6 into 285) 2)
              ((9 into 159) 3)
              ((10 into 177) 3)
              ((11 into 176) 2)
              ((15 into 132) 1)
              ((15 into 175) 1)
              ((15 into 140) 1)
              ((9 into 234) 1)
              ((1 into 81) 1)
              ((12 into 175) 2)
              ((4 into 163) 2)
              ((5 into 284) 1)
              ((5 into 283) 1)
              ((5 into 174) 1)
              ((15 into 174) 1)
              ((9 into 283) 2)
              ((9 into 298) 1)
              ((1 into 63) 1)
              ((10 into 297) 2)
              ((10 into 260) 2)
              ((10 into 282) 3)
              ((11 into 281) 1)
              ((11 into 259) 1)
              ((11 into 296) 1)
              ((5 into 171) 4)
              ((8 into 295) 1)
              ((9 into 233) 2)
              ((14 into 160) 1)
              ((14 into 229) 1)
              ((14 into 258) 1)
              ((14 into 171) 1)
              ((14 into 280) 1)
              ((10 into 280) 2)
              ((10 into 295) 1)
              ((11 into 159) 2)
              ((11 into 279) 1)
              ((11 into 294) 1)
              ((14 into 158) 1)
              ((14 into 228) 1)
              ((14 into 257) 1)
              ((14 into 170) 1)
              ((14 into 278) 1)
              ((9 into 232) 3)
              ((9 into 231) 1)
              ((10 into 197) 2)
              ((10 into 229) 1)
              ((10 into 164) 1)
              ((8 into 229) 2)
              ((6 into 168) 3)
              ((14 into 277) 1)
              ((14 into 157) 1)
              ((6 into 195) 2)
              ((9 into 276) 1)
              ((13 into 275) 2)
              ((8 into 225) 1)
              ((11 into 274) 2)
              ((9 into 274) 2)
              ((11 into 225) 1)
              ((11 into 157) 4)
              ((11 into 165) 3)
              ((11 into 293) 1)
              ((5 into 169) 2)
              ((14 into 156) 1)
              ((14 into 292) 1)
              ((14 into 273) 1)
              ((9 into 155) 4)
              ((9 into 272) 1)
              ((9 into 163) 2)
              ((14 into 154) 1)
              ((14 into 126) 1)
              ((14 into 291) 1)
              ((14 into 155) 1)
              ((14 into 271) 1)
              ((6 into 165) 3)
              ((14 into 153) 1)
              ((14 into 290) 1)
              ((14 into 125) 1)
              ((14 into 270) 1)
              ((7 into 161) 4)
              ((5 into 289) 1)
              ((6 into 288) 2)
              ((11 into 287) 1)
              ((11 into 223) 1)
              ((11 into 162) 2)
              ((15 into 104) 3)
              ((15 into 149) 1)
              ((15 into 152) 1)
              ((12 into 151) 1)
              ((12 into 269) 1)
              ((2 into 158) 1)
              ((4 into 116) 2)
              ((14 into 151) 1)
              ((14 into 150) 1)
              ((15 into 148) 1)
              ((15 into 150) 1)
              ((15 into 151) 2)
              ((11 into 286) 1)
              ((16 into 71) 1)
              ((16 into 99) 2)
              ((16 into 147) 1)
              ((16 into 150) 2)
              ((2 into 157) 1)
              ((11 into 123) 2)
              ((14 into 149) 1)
              ((14 into 136) 1)
              ((14 into 148) 3)
              ((14 into 146) 2)
              ((14 into 134) 1)
              ((7 into 157) 4)
              ((7 into 268) 1)
              ((12 into 146) 1)
              ((8 into 152) 1)
              ((4 into 285) 1)
              ((5 into 158) 2)
              ((4 into 147) 2)
              ((6 into 194) 1)
              ((11 into 284) 1)
              ((11 into 153) 3)
              ((11 into 267) 3)
              ((6 into 284) 1)
              ((6 into 227) 2)
              ((6 into 256) 1)
              ((14 into 145) 2)
              ((14 into 144) 3)
              ((14 into 141) 3)
              ((14 into 131) 1)
              ((7 into 283) 1)
              ((6 into 157) 1)
              ((3 into 147) 1)
              ((12 into 140) 1)
              ((5 into 165) 2)
              ((7 into 255) 1)
              ((7 into 266) 1)
              ((6 into 254) 1)
              ((6 into 167) 4)
              ((6 into 253) 1)
              ((6 into 166) 3)
              ((5 into 282) 1)
              ((5 into 191) 1)
              ((5 into 281) 1)
              ((3 into 146) 3)
              ((7 into 162) 6)
              ((4 into 281) 1)
              ((9 into 225) 1)
              ((9 into 206) 1)
              ((9 into 224) 2)
              ((8 into 222) 1)
              ((6 into 221) 1)
              ((5 into 153) 1)
              ((5 into 280) 2)
              ((4 into 190) 3)
              ((5 into 250) 1)
              ((5 into 203) 1)
              ((5 into 279) 1)
              ((8 into 278) 1)
              ((5 into 202) 1)
              ((5 into 266) 1)
              ((9 into 265) 1)
              ((9 into 249) 1)
              ((9 into 248) 2)
              ((9 into 264) 1)
              ((4 into 218) 1)
              ((3 into 190) 1)
              ((4 into 189) 1)
              ((10 into 217) 1)
              ((10 into 247) 1)
              ((10 into 263) 1)
              ((6 into 188) 2)
              ((6 into 216) 1)
              ((8 into 277) 1)
              ((8 into 198) 1)
              ((9 into 220) 2)
              ((9 into 219) 2)
              ((2 into 108) 1)
              ((4 into 215) 1)
              ((9 into 196) 4)
              ((9 into 262) 1)
              ((18 into 95) 1)
              ((18 into 160) 1)
              ((18 into 276) 1)
              ((18 into 119) 1)
              ((18 into 75) 1)
              ((18 into 135) 1)
              ((18 into 138) 1)
              ((18 into 64) 1)
              ((18 into 129) 1)
              ((18 into 73) 1)
              ((18 into 94) 1)
              ((18 into 159) 2)
              ((18 into 275) 1)
              ((18 into 118) 1)
              ((18 into 134) 1)
              ((18 into 136) 1)
              ((18 into 137) 2)
              ((18 into 63) 1)
              ((18 into 128) 1)
              ((18 into 72) 2)
              ((18 into 56) 1)
              ((17 into 133) 1)
              ((17 into 135) 1)
              ((17 into 136) 1)
              ((17 into 46) 1)
              ((17 into 117) 1)
              ((17 into 274) 1)
              ((17 into 158) 1)
              ((17 into 83) 1)
              ((17 into 86) 1)
              ((17 into 67) 1)
              ((17 into 93) 1)
              ((17 into 71) 2)
              ((17 into 127) 1)
              ((17 into 56) 1)
              ((13 into 194) 1)
              ((13 into 273) 1)
              ((5 into 246) 1)
              ((6 into 193) 3)
              ((6 into 213) 1)
              ((6 into 245) 1)
              ((6 into 163) 5)
              ((9 into 244) 2)
              ((9 into 261) 2)
              ((14 into 162) 1)
              ((14 into 188) 1)
              ((8 into 272) 2)
              ((5 into 217) 1)
              ((3 into 111) 3)
              ((3 into 188) 1)
              ((4 into 187) 1)
              ((9 into 161) 4)
              ((9 into 243) 1)
              ((9 into 260) 2)
              ((13 into 131) 1)
              ((12 into 130) 2)
              ((12 into 187) 1)
              ((7 into 242) 1)
              ((7 into 259) 2)
              ((8 into 216) 2)
              ((12 into 186) 2)
              ((3 into 187) 1)
              ((4 into 186) 1)
              ((7 into 159) 7)
              ((7 into 258) 2)
              ((12 into 185) 2)
              ((5 into 257) 1)
              ((16 into 184) 1)
              ((16 into 128) 1)
              ((16 into 127) 1)
              ((16 into 125) 1)
              ((16 into 140) 1)
              ((4 into 185) 1)
              ((5 into 214) 1)
              ((17 into 35) 1)
              ((17 into 183) 1)
              ((17 into 126) 1)
              ((17 into 125) 2)
              ((17 into 151) 1)
              ((5 into 271) 1)
              ((5 into 213) 1)
              ((2 into 125) 1)
              ((17 into 19) 1)
              ((17 into 61) 2)
              ((17 into 21) 1)
              ((17 into 182) 1)
              ((17 into 123) 2)
              ((17 into 122) 1)
              ((17 into 120) 1)
              ((17 into 27) 1)
              ((17 into 96) 1)
              ((17 into 150) 1)
              ((11 into 121) 5)
              ((10 into 143) 3)
              ((10 into 212) 1)
              ((10 into 211) 1)
              ((15 into 60) 2)
              ((15 into 181) 1)
              ((15 into 120) 1)
              ((15 into 116) 1)
              ((15 into 119) 2)
              ((15 into 180) 1)
              ((6 into 210) 2)
              ((13 into 115) 7)
              ((13 into 179) 2)
              ((14 into 178) 2)
              ((14 into 114) 2)
              ((14 into 111) 2)
              ((5 into 209) 2)
              ((3 into 135) 1)
              ((15 into 183) 1)
              ((15 into 109) 1)
              ((15 into 112) 2)
              ((15 into 177) 1)
              ((8 into 257) 3)
              ((9 into 141) 3)
              ((9 into 256) 2)
              ((5 into 182) 2)
              ((5 into 208) 2)
              ((2 into 117) 2)
              ((3 into 117) 3)
              ((13 into 181) 2)
              ((3 into 142) 2)
              ((2 into 143) 2)
              ((12 into 105) 5)
              ((4 into 139) 4)
              ((13 into 176) 2)
              ((12 into 176) 1)
              ((3 into 158) 1)
              ((1 into 77) 1)
              ((10 into 207) 1)
              ((3 into 143) 4)
              ((10 into 147) 2)
              ((3 into 128) 1)
              ((11 into 240) 1)
              ((11 into 211) 1)
              ((5 into 270) 1)
              ((5 into 204) 1)
              ((3 into 126) 2)
              ((5 into 255) 1)
              ((5 into 254) 1)
              ((1 into 68) 1)
              ((5 into 253) 1)
              ((10 into 203) 1)
              ((8 into 203) 2)
              ((3 into 125) 1)
              ((2 into 113) 3)
              ((5 into 252) 1)
              ((3 into 127) 3)
              ((12 into 145) 2)
              ((12 into 190) 2)
              ((12 into 239) 1)
              ((5 into 109) 5)
              ((3 into 156) 1)
              ((6 into 251) 2)
              ((6 into 189) 2)
              ((6 into 209) 1)
              ((1 into 47) 1)
              ((1 into 67) 1)
              ((7 into 251) 1)
              ((7 into 270) 2)
              ((9 into 142) 2)
              ((9 into 188) 1)
              ((9 into 237) 1)
              ((3 into 138) 1)
              ((9 into 200) 4)
              ((2 into 115) 2)
              ((8 into 250) 1)
              ((8 into 269) 1)
              ((11 into 186) 3)
              ((11 into 236) 3)
              ((9 into 199) 4)
              ((8 into 235) 3)
              ((8 into 249) 1)
              ((7 into 248) 1)
              ((7 into 234) 3)
              ((6 into 233) 2)
              ((11 into 198) 1)
              ((13 into 123) 4)
              ((13 into 182) 2)
              ((13 into 268) 1)
              ((6 into 131) 10)
              ((10 into 198) 3)
              ((12 into 205) 1)
              ((12 into 232) 1)
              ((12 into 181) 1)
              ((12 into 137) 2)
              ((17 into 112) 1)
              ((17 into 50) 1)
              ((17 into 107) 1)
              ((17 into 70) 2)
              ((17 into 29) 2)
              ((17 into 41) 3)
              ((17 into 103) 2)
              ((17 into 59) 2)
              ((17 into 44) 2)
              ((17 into 49) 1)
              ((17 into 30) 1)
              ((17 into 42) 3)
              ((18 into 43) 2)
              ((18 into 111) 1)
              ((18 into 40) 2)
              ((18 into 28) 1)
              ((18 into 106) 1)
              ((3 into 177) 1)
              ((4 into 132) 3)
              ((3 into 123) 3)
              ((4 into 176) 2)
              ((5 into 126) 6)
              ((16 into 101) 2)
              ((16 into 53) 1)
              ((8 into 231) 1)
              ((8 into 204) 1)
              ((7 into 156) 4)
              ((7 into 230) 3)
              ((7 into 203) 1)
              ((4 into 127) 2)
              ((7 into 229) 2)
              ((7 into 202) 4)
              ((6 into 267) 2)
              ((9 into 266) 2)
              ((9 into 151) 2)
              ((11 into 265) 1)
              ((10 into 196) 2)
              ((4 into 124) 4)
              ((11 into 201) 2)
              ((11 into 228) 1)
              ((11 into 180) 2)
              ((11 into 135) 2)
              ((11 into 179) 1)
              ((11 into 227) 1)
              ((7 into 179) 3)
              ((7 into 200) 1)
              ((6 into 154) 5)
              ((6 into 226) 4)
              ((6 into 199) 2)
              ((6 into 177) 4)
              ((6 into 198) 1)
              ((6 into 225) 1)
              ((8 into 197) 2)
              ((8 into 224) 1)
              ((8 into 247) 1)
              ((4 into 173) 3)
              ((4 into 152) 3)
              ((14 into 81) 3)
              ((14 into 112) 1)
              ((8 into 264) 1)
              ((8 into 150) 7)
              ((5 into 195) 1)
              ((11 into 195) 2)
              ((7 into 175) 1)
              ((7 into 223) 2)
              ((8 into 133) 6)
              ((8 into 223) 1)
              ((8 into 196) 3)
              ((9 into 195) 2)
              ((9 into 222) 1)
              ((9 into 246) 3)
              ((5 into 245) 1)
              ((5 into 173) 5)
              ((8 into 194) 4)
              ((8 into 220) 1)
              ((8 into 172) 2)
              ((8 into 244) 1)
              ((7 into 193) 4)
              ((7 into 219) 1)
              ((7 into 171) 5)
              ((7 into 243) 1)
              ((4 into 263) 1)
              ((11 into 151) 1)
              ((13 into 175) 3)
              ((13 into 112) 5)
              ((12 into 194) 1)
              ((8 into 155) 5)
              ((9 into 218) 2)
              ((9 into 217) 1)
              ((9 into 242) 1)
              ((4 into 241) 1)
              ((12 into 171) 1)
              ((12 into 150) 3)
              ((11 into 169) 1)
              ((11 into 110) 3)
              ((11 into 262) 1)
              ((7 into 261) 3)
              ((5 into 192) 2)
              ((4 into 114) 4)
              ((12 into 148) 1)
              ((4 into 125) 8)
              ((11 into 191) 5)
              ((8 into 146) 3)
              ((3 into 260) 2)
              ((4 into 119) 1)
              ((5 into 123) 6)
              ((4 into 174) 3)
              ((6 into 173) 5)
              ((6 into 120) 9)
              ((15 into 95) 2)
              ((15 into 92) 1)
              ((15 into 102) 2)
              ((3 into 173) 1)
              ((6 into 149) 9)
              ((15 into 91) 1)
              ((15 into 96) 2)
              ((15 into 94) 2)
              ((4 into 172) 2)
              ((8 into 189) 1)
              ((8 into 259) 1)
              ((11 into 109) 2)
              ((12 into 106) 7)
              ((12 into 108) 5)
              ((13 into 106) 6)
              ((4 into 171) 1)
              ((7 into 168) 5)
              ((7 into 216) 1)
              ((7 into 190) 2)
              ((9 into 170) 6)
              ((7 into 167) 5)
              ((8 into 258) 1)
              ((7 into 166) 6)
              ((7 into 241) 3)
              ((4 into 169) 1)
              ((10 into 146) 3)
              ((10 into 165) 5)
              ((7 into 130) 7)
              ((7 into 257) 1)
              ((8 into 256) 1)
              ((3 into 168) 1)
              ((4 into 120) 2)
              ((6 into 214) 1)
              ((6 into 240) 1)
              ((7 into 189) 5)
              ((6 into 255) 1)
              ((6 into 152) 6)
              ((6 into 164) 7)
              ((2 into 103) 2)
              ((13 into 163) 2)
              ((13 into 121) 2)
              ((5 into 186) 1)
              ((7 into 254) 2)
              ((13 into 162) 1)
              ((7 into 253) 2)
              ((7 into 184) 5)
              ((5 into 184) 4)
              ((11 into 108) 4)
              ((6 into 162) 4)
              ((6 into 183) 5)
              ((11 into 161) 3)
              ((7 into 252) 2)
              ((8 into 161) 5)
              ((8 into 213) 1)
              ((8 into 212) 1)
              ((8 into 211) 2)
              ((8 into 239) 1)
              ((4 into 251) 1)
              ((6 into 250) 1)
              ((8 into 185) 3)
              ((8 into 238) 1)
              ((6 into 249) 1)
              ((6 into 129) 4)
              ((3 into 141) 2)
              ((6 into 248) 2)
              ((2 into 128) 1)
              ((8 into 237) 2)
              ((5 into 161) 2)
              ((5 into 247) 1)
              ((5 into 178) 2)
              ((8 into 208) 1)
              ((8 into 153) 9)
              ((8 into 236) 2)
              ((5 into 176) 4)
              ((7 into 207) 2)
              ((6 into 181) 4)
              ((13 into 90) 4)
              ((5 into 235) 1)
              ((6 into 234) 1)
              ((10 into 157) 5)
              ((3 into 124) 4)
              ((8 into 205) 2)
              ((8 into 180) 1)
              ((4 into 175) 5)
              ((1 into 135) 1)
              ((3 into 118) 6)
              ((7 into 246) 1)
              ((6 into 205) 1)
              ((7 into 245) 2)
              ((5 into 156) 5)
              ((7 into 244) 2)
              ((3 into 151) 2)
              ((5 into 167) 2)
              ((4 into 121) 6)
              ((15 into 89) 2)
              ((6 into 144) 5)
              ((5 into 244) 1)
              ((5 into 142) 4)
              ((5 into 145) 6)
              ((10 into 144) 5)
              ((10 into 204) 2)
              ((10 into 233) 1)
              ((9 into 156) 5)
              ((12 into 144) 1)
              ((12 into 244) 1)
              ((13 into 143) 3)
              ((13 into 243) 1)
              ((4 into 150) 3)
              ((6 into 232) 1)
              ((10 into 153) 2)
              ((12 into 242) 1)
              ((6 into 231) 1)
              ((6 into 140) 9)
              ((6 into 137) 7)
              ((6 into 230) 1)
              ((13 into 122) 3)
              ((5 into 152) 3)
              ((9 into 241) 1)
              ((8 into 149) 3)
              ((11 into 142) 3)
              ((5 into 229) 2)
              ((6 into 228) 1)
              ((6 into 134) 8)
              ((6 into 122) 3)
              ((3 into 115) 4)
              ((15 into 101) 2)
              ((15 into 144) 1)
              ((8 into 241) 1)
              ((9 into 240) 1)
              ((4 into 240) 1)
              ((5 into 164) 3)
              ((2 into 141) 3)
              ((7 into 227) 3)
              ((4 into 239) 1)
              ((5 into 239) 2)
              ((6 into 239) 1)
              ((2 into 95) 1)
              ((2 into 140) 1)
              ((8 into 226) 2)
              ((1 into 66) 2)
              ((1 into 70) 1)
              ((7 into 238) 1)
              ((6 into 143) 9)
              ((6 into 238) 4)
              ((7 into 237) 1)
              ((10 into 163) 3)
              ((3 into 163) 1)
              ((4 into 146) 4)
              ((7 into 225) 2)
              ((7 into 224) 1)
              ((6 into 142) 10)
              ((4 into 162) 4)
              ((3 into 145) 4)
              ((14 into 93) 3)
              ((14 into 104) 1)
              ((14 into 117) 1)
              ((14 into 113) 3)
              ((14 into 135) 2)
              ((14 into 223) 1)
              ((6 into 236) 3)
              ((7 into 235) 2)
              ((3 into 161) 1)
              ((7 into 141) 5)
              ((7 into 151) 4)
              ((11 into 234) 1)
              ((7 into 222) 1)
              ((5 into 233) 1)
              ((10 into 232) 1)
              ((5 into 221) 3)
              ((4 into 113) 8)
              ((7 into 142) 3)
              ((5 into 149) 4)
              ((10 into 231) 1)
              ((4 into 148) 3)
              ((9 into 230) 3)
              ((9 into 229) 1)
              ((1 into 91) 1)
              ((12 into 114) 8)
              ((8 into 160) 4)
              ((8 into 173) 3)
              ((6 into 172) 5)
              ((10 into 116) 6)
              ((4 into 115) 6)
              ((4 into 220) 2)
              ((9 into 228) 2)
              ((3 into 159) 1)
              ((6 into 171) 5)
              ((4 into 227) 1)
              ((3 into 157) 2)
              ((6 into 170) 3)
              ((3 into 91) 4)
              ((3 into 140) 4)
              ((5 into 139) 6)
              ((4 into 226) 1)
              ((4 into 180) 3)
              ((6 into 169) 6)
              ((6 into 138) 5)
              ((5 into 168) 4)
              ((3 into 155) 2)
              ((4 into 154) 3)
              ((4 into 153) 3)
              ((4 into 110) 8)
              ((5 into 134) 3)
              ((5 into 225) 2)
              ((3 into 152) 3)
              ((6 into 224) 1)
              ((6 into 133) 6)
              ((9 into 178) 1)
              ((3 into 220) 1)
              ((3 into 150) 1)
              ((4 into 149) 3)
              ((4 into 219) 1)
              ((4 into 107) 5)
              ((10 into 168) 2)
              ((11 into 167) 2)
              ((11 into 139) 1)
              ((11 into 166) 5)
              ((8 into 202) 2)
              ((8 into 147) 7)
              ((7 into 218) 1)
              ((9 into 177) 2)
              ((9 into 146) 4)
              ((9 into 201) 4)
              ((6 into 200) 2)
              ((7 into 217) 1)
              ((5 into 200) 3)
              ((11 into 199) 1)
              ((11 into 145) 3)
              ((5 into 198) 3)
              ((6 into 223) 2)
              ((3 into 101) 11)
              ((5 into 144) 5)
              ((4 into 104) 5)
              ((6 into 222) 3)
              ((6 into 197) 3)
              ((4 into 143) 3)
              ((3 into 102) 9)
              ((9 into 221) 2)
              ((6 into 130) 7)
              ((2 into 79) 3)
              ((15 into 90) 1)
              ((15 into 103) 2)
              ((4 into 197) 1)
              ((5 into 196) 1)
              ((4 into 196) 1)
              ((3 into 129) 4)
              ((6 into 113) 10)
              ((4 into 166) 2)
              ((9 into 165) 7)
              ((8 into 195) 3)
              ((1 into 84) 1)
              ((5 into 194) 3)
              ((5 into 193) 3)
              ((2 into 127) 1)
              ((1 into 76) 1)
              ((4 into 221) 2)
              ((3 into 193) 2)
              ((3 into 137) 4)
              ((5 into 220) 1)
              ((4 into 136) 3)
              ((2 into 83) 2)
              ((14 into 102) 3)
              ((14 into 98) 4)
              ((15 into 106) 1)
              ((15 into 86) 4)
              ((15 into 100) 3)
              ((1 into 54) 2)
              ((9 into 174) 3)
              ((10 into 191) 3)
              ((10 into 216) 1)
              ((10 into 215) 2)
              ((10 into 190) 1)
              ((10 into 172) 1)
              ((9 into 189) 2)
              ((9 into 214) 3)
              ((8 into 170) 4)
              ((8 into 219) 1)
              ((8 into 169) 5)
              ((8 into 187) 3)
              ((8 into 218) 1)
              ((14 into 100) 3)
              ((8 into 186) 2)
              ((8 into 168) 5)
              ((6 into 217) 2)
              ((9 into 184) 1)
              ((2 into 136) 1)
              ((8 into 165) 6)
              ((8 into 183) 4)
              ((1 into 75) 1)
              ((7 into 181) 3)
              ((11 into 125) 2)
              ((11 into 213) 1)
              ((5 into 163) 5)
              ((5 into 138) 6)
              ((9 into 180) 3)
              ((9 into 136) 3)
              ((1 into 53) 1)
              ((1 into 61) 4)
              ((6 into 179) 3)
              ((9 into 212) 3)
              ((4 into 178) 1)
              ((4 into 160) 2)
              ((4 into 164) 5)
              ((2 into 105) 1)
              ((6 into 160) 7)
              ((1 into 44) 4)
              ((2 into 104) 3)
              ((8 into 163) 3)
              ((8 into 139) 3)
              ((2 into 112) 1)
              ((2 into 102) 4)
              ((2 into 111) 4)
              ((8 into 159) 4)
              ((8 into 210) 2)
              ((8 into 123) 6)
              ((3 into 122) 3)
              ((5 into 162) 2)
              ((12 into 216) 1)
              ((4 into 135) 3)
              ((2 into 101) 2)
              ((8 into 176) 6)
              ((8 into 175) 2)
              ((8 into 209) 3)
              ((13 into 208) 1)
              ((11 into 156) 1)
              ((11 into 174) 2)
              ((7 into 215) 3)
              ((7 into 214) 2)
              ((12 into 206) 1)
              ((10 into 160) 3)
              ((13 into 100) 6)
              ((7 into 205) 1)
              ((5 into 207) 3)
              ((5 into 175) 3)
              ((6 into 174) 4)
              ((6 into 206) 3)
              ((13 into 88) 2)
              ((13 into 173) 1)
              ((13 into 205) 1)
              ((13 into 120) 3)
              ((13 into 130) 2)
              ((12 into 213) 1)
              ((12 into 134) 2)
              ((12 into 129) 4)
              ((12 into 212) 1)
              ((10 into 171) 1)
              ((10 into 155) 3)
              ((9 into 211) 3)
              ((10 into 154) 5)
              ((3 into 113) 6)
              ((1 into 79) 2)
              ((9 into 129) 5)
              ((9 into 202) 2)
              ((15 into 129) 1)
              ((15 into 167) 1)
              ((15 into 201) 1)
              ((15 into 117) 2)
              ((15 into 93) 1)
              ((13 into 91) 3)
              ((13 into 200) 1)
              ((13 into 136) 2)
              ((8 into 199) 1)
              ((8 into 166) 6)
              ((7 into 198) 1)
              ((7 into 165) 7)
              ((12 into 210) 2)
              ((13 into 197) 2)
              ((13 into 109) 5)
              ((10 into 152) 3)
              ((12 into 132) 5)
              ((8 into 151) 5)
              ((8 into 127) 2)
              ((3 into 112) 5)
              ((7 into 164) 6)
              ((7 into 150) 5)
              ((7 into 196) 2)
              ((7 into 163) 6)
              ((9 into 162) 5)
              ((9 into 194) 1)
              ((15 into 107) 1)
              ((15 into 193) 1)
              ((15 into 209) 1)
              ((15 into 98) 2)
              ((9 into 208) 3)
              ((10 into 121) 4)
              ((6 into 192) 1)
              ((6 into 161) 5)
              ((9 into 160) 4)
              ((9 into 191) 2)
              ((7 into 160) 9)
              ((7 into 191) 2)
              ((11 into 133) 6)
              ((11 into 207) 3)
              ((11 into 150) 2)
              ((6 into 190) 2)
              ((10 into 149) 3)
              ((10 into 206) 2)
              ((9 into 148) 4)
              ((12 into 189) 1)
              ((12 into 158) 1)
              ((12 into 149) 2)
              ((12 into 127) 1)
              ((8 into 157) 6)
              ((8 into 188) 4)
              ((9 into 205) 2)
              ((9 into 131) 5)
              ((10 into 187) 1)
              ((10 into 156) 5)
              ((10 into 148) 1)
              ((6 into 186) 2)
              ((11 into 204) 3)
              ((11 into 185) 1)
              ((9 into 203) 4)
              ((10 into 145) 3)
              ((10 into 123) 6)
              ((11 into 144) 3)
              ((11 into 117) 3)
              ((7 into 185) 5)
              ((8 into 117) 5)
              ((8 into 154) 4)
              ((8 into 184) 4)
              ((10 into 202) 3)
              ((7 into 183) 2)
              ((13 into 183) 2)
              ((13 into 129) 2)
              ((8 into 141) 6)
              ((3 into 105) 4)
              ((7 into 152) 10)
              ((7 into 182) 7)
              ((9 into 181) 1)
              ((11 into 131) 3)
              ((11 into 115) 5)
              ((11 into 148) 6)
              ((11 into 129) 8)
              ((5 into 108) 9)
              ((5 into 201) 1)
              ((9 into 182) 1)
              ((11 into 130) 5)
              ((11 into 200) 2)
              ((11 into 181) 3)
              ((6 into 180) 5)
              ((10 into 199) 3)
              ((10 into 179) 3)
              ((6 into 151) 7)
              ((6 into 148) 7)
              ((6 into 127) 4)
              ((9 into 150) 3)
              ((9 into 147) 4)
              ((11 into 149) 3)
              ((11 into 178) 3)
              ((11 into 146) 4)
              ((8 into 148) 7)
              ((8 into 177) 3)
              ((9 into 198) 3)
              ((3 into 108) 7)
              ((7 into 147) 4)
              ((7 into 176) 1)
              ((5 into 177) 3)
              ((6 into 176) 4)
              ((14 into 94) 2)
              ((14 into 175) 3)
              ((6 into 141) 10)
              ((7 into 146) 5)
              ((7 into 174) 2)
              ((12 into 126) 7)
              ((12 into 128) 7)
              ((13 into 124) 4)
              ((13 into 127) 1)
              ((13 into 93) 7)
              ((13 into 111) 2)
              ((13 into 141) 3)
              ((9 into 140) 2)
              ((11 into 122) 6)
              ((7 into 145) 7)
              ((7 into 173) 4)
              ((10 into 173) 4)
              ((10 into 118) 3)
              ((10 into 138) 2)
              ((11 into 172) 5)
              ((11 into 197) 2)
              ((11 into 101) 7)
              ((11 into 196) 2)
              ((11 into 171) 1)
              ((7 into 195) 4)
              ((11 into 194) 2)
              ((11 into 170) 1)
              ((9 into 193) 1)
              ((9 into 192) 4)
              ((10 into 120) 7)
              ((10 into 170) 2)
              ((6 into 191) 3)
              ((10 into 169) 2)
              ((8 into 190) 1)
              ((9 into 168) 5)
              ((10 into 130) 7)
              ((10 into 125) 10)
              ((10 into 129) 6)
              ((9 into 128) 12)
              ((9 into 126) 8)
              ((9 into 166) 9)
              ((10 into 166) 2)
              ((4 into 122) 5)
              ((12 into 143) 4)
              ((5 into 110) 13)
              ((5 into 189) 2)
              ((11 into 118) 4)
              ((11 into 120) 7)
              ((11 into 124) 3)
              ((3 into 116) 6)
              ((9 into 117) 10)
              ((9 into 98) 12)
              ((11 into 168) 6)
              ((12 into 167) 6)
              ((9 into 115) 10)
              ((12 into 120) 4)
              ((12 into 113) 4)
              ((9 into 114) 8)
              ((11 into 164) 2)
              ((12 into 112) 7)
              ((12 into 162) 2)
              ((12 into 161) 2)
              ((16 into 98) 1)
              ((16 into 92) 1)
              ((16 into 91) 1)
              ((16 into 188) 1)
              ((16 into 123) 1)
              ((11 into 160) 2)
              ((14 into 89) 3)
              ((11 into 96) 8)
              ((10 into 122) 6)
              ((4 into 97) 7)
              ((7 into 143) 7)
              ((5 into 111) 10)
              ((8 into 137) 4)
              ((8 into 142) 5)
              ((6 into 187) 6)
              ((16 into 84) 1)
              ((16 into 109) 1)
              ((16 into 108) 1)
              ((16 into 157) 1)
              ((16 into 75) 1)
              ((16 into 186) 1)
              ((16 into 94) 1)
              ((9 into 138) 10)
              ((10 into 137) 3)
              ((15 into 80) 2)
              ((15 into 82) 4)
              ((15 into 84) 3)
              ((10 into 141) 3)
              ((9 into 185) 2)
              ((16 into 83) 2)
              ((10 into 185) 2)
              ((10 into 111) 11)
              ((4 into 133) 2)
              ((6 into 184) 1)
              ((11 into 132) 1)
              ((11 into 184) 2)
              ((12 into 131) 3)
              ((12 into 183) 2)
              ((3 into 104) 4)
              ((8 into 182) 2)
              ((5 into 181) 7)
              ((5 into 180) 4)
              ((4 into 101) 12)
              ((5 into 160) 3)
              ((6 into 159) 6)
              ((6 into 105) 8)
              ((5 into 179) 5)
              ((6 into 178) 6)
              ((6 into 103) 14)
              ((6 into 135) 5)
              ((4 into 177) 3)
              ((4 into 128) 7)
              ((15 into 53) 3)
              ((15 into 74) 7)
              ((15 into 69) 3)
              ((9 into 119) 10)
              ((9 into 176) 2)
              ((9 into 127) 7)
              ((11 into 126) 5)
              ((11 into 175) 3)
              ((3 into 103) 4)
              ((8 into 144) 3)
              ((9 into 143) 2)
              ((15 into 70) 11)
              ((8 into 125) 4)
              ((8 into 174) 5)
              ((5 into 118) 8)
              ((4 into 102) 11)
              ((9 into 124) 8)
              ((9 into 173) 2)
              ((5 into 102) 12)
              ((5 into 159) 4)
              ((6 into 158) 6)
              ((21 into 37) 1)
              ((21 into 87) 1)
              ((21 into 43) 2)
              ((21 into 90) 1)
              ((21 into 172) 1)
              ((21 into 27) 1)
              ((21 into 62) 1)
              ((21 into 40) 2)
              ((21 into 54) 1)
              ((21 into 66) 1)
              ((21 into 38) 1)
              ((21 into 29) 1)
              ((21 into 11) 1)
              ((21 into 69) 1)
              ((21 into 71) 1)
              ((21 into 142) 1)
              ((21 into 9) 1)
              ((21 into 14) 1)
              ((9 into 171) 4)
              ((12 into 170) 3)
              ((9 into 122) 6)
              ((9 into 169) 7)
              ((9 into 130) 5)
              ((6 into 128) 8)
              ((2 into 80) 6)
              ((8 into 135) 7)
              ((12 into 115) 4)
              ((12 into 168) 2)
              ((8 into 167) 5)
              ((6 into 123) 6)
              ((4 into 123) 7)
              ((9 into 135) 1)
              ((9 into 158) 6)
              ((9 into 167) 4)
              ((5 into 121) 6)
              ((6 into 121) 8)
              ((5 into 120) 5)
              ((3 into 119) 3)
              ((5 into 96) 9)
              ((13 into 118) 4)
              ((13 into 113) 8)
              ((13 into 117) 6)
              ((5 into 116) 9)
              ((3 into 114) 4)
              ((10 into 136) 7)
              ((5 into 135) 8)
              ((7 into 132) 7)
              ((2 into 92) 3)
              ((11 into 111) 4)
              ((4 into 131) 3)
              ((4 into 140) 3)
              ((12 into 166) 2)
              ((10 into 133) 7)
              ((3 into 130) 4)
              ((12 into 165) 2)
              ((12 into 164) 2)
              ((2 into 91) 2)
              ((14 into 79) 4)
              ((15 into 77) 5)
              ((15 into 78) 4)
              ((15 into 81) 3)
              ((7 into 158) 8)
              ((7 into 140) 7)
              ((2 into 89) 1)
              ((8 into 158) 8)
              ((8 into 121) 11)
              ((8 into 140) 7)
              ((9 into 139) 6)
              ((8 into 164) 4)
              ((12 into 163) 2)
              ((2 into 94) 4)
              ((5 into 131) 3)
              ((5 into 129) 7)
              ((16 into 163) 1)
              ((16 into 111) 3)
              ((16 into 46) 2)
              ((16 into 54) 2)
              ((16 into 65) 5)
              ((17 into 162) 1)
              ((17 into 110) 1)
              ((17 into 48) 2)
              ((17 into 31) 2)
              ((17 into 53) 1)
              ((17 into 64) 2)
              ((17 into 66) 2)
              ((17 into 68) 2)
              ((21 into 161) 1)
              ((21 into 109) 1)
              ((21 into 44) 1)
              ((21 into 46) 2)
              ((21 into 19) 1)
              ((21 into 52) 1)
              ((21 into 65) 1)
              ((21 into 67) 2)
              ((21 into 15) 1)
              ((21 into 63) 2)
              ((21 into 30) 1)
              ((21 into 25) 1)
              ((21 into 24) 1)
              ((21 into 47) 1)
              ((21 into 45) 1)
              ((21 into 53) 1)
              ((21 into 104) 1)
              ((21 into 59) 1)
              ((21 into 57) 2)
              ((21 into 48) 1)
              ((13 into 96) 7)
              ((11 into 128) 4)
              ((11 into 138) 2)
              ((11 into 137) 4)
              ((11 into 127) 7)
              ((4 into 137) 4)
              ((13 into 160) 1)
              ((13 into 103) 11)
              ((14 into 95) 5)
              ((14 into 80) 8)
              ((2 into 73) 8)
              ((8 into 136) 5)
              ((6 into 136) 8)
              ((3 into 136) 3)
              ((10 into 159) 4)
              ((6 into 88) 12)
              ((7 into 135) 6)
              ((9 into 107) 6)
              ((7 into 134) 6)
              ((7 into 155) 8)
              ((7 into 133) 6)
              ((7 into 154) 7)
              ((3 into 133) 3)
              ((18 into 102) 3)
              ((18 into 88) 1)
              ((18 into 158) 1)
              ((18 into 90) 2)
              ((18 into 44) 1)
              ((18 into 130) 1)
              ((11 into 95) 5)
              ((4 into 106) 8)
              ((9 into 132) 5)
              ((9 into 153) 2)
              ((9 into 157) 7)
              ((5 into 98) 14)
              ((9 into 94) 8)
              ((10 into 128) 2)
              ((5 into 157) 2)
              ((6 into 156) 5)
              ((6 into 78) 22)
              ((13 into 92) 5)
              ((13 into 107) 7)
              ((13 into 86) 5)
              ((14 into 91) 5)
              ((14 into 105) 6)
              ((14 into 101) 4)
              ((14 into 87) 9)
              ((9 into 106) 10)
              ((1 into 94) 1)
              ((14 into 152) 1)
              ((13 into 151) 1)
              ((13 into 150) 1)
              ((12 into 92) 7)
              ((16 into 57) 2)
              ((16 into 149) 2)
              ((16 into 18) 3)
              ((16 into 148) 1)
              ((16 into 72) 1)
              ((14 into 71) 6)
              ((14 into 147) 3)
              ((11 into 91) 8)
              ((13 into 146) 2)
              ((13 into 145) 2)
              ((13 into 144) 3)
              ((14 into 107) 2)
              ((16 into 81) 5)
              ((16 into 106) 2)
              ((16 into 118) 1)
              ((16 into 89) 3)
              ((16 into 38) 2)
              ((16 into 52) 4)
              ((16 into 68) 4)
              ((12 into 88) 13)
              ((14 into 143) 2)
              ((11 into 105) 9)
              ((16 into 104) 2)
              ((16 into 117) 1)
              ((16 into 63) 3)
              ((16 into 19) 3)
              ((16 into 49) 5)
              ((12 into 142) 4)
              ((6 into 92) 16)
              ((11 into 78) 11)
              ((11 into 100) 9)
              ((10 into 142) 6)
              ((17 into 88) 1)
              ((17 into 78) 1)
              ((17 into 60) 2)
              ((17 into 45) 2)
              ((17 into 33) 2)
              ((17 into 85) 1)
              ((17 into 25) 2)
              ((17 into 34) 4)
              ((17 into 18) 3)
              ((17 into 62) 3)
              ((17 into 116) 1)
              ((17 into 97) 1)
              ((17 into 72) 2)
              ((17 into 65) 2)
              ((14 into 86) 8)
              ((14 into 142) 3)
              ((15 into 85) 3)
              ((15 into 141) 1)
              ((11 into 90) 15)
              ((11 into 89) 14)
              ((11 into 116) 2)
              ((11 into 104) 11)
              ((11 into 141) 5)
              ((14 into 140) 1)
              ((14 into 103) 7)
              ((1 into 48) 6)
              ((2 into 75) 9)
              ((13 into 139) 2)
              ((13 into 102) 9)
              ((11 into 93) 10)
              ((6 into 115) 14)
              ((12 into 138) 3)
              ((13 into 125) 2)
              ((12 into 91) 14)
              ((10 into 113) 8)
              ((10 into 124) 9)
              ((16 into 87) 5)
              ((16 into 115) 1)
              ((16 into 61) 1)
              ((11 into 87) 16)
              ((14 into 52) 7)
              ((12 into 111) 8)
              ((12 into 97) 13)
              ((10 into 110) 4)
              ((10 into 96) 7)
              ((9 into 99) 8)
              ((12 into 95) 13)
              ((12 into 109) 3)
              ((13 into 94) 7)
              ((13 into 108) 7)
              ((6 into 132) 10)
              ((6 into 125) 5)
              ((12 into 107) 7)
              ((12 into 93) 8)
              ((14 into 106) 3)
              ((14 into 92) 4)
              ((13 into 137) 2)
              ((12 into 136) 1)
              ((10 into 91) 17)
              ((7 into 131) 4)
              ((7 into 124) 6)
              ((9 into 90) 19)
              ((4 into 156) 1)
              ((5 into 155) 3)
              ((15 into 64) 3)
              ((15 into 122) 1)
              ((15 into 61) 2)
              ((12 into 135) 7)
              ((12 into 100) 6)
              ((13 into 134) 2)
              ((2 into 97) 1)
              ((12 into 99) 19)
              ((12 into 98) 10)
              ((13 into 133) 3)
              ((13 into 97) 5)
              ((13 into 82) 9)
              ((11 into 81) 9)
              ((10 into 97) 9)
              ((13 into 132) 6)
              ((2 into 98) 1)
              ((2 into 99) 1)
              ((2 into 100) 1)
              ((13 into 55) 15)
              ((10 into 82) 14)
              ((14 into 84) 4)
              ((14 into 132) 3)
              ((15 into 83) 2)
              ((15 into 131) 2)
              ((13 into 71) 10)
              ((13 into 81) 13)
              ((16 into 73) 4)
              ((16 into 66) 3)
              ((16 into 59) 3)
              ((16 into 56) 2)
              ((16 into 62) 3)
              ((16 into 74) 3)
              ((16 into 69) 4)
              ((16 into 76) 6)
              ((16 into 79) 3)
              ((9 into 92) 14)
              ((9 into 74) 21)
              ((11 into 84) 11)
              ((3 into 110) 2)
              ((13 into 83) 10)
              ((11 into 82) 18)
              ((18 into 47) 4)
              ((18 into 17) 2)
              ((18 into 77) 1)
              ((18 into 49) 3)
              ((18 into 31) 1)
              ((18 into 70) 2)
              ((18 into 58) 3)
              ((18 into 60) 1)
              ((18 into 53) 2)
              ((18 into 55) 1)
              ((18 into 68) 3)
              ((18 into 42) 2)
              ((18 into 41) 4)
              ((18 into 54) 2)
              ((18 into 52) 2)
              ((18 into 59) 2)
              ((18 into 69) 5)
              ((18 into 20) 4)
              ((18 into 30) 3)
              ((18 into 29) 3)
              ((18 into 48) 7)
              ((18 into 67) 2)
              ((18 into 76) 2)
              ((18 into 38) 2)
              ((18 into 16) 1)
              ((3 into 109) 6)
              ((8 into 130) 6)
              ((7 into 107) 13)
              ((2 into 74) 3)
              ((13 into 80) 8)
              ((13 into 62) 9)
              ((13 into 64) 15)
              ((3 into 106) 6)
              ((7 into 149) 8)
              ((7 into 148) 5)
              ((6 into 147) 11)
              ((3 into 100) 11)
              ((1 into 74) 2)
              ((6 into 146) 6)
              ((2 into 72) 4)
              ((7 into 129) 3)
              ((7 into 128) 1)
              ((4 into 99) 13)
              ((1 into 71) 1)
              ((13 into 67) 10)
              ((13 into 84) 6)
              ((13 into 65) 7)
              ((12 into 73) 11)
              ((2 into 78) 11)
              ((5 into 127) 13)
              ((8 into 129) 5)
              ((12 into 72) 16)
              ((2 into 77) 6)
              ((5 into 125) 6)
              ((8 into 128) 6)
              ((15 into 79) 2)
              ((7 into 127) 8)
              ((4 into 145) 4)
              ((8 into 122) 7)
              ((8 into 126) 5)
              ((2 into 76) 6)
              ((7 into 122) 8)
              ((7 into 126) 12)
              ((6 into 145) 5)
              ((3 into 98) 13)
              ((10 into 103) 13)
              ((4 into 144) 5)
              ((9 into 121) 8)
              ((9 into 116) 8)
              ((9 into 123) 6)
              ((9 into 125) 5)
              ((8 into 120) 11)
              ((8 into 124) 10)
              ((3 into 95) 23)
              ((14 into 90) 6)
              ((14 into 83) 5)
              ((14 into 122) 2)
              ((14 into 61) 6)
              ((14 into 65) 5)
              ((14 into 85) 8)
              ((14 into 88) 6)
              ((11 into 102) 6)
              ((11 into 69) 13)
              ((8 into 87) 26)
              ((7 into 120) 9)
              ((8 into 119) 11)
              ((7 into 113) 8)
              ((7 into 118) 11)
              ((1 into 64) 2)
              ((12 into 84) 16)
              ((12 into 89) 10)
              ((12 into 117) 4)
              ((14 into 59) 8)
              ((5 into 112) 11)
              ((6 into 112) 9)
              ((6 into 119) 9)
              ((8 into 92) 15)
              ((8 into 118) 9)
              ((10 into 83) 20)
              ((5 into 143) 9)
              ((13 into 116) 5)
              ((13 into 89) 5)
              ((13 into 142) 3)
              ((16 into 36) 6)
              ((16 into 67) 5)
              ((16 into 77) 3)
              ((5 into 141) 10)
              ((15 into 97) 4)
              ((15 into 71) 9)
              ((15 into 75) 7)
              ((15 into 113) 1)
              ((15 into 111) 2)
              ((1 into 43) 2)
              ((1 into 62) 3)
              ((11 into 57) 18)
              ((11 into 97) 6)
              ((9 into 110) 12)
              ((9 into 112) 10)
              ((14 into 96) 2)
              ((14 into 70) 7)
              ((14 into 110) 1)
              ((14 into 108) 4)
              ((14 into 67) 10)
              ((7 into 117) 12)
              ((7 into 119) 9)
              ((11 into 114) 4)
              ((9 into 95) 16)
              ((4 into 118) 5)
              ((10 into 114) 7)
              ((4 into 117) 10)
              ((6 into 116) 13)
              ((7 into 109) 19)
              ((11 into 94) 8)
              ((5 into 115) 12)
              ((12 into 87) 19)
              ((10 into 140) 5)
              ((11 into 113) 5)
              ((11 into 79) 14)
              ((12 into 94) 11)
              ((14 into 63) 6)
              ((14 into 78) 12)
              ((7 into 108) 16)
              ((10 into 85) 17)
              ((10 into 139) 5)
              ((5 into 114) 9)
              ((6 into 87) 18)
              ((8 into 115) 7)
              ((2 into 61) 15)
              ((7 into 139) 10)
              ((8 into 114) 13)
              ((2 into 60) 7)
              ((6 into 72) 23)
              ((8 into 112) 12)
              ((8 into 138) 6)
              ((9 into 103) 9)
              ((9 into 109) 11)
              ((9 into 137) 4)
              ((8 into 111) 13)
              ((6 into 99) 11)
              ((8 into 105) 11)
              ((8 into 109) 8)
              ((11 into 73) 22)
              ((11 into 136) 3)
              ((11 into 83) 16)
              ((11 into 85) 21)
              ((7 into 136) 12)
              ((13 into 135) 4)
              ((13 into 99) 4)
              ((13 into 72) 11)
              ((13 into 114) 5)
              ((13 into 77) 9)
              ((9 into 84) 17)
              ((8 into 102) 14)
              ((8 into 107) 18)
              ((8 into 113) 9)
              ((5 into 97) 12)
              ((5 into 101) 16)
              ((7 into 100) 9)
              ((8 into 98) 16)
              ((7 into 112) 13)
              ((9 into 134) 9)
              ((6 into 111) 11)
              ((6 into 69) 20)
              ((8 into 134) 10)
              ((9 into 133) 3)
              ((7 into 110) 10)
              ((13 into 79) 10)
              ((11 into 134) 6)
              ((11 into 62) 27)
              ((16 into 60) 3)
              ((16 into 41) 2)
              ((16 into 4) 2)
              ((16 into 32) 6)
              ((12 into 133) 4)
              ((6 into 109) 19)
              ((13 into 78) 16)
              ((10 into 132) 7)
              ((5 into 106) 17)
              ((10 into 94) 13)
              ((10 into 131) 8)
              ((6 into 106) 13)
              ((10 into 93) 4)
              ((10 into 89) 5)
              ((10 into 104) 12)
              ((14 into 130) 1)
              ((14 into 129) 1)
              ((5 into 105) 15)
              ((5 into 103) 11)
              ((14 into 128) 1)
              ((14 into 127) 3)
              ((4 into 105) 8)
              ((10 into 126) 5)
              ((3 into 107) 5)
              ((11 into 92) 11)
              ((9 into 91) 13)
              ((8 into 101) 5)
              ((8 into 86) 14)
              ((8 into 90) 17)
              ((12 into 125) 5)
              ((12 into 85) 12)
              ((8 into 88) 18)
              ((8 into 156) 7)
              ((14 into 57) 14)
              ((6 into 155) 5)
              ((6 into 76) 17)
              ((9 into 154) 5)
              ((9 into 102) 9)
              ((12 into 124) 3)
              ((7 into 153) 8)
              ((6 into 153) 7)
              ((9 into 152) 6)
              ((9 into 101) 10)
              ((12 into 123) 6)
              ((2 into 106) 5)
              ((5 into 151) 6)
              ((5 into 71) 19)
              ((5 into 150) 4)
              ((4 into 100) 11)
              ((6 into 150) 9)
              ((9 into 100) 16)
              ((9 into 149) 5)
              ((12 into 122) 5)
              ((5 into 148) 7)
              ((5 into 147) 8)
              ((5 into 146) 5)
              ((5 into 99) 10)
              ((12 into 121) 3)
              ((12 into 80) 19)
              ((8 into 145) 7)
              ((7 into 144) 7)
              ((10 into 112) 10)
              ((8 into 143) 4)
              ((14 into 97) 5)
              ((14 into 77) 11)
              ((14 into 120) 1)
              ((4 into 142) 6)
              ((11 into 112) 6)
              ((9 into 111) 8)
              ((13 into 110) 5)
              ((13 into 58) 17)
              ((8 into 85) 21)
              ((10 into 119) 6)
              ((4 into 141) 8)
              ((5 into 140) 6)
              ((12 into 110) 8)
              ((10 into 101) 8)
              ((7 into 95) 14)
              ((11 into 119) 8)
              ((6 into 139) 8)
              ((9 into 108) 9)
              ((10 into 108) 14)
              ((12 into 119) 3)
              ((7 into 138) 6)
              ((7 into 137) 8)
              ((4 into 138) 6)
              ((13 into 119) 3)
              ((5 into 137) 6)
              ((5 into 136) 4)
              ((13 into 98) 7)
              ((13 into 87) 8)
              ((14 into 119) 1)
              ((14 into 48) 11)
              ((9 into 97) 14)
              ((10 into 135) 3)
              ((15 into 118) 2)
              ((15 into 47) 6)
              ((10 into 134) 7)
              ((5 into 133) 7)
              ((11 into 107) 5)
              ((10 into 68) 16)
              ((5 into 132) 5)
              ((8 into 80) 15)
              ((8 into 131) 5)
              ((9 into 63) 26)
              ((5 into 130) 5)
              ((10 into 106) 10)
              ((9 into 118) 10)
              ((10 into 117) 5)
              ((8 into 96) 10)
              ((4 into 129) 3)
              ((5 into 128) 5)
              ((13 into 105) 11)
              ((6 into 117) 14)
              ((10 into 95) 6)
              ((10 into 127) 3)
              ((4 into 126) 1)
              ((12 into 104) 11)
              ((12 into 82) 18)
              ((12 into 103) 11)
              ((12 into 81) 13)
              ((6 into 126) 8)
              ((6 into 100) 15)
              ((6 into 95) 12)
              ((7 into 94) 21)
              ((7 into 92) 21)
              ((7 into 99) 14)
              ((7 into 125) 14)
              ((5 into 124) 7)
              ((11 into 103) 8)
              ((6 into 124) 11)
              ((7 into 93) 17)
              ((12 into 66) 18)
              ((7 into 123) 11)
              ((5 into 122) 9)
              ((7 into 121) 12)
              ((15 into 39) 9)
              ((9 into 120) 5)
              ((9 into 89) 18)
              ((8 into 93) 16)
              ((8 into 116) 12)
              ((12 into 65) 21)
              ((5 into 119) 7)
              ((12 into 102) 6)
              ((5 into 90) 18)
              ((13 into 101) 9)
              ((13 into 57) 16)
              ((10 into 115) 7)
              ((7 into 91) 14)
              ((7 into 114) 14)
              ((16 into 22) 7)
              ((16 into 34) 4)
              ((16 into 20) 4)
              ((6 into 98) 14)
              ((6 into 79) 20)
              ((6 into 118) 8)
              ((5 into 117) 14)
              ((4 into 90) 15)
              ((4 into 88) 12)
              ((7 into 97) 13)
              ((7 into 116) 9)
              ((7 into 115) 10)
              ((6 into 77) 11)
              ((6 into 114) 14)
              ((5 into 78) 19)
              ((10 into 87) 9)
              ((5 into 113) 12)
              ((4 into 112) 14)
              ((7 into 111) 11)
              ((2 into 96) 7)
              ((2 into 70) 9)
              ((8 into 110) 21)
              ((9 into 86) 27)
              ((6 into 108) 21)
              ((6 into 94) 17)
              ((6 into 107) 18)
              ((6 into 93) 17)
              ((7 into 106) 11)
              ((10 into 92) 13)
              ((10 into 109) 10)
              ((9 into 87) 21)
              ((9 into 105) 12)
              ((8 into 91) 19)
              ((8 into 108) 14)
              ((7 into 105) 10)
              ((7 into 85) 22)
              ((7 into 104) 17)
              ((10 into 90) 6)
              ((8 into 106) 10)
              ((8 into 89) 15)
              ((10 into 88) 7)
              ((2 into 66) 10)
              ((15 into 62) 4)
              ((4 into 103) 10)
              ((7 into 102) 10)
              ((3 into 86) 5)
              ((9 into 104) 15)
              ((9 into 85) 18)
              ((5 into 87) 14)
              ((8 into 103) 16)
              ((7 into 101) 14)
              ((5 into 100) 12)
              ((3 into 83) 9)
              ((3 into 99) 6)
              ((8 into 99) 10)
              ((7 into 98) 12)
              ((6 into 96) 18)
              ((3 into 96) 18)
              ((4 into 95) 13)
              ((10 into 61) 17)
              ((3 into 94) 11)
              ((8 into 83) 21)
              ((8 into 97) 17)
              ((9 into 96) 11)
              ((9 into 79) 24)
              ((9 into 113) 9)
              ((6 into 102) 12)
              ((8 into 95) 8)
              ((8 into 82) 16)
              ((5 into 94) 15)
              ((4 into 93) 17)
              ((4 into 92) 13)
              ((6 into 91) 14)
              ((16 into 42) 4)
              ((16 into 45) 4)
              ((16 into 80) 1)
              ((16 into 93) 1)
              ((16 into 29) 5)
              ((16 into 78) 4)
              ((16 into 51) 3)
              ((16 into 112) 2)
              ((16 into 30) 6)
              ((5 into 93) 15)
              ((4 into 111) 7)
              ((6 into 110) 13)
              ((11 into 76) 23)
              ((3 into 93) 13)
              ((4 into 109) 12)
              ((6 into 101) 20)
              ((4 into 108) 5)
              ((8 into 100) 18)
              ((5 into 107) 13)
              ((15 into 36) 12)
              ((16 into 55) 3)
              ((16 into 25) 3)
              ((16 into 27) 9)
              ((16 into 39) 8)
              ((16 into 50) 3)
              ((16 into 48) 4)
              ((16 into 31) 8)
              ((16 into 35) 13)
              ((3 into 90) 7)
              ((5 into 89) 25)
              ((14 into 55) 13)
              ((14 into 66) 10)
              ((15 into 66) 5)
              ((15 into 65) 5)
              ((15 into 54) 9)
              ((7 into 87) 15)
              ((10 into 107) 11)
              ((11 into 106) 9)
              ((7 into 86) 22)
              ((7 into 79) 23)
              ((6 into 74) 22)
              ((8 into 74) 24)
              ((14 into 60) 8)
              ((10 into 105) 15)
              ((8 into 104) 15)
              ((5 into 104) 13)
              ((15 into 59) 6)
              ((5 into 86) 17)
              ((15 into 51) 7)
              ((6 into 86) 17)
              ((6 into 104) 21)
              ((5 into 84) 14)
              ((3 into 88) 13)
              ((7 into 83) 20)
              ((7 into 103) 17)
              ((5 into 83) 26)
              ((9 into 72) 23)
              ((6 into 82) 22)
              ((11 into 66) 21)
              ((15 into 57) 3)
              ((11 into 75) 20)
              ((11 into 99) 10)
              ((10 into 98) 12)
              ((11 into 98) 5)
              ((3 into 97) 15)
              ((13 into 75) 15)
              ((4 into 96) 10)
              ((14 into 73) 7)
              ((6 into 80) 21)
              ((12 into 96) 12)
              ((13 into 95) 9)
              ((12 into 64) 14)
              ((16 into 3) 1)
              ((16 into 16) 2)
              ((16 into 47) 5)
              ((16 into 64) 4)
              ((13 into 63) 16)
              ((15 into 56) 8)
              ((15 into 37) 12)
              ((4 into 79) 18)
              ((2 into 93) 2)
              ((3 into 92) 7)
              ((4 into 91) 15)
              ((17 into 20) 5)
              ((17 into 63) 2)
              ((17 into 8) 1)
              ((17 into 47) 3)
              ((17 into 16) 2)
              ((17 into 3) 1)
              ((17 into 10) 2)
              ((17 into 22) 4)
              ((18 into 19) 5)
              ((18 into 62) 2)
              ((18 into 7) 1)
              ((18 into 46) 3)
              ((18 into 15) 1)
              ((18 into 2) 1)
              ((18 into 9) 2)
              ((18 into 21) 3)
              ((18 into 74) 2)
              ((12 into 71) 15)
              ((8 into 79) 14)
              ((15 into 50) 5)
              ((8 into 78) 15)
              ((2 into 90) 3)
              ((9 into 73) 22)
              ((9 into 78) 18)
              ((13 into 70) 9)
              ((7 into 75) 19)
              ((10 into 76) 18)
              ((10 into 102) 10)
              ((10 into 70) 18)
              ((14 into 58) 11)
              ((14 into 75) 11)
              ((14 into 72) 10)
              ((5 into 70) 28)
              ((12 into 74) 14)
              ((4 into 84) 25)
              ((10 into 62) 23)
              ((13 into 68) 11)
              ((6 into 90) 18)
              ((13 into 74) 14)
              ((7 into 89) 14)
              ((14 into 74) 12)
              ((15 into 72) 7)
              ((12 into 61) 23)
              ((6 into 83) 16)
              ((6 into 89) 16)
              ((12 into 77) 19)
              ((12 into 101) 5)
              ((12 into 63) 22)
              ((14 into 76) 10)
              ((14 into 82) 5)
              ((14 into 54) 8)
              ((14 into 62) 7)
              ((13 into 60) 10)
              ((5 into 88) 17)
              ((7 into 88) 20)
              ((3 into 81) 12)
              ((11 into 61) 28)
              ((11 into 53) 27)
              ((14 into 69) 7)
              ((15 into 68) 3)
              ((11 into 72) 14)
              ((10 into 100) 14)
              ((10 into 99) 17)
              ((11 into 46) 35)
              ((3 into 85) 13)
              ((4 into 98) 12)
              ((6 into 97) 9)
              ((5 into 85) 18)
              ((6 into 85) 20)
              ((6 into 84) 31)
              ((14 into 68) 16)
              ((15 into 67) 4)
              ((15 into 46) 6)
              ((8 into 84) 18)
              ((10 into 69) 24)
              ((7 into 84) 19)
              ((12 into 51) 33)
              ((11 into 65) 28)
              ((11 into 68) 20)
              ((9 into 83) 10)
              ((13 into 51) 23)
              ((14 into 64) 14)
              ((11 into 71) 21)
              ((12 into 70) 15)
              ((4 into 75) 17)
              ((4 into 81) 17)
              ((5 into 76) 28)
              ((1 into 45) 7)
              ((7 into 96) 19)
              ((3 into 75) 10)
              ((10 into 67) 20)
              ((9 into 80) 25)
              ((9 into 75) 22)
              ((3 into 80) 11)
              ((3 into 79) 13)
              ((3 into 66) 24)
              ((5 into 77) 30)
              ((5 into 82) 30)
              ((10 into 74) 20)
              ((12 into 67) 14)
              ((1 into 38) 4)
              ((5 into 95) 26)
              ((1 into 73) 1)
              ((13 into 66) 10)
              ((3 into 73) 16)
              ((4 into 94) 19)
              ((8 into 73) 24)
              ((7 into 73) 31)
              ((8 into 94) 11)
              ((8 into 68) 17)
              ((9 into 93) 18)
              ((9 into 67) 16)
              ((1 into 30) 6)
              ((5 into 92) 24)
              ((5 into 75) 24)
              ((8 into 47) 37)
              ((14 into 50) 17)
              ((5 into 91) 14)
              ((15 into 58) 4)
              ((15 into 49) 7)
              ((15 into 73) 11)
              ((15 into 63) 4)
              ((15 into 42) 13)
              ((15 into 25) 19)
              ((3 into 59) 24)
              ((7 into 90) 23)
              ((8 into 76) 26)
              ((8 into 50) 35)
              ((4 into 89) 11)
              ((7 into 82) 23)
              ((9 into 88) 18)
              ((9 into 64) 29)
              ((6 into 81) 33)
              ((2 into 71) 10)
              ((4 into 87) 10)
              ((4 into 86) 14)
              ((3 into 64) 22)
              ((3 into 71) 18)
              ((10 into 78) 15)
              ((11 into 77) 19)
              ((11 into 63) 19)
              ((12 into 69) 9)
              ((12 into 76) 17)
              ((8 into 71) 22)
              ((8 into 53) 34)
              ((7 into 80) 25)
              ((7 into 74) 27)
              ((14 into 49) 12)
              ((15 into 48) 4)
              ((10 into 64) 24)
              ((10 into 86) 13)
              ((11 into 86) 16)
              ((8 into 77) 23)
              ((8 into 70) 13)
              ((9 into 77) 23)
              ((9 into 70) 26)
              ((9 into 69) 28)
              ((9 into 76) 19)
              ((12 into 68) 11)
              ((12 into 75) 10)
              ((11 into 59) 30)
              ((10 into 63) 21)
              ((10 into 79) 12)
              ((10 into 73) 20)
              ((7 into 78) 23)
              ((7 into 72) 26)
              ((12 into 86) 11)
              ((13 into 61) 13)
              ((13 into 53) 22)
              ((13 into 85) 8)
              ((11 into 67) 20)
              ((11 into 74) 16)
              ((13 into 73) 15)
              ((10 into 84) 12)
              ((10 into 57) 35)
              ((10 into 66) 30)
              ((10 into 72) 20)
              ((9 into 65) 30)
              ((10 into 65) 22)
              ((10 into 71) 16)
              ((11 into 64) 23)
              ((11 into 70) 18)
              ((2 into 69) 10)
              ((12 into 83) 11)
              ((9 into 82) 19)
              ((6 into 70) 27)
              ((12 into 56) 23)
              ((12 into 52) 24)
              ((12 into 90) 9)
              ((2 into 63) 12)
              ((3 into 89) 7)
              ((11 into 88) 18)
              ((2 into 65) 11)
              ((8 into 69) 25)
              ((15 into 32) 18)
              ((4 into 69) 26)
              ((6 into 64) 24)
              ((2 into 88) 9)
              ((3 into 87) 9)
              ((7 into 77) 21)
              ((8 into 55) 28)
              ((15 into 44) 12)
              ((2 into 87) 4)
              ((10 into 59) 41)
              ((9 into 46) 34)
              ((9 into 68) 31)
              ((15 into 15) 18)
              ((15 into 45) 9)
              ((15 into 41) 14)
              ((15 into 24) 22)
              ((15 into 29) 13)
              ((15 into 23) 15)
              ((16 into 37) 7)
              ((16 into 33) 5)
              ((16 into 21) 6)
              ((16 into 10) 6)
              ((16 into 17) 7)
              ((16 into 44) 6)
              ((16 into 23) 12)
              ((16 into 8) 4)
              ((16 into 15) 3)
              ((16 into 43) 5)
              ((2 into 86) 8)
              ((2 into 55) 16)
              ((4 into 85) 20)
              ((7 into 76) 21)
              ((8 into 75) 25)
              ((5 into 74) 24)
              ((8 into 66) 24)
              ((2 into 85) 2)
              ((5 into 73) 32)
              ((7 into 81) 22)
              ((14 into 44) 19)
              ((3 into 84) 10)
              ((4 into 83) 18)
              ((15 into 43) 9)
              ((15 into 27) 17)
              ((15 into 26) 20)
              ((15 into 20) 24)
              ((8 into 81) 17)
              ((1 into 34) 10)
              ((4 into 65) 26)
              ((3 into 82) 11)
              ((9 into 81) 28)
              ((1 into 40) 8)
              ((10 into 81) 14)
              ((14 into 43) 20)
              ((10 into 80) 22)
              ((8 into 60) 34)
              ((9 into 59) 26)
              ((9 into 60) 26)
              ((11 into 80) 19)
              ((12 into 79) 10)
              ((12 into 32) 33)
              ((12 into 48) 21)
              ((12 into 54) 21)
              ((2 into 59) 24)
              ((5 into 72) 33)
              ((2 into 81) 5)
              ((4 into 82) 15)
              ((12 into 78) 13)
              ((2 into 82) 6)
              ((5 into 81) 19)
              ((10 into 77) 18)
              ((13 into 76) 17)
              ((13 into 50) 28)
              ((5 into 80) 26)
              ((10 into 75) 22)
              ((12 into 47) 35)
              ((13 into 46) 27)
              ((4 into 74) 13)
              ((12 into 62) 24)
              ((6 into 71) 32)
              ((4 into 73) 16)
              ((4 into 80) 18)
              ((4 into 72) 25)
              ((5 into 79) 18)
              ((8 into 72) 20)
              ((9 into 66) 15)
              ((9 into 41) 44)
              ((9 into 71) 36)
              ((4 into 70) 24)
              ((4 into 78) 23)
              ((8 into 65) 31)
              ((9 into 62) 36)
              ((3 into 77) 13)
              ((7 into 70) 24)
              ((7 into 69) 26)
              ((3 into 76) 13)
              ((3 into 78) 12)
              ((4 into 77) 22)
              ((4 into 76) 16)
              ((4 into 60) 33)
              ((1 into 31) 6)
              ((6 into 75) 16)
              ((6 into 56) 31)
              ((3 into 74) 11)
              ((8 into 58) 32)
              ((6 into 73) 20)
              ((3 into 72) 15)
              ((6 into 61) 35)
              ((9 into 57) 36)
              ((9 into 58) 38)
              ((12 into 60) 29)
              ((7 into 71) 23)
              ((4 into 71) 23)
              ((3 into 70) 25)
              ((5 into 69) 22)
              ((13 into 59) 17)
              ((15 into 22) 20)
              ((15 into 21) 18)
              ((13 into 48) 28)
              ((13 into 45) 26)
              ((13 into 69) 19)
              ((3 into 69) 19)
              ((6 into 67) 28)
              ((3 into 68) 19)
              ((2 into 67) 11)
              ((8 into 63) 29)
              ((2 into 68) 11)
              ((4 into 68) 18)
              ((8 into 62) 31)
              ((10 into 50) 36)
              ((3 into 67) 27)
              ((5 into 66) 21)
              ((7 into 62) 36)
              ((6 into 68) 22)
              ((6 into 62) 32)
              ((7 into 61) 39)
              ((8 into 54) 45)
              ((9 into 53) 31)
              ((3 into 65) 21)
              ((6 into 65) 39)
              ((10 into 58) 31)
              ((7 into 68) 28)
              ((8 into 67) 29)
              ((8 into 64) 40)
              ((6 into 59) 29)
              ((12 into 35) 34)
              ((13 into 34) 31)
              ((14 into 53) 7)
              ((10 into 56) 32)
              ((13 into 37) 32)
              ((13 into 33) 27)
              ((12 into 41) 36)
              ((13 into 40) 25)
              ((15 into 14) 28)
              ((15 into 52) 7)
              ((5 into 59) 30)
              ((12 into 37) 34)
              ((12 into 57) 22)
              ((13 into 56) 22)
              ((14 into 32) 28)
              ((14 into 22) 26)
              ((15 into 55) 10)
              ((15 into 31) 22)
              ((15 into 17) 25)
              ((8 into 49) 33)
              ((6 into 57) 31)
              ((13 into 38) 19)
              ((14 into 37) 26)
              ((14 into 20) 24)
              ((4 into 57) 25)
              ((4 into 58) 29)
              ((4 into 67) 22)
              ((5 into 57) 35)
              ((5 into 67) 28)
              ((5 into 64) 38)
              ((6 into 66) 24)
              ((6 into 63) 23)
              ((9 into 51) 35)
              ((4 into 66) 22)
              ((4 into 63) 35)
              ((5 into 68) 26)
              ((2 into 53) 11)
              ((2 into 64) 10)
              ((3 into 63) 21)
              ((5 into 65) 22)
              ((5 into 62) 27)
              ((7 into 67) 25)
              ((8 into 44) 37)
              ((8 into 61) 32)
              ((4 into 64) 21)
              ((4 into 61) 22)
              ((7 into 66) 37)
              ((7 into 56) 27)
              ((7 into 65) 42)
              ((7 into 55) 44)
              ((9 into 61) 32)
              ((6 into 60) 29)
              ((12 into 49) 31)
              ((12 into 46) 37)
              ((12 into 59) 33)
              ((7 into 49) 43)
              ((7 into 60) 32)
              ((8 into 59) 34)
              ((8 into 42) 37)
              ((2 into 52) 15)
              ((5 into 53) 47)
              ((6 into 45) 32)
              ((7 into 64) 26)
              ((7 into 54) 47)
              ((12 into 42) 33)
              ((12 into 28) 47)
              ((13 into 41) 31)
              ((13 into 52) 20)
              ((7 into 63) 33)
              ((14 into 47) 15)
              ((14 into 21) 33)
              ((14 into 42) 14)
              ((14 into 51) 15)
              ((14 into 33) 20)
              ((5 into 58) 38)
              ((2 into 58) 13)
              ((4 into 62) 26)
              ((11 into 58) 33)
              ((12 into 58) 27)
              ((5 into 63) 25)
              ((5 into 61) 33)
              ((5 into 60) 31)
              ((16 into 24) 4)
              ((16 into 26) 8)
              ((16 into 14) 8)
              ((16 into 40) 6)
              ((16 into 28) 5)
              ((16 into 12) 5)
              ((16 into 9) 4)
              ((16 into 13) 4)
              ((16 into 58) 3)
              ((16 into 6) 4)
              ((16 into 11) 8)
              ((3 into 62) 21)
              ((17 into 26) 3)
              ((17 into 14) 2)
              ((17 into 40) 1)
              ((17 into 28) 2)
              ((17 into 12) 2)
              ((17 into 9) 4)
              ((17 into 13) 3)
              ((17 into 58) 3)
              ((17 into 6) 4)
              ((17 into 11) 4)
              ((17 into 24) 2)
              ((18 into 25) 2)
              ((18 into 13) 3)
              ((18 into 39) 4)
              ((18 into 27) 1)
              ((18 into 11) 3)
              ((18 into 8) 4)
              ((18 into 12) 3)
              ((18 into 57) 3)
              ((18 into 5) 4)
              ((18 into 10) 4)
              ((18 into 23) 2)
              ((18 into 24) 1)
              ((11 into 56) 28)
              ((13 into 32) 22)
              ((7 into 59) 20)
              ((11 into 55) 26)
              ((11 into 49) 36)
              ((10 into 55) 38)
              ((12 into 36) 32)
              ((1 into 24) 11)
              ((1 into 56) 3)
              ((7 into 51) 45)
              ((7 into 58) 31)
              ((11 into 48) 37)
              ((2 into 62) 12)
              ((7 into 57) 35)
              ((8 into 52) 42)
              ((9 into 42) 43)
              ((3 into 61) 27)
              ((11 into 43) 26)
              ((10 into 51) 26)
              ((5 into 56) 30)
              ((10 into 54) 37)
              ((8 into 43) 37)
              ((14 into 31) 18)
              ((14 into 36) 12)
              ((14 into 19) 23)
              ((12 into 50) 31)
              ((13 into 49) 23)
              ((15 into 30) 17)
              ((15 into 35) 13)
              ((15 into 18) 26)
              ((15 into 40) 13)
              ((11 into 54) 27)
              ((12 into 43) 39)
              ((12 into 53) 26)
              ((10 into 53) 42)
              ((3 into 60) 26)
              ((5 into 54) 43)
              ((11 into 52) 24)
              ((11 into 41) 47)
              ((10 into 47) 40)
              ((10 into 28) 50)
              ((10 into 46) 32)
              ((10 into 41) 45)
              ((10 into 52) 30)
              ((10 into 34) 47)
              ((11 into 51) 39)
              ((11 into 50) 26)
              ((14 into 39) 22)
              ((10 into 60) 30)
              ((11 into 60) 38)
              ((15 into 38) 15)
              ((15 into 16) 28)
              ((15 into 33) 16)
              ((15 into 3) 15)
              ((10 into 45) 47)
              ((12 into 38) 52)
              ((12 into 23) 52)
              ((12 into 39) 42)
              ((11 into 45) 35)
              ((12 into 40) 40)
              ((13 into 39) 29)
              ((13 into 44) 36)
              ((13 into 43) 26)
              ((9 into 44) 40)
              ((9 into 48) 34)
              ((9 into 47) 37)
              ((8 into 57) 31)
              ((3 into 58) 23)
              ((7 into 52) 36)
              ((14 into 38) 17)
              ((14 into 41) 27)
              ((14 into 56) 15)
              ((14 into 45) 15)
              ((14 into 40) 21)
              ((8 into 51) 28)
              ((8 into 46) 37)
              ((11 into 40) 46)
              ((11 into 37) 25)
              ((8 into 48) 40)
              ((8 into 45) 41)
              ((1 into 21) 17)
              ((11 into 44) 37)
              ((11 into 47) 32)
              ((11 into 34) 56)
              ((7 into 47) 46)
              ((9 into 56) 42)
              ((8 into 56) 41)
              ((9 into 39) 58)
              ((9 into 45) 41)
              ((8 into 33) 48)
              ((12 into 31) 35)
              ((13 into 31) 32)
              ((9 into 52) 30)
              ((3 into 57) 27)
              ((4 into 56) 33)
              ((14 into 30) 28)
              ((14 into 18) 24)
              ((14 into 24) 18)
              ((14 into 28) 20)
              ((11 into 31) 40)
              ((11 into 38) 49)
              ((11 into 32) 40)
              ((13 into 30) 32)
              ((1 into 51) 5)
              ((8 into 37) 39)
              ((9 into 50) 43)
              ((9 into 49) 41)
              ((9 into 37) 50)
              ((10 into 48) 44)
              ((8 into 32) 39)
              ((10 into 36) 48)
              ((14 into 12) 30)
              ((14 into 29) 17)
              ((14 into 11) 27)
              ((14 into 13) 28)
              ((1 into 27) 8)
              ((11 into 35) 38)
              ((11 into 29) 41)
              ((15 into 34) 11)
              ((15 into 5) 17)
              ((15 into 28) 20)
              ((15 into 10) 22)
              ((15 into 8) 20)
              ((15 into 12) 23)
              ((15 into 19) 21)
              ((1 into 42) 7)
              ((13 into 35) 22)
              ((13 into 36) 31)
              ((13 into 47) 24)
              ((14 into 34) 27)
              ((14 into 35) 21)
              ((14 into 46) 19)
              ((14 into 17) 27)
              ((14 into 27) 21)
              ((14 into 9) 35)
              ((1 into 41) 7)
              ((12 into 33) 46)
              ((12 into 34) 31)
              ((12 into 45) 37)
              ((12 into 22) 31)
              ((6 into 43) 50)
              ((8 into 36) 43)
              ((8 into 34) 39)
              ((10 into 43) 38)
              ((9 into 43) 51)
              ((11 into 42) 37)
              ((11 into 39) 37)
              ((1 into 39) 6)
              ((1 into 60) 4)
              ((10 into 42) 39)
              ((10 into 39) 37)
              ((4 into 59) 25)
              ((1 into 59) 3)
              ((6 into 58) 38)
              ((10 into 30) 39)
              ((13 into 25) 30)
              ((1 into 58) 5)
              ((1 into 26) 6)
              ((10 into 29) 49)
              ((10 into 35) 45)
              ((2 into 57) 10)
              ((12 into 30) 30)
              ((12 into 12) 52)
              ((14 into 8) 23)
              ((14 into 10) 19)
              ((14 into 14) 25)
              ((14 into 2) 32)
              ((14 into 1) 38)
              ((14 into 3) 16)
              ((11 into 28) 48)
              ((11 into 33) 44)
              ((12 into 55) 33)
              ((13 into 29) 28)
              ((13 into 18) 29)
              ((15 into 6) 11)
              ((15 into 7) 18)
              ((15 into 9) 18)
              ((15 into 13) 25)
              ((15 into 1) 28)
              ((15 into 0) 42)
              ((15 into 2) 10)
              ((15 into 4) 21)
              ((15 into 11) 21)
              ((13 into 54) 15)
              ((13 into 23) 39)
              ((9 into 55) 41)
              ((9 into 35) 59)
              ((9 into 36) 36)
              ((9 into 31) 47)
              ((9 into 54) 37)
              ((9 into 33) 62)
              ((9 into 30) 58)
              ((9 into 34) 55)
              ((9 into 27) 55)
              ((12 into 20) 30)
              ((12 into 29) 54)
              ((13 into 19) 36)
              ((13 into 28) 40)
              ((6 into 53) 38)
              ((11 into 27) 47)
              ((12 into 24) 46)
              ((12 into 27) 37)
              ((12 into 26) 40)
              ((12 into 8) 38)
              ((11 into 25) 55)
              ((13 into 27) 35)
              ((13 into 26) 39)
              ((14 into 16) 25)
              ((14 into 23) 38)
              ((14 into 26) 28)
              ((14 into 4) 16)
              ((14 into 25) 25)
              ((14 into 7) 20)
              ((14 into 5) 34)
              ((14 into 6) 32)
              ((14 into 15) 26)
              ((9 into 29) 60)
              ((9 into 26) 68)
              ((11 into 24) 60)
              ((11 into 22) 56)
              ((10 into 38) 46)
              ((11 into 26) 56)
              ((9 into 38) 47)
              ((9 into 32) 62)
              ((13 into 22) 32)
              ((11 into 23) 43)
              ((11 into 18) 57)
              ((10 into 37) 40)
              ((2 into 45) 18)
              ((11 into 36) 47)
              ((11 into 30) 43)
              ((12 into 44) 39)
              ((12 into 14) 40)
              ((12 into 25) 46)
              ((8 into 35) 51)
              ((13 into 42) 30)
              ((13 into 24) 38)
              ((8 into 41) 28)
              ((9 into 40) 50)
              ((9 into 24) 43)
              ((9 into 23) 57)
              ((12 into 11) 63)
              ((13 into 10) 58)
              ((13 into 21) 44)
              ((8 into 26) 56)
              ((9 into 25) 47)
              ((8 into 25) 55)
              ((10 into 33) 39)
              ((1 into 36) 8)
              ((1 into 35) 10)
              ((11 into 21) 59)
              ((12 into 21) 39)
              ((12 into 10) 62)
              ((13 into 20) 40)
              ((11 into 20) 53)
              ((3 into 54) 39)
              ((11 into 19) 42)
              ((8 into 24) 55)
              ((12 into 19) 46)
              ((10 into 12) 71)
              ((4 into 53) 35)
              ((5 into 52) 42)
              ((12 into 15) 57)
              ((12 into 7) 45)
              ((12 into 1) 44)
              ((12 into 18) 51)
              ((12 into 17) 41)
              ((12 into 6) 56)
              ((13 into 6) 56)
              ((13 into 13) 52)
              ((12 into 13) 49)
              ((12 into 16) 59)
              ((12 into 9) 55)
              ((12 into 4) 55)
              ((12 into 2) 47)
              ((12 into 3) 52)
              ((12 into 5) 45)
              ((8 into 23) 57)
              ((8 into 22) 54)
              ((13 into 5) 48)
              ((13 into 17) 44)
              ((13 into 15) 73)
              ((13 into 12) 45)
              ((13 into 14) 48)
              ((13 into 4) 52)
              ((13 into 9) 55)
              ((9 into 22) 56)
              ((9 into 21) 52)
              ((2 into 26) 41)
              ((10 into 25) 56)
              ((10 into 17) 63)
              ((10 into 20) 54)
              ((10 into 22) 61)
              ((8 into 10) 44)
              ((9 into 20) 51)
              ((11 into 16) 70)
              ((11 into 17) 62)
              ((9 into 11) 62)
              ((13 into 11) 48)
              ((13 into 16) 43)
              ((13 into 7) 39)
              ((13 into 2) 49)
              ((13 into 0) 42)
              ((13 into 1) 51)
              ((13 into 3) 39)
              ((13 into 8) 52)
              ((8 into 17) 57)
              ((10 into 19) 57)
              ((9 into 15) 76)
              ((9 into 19) 73)
              ((10 into 18) 64)
              ((10 into 16) 61)
              ((10 into 21) 59)
              ((11 into 13) 67)
              ((10 into 10) 78)
              ((10 into 11) 81)
              ((10 into 8) 80)
              ((10 into 7) 64)
              ((10 into 9) 60)
              ((9 into 14) 62)
              ((9 into 18) 67)
              ((11 into 8) 81)
              ((11 into 7) 65)
              ((11 into 6) 72)
              ((11 into 10) 78)
              ((11 into 9) 63)
              ((8 into 4) 32)
              ((11 into 15) 68)
              ((9 into 13) 67)
              ((9 into 28) 58)
              ((9 into 4) 36)
              ((9 into 5) 47)
              ((8 into 2) 42)
              ((8 into 3) 56)
              ((9 into 10) 61)
              ((9 into 17) 71)
              ((9 into 16) 72)
              ((9 into 9) 62)
              ((9 into 2) 65)
              ((9 into 3) 48)
              ((9 into 12) 60)
              ((10 into 26) 64)
              ((10 into 13) 51)
              ((10 into 6) 71)
              ((10 into 2) 67)
              ((10 into 4) 62)
              ((10 into 3) 41)
              ((10 into 1) 49)
              ((10 into 5) 71)
              ((11 into 12) 80)
              ((11 into 5) 70)
              ((11 into 14) 76)
              ((9 into 8) 61)
              ((9 into 6) 65)
              ((9 into 0) 30)
              ((9 into 1) 34)
              ((9 into 7) 51)
              ((11 into 11) 75)
              ((11 into 3) 63)
              ((11 into 1) 63)
              ((11 into 0) 48)
              ((11 into 2) 77)
              ((11 into 4) 65)
              ((0 into 2) 2)
              ((1 into 4) 56)
              ((2 into 0) 28)
              ((0 into 1) 24)
              ((0 into 0) 30)
              ((2 into 1) 126)
              ((7 into 37) 46)
              ((2 into 38) 30)
              ((6 into 55) 27)
              ((1 into 49) 2)
              ((2 into 51) 21)
              ((3 into 51) 45)
              ((6 into 50) 48)
              ((3 into 55) 27)
              ((1 into 20) 14)
              ((1 into 17) 19)
              ((2 into 36) 35)
              ((7 into 48) 50)
              ((6 into 52) 43)
              ((1 into 32) 6)
              ((2 into 33) 31)
              ((1 into 19) 18)
              ((5 into 51) 49)
              ((7 into 46) 47)
              ((10 into 14) 57)
              ((10 into 32) 66)
              ((10 into 40) 40)
              ((10 into 23) 57)
              ((10 into 27) 66)
              ((10 into 24) 46)
              ((10 into 31) 54)
              ((10 into 49) 34)
              ((10 into 15) 62)
              ((10 into 44) 38)
              ((6 into 40) 31)
              ((1 into 22) 8)
              ((2 into 35) 29)
              ((7 into 38) 52)
              ((7 into 42) 51)
              ((6 into 48) 35)
              ((1 into 11) 41)
              ((4 into 42) 44)
              ((1 into 18) 12)
              ((2 into 30) 31)
              ((1 into 28) 8)
              ((1 into 8) 44)
              ((2 into 39) 32)
              ((2 into 47) 24)
              ((5 into 46) 42)
              ((5 into 45) 46)
              ((1 into 12) 38)
              ((7 into 41) 36)
              ((8 into 16) 73)
              ((8 into 40) 43)
              ((8 into 31) 55)
              ((8 into 28) 53)
              ((8 into 39) 38)
              ((8 into 29) 58)
              ((6 into 39) 54)
              ((3 into 38) 44)
              ((3 into 40) 39)
              ((3 into 32) 56)
              ((5 into 40) 46)
              ((4 into 41) 41)
              ((5 into 33) 56)
              ((5 into 41) 42)
              ((6 into 31) 41)
              ((2 into 9) 78)
              ((3 into 30) 61)
              ((1 into 7) 37)
              ((3 into 39) 39)
              ((1 into 5) 55)
              ((1 into 6) 51)
              ((0 into 3) 3)
              ((1 into 23) 16)
              ((1 into 14) 23)
              ((1 into 25) 12)
              ((1 into 10) 37)
              ((1 into 29) 9)
              ((1 into 15) 20)
              ((2 into 29) 36)
              ((4 into 39) 41)
              ((6 into 38) 45)
              ((1 into 33) 10)
              ((1 into 16) 20)
              ((2 into 34) 28)
              ((2 into 17) 66)
              ((3 into 34) 52)
              ((3 into 33) 59)
              ((3 into 17) 92)
              ((3 into 37) 55)
              ((2 into 31) 31)
              ((4 into 37) 43)
              ((5 into 31) 67)
              ((5 into 38) 52)
              ((1 into 37) 7)
              ((2 into 40) 26)
              ((2 into 18) 61)
              ((2 into 41) 18)
              ((2 into 42) 13)
              ((3 into 41) 46)
              ((3 into 42) 47)
              ((5 into 43) 51)
              ((2 into 44) 33)
              ((3 into 26) 53)
              ((4 into 44) 44)
              ((6 into 35) 51)
              ((5 into 42) 41)
              ((2 into 43) 17)
              ((2 into 20) 52)
              ((4 into 43) 56)
              ((4 into 35) 38)
              ((1 into 46) 1)
              ((1 into 9) 33)
              ((4 into 50) 38)
              ((4 into 24) 57)
              ((2 into 37) 26)
              ((3 into 50) 37)
              ((3 into 20) 71)
              ((4 into 48) 53)
              ((4 into 18) 74)
              ((4 into 47) 43)
              ((4 into 27) 69)
              ((5 into 47) 58)
              ((3 into 36) 46)
              ((4 into 46) 48)
              ((4 into 36) 44)
              ((7 into 45) 45)
              ((7 into 44) 46)
              ((7 into 34) 49)
              ((5 into 44) 45)
              ((6 into 44) 44)
              ((7 into 43) 42)
              ((7 into 27) 69)
              ((1 into 50) 3)
              ((2 into 50) 13)
              ((5 into 48) 40)
              ((5 into 25) 74)
              ((5 into 35) 46)
              ((3 into 47) 38)
              ((2 into 46) 12)
              ((2 into 48) 12)
              ((2 into 27) 46)
              ((3 into 24) 58)
              ((1 into 55) 1)
              ((1 into 13) 28)
              ((2 into 56) 13)
              ((3 into 56) 33)
              ((3 into 16) 83)
              ((3 into 35) 51)
              ((4 into 54) 38)
              ((4 into 55) 39)
              ((4 into 23) 64)
              ((4 into 34) 45)
              ((5 into 55) 34)
              ((5 into 34) 54)
              ((6 into 54) 34)
              ((6 into 33) 44)
              ((7 into 53) 50)
              ((7 into 32) 67)
              ((2 into 54) 16)
              ((2 into 14) 64)
              ((3 into 53) 33)
              ((3 into 52) 38)
              ((4 into 51) 37)
              ((4 into 32) 51)
              ((4 into 30) 42)
              ((4 into 52) 43)
              ((4 into 31) 55)
              ((6 into 51) 36)
              ((6 into 30) 56)
              ((7 into 50) 36)
              ((7 into 29) 46)
              ((7 into 30) 61)
              ((5 into 50) 44)
              ((5 into 18) 68)
              ((5 into 30) 61)
              ((6 into 49) 32)
              ((6 into 29) 77)
              ((6 into 21) 43)
              ((3 into 49) 42)
              ((2 into 49) 21)
              ((4 into 49) 43)
              ((5 into 49) 34)
              ((5 into 26) 64)
              ((5 into 27) 52)
              ((3 into 25) 68)
              ((3 into 48) 32)
              ((6 into 47) 36)
              ((6 into 46) 48)
              ((6 into 23) 52)
              ((3 into 46) 36)
              ((4 into 45) 45)
              ((3 into 45) 36)
              ((3 into 22) 73)
              ((3 into 44) 42)
              ((3 into 43) 49)
              ((6 into 42) 45)
              ((6 into 26) 46)
              ((6 into 25) 49)
              ((6 into 41) 42)
              ((6 into 24) 60)
              ((7 into 40) 31)
              ((4 into 40) 48)
              ((4 into 25) 56)
              ((4 into 17) 68)
              ((5 into 39) 47)
              ((5 into 23) 79)
              ((7 into 39) 42)
              ((8 into 38) 48)
              ((8 into 18) 67)
              ((8 into 12) 73)
              ((8 into 11) 48)
              ((8 into 19) 67)
              ((8 into 21) 49)
              ((4 into 38) 50)
              ((4 into 21) 66)
              ((5 into 37) 50)
              ((5 into 20) 75)
              ((6 into 37) 40)
              ((6 into 22) 62)
              ((7 into 36) 43)
              ((7 into 20) 65)
              ((7 into 26) 55)
              ((5 into 36) 64)
              ((5 into 19) 77)
              ((6 into 36) 42)
              ((7 into 35) 60)
              ((7 into 25) 65)
              ((7 into 24) 61)
              ((6 into 34) 45)
              ((6 into 15) 64)
              ((7 into 33) 56)
              ((7 into 23) 58)
              ((7 into 22) 69)
              ((7 into 19) 50)
              ((7 into 18) 52)
              ((4 into 33) 56)
              ((4 into 12) 95)
              ((4 into 14) 83)
              ((5 into 32) 53)
              ((5 into 16) 69)
              ((6 into 32) 57)
              ((7 into 17) 61)
              ((7 into 21) 56)
              ((2 into 32) 27)
              ((3 into 31) 53)
              ((7 into 31) 44)
              ((8 into 30) 55)
              ((8 into 7) 36)
              ((8 into 5) 40)
              ((8 into 9) 50)
              ((8 into 15) 68)
              ((3 into 28) 53)
              ((2 into 28) 32)
              ((7 into 28) 65)
              ((7 into 14) 65)
              ((8 into 27) 56)
              ((8 into 14) 77)
              ((8 into 6) 64)
              ((8 into 8) 59)
              ((8 into 13) 42)
              ((8 into 1) 31)
              ((8 into 20) 52)
              ((3 into 29) 48)
              ((4 into 29) 67)
              ((5 into 29) 58)
              ((6 into 28) 62)
              ((6 into 19) 49)
              ((6 into 18) 48)
              ((6 into 14) 56)
              ((4 into 28) 55)
              ((5 into 28) 62)
              ((6 into 27) 44)
              ((6 into 16) 71)
              ((6 into 11) 58)
              ((7 into 13) 55)
              ((3 into 27) 62)
              ((7 into 15) 64)
              ((7 into 5) 69)
              ((7 into 11) 40)
              ((7 into 6) 67)
              ((7 into 12) 71)
              ((4 into 26) 64)
              ((2 into 25) 40)
              ((5 into 24) 65)
              ((2 into 24) 44)
              ((5 into 22) 65)
              ((5 into 13) 72)
              ((5 into 21) 68)
              ((5 into 14) 75)
              ((6 into 20) 52)
              ((6 into 3) 67)
              ((6 into 8) 61)
              ((6 into 12) 51)
              ((2 into 19) 56)
              ((2 into 23) 47)
              ((2 into 11) 87)
              ((2 into 12) 76)
              ((3 into 23) 80)
              ((4 into 22) 62)
              ((2 into 22) 51)
              ((2 into 21) 47)
              ((3 into 21) 60)
              ((3 into 12) 119)
              ((4 into 20) 74)
              ((3 into 19) 85)
              ((4 into 19) 69)
              ((3 into 18) 81)
              ((3 into 9) 97)
              ((5 into 17) 80)
              ((6 into 17) 65)
              ((6 into 9) 68)
              ((6 into 10) 68)
              ((6 into 2) 76)
              ((7 into 16) 62)
              ((7 into 1) 70)
              ((7 into 4) 49)
              ((7 into 10) 63)
              ((7 into 9) 59)
              ((7 into 3) 61)
              ((7 into 2) 66)
              ((7 into 7) 59)
              ((7 into 0) 72)
              ((7 into 8) 71)
              ((2 into 16) 66)
              ((4 into 16) 65)
              ((4 into 8) 120)
              ((5 into 11) 90)
              ((5 into 7) 100)
              ((3 into 15) 88)
              ((4 into 15) 83)
              ((5 into 15) 63)
              ((2 into 15) 63)
              ((2 into 8) 87)
              ((3 into 14) 77)
              ((6 into 13) 62)
              ((6 into 1) 78)
              ((6 into 6) 72)
              ((6 into 5) 48)
              ((6 into 4) 68)
              ((6 into 0) 34)
              ((6 into 7) 59)
              ((2 into 13) 88)
              ((2 into 7) 98)
              ((2 into 10) 89)
              ((4 into 13) 82)
              ((4 into 10) 86)
              ((3 into 13) 93)
              ((5 into 12) 74)
              ((5 into 1) 160)
              ((5 into 9) 85)
              ((5 into 8) 74)
              ((5 into 0) 102)
              ((3 into 11) 95)
              ((4 into 11) 103)
              ((5 into 10) 88)
              ((5 into 3) 142)
              ((5 into 6) 82)
              ((3 into 10) 122)
              ((4 into 9) 104)
              ((5 into 5) 106)
              ((5 into 2) 156)
              ((5 into 4) 125)
              ((3 into 8) 125)
              ((4 into 7) 107)
              ((4 into 3) 130)
              ((3 into 7) 139)
              ((3 into 6) 165)
              ((4 into 6) 98)
              ((4 into 5) 135)
              ((4 into 2) 166)
              ((4 into 1) 138)
              ((4 into 0) 60)
              ((4 into 4) 134)
              ((2 into 6) 106)
              ((2 into 3) 92)
              ((3 into 5) 149)
              ((2 into 5) 133)
              ((2 into 4) 125)
              ((2 into 2) 129)
              ((3 into 4) 188)
              ((3 into 3) 167)
              ((3 into 2) 226)
              ((3 into 1) 196)
              ((3 into 0) 130)
              ((1 into 3) 77)
              ((1 into 2) 85)
              ((1 into 1) 61)
              ((1 into 0) 26))
  (length 0
          (22 2)
          (17 23)
          (18 8)
          (19 9)
          (16 70)
          (15 110)
          (13 248)
          (14 192)
          (10 446)
          (12 329)
          (11 373)
          (1 59)
          (9 469)
          (8 605)
          (7 660)
          (6 906)
          (5 1003)
          (3 1031)
          (4 1297)
          (2 534))
  (by-computation 629))
 (tms
  0
  (assimilate 3871017
              ((13 into 5) 1)
              ((1 into 9) 4195)
              ((15 into 5) 63)
              ((12 into 5) 10)
              ((16 into 5) 84)
              ((11 into 5) 184)
              ((10 into 5) 28)
              ((9 into 5) 21)
              ((16 into 1) 51)
              ((2 into 9) 13904)
              ((1 into 8) 5890)
              ((14 into 5) 2)
              ((8 into 9) 26780)
              ((15 into 4) 678)
              ((13 into 4) 320)
              ((2 into 8) 31247)
              ((16 into 2) 18)
              ((9 into 4) 1007)
              ((15 into 2) 933)
              ((3 into 8) 9768)
              ((1 into 6) 18340)
              ((15 into 3) 1087)
              ((16 into 4) 110)
              ((16 into 3) 122)
              ((14 into 4) 336)
              ((14 into 1) 978)
              ((15 into 1) 682)
              ((11 into 4) 790)
              ((12 into 4) 480)
              ((13 into 3) 717)
              ((14 into 3) 920)
              ((14 into 2) 1241)
              ((13 into 1) 1671)
              ((13 into 2) 1817)
              ((12 into 3) 691)
              ((10 into 4) 1274)
              ((10 into 1) 2234)
              ((11 into 2) 2594)
              ((11 into 3) 1676)
              ((10 into 3) 3821)
              ((11 into 1) 2339)
              ((12 into 2) 1125)
              ((12 into 1) 1926)
              ((10 into 2) 3492)
              ((9 into 1) 3391)
              ((9 into 3) 2999)
              ((9 into 2) 2465)
              ((8 into 1) 27398)
              ((3 into 9) 20636)
              ((4 into 9) 267)
              ((5 into 9) 2686)
              ((5 into 8) 776)
              ((4 into 8) 4713)
              ((4 into 7) 10397)
              ((4 into 6) 15473)
              ((1 into 5) 21435)
              ((6 into 9) 5691)
              ((7 into 9) 9537)
              ((7 into 8) 25203)
              ((6 into 8) 9492)
              ((8 into 8) 26367)
              ((6 into 7) 13623)
              ((5 into 5) 26007)
              ((5 into 7) 4163)
              ((5 into 6) 18477)
              ((6 into 6) 34348)
              ((7 into 7) 23356)
              ((5 into 4) 838)
              ((8 into 7) 31)
              ((6 into 5) 116)
              ((7 into 6) 70)
              ((0 into 5) 1882)
              ((8 into 4) 507)
              ((6 into 4) 605)
              ((0 into 4) 39143)
              ((7 into 4) 649)
              ((8 into 3) 2305)
              ((8 into 2) 15432)
              ((4 into 5) 13983)
              ((5 into 3) 2117)
              ((7 into 3) 1687)
              ((7 into 1) 27115)
              ((6 into 3) 757)
              ((7 into 2) 14237)
              ((4 into 4) 18633)
              ((4 into 3) 811)
              ((6 into 2) 10708)
              ((6 into 1) 31664)
              ((5 into 1) 20044)
              ((5 into 2) 6445)
              ((4 into 2) 6352)
              ((4 into 1) 27292)
              ((1 into 7) 13884)
              ((3 into 5) 7527)
              ((3 into 7) 18744)
              ((3 into 6) 12453)
              ((2 into 7) 13457)
              ((2 into 6) 8439)
              ((3 into 2) 14614)
              ((3 into 1) 40786)
              ((3 into 4) 14470)
              ((3 into 3) 17243)
              ((0 into 3) 101311)
              ((2 into 5) 8974)
              ((2 into 4) 11900)
              ((1 into 4) 31509)
              ((0 into 2) 429876)
              ((1 into 2) 1410858)
              ((1 into 3) 34357)
              ((0 into 1) 525210)
              ((2 into 1) 44443)
              ((2 into 3) 15354)
              ((2 into 2) 32384)
              ((1 into 1) 365254)))
 (invocation 2297448 (amb-choose 201296)))
process time: 276470 (263100 RUN + 13370 GC); real time: 376879
;Value 4208: #[sudoku-board 4208]

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
;      Compiling procedure: prof:node-get-child... done
;      Compiling procedure: prof:subnode... done
;      Compiling procedure: prof:node-child-test... done
;      Compiling procedure: |#[unnamed-procedure]|... done
;      Compiling procedure: incrementation-form... done
;      Compiling procedure: node-access-form... done
;      Compiling procedure: node-access-form... done
;      Compiling procedure: prof:stats... done
;      Compiling procedure: prof:node-clean-copy... done
;      Compiling procedure: prof:show-stats... done
;      Compiling procedure: prof:reset-stats!... done
;      Compiling procedure: prof:node-reset!... done
;      Compiling procedure: prof:with-reset... 
;Warning: Possible inapplicable operator ()
;      ... done
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
;Value 4360: #[test-group 4360]

1 ]=> (set! *number-of-calls-to-fail* 0)

;Value: 63

1 ]=> (prof:show-stats)
((pairwise-union (8 (with (4 1)))
                 (5 (with (4 1) (1 7) (5 1) (2 1)))
                 (6 (with (2 1) (6 1) (1 7) (3 2)))
                 (4 (with (2 4) (1 8) (4 2) (3 4)))
                 (2 (with (5 1) (3 10) (4 2) (1 65) (2 29)))
                 (3 (with (4 2) (5 1) (2 11) (3 9) (1 37)))
                 (1 (with (8 1) (5 2) (6 1) (4 4) (3 15) (2 43) (1 242))))
 (nogood
  (by-resolution 515)
  (assimilate
   2802
   (10
    (into (14 2)
          (32 1)
          (40 1)
          (23 1)
          (27 1)
          (24 1)
          (31 1)
          (49 1)
          (15 1)
          (44 1)))
   (0 (into (14 1) (13 1) (15 1) (3 2) (22 1)))
   (8
    (into (16 1)
          (40 1)
          (31 1)
          (28 2)
          (39 1)
          (29 2)
          (38 1)
          (18 1)
          (12 1)
          (11 2)
          (19 1)
          (21 1)
          (30 2)
          (7 4)
          (5 2)
          (9 2)
          (15 4)
          (27 2)
          (14 4)
          (6 2)
          (8 3)
          (13 3)
          (1 1)
          (20 1)))
   (7
    (into (37 2)
          (48 1)
          (46 1)
          (38 4)
          (42 1)
          (41 7)
          (45 1)
          (44 1)
          (34 2)
          (43 2)
          (27 4)
          (53 2)
          (32 4)
          (50 2)
          (29 8)
          (30 3)
          (40 3)
          (39 3)
          (36 3)
          (20 9)
          (26 4)
          (35 4)
          (25 5)
          (24 4)
          (33 5)
          (23 8)
          (22 8)
          (19 10)
          (18 11)
          (17 13)
          (21 9)
          (31 8)
          (28 7)
          (14 12)
          (13 10)
          (15 14)
          (5 9)
          (11 9)
          (6 12)
          (12 10)
          (16 12)
          (1 5)
          (4 6)
          (10 13)
          (9 10)
          (3 7)
          (2 7)
          (7 13)
          (0 8)
          (8 12)))
   (6
    (into (55 1)
          (50 1)
          (52 1)
          (40 7)
          (48 2)
          (39 6)
          (31 6)
          (38 3)
          (35 7)
          (44 2)
          (54 5)
          (33 6)
          (51 5)
          (30 19)
          (49 5)
          (29 12)
          (21 10)
          (47 3)
          (46 4)
          (23 6)
          (42 7)
          (26 14)
          (25 10)
          (41 7)
          (24 13)
          (37 7)
          (22 13)
          (36 9)
          (34 10)
          (15 17)
          (32 11)
          (28 7)
          (19 14)
          (18 16)
          (14 13)
          (27 8)
          (16 20)
          (11 14)
          (20 16)
          (3 7)
          (8 23)
          (12 23)
          (17 13)
          (9 24)
          (10 14)
          (2 6)
          (13 14)
          (1 6)
          (6 8)
          (5 14)
          (4 11)
          (0 2)
          (7 16)))
   (5
    (into (51 2)
          (46 1)
          (45 2)
          (40 6)
          (33 13)
          (41 7)
          (31 9)
          (38 5)
          (43 3)
          (42 15)
          (47 3)
          (44 2)
          (48 4)
          (25 11)
          (35 9)
          (55 3)
          (34 9)
          (50 3)
          (18 13)
          (30 12)
          (49 7)
          (26 10)
          (27 13)
          (39 2)
          (23 14)
          (37 10)
          (20 11)
          (36 5)
          (19 13)
          (32 9)
          (16 7)
          (29 8)
          (28 7)
          (24 5)
          (22 13)
          (13 17)
          (21 10)
          (14 21)
          (17 14)
          (11 11)
          (7 15)
          (15 14)
          (12 24)
          (1 7)
          (9 21)
          (8 12)
          (0 7)
          (10 23)
          (3 11)
          (6 18)
          (5 9)
          (2 16)
          (4 18)))
   (4
    (into (42 13)
          (41 7)
          (39 4)
          (37 3)
          (44 8)
          (43 7)
          (35 5)
          (50 5)
          (24 8)
          (48 3)
          (18 6)
          (47 7)
          (27 14)
          (46 2)
          (36 3)
          (54 3)
          (55 2)
          (23 8)
          (34 13)
          (51 3)
          (32 8)
          (30 8)
          (52 1)
          (31 8)
          (49 3)
          (45 3)
          (40 9)
          (25 10)
          (17 17)
          (38 6)
          (21 11)
          (33 12)
          (12 14)
          (14 21)
          (29 11)
          (28 2)
          (26 8)
          (22 13)
          (20 23)
          (19 16)
          (16 7)
          (8 12)
          (15 11)
          (13 18)
          (10 22)
          (11 17)
          (9 16)
          (7 8)
          (3 6)
          (6 9)
          (5 14)
          (2 9)
          (1 10)
          (0 6)
          (4 17)))
   (2
    (into (1 1)
          (38 1)
          (51 1)
          (36 1)
          (33 4)
          (35 3)
          (30 1)
          (39 3)
          (47 2)
          (9 5)
          (29 1)
          (34 4)
          (17 8)
          (31 1)
          (40 3)
          (18 7)
          (41 2)
          (42 5)
          (44 1)
          (43 5)
          (20 4)
          (37 4)
          (50 5)
          (46 1)
          (48 2)
          (27 5)
          (56 1)
          (54 2)
          (14 15)
          (49 5)
          (32 4)
          (28 6)
          (25 7)
          (24 2)
          (19 10)
          (23 7)
          (11 9)
          (12 12)
          (22 5)
          (21 4)
          (16 7)
          (15 11)
          (8 11)
          (13 21)
          (7 14)
          (10 13)
          (6 12)
          (3 4)
          (5 7)
          (4 8)
          (2 5)))
   (3
    (into (51 1)
          (55 1)
          (38 1)
          (40 5)
          (32 1)
          (30 5)
          (39 2)
          (34 11)
          (33 7)
          (17 11)
          (37 5)
          (41 5)
          (42 6)
          (26 5)
          (50 4)
          (20 10)
          (36 3)
          (47 4)
          (24 8)
          (56 1)
          (16 7)
          (35 5)
          (53 1)
          (52 1)
          (49 5)
          (25 8)
          (48 6)
          (46 4)
          (45 6)
          (22 9)
          (44 3)
          (43 10)
          (31 6)
          (28 5)
          (29 8)
          (27 11)
          (23 5)
          (21 7)
          (12 22)
          (19 12)
          (18 6)
          (9 12)
          (15 13)
          (14 21)
          (13 16)
          (11 20)
          (10 19)
          (8 11)
          (7 17)
          (6 22)
          (5 15)
          (4 13)
          (3 9)
          (2 19)
          (1 10)
          (0 12)))
   (1
    (into (49 1)
          (20 2)
          (17 1)
          (32 1)
          (19 2)
          (22 2)
          (11 2)
          (18 3)
          (28 1)
          (8 1)
          (12 3)
          (7 3)
          (5 2)
          (6 5)
          (23 2)
          (14 6)
          (25 2)
          (10 7)
          (29 1)
          (15 7)
          (33 2)
          (16 3)
          (37 1)
          (46 1)
          (9 3)
          (50 2)
          (55 1)
          (13 11)
          (3 3)
          (2 5)
          (1 5)
          (0 5))))
  (length (11 1) (1 6) (9 5) (8 41) (7 74) (6 89) (5 102) (3 94) (4 118) (2 48))
  (by-computation 63))
 (tms
  (assimilate
   79570
   (8 (into (11 3) (8 4) (5 25) (7 10) (6 12) (4 14) (3 12) (2 3)))
   (7
    (into (11 3) (9 29) (8 24) (7 14) (6 16) (5 58) (4 76) (3 27) (1 2) (2 11)))
   (6
    (into (11 8)
          (12 150)
          (9 36)
          (8 204)
          (7 37)
          (6 46)
          (5 141)
          (4 197)
          (3 32)
          (2 29)
          (1 3)))
   (5
    (into (10 1)
          (12 196)
          (11 32)
          (9 2)
          (8 1)
          (5 51)
          (7 46)
          (6 64)
          (4 83)
          (3 23)
          (1 8)
          (2 152)))
   (4
    (into (12 72)
          (11 6)
          (10 10)
          (9 2)
          (8 1)
          (7 14)
          (6 44)
          (5 1599)
          (4 152)
          (3 17)
          (2 183)
          (1 545)))
   (3
    (into (9 1)
          (11 4)
          (10 3)
          (5 821)
          (7 9)
          (6 9)
          (2 202)
          (1 619)
          (4 933)
          (3 566)))
   (0
    (into (11 267)
          (10 8)
          (9 76)
          (8 6)
          (7 581)
          (6 965)
          (5 2051)
          (4 2366)
          (3 812)
          (2 3772)
          (1 1566)))
   (2 (into (7 22) (6 28) (5 1419) (4 593) (1 1130) (3 1516) (2 653)))
   (1 (into (5 620) (7 7) (4 926) (2 42439) (3 1430) (1 8620)))))
 (invocation 51705 (amb-choose 6180)))
;Unspecified return value

1 ]=> 
;Loading "examples/sudoku.scm"... done
;Unspecified return value

1 ]=> (show-time
 (lambda ()
   (prof:with-reset
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
	 (0 3 1 0 0 0 5 0 0)))))))


(show-time
 (lambda ()
   (prof:with-reset
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
	 (0 3 1 0 0 0 5 0 0)))))))
  C-c C-c
;Quit!

1 ]=> (show-time
 (lambda ()
   (prof:with-reset
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
	 (0 3 1 0 0 0 5 0 0)))))))
  C-c C-c
;Quit!

1 ]=> (set! *number-of-calls-to-fail* 0)

;Value: 664

1 ]=> (show-time
 (lambda ()
   (prof:with-reset
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
	 (0 3 1 0 0 0 5 0 0)))))))
327194658
846325179
519687243
172563894
653948721
498712365
764851932
985236417
231479586
((pairwise-union
  (41 (with (3 1)))
  (54 (with (3 1)))
  (47 (with (1 1)))
  (58 (with (3 1)))
  (33 (with (4 1)))
  (36 (with (4 1)))
  (28 (with (1 1) (5 1)))
  (19 (with (3 1) (12 1) (9 1) (6 1) (1 5) (2 3) (4 2)))
  (48 (with (20 1)))
  (37 (with (1 1) (6 1)))
  (38 (with (4 1) (12 1)))
  (23 (with (1 3) (3 1)))
  (20 (with (6 1) (1 6) (3 1) (5 1)))
  (24 (with (6 1) (3 1) (10 1) (5 1)))
  (34 (with (15 1) (3 1)))
  (26 (with (2 3) (1 1) (3 2) (4 2)))
  (40 (with (1 1)))
  (27 (with (3 1) (2 1) (10 1) (1 1)))
  (45 (with (15 1) (1 1)))
  (25 (with (4 1) (1 2) (2 2) (3 1)))
  (31 (with (3 1)))
  (35 (with (2 1) (3 1)))
  (30 (with (21 2) (2 3)))
  (17 (with (2 1) (11 1) (6 1) (3 3) (7 1) (15 1) (4 4) (1 9)))
  (15 (with (3 3) (17 1) (14 1) (8 2) (7 1) (5 3) (4 2) (1 16) (2 5)))
  (18 (with (5 1) (1 5) (6 1) (7 2) (4 3) (2 1)))
  (21 (with (3 1) (4 1) (1 3)))
  (22 (with (3 1) (2 2) (1 5)))
  (16 (with (11 1) (6 1) (5 1) (3 1) (2 2) (1 14)))
  (14 (with (4 1) (6 1) (7 1) (12 2) (3 2) (5 1) (1 18) (2 7)))
  (12
   (with (20 1)
         (26 1)
         (10 1)
         (6 3)
         (8 3)
         (11 1)
         (7 5)
         (5 2)
         (3 2)
         (4 5)
         (2 15)
         (1 37)))
  (9 (with (9 1) (7 2) (6 4) (11 2) (5 4) (12 2) (3 8) (4 8) (2 36) (1 67)))
  (10 (with (33 1) (20 1) (12 2) (7 3) (6 2) (5 5) (4 7) (3 9) (2 14) (1 52)))
  (13 (with (17 1) (8 1) (7 3) (4 2) (13 1) (3 4) (10 1) (5 2) (2 11) (1 36)))
  (11 (with (8 2) (7 1) (5 6) (6 3) (3 12) (4 3) (2 20) (1 40)))
  (7
   (with (28 1)
         (11 1)
         (17 1)
         (9 4)
         (10 2)
         (14 1)
         (18 1)
         (12 4)
         (7 5)
         (5 7)
         (4 17)
         (8 3)
         (6 5)
         (2 33)
         (3 27)
         (1 119)))
  (8
   (with (16 1)
         (10 2)
         (6 2)
         (11 2)
         (7 1)
         (13 1)
         (8 3)
         (9 1)
         (5 10)
         (3 16)
         (2 38)
         (1 86)
         (4 10)))
  (5
   (with (21 1)
         (13 3)
         (24 1)
         (9 7)
         (15 1)
         (8 8)
         (12 4)
         (7 9)
         (10 5)
         (6 14)
         (3 50)
         (4 29)
         (1 254)
         (5 22)
         (2 82)))
  (6
   (with (23 1)
         (13 1)
         (9 2)
         (8 8)
         (10 5)
         (4 19)
         (5 19)
         (7 9)
         (2 68)
         (6 10)
         (1 173)
         (3 26)))
  (4
   (with (12 2)
         (17 3)
         (16 1)
         (14 2)
         (15 2)
         (13 1)
         (11 3)
         (9 4)
         (8 16)
         (7 13)
         (10 5)
         (5 30)
         (6 20)
         (2 136)
         (1 318)
         (4 34)
         (3 70)))
  (2
   (with (14 1)
         (20 1)
         (26 2)
         (22 2)
         (17 1)
         (23 3)
         (21 1)
         (15 1)
         (12 4)
         (18 1)
         (19 3)
         (16 1)
         (13 3)
         (9 12)
         (11 5)
         (8 16)
         (7 18)
         (6 21)
         (10 11)
         (5 32)
         (3 124)
         (4 54)
         (1 589)
         (2 232)))
  (3
   (with (17 2)
         (13 2)
         (11 7)
         (8 8)
         (14 3)
         (10 5)
         (16 1)
         (15 4)
         (19 1)
         (7 16)
         (12 7)
         (6 17)
         (9 6)
         (4 52)
         (5 34)
         (2 178)
         (3 96)
         (1 437)))
  (1
   (with (24 1)
         (25 3)
         (22 4)
         (14 5)
         (18 4)
         (23 4)
         (20 3)
         (17 11)
         (19 5)
         (16 7)
         (10 21)
         (12 7)
         (15 10)
         (13 10)
         (11 20)
         (9 23)
         (7 50)
         (8 38)
         (5 96)
         (6 60)
         (4 137)
         (3 260)
         (2 451)
         (1 1942))))
 (nogood
  (by-resolution 7745)
  (assimilate
   55483
   (21
    (into (37 1)
          (87 1)
          (43 2)
          (90 1)
          (172 1)
          (27 1)
          (62 1)
          (40 2)
          (54 1)
          (66 1)
          (38 1)
          (29 1)
          (11 1)
          (69 1)
          (71 1)
          (142 1)
          (9 1)
          (14 1)
          (161 1)
          (109 1)
          (44 1)
          (46 2)
          (19 1)
          (52 1)
          (65 1)
          (67 2)
          (15 1)
          (63 2)
          (30 1)
          (25 1)
          (24 1)
          (47 1)
          (45 1)
          (53 1)
          (104 1)
          (59 1)
          (57 2)
          (48 1)))
   (16
    (into (155 1)
          (120 1)
          (176 1)
          (190 1)
          (347 1)
          (122 1)
          (214 1)
          (158 1)
          (172 1)
          (135 1)
          (305 1)
          (164 1)
          (293 1)
          (71 1)
          (99 2)
          (147 1)
          (150 2)
          (184 1)
          (128 1)
          (127 1)
          (125 1)
          (140 1)
          (101 2)
          (53 1)
          (98 1)
          (92 1)
          (91 1)
          (188 1)
          (123 1)
          (84 1)
          (109 1)
          (108 1)
          (157 1)
          (75 1)
          (186 1)
          (94 1)
          (83 2)
          (163 1)
          (111 3)
          (46 2)
          (54 2)
          (65 5)
          (57 2)
          (149 2)
          (18 3)
          (148 1)
          (72 1)
          (81 5)
          (106 2)
          (118 1)
          (89 3)
          (38 2)
          (52 4)
          (68 4)
          (104 2)
          (117 1)
          (63 3)
          (19 3)
          (49 5)
          (87 5)
          (115 1)
          (61 1)
          (73 4)
          (66 3)
          (59 3)
          (56 2)
          (62 3)
          (74 3)
          (69 4)
          (76 6)
          (79 3)
          (36 6)
          (67 5)
          (77 3)
          (60 3)
          (41 2)
          (4 2)
          (32 6)
          (22 7)
          (34 4)
          (20 4)
          (42 4)
          (45 4)
          (80 1)
          (93 1)
          (29 5)
          (78 4)
          (51 3)
          (112 2)
          (30 6)
          (55 3)
          (25 3)
          (27 9)
          (39 8)
          (50 3)
          (48 4)
          (31 8)
          (35 13)
          (3 1)
          (16 2)
          (47 5)
          (64 4)
          (37 7)
          (33 5)
          (21 6)
          (10 6)
          (17 7)
          (44 6)
          (23 12)
          (8 4)
          (15 3)
          (43 5)
          (24 4)
          (26 8)
          (14 8)
          (40 6)
          (28 5)
          (12 5)
          (9 4)
          (13 4)
          (58 3)
          (6 4)
          (11 8)))
   (17
    (into (133 1)
          (135 1)
          (136 1)
          (46 1)
          (117 1)
          (274 1)
          (158 1)
          (83 1)
          (86 1)
          (67 1)
          (93 1)
          (71 2)
          (127 1)
          (56 1)
          (35 1)
          (183 1)
          (126 1)
          (125 2)
          (151 1)
          (19 1)
          (61 2)
          (21 1)
          (182 1)
          (123 2)
          (122 1)
          (120 1)
          (27 1)
          (96 1)
          (150 1)
          (112 1)
          (50 1)
          (107 1)
          (70 2)
          (29 2)
          (41 3)
          (103 2)
          (59 2)
          (44 2)
          (49 1)
          (30 1)
          (42 3)
          (162 1)
          (110 1)
          (48 2)
          (31 2)
          (53 1)
          (64 2)
          (66 2)
          (68 2)
          (88 1)
          (78 1)
          (60 2)
          (45 2)
          (33 2)
          (85 1)
          (25 2)
          (34 4)
          (18 3)
          (62 3)
          (116 1)
          (97 1)
          (72 2)
          (65 2)
          (20 5)
          (63 2)
          (8 1)
          (47 3)
          (16 2)
          (3 1)
          (10 2)
          (22 4)
          (26 3)
          (14 2)
          (40 1)
          (28 2)
          (12 2)
          (9 4)
          (13 3)
          (58 3)
          (6 4)
          (11 4)
          (24 2)))
   (18
    (into (156 1)
          (215 1)
          (100 1)
          (123 1)
          (50 2)
          (112 1)
          (349 1)
          (114 1)
          (192 1)
          (152 1)
          (178 1)
          (122 1)
          (95 1)
          (160 1)
          (276 1)
          (119 1)
          (75 1)
          (135 1)
          (138 1)
          (64 1)
          (129 1)
          (73 1)
          (94 1)
          (159 2)
          (275 1)
          (118 1)
          (134 1)
          (136 1)
          (137 2)
          (63 1)
          (128 1)
          (72 2)
          (56 1)
          (43 2)
          (111 1)
          (40 2)
          (28 1)
          (106 1)
          (102 3)
          (88 1)
          (158 1)
          (90 2)
          (44 1)
          (130 1)
          (47 4)
          (17 2)
          (77 1)
          (49 3)
          (31 1)
          (70 2)
          (58 3)
          (60 1)
          (53 2)
          (55 1)
          (68 3)
          (42 2)
          (41 4)
          (54 2)
          (52 2)
          (59 2)
          (69 5)
          (20 4)
          (30 3)
          (29 3)
          (48 7)
          (67 2)
          (76 2)
          (38 2)
          (16 1)
          (19 5)
          (62 2)
          (7 1)
          (46 3)
          (15 1)
          (2 1)
          (9 2)
          (21 3)
          (74 2)
          (25 2)
          (13 3)
          (39 4)
          (27 1)
          (11 3)
          (8 4)
          (12 3)
          (57 3)
          (5 4)
          (10 4)
          (23 2)
          (24 1)))
   (15
    (into (173 1)
          (136 1)
          (307 1)
          (165 1)
          (294 1)
          (105 1)
          (132 1)
          (175 1)
          (140 1)
          (174 1)
          (104 3)
          (149 1)
          (152 1)
          (148 1)
          (150 1)
          (151 2)
          (60 2)
          (181 1)
          (120 1)
          (116 1)
          (119 2)
          (180 1)
          (183 1)
          (109 1)
          (112 2)
          (177 1)
          (95 2)
          (92 1)
          (102 2)
          (91 1)
          (96 2)
          (94 2)
          (89 2)
          (101 2)
          (144 1)
          (90 1)
          (103 2)
          (106 1)
          (86 4)
          (100 3)
          (129 1)
          (167 1)
          (201 1)
          (117 2)
          (93 1)
          (107 1)
          (193 1)
          (209 1)
          (98 2)
          (80 2)
          (82 4)
          (84 3)
          (53 3)
          (74 7)
          (69 3)
          (70 11)
          (77 5)
          (78 4)
          (81 3)
          (85 3)
          (141 1)
          (64 3)
          (122 1)
          (61 2)
          (83 2)
          (131 2)
          (79 2)
          (97 4)
          (71 9)
          (75 7)
          (113 1)
          (111 2)
          (118 2)
          (47 6)
          (39 9)
          (62 4)
          (36 12)
          (66 5)
          (65 5)
          (54 9)
          (59 6)
          (51 7)
          (57 3)
          (56 8)
          (37 12)
          (50 5)
          (72 7)
          (68 3)
          (67 4)
          (46 6)
          (58 4)
          (49 7)
          (73 11)
          (63 4)
          (42 13)
          (25 19)
          (48 4)
          (32 18)
          (44 12)
          (15 18)
          (45 9)
          (41 14)
          (24 22)
          (29 13)
          (23 15)
          (43 9)
          (27 17)
          (26 20)
          (20 24)
          (22 20)
          (21 18)
          (14 28)
          (52 7)
          (55 10)
          (31 22)
          (17 25)
          (30 17)
          (35 13)
          (18 26)
          (40 13)
          (38 15)
          (16 28)
          (33 16)
          (3 15)
          (34 11)
          (5 17)
          (28 20)
          (10 22)
          (8 20)
          (12 23)
          (19 21)
          (6 11)
          (7 18)
          (9 18)
          (13 25)
          (1 28)
          (0 42)
          (2 10)
          (4 21)
          (11 21)))
   (14
    (into (160 1)
          (229 1)
          (258 1)
          (171 1)
          (280 1)
          (158 1)
          (228 1)
          (257 1)
          (170 1)
          (278 1)
          (277 1)
          (157 1)
          (156 1)
          (292 1)
          (273 1)
          (154 1)
          (126 1)
          (291 1)
          (155 1)
          (271 1)
          (153 1)
          (290 1)
          (125 1)
          (270 1)
          (151 1)
          (150 1)
          (149 1)
          (136 1)
          (148 3)
          (146 2)
          (134 1)
          (145 2)
          (144 3)
          (141 3)
          (131 1)
          (162 1)
          (188 1)
          (178 2)
          (114 2)
          (111 2)
          (81 3)
          (112 1)
          (93 3)
          (104 1)
          (117 1)
          (113 3)
          (135 2)
          (223 1)
          (102 3)
          (98 4)
          (100 3)
          (94 2)
          (175 3)
          (89 3)
          (79 4)
          (95 5)
          (80 8)
          (91 5)
          (105 6)
          (101 4)
          (87 9)
          (152 1)
          (71 6)
          (147 3)
          (107 2)
          (143 2)
          (86 8)
          (142 3)
          (140 1)
          (103 7)
          (52 7)
          (106 3)
          (92 4)
          (84 4)
          (132 3)
          (90 6)
          (83 5)
          (122 2)
          (61 6)
          (65 5)
          (85 8)
          (88 6)
          (59 8)
          (96 2)
          (70 7)
          (110 1)
          (108 4)
          (67 10)
          (63 6)
          (78 12)
          (130 1)
          (129 1)
          (128 1)
          (127 3)
          (57 14)
          (97 5)
          (77 11)
          (120 1)
          (119 1)
          (48 11)
          (55 13)
          (66 10)
          (60 8)
          (73 7)
          (58 11)
          (75 11)
          (72 10)
          (74 12)
          (76 10)
          (82 5)
          (54 8)
          (62 7)
          (69 7)
          (68 16)
          (64 14)
          (50 17)
          (49 12)
          (44 19)
          (43 20)
          (53 7)
          (32 28)
          (22 26)
          (37 26)
          (20 24)
          (47 15)
          (21 33)
          (42 14)
          (51 15)
          (33 20)
          (31 18)
          (36 12)
          (19 23)
          (39 22)
          (38 17)
          (41 27)
          (56 15)
          (45 15)
          (40 21)
          (30 28)
          (18 24)
          (24 18)
          (28 20)
          (12 30)
          (29 17)
          (11 27)
          (13 28)
          (34 27)
          (35 21)
          (46 19)
          (17 27)
          (27 21)
          (9 35)
          (8 23)
          (10 19)
          (14 25)
          (2 32)
          (1 38)
          (3 16)
          (16 25)
          (23 38)
          (26 28)
          (4 16)
          (25 25)
          (7 20)
          (5 34)
          (6 32)
          (15 26)))
   (12
    (into (218 1)
          (276 1)
          (172 1)
          (156 1)
          (184 1)
          (250 1)
          (118 1)
          (266 1)
          (235 1)
          (169 1)
          (192 1)
          (191 1)
          (178 1)
          (141 1)
          (175 2)
          (151 1)
          (269 1)
          (146 1)
          (140 1)
          (130 2)
          (187 1)
          (186 2)
          (185 2)
          (105 5)
          (176 1)
          (145 2)
          (190 2)
          (239 1)
          (205 1)
          (232 1)
          (181 1)
          (137 2)
          (194 1)
          (171 1)
          (150 3)
          (148 1)
          (106 7)
          (108 5)
          (144 1)
          (244 1)
          (242 1)
          (114 8)
          (216 1)
          (206 1)
          (213 1)
          (134 2)
          (129 4)
          (212 1)
          (210 2)
          (132 5)
          (189 1)
          (158 1)
          (149 2)
          (127 1)
          (126 7)
          (128 7)
          (143 4)
          (167 6)
          (120 4)
          (113 4)
          (112 7)
          (162 2)
          (161 2)
          (131 3)
          (183 2)
          (170 3)
          (115 4)
          (168 2)
          (166 2)
          (165 2)
          (164 2)
          (163 2)
          (92 7)
          (88 13)
          (142 4)
          (138 3)
          (91 14)
          (111 8)
          (97 13)
          (95 13)
          (109 3)
          (107 7)
          (93 8)
          (136 1)
          (135 7)
          (100 6)
          (99 19)
          (98 10)
          (73 11)
          (72 16)
          (84 16)
          (89 10)
          (117 4)
          (87 19)
          (94 11)
          (133 4)
          (125 5)
          (85 12)
          (124 3)
          (123 6)
          (122 5)
          (121 3)
          (80 19)
          (110 8)
          (119 3)
          (104 11)
          (82 18)
          (103 11)
          (81 13)
          (66 18)
          (65 21)
          (102 6)
          (96 12)
          (64 14)
          (71 15)
          (74 14)
          (61 23)
          (77 19)
          (101 5)
          (63 22)
          (51 33)
          (70 15)
          (67 14)
          (69 9)
          (76 17)
          (68 11)
          (75 10)
          (86 11)
          (83 11)
          (56 23)
          (52 24)
          (90 9)
          (79 10)
          (32 33)
          (48 21)
          (54 21)
          (78 13)
          (47 35)
          (62 24)
          (60 29)
          (35 34)
          (41 36)
          (37 34)
          (57 22)
          (49 31)
          (46 37)
          (59 33)
          (42 33)
          (28 47)
          (58 27)
          (36 32)
          (50 31)
          (43 39)
          (53 26)
          (38 52)
          (23 52)
          (39 42)
          (40 40)
          (31 35)
          (33 46)
          (34 31)
          (45 37)
          (22 31)
          (30 30)
          (12 52)
          (55 33)
          (20 30)
          (29 54)
          (24 46)
          (27 37)
          (26 40)
          (8 38)
          (44 39)
          (14 40)
          (25 46)
          (11 63)
          (21 39)
          (10 62)
          (19 46)
          (15 57)
          (7 45)
          (1 44)
          (18 51)
          (17 41)
          (6 56)
          (13 49)
          (16 59)
          (9 55)
          (4 55)
          (2 47)
          (3 52)
          (5 45)))
   (13
    (into (217 1)
          (174 1)
          (172 1)
          (170 1)
          (156 1)
          (184 1)
          (167 2)
          (155 1)
          (169 1)
          (171 1)
          (166 2)
          (161 1)
          (185 2)
          (189 1)
          (193 1)
          (188 1)
          (192 1)
          (190 1)
          (178 1)
          (104 3)
          (275 2)
          (194 1)
          (273 1)
          (131 1)
          (115 7)
          (179 2)
          (181 2)
          (176 2)
          (123 4)
          (182 2)
          (268 1)
          (175 3)
          (112 5)
          (106 6)
          (163 2)
          (121 2)
          (162 1)
          (90 4)
          (143 3)
          (243 1)
          (122 3)
          (208 1)
          (100 6)
          (88 2)
          (173 1)
          (205 1)
          (120 3)
          (130 2)
          (91 3)
          (200 1)
          (136 2)
          (197 2)
          (109 5)
          (183 2)
          (129 2)
          (124 4)
          (127 1)
          (93 7)
          (111 2)
          (141 3)
          (118 4)
          (113 8)
          (117 6)
          (96 7)
          (160 1)
          (103 11)
          (92 5)
          (107 7)
          (86 5)
          (151 1)
          (150 1)
          (146 2)
          (145 2)
          (144 3)
          (139 2)
          (102 9)
          (125 2)
          (94 7)
          (108 7)
          (137 2)
          (134 2)
          (133 3)
          (97 5)
          (82 9)
          (132 6)
          (55 15)
          (71 10)
          (81 13)
          (83 10)
          (80 8)
          (62 9)
          (64 15)
          (67 10)
          (84 6)
          (65 7)
          (116 5)
          (89 5)
          (142 3)
          (135 4)
          (99 4)
          (72 11)
          (114 5)
          (77 9)
          (79 10)
          (78 16)
          (110 5)
          (58 17)
          (119 3)
          (98 7)
          (87 8)
          (105 11)
          (101 9)
          (57 16)
          (75 15)
          (95 9)
          (63 16)
          (70 9)
          (68 11)
          (74 14)
          (60 10)
          (51 23)
          (66 10)
          (61 13)
          (53 22)
          (85 8)
          (73 15)
          (76 17)
          (50 28)
          (46 27)
          (59 17)
          (48 28)
          (45 26)
          (69 19)
          (34 31)
          (37 32)
          (33 27)
          (40 25)
          (56 22)
          (38 19)
          (41 31)
          (52 20)
          (32 22)
          (49 23)
          (39 29)
          (44 36)
          (43 26)
          (31 32)
          (30 32)
          (35 22)
          (36 31)
          (47 24)
          (25 30)
          (29 28)
          (18 29)
          (54 15)
          (23 39)
          (19 36)
          (28 40)
          (27 35)
          (26 39)
          (22 32)
          (42 30)
          (24 38)
          (10 58)
          (21 44)
          (20 40)
          (6 56)
          (13 52)
          (5 48)
          (17 44)
          (15 73)
          (12 45)
          (14 48)
          (4 52)
          (9 55)
          (11 48)
          (16 43)
          (7 39)
          (2 49)
          (0 42)
          (1 51)
          (3 39)
          (8 52)))
   (9
    (into (277 1)
          (271 1)
          (213 1)
          (269 1)
          (268 1)
          (267 1)
          (353 1)
          (209 1)
          (339 1)
          (337 1)
          (145 1)
          (334 1)
          (332 1)
          (175 1)
          (164 1)
          (144 1)
          (186 1)
          (263 2)
          (179 2)
          (159 3)
          (234 1)
          (283 2)
          (298 1)
          (233 2)
          (232 3)
          (231 1)
          (276 1)
          (274 2)
          (155 4)
          (272 1)
          (163 2)
          (225 1)
          (206 1)
          (224 2)
          (265 1)
          (249 1)
          (248 2)
          (264 1)
          (220 2)
          (219 2)
          (196 4)
          (262 1)
          (244 2)
          (261 2)
          (161 4)
          (243 1)
          (260 2)
          (141 3)
          (256 2)
          (142 2)
          (188 1)
          (237 1)
          (200 4)
          (199 4)
          (266 2)
          (151 2)
          (195 2)
          (222 1)
          (246 3)
          (218 2)
          (217 1)
          (242 1)
          (170 6)
          (156 5)
          (241 1)
          (240 1)
          (230 3)
          (229 1)
          (228 2)
          (178 1)
          (177 2)
          (146 4)
          (201 4)
          (221 2)
          (165 7)
          (174 3)
          (189 2)
          (214 3)
          (184 1)
          (180 3)
          (136 3)
          (212 3)
          (211 3)
          (129 5)
          (202 2)
          (162 5)
          (194 1)
          (208 3)
          (160 4)
          (191 2)
          (148 4)
          (205 2)
          (131 5)
          (203 4)
          (181 1)
          (182 1)
          (150 3)
          (147 4)
          (198 3)
          (140 2)
          (193 1)
          (192 4)
          (168 5)
          (128 12)
          (126 8)
          (166 9)
          (117 10)
          (98 12)
          (115 10)
          (114 8)
          (138 10)
          (185 2)
          (119 10)
          (176 2)
          (127 7)
          (143 2)
          (124 8)
          (173 2)
          (171 4)
          (122 6)
          (169 7)
          (130 5)
          (135 1)
          (158 6)
          (167 4)
          (139 6)
          (107 6)
          (132 5)
          (153 2)
          (157 7)
          (94 8)
          (106 10)
          (99 8)
          (90 19)
          (92 14)
          (74 21)
          (121 8)
          (116 8)
          (123 6)
          (125 5)
          (110 12)
          (112 10)
          (95 16)
          (103 9)
          (109 11)
          (137 4)
          (84 17)
          (134 9)
          (133 3)
          (91 13)
          (154 5)
          (102 9)
          (152 6)
          (101 10)
          (100 16)
          (149 5)
          (111 8)
          (108 9)
          (97 14)
          (63 26)
          (118 10)
          (120 5)
          (89 18)
          (86 27)
          (87 21)
          (105 12)
          (104 15)
          (85 18)
          (96 11)
          (79 24)
          (113 9)
          (72 23)
          (73 22)
          (78 18)
          (83 10)
          (80 25)
          (75 22)
          (93 18)
          (67 16)
          (88 18)
          (64 29)
          (77 23)
          (70 26)
          (69 28)
          (76 19)
          (65 30)
          (82 19)
          (46 34)
          (68 31)
          (81 28)
          (59 26)
          (60 26)
          (66 15)
          (41 44)
          (71 36)
          (62 36)
          (57 36)
          (58 38)
          (53 31)
          (51 35)
          (61 32)
          (42 43)
          (44 40)
          (48 34)
          (47 37)
          (56 42)
          (39 58)
          (45 41)
          (52 30)
          (50 43)
          (49 41)
          (37 50)
          (43 51)
          (55 41)
          (35 59)
          (36 36)
          (31 47)
          (54 37)
          (33 62)
          (30 58)
          (34 55)
          (27 55)
          (29 60)
          (26 68)
          (38 47)
          (32 62)
          (40 50)
          (24 43)
          (23 57)
          (25 47)
          (22 56)
          (21 52)
          (20 51)
          (11 62)
          (15 76)
          (19 73)
          (14 62)
          (18 67)
          (13 67)
          (28 58)
          (4 36)
          (5 47)
          (10 61)
          (17 71)
          (16 72)
          (9 62)
          (2 65)
          (3 48)
          (12 60)
          (8 61)
          (6 65)
          (0 30)
          (1 34)
          (7 51)))
   (11
    (into (216 1)
          (273 1)
          (183 1)
          (143 1)
          (202 1)
          (190 1)
          (158 1)
          (258 1)
          (351 1)
          (154 1)
          (350 1)
          (255 1)
          (155 1)
          (238 1)
          (268 1)
          (193 1)
          (251 2)
          (206 1)
          (163 2)
          (176 2)
          (281 1)
          (259 1)
          (296 1)
          (159 2)
          (279 1)
          (294 1)
          (274 2)
          (225 1)
          (157 4)
          (165 3)
          (293 1)
          (287 1)
          (223 1)
          (162 2)
          (286 1)
          (123 2)
          (284 1)
          (153 3)
          (267 3)
          (121 5)
          (240 1)
          (211 1)
          (186 3)
          (236 3)
          (198 1)
          (265 1)
          (201 2)
          (228 1)
          (180 2)
          (135 2)
          (179 1)
          (227 1)
          (195 2)
          (151 1)
          (169 1)
          (110 3)
          (262 1)
          (191 5)
          (109 2)
          (108 4)
          (161 3)
          (142 3)
          (234 1)
          (167 2)
          (139 1)
          (166 5)
          (199 1)
          (145 3)
          (125 2)
          (213 1)
          (156 1)
          (174 2)
          (133 6)
          (207 3)
          (150 2)
          (204 3)
          (185 1)
          (144 3)
          (117 3)
          (131 3)
          (115 5)
          (148 6)
          (129 8)
          (130 5)
          (200 2)
          (181 3)
          (149 3)
          (178 3)
          (146 4)
          (122 6)
          (172 5)
          (197 2)
          (101 7)
          (196 2)
          (171 1)
          (194 2)
          (170 1)
          (118 4)
          (120 7)
          (124 3)
          (168 6)
          (164 2)
          (160 2)
          (96 8)
          (132 1)
          (184 2)
          (126 5)
          (175 3)
          (111 4)
          (128 4)
          (138 2)
          (137 4)
          (127 7)
          (95 5)
          (91 8)
          (105 9)
          (78 11)
          (100 9)
          (90 15)
          (89 14)
          (116 2)
          (104 11)
          (141 5)
          (93 10)
          (87 16)
          (81 9)
          (84 11)
          (82 18)
          (102 6)
          (69 13)
          (57 18)
          (97 6)
          (114 4)
          (94 8)
          (113 5)
          (79 14)
          (73 22)
          (136 3)
          (83 16)
          (85 21)
          (134 6)
          (62 27)
          (92 11)
          (112 6)
          (119 8)
          (107 5)
          (103 8)
          (76 23)
          (106 9)
          (66 21)
          (75 20)
          (99 10)
          (98 5)
          (61 28)
          (53 27)
          (72 14)
          (46 35)
          (65 28)
          (68 20)
          (71 21)
          (77 19)
          (63 19)
          (86 16)
          (59 30)
          (67 20)
          (74 16)
          (64 23)
          (70 18)
          (88 18)
          (80 19)
          (58 33)
          (56 28)
          (55 26)
          (49 36)
          (48 37)
          (43 26)
          (54 27)
          (52 24)
          (41 47)
          (51 39)
          (50 26)
          (60 38)
          (45 35)
          (40 46)
          (37 25)
          (44 37)
          (47 32)
          (34 56)
          (31 40)
          (38 49)
          (32 40)
          (35 38)
          (29 41)
          (42 37)
          (39 37)
          (28 48)
          (33 44)
          (27 47)
          (25 55)
          (24 60)
          (22 56)
          (26 56)
          (23 43)
          (18 57)
          (36 47)
          (30 43)
          (21 59)
          (20 53)
          (19 42)
          (16 70)
          (17 62)
          (13 67)
          (8 81)
          (7 65)
          (6 72)
          (10 78)
          (9 63)
          (15 68)
          (12 80)
          (5 70)
          (14 76)
          (11 75)
          (3 63)
          (1 63)
          (0 48)
          (2 77)
          (4 65)))
   (10
    (into (220 1)
          (236 1)
          (281 1)
          (358 1)
          (235 1)
          (201 1)
          (357 1)
          (219 1)
          (279 1)
          (200 1)
          (278 1)
          (205 1)
          (195 1)
          (271 1)
          (241 1)
          (181 1)
          (351 1)
          (158 2)
          (193 3)
          (151 3)
          (240 1)
          (270 1)
          (239 1)
          (269 1)
          (186 1)
          (162 3)
          (180 1)
          (188 1)
          (189 2)
          (265 1)
          (234 1)
          (167 2)
          (178 2)
          (177 3)
          (297 2)
          (260 2)
          (282 3)
          (280 2)
          (295 1)
          (197 2)
          (229 1)
          (164 1)
          (217 1)
          (247 1)
          (263 1)
          (143 3)
          (212 1)
          (211 1)
          (207 1)
          (147 2)
          (203 1)
          (198 3)
          (196 2)
          (146 3)
          (165 5)
          (157 5)
          (144 5)
          (204 2)
          (233 1)
          (153 2)
          (163 3)
          (232 1)
          (231 1)
          (116 6)
          (168 2)
          (191 3)
          (216 1)
          (215 2)
          (190 1)
          (172 1)
          (160 3)
          (171 1)
          (155 3)
          (154 5)
          (152 3)
          (121 4)
          (149 3)
          (206 2)
          (187 1)
          (156 5)
          (148 1)
          (145 3)
          (123 6)
          (202 3)
          (199 3)
          (179 3)
          (173 4)
          (118 3)
          (138 2)
          (120 7)
          (170 2)
          (169 2)
          (130 7)
          (125 10)
          (129 6)
          (166 2)
          (122 6)
          (137 3)
          (141 3)
          (185 2)
          (111 11)
          (136 7)
          (133 7)
          (159 4)
          (128 2)
          (142 6)
          (113 8)
          (124 9)
          (110 4)
          (96 7)
          (91 17)
          (97 9)
          (82 14)
          (103 13)
          (83 20)
          (114 7)
          (140 5)
          (85 17)
          (139 5)
          (132 7)
          (94 13)
          (131 8)
          (93 4)
          (89 5)
          (104 12)
          (126 5)
          (112 10)
          (119 6)
          (101 8)
          (108 14)
          (135 3)
          (134 7)
          (68 16)
          (106 10)
          (117 5)
          (95 6)
          (127 3)
          (115 7)
          (87 9)
          (92 13)
          (109 10)
          (90 6)
          (88 7)
          (61 17)
          (107 11)
          (105 15)
          (98 12)
          (76 18)
          (102 10)
          (70 18)
          (62 23)
          (100 14)
          (99 17)
          (69 24)
          (67 20)
          (74 20)
          (78 15)
          (64 24)
          (86 13)
          (63 21)
          (79 12)
          (73 20)
          (84 12)
          (57 35)
          (66 30)
          (72 20)
          (65 22)
          (71 16)
          (59 41)
          (81 14)
          (80 22)
          (77 18)
          (75 22)
          (50 36)
          (58 31)
          (56 32)
          (55 38)
          (51 26)
          (54 37)
          (53 42)
          (47 40)
          (28 50)
          (46 32)
          (41 45)
          (52 30)
          (34 47)
          (60 30)
          (45 47)
          (48 44)
          (36 48)
          (43 38)
          (42 39)
          (39 37)
          (30 39)
          (29 49)
          (35 45)
          (38 46)
          (37 40)
          (33 39)
          (12 71)
          (25 56)
          (17 63)
          (20 54)
          (22 61)
          (19 57)
          (18 64)
          (16 61)
          (21 59)
          (10 78)
          (11 81)
          (8 80)
          (7 64)
          (9 60)
          (26 64)
          (13 51)
          (6 71)
          (2 67)
          (4 62)
          (3 41)
          (1 49)
          (5 71)
          (14 57)
          (32 66)
          (40 40)
          (23 57)
          (27 66)
          (24 46)
          (31 54)
          (49 34)
          (15 62)
          (44 38)))
   (0 (into (2 2) (1 24) (0 30) (3 3)))
   (8
    (into (215 1)
          (265 1)
          (233 1)
          (232 1)
          (207 1)
          (228 1)
          (262 1)
          (192 1)
          (171 2)
          (193 1)
          (252 1)
          (336 1)
          (132 1)
          (333 1)
          (243 1)
          (329 1)
          (178 2)
          (323 1)
          (322 1)
          (320 1)
          (162 2)
          (295 1)
          (229 2)
          (225 1)
          (152 1)
          (222 1)
          (278 1)
          (277 1)
          (198 1)
          (272 2)
          (216 2)
          (257 3)
          (203 2)
          (250 1)
          (269 1)
          (235 3)
          (249 1)
          (231 1)
          (204 1)
          (197 2)
          (224 1)
          (247 1)
          (264 1)
          (150 7)
          (133 6)
          (223 1)
          (196 3)
          (194 4)
          (220 1)
          (172 2)
          (244 1)
          (155 5)
          (146 3)
          (189 1)
          (259 1)
          (258 1)
          (256 1)
          (161 5)
          (213 1)
          (212 1)
          (211 2)
          (239 1)
          (185 3)
          (238 1)
          (237 2)
          (208 1)
          (153 9)
          (236 2)
          (205 2)
          (180 1)
          (149 3)
          (241 1)
          (226 2)
          (160 4)
          (173 3)
          (202 2)
          (147 7)
          (195 3)
          (170 4)
          (219 1)
          (169 5)
          (187 3)
          (218 1)
          (186 2)
          (168 5)
          (165 6)
          (183 4)
          (163 3)
          (139 3)
          (159 4)
          (210 2)
          (123 6)
          (176 6)
          (175 2)
          (209 3)
          (199 1)
          (166 6)
          (151 5)
          (127 2)
          (157 6)
          (188 4)
          (117 5)
          (154 4)
          (184 4)
          (141 6)
          (148 7)
          (177 3)
          (190 1)
          (137 4)
          (142 5)
          (182 2)
          (144 3)
          (125 4)
          (174 5)
          (135 7)
          (167 5)
          (158 8)
          (121 11)
          (140 7)
          (164 4)
          (136 5)
          (130 6)
          (129 5)
          (128 6)
          (122 7)
          (126 5)
          (120 11)
          (124 10)
          (87 26)
          (119 11)
          (92 15)
          (118 9)
          (115 7)
          (114 13)
          (112 12)
          (138 6)
          (111 13)
          (105 11)
          (109 8)
          (102 14)
          (107 18)
          (113 9)
          (98 16)
          (134 10)
          (101 5)
          (86 14)
          (90 17)
          (88 18)
          (156 7)
          (145 7)
          (143 4)
          (85 21)
          (80 15)
          (131 5)
          (96 10)
          (93 16)
          (116 12)
          (110 21)
          (91 19)
          (108 14)
          (106 10)
          (89 15)
          (103 16)
          (99 10)
          (83 21)
          (97 17)
          (95 8)
          (82 16)
          (100 18)
          (74 24)
          (104 15)
          (79 14)
          (78 15)
          (84 18)
          (73 24)
          (94 11)
          (68 17)
          (47 37)
          (76 26)
          (50 35)
          (71 22)
          (53 34)
          (77 23)
          (70 13)
          (69 25)
          (55 28)
          (75 25)
          (66 24)
          (81 17)
          (60 34)
          (72 20)
          (65 31)
          (58 32)
          (63 29)
          (62 31)
          (54 45)
          (67 29)
          (64 40)
          (49 33)
          (44 37)
          (61 32)
          (59 34)
          (42 37)
          (52 42)
          (43 37)
          (57 31)
          (51 28)
          (46 37)
          (48 40)
          (45 41)
          (56 41)
          (33 48)
          (37 39)
          (32 39)
          (36 43)
          (34 39)
          (35 51)
          (41 28)
          (26 56)
          (25 55)
          (24 55)
          (23 57)
          (22 54)
          (10 44)
          (17 57)
          (4 32)
          (2 42)
          (3 56)
          (16 73)
          (40 43)
          (31 55)
          (28 53)
          (39 38)
          (29 58)
          (38 48)
          (18 67)
          (12 73)
          (11 48)
          (19 67)
          (21 49)
          (30 55)
          (7 36)
          (5 40)
          (9 50)
          (15 68)
          (27 56)
          (14 77)
          (6 64)
          (8 59)
          (13 42)
          (1 31)
          (20 52)))
   (7
    (into (284 1)
          (210 1)
          (264 1)
          (263 1)
          (226 1)
          (206 1)
          (356 1)
          (355 1)
          (352 1)
          (194 1)
          (199 1)
          (188 1)
          (197 2)
          (187 2)
          (186 2)
          (341 1)
          (249 1)
          (247 1)
          (240 1)
          (236 1)
          (262 1)
          (231 2)
          (172 2)
          (169 3)
          (178 1)
          (170 3)
          (301 1)
          (300 1)
          (286 1)
          (177 2)
          (161 4)
          (157 4)
          (268 1)
          (283 1)
          (255 1)
          (266 1)
          (162 6)
          (242 1)
          (259 2)
          (159 7)
          (258 2)
          (251 1)
          (270 2)
          (248 1)
          (234 3)
          (156 4)
          (230 3)
          (203 1)
          (229 2)
          (202 4)
          (179 3)
          (200 1)
          (175 1)
          (223 2)
          (193 4)
          (219 1)
          (171 5)
          (243 1)
          (261 3)
          (168 5)
          (216 1)
          (190 2)
          (167 5)
          (166 6)
          (241 3)
          (130 7)
          (257 1)
          (189 5)
          (254 2)
          (253 2)
          (184 5)
          (252 2)
          (207 2)
          (246 1)
          (245 2)
          (244 2)
          (227 3)
          (238 1)
          (237 1)
          (225 2)
          (224 1)
          (235 2)
          (141 5)
          (151 4)
          (222 1)
          (142 3)
          (218 1)
          (217 1)
          (181 3)
          (215 3)
          (214 2)
          (205 1)
          (198 1)
          (165 7)
          (164 6)
          (150 5)
          (196 2)
          (163 6)
          (160 9)
          (191 2)
          (185 5)
          (183 2)
          (152 10)
          (182 7)
          (147 4)
          (176 1)
          (146 5)
          (174 2)
          (145 7)
          (173 4)
          (195 4)
          (143 7)
          (132 7)
          (158 8)
          (140 7)
          (135 6)
          (134 6)
          (155 8)
          (133 6)
          (154 7)
          (131 4)
          (124 6)
          (107 13)
          (149 8)
          (148 5)
          (129 3)
          (128 1)
          (127 8)
          (122 8)
          (126 12)
          (120 9)
          (113 8)
          (118 11)
          (117 12)
          (119 9)
          (109 19)
          (108 16)
          (139 10)
          (136 12)
          (100 9)
          (112 13)
          (110 10)
          (153 8)
          (144 7)
          (95 14)
          (138 6)
          (137 8)
          (94 21)
          (92 21)
          (99 14)
          (125 14)
          (93 17)
          (123 11)
          (121 12)
          (91 14)
          (114 14)
          (97 13)
          (116 9)
          (115 10)
          (111 11)
          (106 11)
          (105 10)
          (85 22)
          (104 17)
          (102 10)
          (101 14)
          (98 12)
          (87 15)
          (86 22)
          (79 23)
          (83 20)
          (103 17)
          (75 19)
          (89 14)
          (88 20)
          (84 19)
          (96 19)
          (73 31)
          (90 23)
          (82 23)
          (80 25)
          (74 27)
          (78 23)
          (72 26)
          (77 21)
          (76 21)
          (81 22)
          (70 24)
          (69 26)
          (71 23)
          (62 36)
          (61 39)
          (68 28)
          (67 25)
          (66 37)
          (56 27)
          (65 42)
          (55 44)
          (49 43)
          (60 32)
          (64 26)
          (54 47)
          (63 33)
          (59 20)
          (51 45)
          (58 31)
          (57 35)
          (52 36)
          (47 46)
          (37 46)
          (48 50)
          (46 47)
          (38 52)
          (42 51)
          (41 36)
          (45 45)
          (44 46)
          (34 49)
          (43 42)
          (27 69)
          (53 50)
          (32 67)
          (50 36)
          (29 46)
          (30 61)
          (40 31)
          (39 42)
          (36 43)
          (20 65)
          (26 55)
          (35 60)
          (25 65)
          (24 61)
          (33 56)
          (23 58)
          (22 69)
          (19 50)
          (18 52)
          (17 61)
          (21 56)
          (31 44)
          (28 65)
          (14 65)
          (13 55)
          (15 64)
          (5 69)
          (11 40)
          (6 67)
          (12 71)
          (16 62)
          (1 70)
          (4 49)
          (10 63)
          (9 59)
          (3 61)
          (2 66)
          (7 59)
          (0 72)
          (8 71)))
   (6
    (into (283 1)
          (203 1)
          (219 1)
          (348 1)
          (346 1)
          (345 1)
          (344 1)
          (343 1)
          (338 1)
          (335 1)
          (246 2)
          (331 1)
          (330 1)
          (328 1)
          (327 1)
          (326 1)
          (325 1)
          (175 2)
          (237 1)
          (318 1)
          (235 1)
          (317 1)
          (316 1)
          (315 1)
          (314 1)
          (311 1)
          (208 1)
          (264 1)
          (306 1)
          (292 1)
          (182 3)
          (291 1)
          (290 1)
          (289 1)
          (287 1)
          (299 1)
          (285 2)
          (168 3)
          (195 2)
          (165 3)
          (288 2)
          (194 1)
          (284 1)
          (227 2)
          (256 1)
          (157 1)
          (254 1)
          (167 4)
          (253 1)
          (166 3)
          (221 1)
          (188 2)
          (216 1)
          (193 3)
          (213 1)
          (245 1)
          (163 5)
          (210 2)
          (251 2)
          (189 2)
          (209 1)
          (233 2)
          (131 10)
          (267 2)
          (154 5)
          (226 4)
          (199 2)
          (177 4)
          (198 1)
          (225 1)
          (173 5)
          (120 9)
          (149 9)
          (214 1)
          (240 1)
          (255 1)
          (152 6)
          (164 7)
          (162 4)
          (183 5)
          (250 1)
          (249 1)
          (129 4)
          (248 2)
          (181 4)
          (234 1)
          (205 1)
          (144 5)
          (232 1)
          (231 1)
          (140 9)
          (137 7)
          (230 1)
          (228 1)
          (134 8)
          (122 3)
          (239 1)
          (143 9)
          (238 4)
          (142 10)
          (236 3)
          (172 5)
          (171 5)
          (170 3)
          (169 6)
          (138 5)
          (224 1)
          (133 6)
          (200 2)
          (223 2)
          (222 3)
          (197 3)
          (130 7)
          (113 10)
          (217 2)
          (179 3)
          (160 7)
          (174 4)
          (206 3)
          (192 1)
          (161 5)
          (190 2)
          (186 2)
          (180 5)
          (151 7)
          (148 7)
          (127 4)
          (176 4)
          (141 10)
          (191 3)
          (187 6)
          (184 1)
          (159 6)
          (105 8)
          (178 6)
          (103 14)
          (135 5)
          (158 6)
          (128 8)
          (123 6)
          (121 8)
          (136 8)
          (88 12)
          (156 5)
          (78 22)
          (92 16)
          (115 14)
          (132 10)
          (125 5)
          (147 11)
          (146 6)
          (145 5)
          (112 9)
          (119 9)
          (116 13)
          (87 18)
          (72 23)
          (99 11)
          (111 11)
          (69 20)
          (109 19)
          (106 13)
          (155 5)
          (76 17)
          (153 7)
          (150 9)
          (139 8)
          (117 14)
          (126 8)
          (100 15)
          (95 12)
          (124 11)
          (98 14)
          (79 20)
          (118 8)
          (77 11)
          (114 14)
          (108 21)
          (94 17)
          (107 18)
          (93 17)
          (96 18)
          (102 12)
          (91 14)
          (110 13)
          (101 20)
          (74 22)
          (86 17)
          (104 21)
          (82 22)
          (80 21)
          (90 18)
          (83 16)
          (89 16)
          (97 9)
          (85 20)
          (84 31)
          (81 33)
          (70 27)
          (64 24)
          (71 32)
          (75 16)
          (56 31)
          (73 20)
          (61 35)
          (67 28)
          (68 22)
          (62 32)
          (65 39)
          (59 29)
          (57 31)
          (66 24)
          (63 23)
          (60 29)
          (45 32)
          (43 50)
          (58 38)
          (53 38)
          (55 27)
          (50 48)
          (52 43)
          (40 31)
          (48 35)
          (39 54)
          (31 41)
          (38 45)
          (35 51)
          (44 44)
          (54 34)
          (33 44)
          (51 36)
          (30 56)
          (49 32)
          (29 77)
          (21 43)
          (47 36)
          (46 48)
          (23 52)
          (42 45)
          (26 46)
          (25 49)
          (41 42)
          (24 60)
          (37 40)
          (22 62)
          (36 42)
          (34 45)
          (15 64)
          (32 57)
          (28 62)
          (19 49)
          (18 48)
          (14 56)
          (27 44)
          (16 71)
          (11 58)
          (20 52)
          (3 67)
          (8 61)
          (12 51)
          (17 65)
          (9 68)
          (10 68)
          (2 76)
          (13 62)
          (1 78)
          (6 72)
          (5 48)
          (4 68)
          (0 34)
          (7 59)))
   (5
    (into (286 1)
          (224 1)
          (205 1)
          (185 1)
          (354 1)
          (218 1)
          (199 1)
          (216 1)
          (172 1)
          (166 3)
          (242 1)
          (321 1)
          (238 1)
          (319 1)
          (313 1)
          (206 1)
          (312 1)
          (310 1)
          (309 1)
          (304 1)
          (170 2)
          (303 1)
          (302 1)
          (298 1)
          (284 1)
          (283 1)
          (174 1)
          (171 4)
          (169 2)
          (289 1)
          (158 2)
          (165 2)
          (282 1)
          (191 1)
          (281 1)
          (153 1)
          (280 2)
          (250 1)
          (203 1)
          (279 1)
          (202 1)
          (266 1)
          (246 1)
          (217 1)
          (257 1)
          (214 1)
          (271 1)
          (213 1)
          (209 2)
          (182 2)
          (208 2)
          (270 1)
          (204 1)
          (255 1)
          (254 1)
          (253 1)
          (252 1)
          (109 5)
          (126 6)
          (195 1)
          (245 1)
          (173 5)
          (192 2)
          (123 6)
          (186 1)
          (184 4)
          (161 2)
          (247 1)
          (178 2)
          (176 4)
          (235 1)
          (156 5)
          (167 2)
          (244 1)
          (142 4)
          (145 6)
          (152 3)
          (229 2)
          (164 3)
          (239 2)
          (233 1)
          (221 3)
          (149 4)
          (139 6)
          (168 4)
          (134 3)
          (225 2)
          (200 3)
          (198 3)
          (144 5)
          (196 1)
          (194 3)
          (193 3)
          (220 1)
          (163 5)
          (138 6)
          (162 2)
          (207 3)
          (175 3)
          (108 9)
          (201 1)
          (177 3)
          (110 13)
          (189 2)
          (111 10)
          (181 7)
          (180 4)
          (160 3)
          (179 5)
          (118 8)
          (102 12)
          (159 4)
          (121 6)
          (120 5)
          (96 9)
          (116 9)
          (135 8)
          (131 3)
          (129 7)
          (98 14)
          (157 2)
          (155 3)
          (127 13)
          (125 6)
          (112 11)
          (143 9)
          (141 10)
          (115 12)
          (114 9)
          (97 12)
          (101 16)
          (106 17)
          (105 15)
          (103 11)
          (151 6)
          (71 19)
          (150 4)
          (148 7)
          (147 8)
          (146 5)
          (99 10)
          (140 6)
          (137 6)
          (136 4)
          (133 7)
          (132 5)
          (130 5)
          (128 5)
          (124 7)
          (122 9)
          (119 7)
          (90 18)
          (117 14)
          (78 19)
          (113 12)
          (87 14)
          (100 12)
          (94 15)
          (93 15)
          (107 13)
          (89 25)
          (104 13)
          (86 17)
          (84 14)
          (83 26)
          (70 28)
          (88 17)
          (85 18)
          (76 28)
          (77 30)
          (82 30)
          (95 26)
          (92 24)
          (75 24)
          (91 14)
          (74 24)
          (73 32)
          (72 33)
          (81 19)
          (80 26)
          (79 18)
          (69 22)
          (66 21)
          (59 30)
          (57 35)
          (67 28)
          (64 38)
          (68 26)
          (65 22)
          (62 27)
          (53 47)
          (58 38)
          (63 25)
          (61 33)
          (60 31)
          (56 30)
          (54 43)
          (52 42)
          (51 49)
          (46 42)
          (45 46)
          (40 46)
          (33 56)
          (41 42)
          (31 67)
          (38 52)
          (43 51)
          (42 41)
          (47 58)
          (44 45)
          (48 40)
          (25 74)
          (35 46)
          (55 34)
          (34 54)
          (50 44)
          (18 68)
          (30 61)
          (49 34)
          (26 64)
          (27 52)
          (39 47)
          (23 79)
          (37 50)
          (20 75)
          (36 64)
          (19 77)
          (32 53)
          (16 69)
          (29 58)
          (28 62)
          (24 65)
          (22 65)
          (13 72)
          (21 68)
          (14 75)
          (17 80)
          (11 90)
          (7 100)
          (15 63)
          (12 74)
          (1 160)
          (9 85)
          (8 74)
          (0 102)
          (10 88)
          (3 142)
          (6 82)
          (5 106)
          (2 156)
          (4 125)))
   (4
    (into (183 1)
          (182 1)
          (184 1)
          (161 1)
          (179 1)
          (217 1)
          (192 1)
          (157 2)
          (155 1)
          (191 1)
          (213 1)
          (212 1)
          (342 1)
          (340 1)
          (324 1)
          (308 1)
          (307 1)
          (130 2)
          (151 3)
          (168 1)
          (163 2)
          (116 2)
          (285 1)
          (147 2)
          (281 1)
          (190 3)
          (218 1)
          (189 1)
          (215 1)
          (187 1)
          (186 1)
          (185 1)
          (139 4)
          (132 3)
          (176 2)
          (127 2)
          (124 4)
          (173 3)
          (152 3)
          (263 1)
          (241 1)
          (114 4)
          (125 8)
          (119 1)
          (174 3)
          (172 2)
          (171 1)
          (169 1)
          (120 2)
          (251 1)
          (175 5)
          (121 6)
          (150 3)
          (240 1)
          (239 1)
          (146 4)
          (162 4)
          (113 8)
          (148 3)
          (115 6)
          (220 2)
          (227 1)
          (226 1)
          (180 3)
          (154 3)
          (153 3)
          (110 8)
          (149 3)
          (219 1)
          (107 5)
          (104 5)
          (143 3)
          (197 1)
          (196 1)
          (166 2)
          (221 2)
          (136 3)
          (178 1)
          (160 2)
          (164 5)
          (135 3)
          (122 5)
          (97 7)
          (133 2)
          (101 12)
          (177 3)
          (128 7)
          (102 11)
          (123 7)
          (131 3)
          (140 3)
          (137 4)
          (106 8)
          (156 1)
          (99 13)
          (145 4)
          (144 5)
          (118 5)
          (117 10)
          (105 8)
          (100 11)
          (142 6)
          (141 8)
          (138 6)
          (129 3)
          (126 1)
          (90 15)
          (88 12)
          (112 14)
          (103 10)
          (95 13)
          (93 17)
          (92 13)
          (111 7)
          (109 12)
          (108 5)
          (96 10)
          (79 18)
          (91 15)
          (84 25)
          (98 12)
          (75 17)
          (81 17)
          (94 19)
          (89 11)
          (87 10)
          (86 14)
          (69 26)
          (85 20)
          (83 18)
          (65 26)
          (82 15)
          (74 13)
          (73 16)
          (80 18)
          (72 25)
          (70 24)
          (78 23)
          (77 22)
          (76 16)
          (60 33)
          (71 23)
          (68 18)
          (57 25)
          (58 29)
          (67 22)
          (66 22)
          (63 35)
          (64 21)
          (61 22)
          (62 26)
          (56 33)
          (59 25)
          (53 35)
          (42 44)
          (41 41)
          (39 41)
          (37 43)
          (44 44)
          (43 56)
          (35 38)
          (50 38)
          (24 57)
          (48 53)
          (18 74)
          (47 43)
          (27 69)
          (46 48)
          (36 44)
          (54 38)
          (55 39)
          (23 64)
          (34 45)
          (51 37)
          (32 51)
          (30 42)
          (52 43)
          (31 55)
          (49 43)
          (45 45)
          (40 48)
          (25 56)
          (17 68)
          (38 50)
          (21 66)
          (33 56)
          (12 95)
          (14 83)
          (29 67)
          (28 55)
          (26 64)
          (22 62)
          (20 74)
          (19 69)
          (16 65)
          (8 120)
          (15 83)
          (13 82)
          (10 86)
          (11 103)
          (9 104)
          (7 107)
          (3 130)
          (6 98)
          (5 135)
          (2 166)
          (1 138)
          (0 60)
          (4 134)))
   (2
    (into (160 1)
          (109 1)
          (132 1)
          (152 1)
          (158 1)
          (157 1)
          (108 1)
          (125 1)
          (117 2)
          (143 2)
          (113 3)
          (115 2)
          (103 2)
          (128 1)
          (141 3)
          (95 1)
          (140 1)
          (79 3)
          (127 1)
          (83 2)
          (136 1)
          (105 1)
          (104 3)
          (112 1)
          (102 4)
          (111 4)
          (101 2)
          (80 6)
          (92 3)
          (91 2)
          (89 1)
          (94 4)
          (73 8)
          (75 9)
          (97 1)
          (98 1)
          (99 1)
          (100 1)
          (74 3)
          (72 4)
          (78 11)
          (77 6)
          (76 6)
          (61 15)
          (60 7)
          (106 5)
          (96 7)
          (70 9)
          (66 10)
          (93 2)
          (90 3)
          (71 10)
          (69 10)
          (63 12)
          (65 11)
          (88 9)
          (87 4)
          (86 8)
          (55 16)
          (85 2)
          (59 24)
          (81 5)
          (82 6)
          (67 11)
          (68 11)
          (53 11)
          (64 10)
          (52 15)
          (58 13)
          (62 12)
          (57 10)
          (45 18)
          (26 41)
          (0 28)
          (1 126)
          (38 30)
          (51 21)
          (36 35)
          (33 31)
          (35 29)
          (30 31)
          (39 32)
          (47 24)
          (9 78)
          (29 36)
          (34 28)
          (17 66)
          (31 31)
          (40 26)
          (18 61)
          (41 18)
          (42 13)
          (44 33)
          (43 17)
          (20 52)
          (37 26)
          (50 13)
          (46 12)
          (48 12)
          (27 46)
          (56 13)
          (54 16)
          (14 64)
          (49 21)
          (32 27)
          (28 32)
          (25 40)
          (24 44)
          (19 56)
          (23 47)
          (11 87)
          (12 76)
          (22 51)
          (21 47)
          (16 66)
          (15 63)
          (8 87)
          (13 88)
          (7 98)
          (10 89)
          (6 106)
          (3 92)
          (5 133)
          (4 125)
          (2 129)))
   (3
    (into (144 1)
          (149 1)
          (192 1)
          (206 1)
          (205 2)
          (204 1)
          (120 2)
          (170 2)
          (121 2)
          (165 1)
          (147 1)
          (146 3)
          (190 1)
          (111 3)
          (188 1)
          (187 1)
          (135 1)
          (117 3)
          (142 2)
          (158 1)
          (143 4)
          (128 1)
          (126 2)
          (125 1)
          (127 3)
          (156 1)
          (138 1)
          (177 1)
          (123 3)
          (260 2)
          (173 1)
          (168 1)
          (141 2)
          (124 4)
          (118 6)
          (151 2)
          (115 4)
          (163 1)
          (145 4)
          (161 1)
          (159 1)
          (157 2)
          (91 4)
          (140 4)
          (155 2)
          (152 3)
          (220 1)
          (150 1)
          (101 11)
          (102 9)
          (129 4)
          (193 2)
          (137 4)
          (122 3)
          (113 6)
          (112 5)
          (105 4)
          (108 7)
          (116 6)
          (104 4)
          (103 4)
          (119 3)
          (114 4)
          (130 4)
          (136 3)
          (133 3)
          (110 2)
          (109 6)
          (106 6)
          (100 11)
          (98 13)
          (95 23)
          (107 5)
          (86 5)
          (83 9)
          (99 6)
          (96 18)
          (94 11)
          (93 13)
          (90 7)
          (88 13)
          (97 15)
          (92 7)
          (81 12)
          (85 13)
          (75 10)
          (80 11)
          (79 13)
          (66 24)
          (73 16)
          (59 24)
          (64 22)
          (71 18)
          (89 7)
          (87 9)
          (84 10)
          (82 11)
          (77 13)
          (76 13)
          (78 12)
          (74 11)
          (72 15)
          (70 25)
          (69 19)
          (68 19)
          (67 27)
          (65 21)
          (63 21)
          (62 21)
          (61 27)
          (60 26)
          (58 23)
          (57 27)
          (54 39)
          (51 45)
          (55 27)
          (38 44)
          (40 39)
          (32 56)
          (30 61)
          (39 39)
          (34 52)
          (33 59)
          (17 92)
          (37 55)
          (41 46)
          (42 47)
          (26 53)
          (50 37)
          (20 71)
          (36 46)
          (47 38)
          (24 58)
          (56 33)
          (16 83)
          (35 51)
          (53 33)
          (52 38)
          (49 42)
          (25 68)
          (48 32)
          (46 36)
          (45 36)
          (22 73)
          (44 42)
          (43 49)
          (31 53)
          (28 53)
          (29 48)
          (27 62)
          (23 80)
          (21 60)
          (12 119)
          (19 85)
          (18 81)
          (9 97)
          (15 88)
          (14 77)
          (13 93)
          (11 95)
          (10 122)
          (8 125)
          (7 139)
          (6 165)
          (5 149)
          (4 188)
          (3 167)
          (2 226)
          (1 196)
          (0 130)))
   (1
    (into (65 1)
          (88 1)
          (89 1)
          (78 1)
          (81 1)
          (63 1)
          (77 1)
          (68 1)
          (47 1)
          (67 1)
          (135 1)
          (66 2)
          (70 1)
          (91 1)
          (84 1)
          (76 1)
          (54 2)
          (75 1)
          (53 1)
          (61 4)
          (44 4)
          (79 2)
          (94 1)
          (48 6)
          (74 2)
          (71 1)
          (64 2)
          (43 2)
          (62 3)
          (45 7)
          (38 4)
          (73 1)
          (30 6)
          (34 10)
          (40 8)
          (31 6)
          (24 11)
          (56 3)
          (21 17)
          (51 5)
          (27 8)
          (42 7)
          (41 7)
          (39 6)
          (60 4)
          (59 3)
          (58 5)
          (26 6)
          (36 8)
          (35 10)
          (4 56)
          (49 2)
          (20 14)
          (17 19)
          (32 6)
          (19 18)
          (22 8)
          (11 41)
          (18 12)
          (28 8)
          (8 44)
          (12 38)
          (7 37)
          (5 55)
          (6 51)
          (23 16)
          (14 23)
          (25 12)
          (10 37)
          (29 9)
          (15 20)
          (33 10)
          (16 20)
          (37 7)
          (46 1)
          (9 33)
          (50 3)
          (55 1)
          (13 28)
          (3 77)
          (2 85)
          (1 61)
          (0 26))))
  (length (22 2)
          (17 23)
          (18 8)
          (19 9)
          (16 70)
          (15 110)
          (13 248)
          (14 192)
          (10 446)
          (12 329)
          (11 373)
          (1 59)
          (9 469)
          (8 605)
          (7 660)
          (6 906)
          (5 1003)
          (3 1031)
          (4 1297)
          (2 534))
  (by-computation 629))
 (tms
  (assimilate
   3871017
   (16 (into (5 84) (1 51) (2 18) (4 110) (3 122)))
   (15 (into (5 63) (4 678) (2 933) (3 1087) (1 682)))
   (14 (into (5 2) (4 336) (1 978) (3 920) (2 1241)))
   (13 (into (5 1) (4 320) (3 717) (1 1671) (2 1817)))
   (11 (into (5 184) (4 790) (2 2594) (3 1676) (1 2339)))
   (12 (into (5 10) (4 480) (3 691) (2 1125) (1 1926)))
   (10 (into (5 28) (4 1274) (1 2234) (3 3821) (2 3492)))
   (9 (into (5 21) (4 1007) (1 3391) (3 2999) (2 2465)))
   (8 (into (9 26780) (1 27398) (8 26367) (7 31) (4 507) (3 2305) (2 15432)))
   (7
    (into (9 9537)
          (8 25203)
          (7 23356)
          (6 70)
          (4 649)
          (3 1687)
          (1 27115)
          (2 14237)))
   (6
    (into (9 5691)
          (8 9492)
          (7 13623)
          (6 34348)
          (5 116)
          (4 605)
          (3 757)
          (2 10708)
          (1 31664)))
   (5
    (into (9 2686)
          (8 776)
          (5 26007)
          (7 4163)
          (6 18477)
          (4 838)
          (3 2117)
          (1 20044)
          (2 6445)))
   (4
    (into (9 267)
          (8 4713)
          (7 10397)
          (6 15473)
          (5 13983)
          (4 18633)
          (3 811)
          (2 6352)
          (1 27292)))
   (3
    (into (8 9768)
          (9 20636)
          (5 7527)
          (7 18744)
          (6 12453)
          (2 14614)
          (1 40786)
          (4 14470)
          (3 17243)))
   (0 (into (5 1882) (4 39143) (3 101311) (2 429876) (1 525210)))
   (2
    (into (9 13904)
          (8 31247)
          (7 13457)
          (6 8439)
          (5 8974)
          (4 11900)
          (1 44443)
          (3 15354)
          (2 32384)))
   (1
    (into (9 4195)
          (8 5890)
          (6 18340)
          (5 21435)
          (7 13884)
          (4 31509)
          (2 1410858)
          (3 34357)
          (1 365254)))))
 (invocation 2297448 (amb-choose 201296)))
process time: 248280 (235330 RUN + 12950 GC); real time: 321126
;Value 4361: #[sudoku-board 4361]

1 ]=> (length (prof:node-clean-copy (prof:stats)))

;Value: 4

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
;Value 4496: #[test-group 4496]

1 ]=> (set! *number-of-calls-to-fail* 0)

;Value: 63

1 ]=> (prof:with-reset
 (lambda ()
   (show-time
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
	 (0 3 1 0 0 0 5 0 0)))))))

;The procedure #[compiled-procedure 4497 ("masyu" #xa) #xf #x22963cf] has been called with 1 argument; it requires exactly 2 arguments.
;To continue, call RESTART with an option number:
; (RESTART 1) => Return to read-eval-print level 1.

2 error> (debug)

There are 9 subproblems on the stack.

Subproblem level: 0 (this is the lowest subproblem level)
Expression (from stack):
    (#[compiled-procedure 4497 ("masyu" #xa) #xf #x22963cf] 3)
There is no current environment.
The execution history for this subproblem contains 1 reduction.
You are now in the debugger.  Type q to quit, ? for commands.

3 debug> h
h
SL#  Procedure-name          Expression

0                            (#[compiled-procedure 4497 ("masyu" #xa) #xf # ...
1                            (let ((board (empty-board rt-size))) (add-diff ...
2    do-sudoku               (let ((board (parse-sudoku board-by-rows))) (r ...
3                            (let ((value (thunk))) (let ((process-end (pro ...
4    prof:with-reset         (let ((value (thunk))) (prof:show-stats path)  ...
5    %repl-eval              (let ((value (hook/repl-eval s-expression envi ...
6    %repl-eval/write        (hook/repl-write (%repl-eval s-expression envi ...
7                            (begin (if (queue-empty? queue) (let ((environ ...
8                            (loop (bind-abort-restart cmdl (lambda () (der ...

3 debug>   C-c C-c
;Quit!

1 ]=> 
;Loading "examples/sudoku.scm"... done
;Unspecified return value

1 ]=> (prof:with-reset
 (lambda ()
   (show-time
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
	 (0 3 1 0 0 0 5 0 0)))))))
327194658
846325179
519687243
172563894
653948721
498712365
764851932
985236417
231479586
process time: 268810 (255680 RUN + 13130 GC); real time: 336533
((pairwise-union
  (41 (with (3 1)))
  (54 (with (3 1)))
  (47 (with (1 1)))
  (58 (with (3 1)))
  (33 (with (4 1)))
  (36 (with (4 1)))
  (28 (with (1 1) (5 1)))
  (19 (with (3 1) (12 1) (9 1) (6 1) (1 5) (2 3) (4 2)))
  (48 (with (20 1)))
  (37 (with (1 1) (6 1)))
  (38 (with (4 1) (12 1)))
  (23 (with (1 3) (3 1)))
  (20 (with (6 1) (1 6) (3 1) (5 1)))
  (24 (with (6 1) (3 1) (10 1) (5 1)))
  (34 (with (15 1) (3 1)))
  (26 (with (2 3) (1 1) (3 2) (4 2)))
  (40 (with (1 1)))
  (27 (with (3 1) (2 1) (10 1) (1 1)))
  (45 (with (15 1) (1 1)))
  (25 (with (4 1) (1 2) (2 2) (3 1)))
  (31 (with (3 1)))
  (35 (with (2 1) (3 1)))
  (30 (with (21 2) (2 3)))
  (17 (with (2 1) (11 1) (6 1) (3 3) (7 1) (15 1) (4 4) (1 9)))
  (15 (with (3 3) (17 1) (14 1) (8 2) (7 1) (5 3) (4 2) (1 16) (2 5)))
  (18 (with (5 1) (1 5) (6 1) (7 2) (4 3) (2 1)))
  (21 (with (3 1) (4 1) (1 3)))
  (22 (with (3 1) (2 2) (1 5)))
  (16 (with (11 1) (6 1) (5 1) (3 1) (2 2) (1 14)))
  (14 (with (4 1) (6 1) (7 1) (12 2) (3 2) (5 1) (1 18) (2 7)))
  (12
   (with (20 1)
         (26 1)
         (10 1)
         (6 3)
         (8 3)
         (11 1)
         (7 5)
         (5 2)
         (3 2)
         (4 5)
         (2 15)
         (1 37)))
  (9 (with (9 1) (7 2) (6 4) (11 2) (5 4) (12 2) (3 8) (4 8) (2 36) (1 67)))
  (10 (with (33 1) (20 1) (12 2) (7 3) (6 2) (5 5) (4 7) (3 9) (2 14) (1 52)))
  (13 (with (17 1) (8 1) (7 3) (4 2) (13 1) (3 4) (10 1) (5 2) (2 11) (1 36)))
  (11 (with (8 2) (7 1) (5 6) (6 3) (3 12) (4 3) (2 20) (1 40)))
  (7
   (with (28 1)
         (11 1)
         (17 1)
         (9 4)
         (10 2)
         (14 1)
         (18 1)
         (12 4)
         (7 5)
         (5 7)
         (4 17)
         (8 3)
         (6 5)
         (2 33)
         (3 27)
         (1 119)))
  (8
   (with (16 1)
         (10 2)
         (6 2)
         (11 2)
         (7 1)
         (13 1)
         (8 3)
         (9 1)
         (5 10)
         (3 16)
         (2 38)
         (1 86)
         (4 10)))
  (5
   (with (21 1)
         (13 3)
         (24 1)
         (9 7)
         (15 1)
         (8 8)
         (12 4)
         (7 9)
         (10 5)
         (6 14)
         (3 50)
         (4 29)
         (1 254)
         (5 22)
         (2 82)))
  (6
   (with (23 1)
         (13 1)
         (9 2)
         (8 8)
         (10 5)
         (4 19)
         (5 19)
         (7 9)
         (2 68)
         (6 10)
         (1 173)
         (3 26)))
  (4
   (with (12 2)
         (17 3)
         (16 1)
         (14 2)
         (15 2)
         (13 1)
         (11 3)
         (9 4)
         (8 16)
         (7 13)
         (10 5)
         (5 30)
         (6 20)
         (2 136)
         (1 318)
         (4 34)
         (3 70)))
  (2
   (with (14 1)
         (20 1)
         (26 2)
         (22 2)
         (17 1)
         (23 3)
         (21 1)
         (15 1)
         (12 4)
         (18 1)
         (19 3)
         (16 1)
         (13 3)
         (9 12)
         (11 5)
         (8 16)
         (7 18)
         (6 21)
         (10 11)
         (5 32)
         (3 124)
         (4 54)
         (1 589)
         (2 232)))
  (3
   (with (17 2)
         (13 2)
         (11 7)
         (8 8)
         (14 3)
         (10 5)
         (16 1)
         (15 4)
         (19 1)
         (7 16)
         (12 7)
         (6 17)
         (9 6)
         (4 52)
         (5 34)
         (2 178)
         (3 96)
         (1 437)))
  (1
   (with (24 1)
         (25 3)
         (22 4)
         (14 5)
         (18 4)
         (23 4)
         (20 3)
         (17 11)
         (19 5)
         (16 7)
         (10 21)
         (12 7)
         (15 10)
         (13 10)
         (11 20)
         (9 23)
         (7 50)
         (8 38)
         (5 96)
         (6 60)
         (4 137)
         (3 260)
         (2 451)
         (1 1942))))
 (nogood
  (by-resolution 7745)
  (assimilate 55483)
  (length (22 2)
          (17 23)
          (18 8)
          (19 9)
          (16 70)
          (15 110)
          (13 248)
          (14 192)
          (10 446)
          (12 329)
          (11 373)
          (1 59)
          (9 469)
          (8 605)
          (7 660)
          (6 906)
          (5 1003)
          (3 1031)
          (4 1297)
          (2 534))
  (by-computation 629))
 (tms
  (subsume
   6962933
   (16
    (vs (7 84)
        (5 80)
        (13 73)
        (8 25)
        (15 1050)
        (10 1269)
        (14 267)
        (9 827)
        (4 30)
        (11 782)
        (16 338)
        (0 23795)
        (6 13)
        (12 197)))
   (14
    (vs (3 64)
        (2 2)
        (12 155)
        (16 100)
        (8 151)
        (7 151)
        (13 219)
        (11 1016)
        (9 1498)
        (5 499)
        (15 1611)
        (4 123)
        (10 2440)
        (14 165)
        (0 37650)
        (6 28)))
   (10
    (vs (3 29)
        (16 2)
        (15 1)
        (14 2)
        (5 50)
        (2 4)
        (12 99)
        (13 616)
        (8 318)
        (11 513)
        (7 574)
        (9 756)
        (4 22)
        (10 137)
        (0 17421)
        (6 474)))
   (12
    (vs (3 85)
        (2 4)
        (15 148)
        (16 98)
        (5 202)
        (11 1029)
        (14 1683)
        (7 719)
        (9 1036)
        (4 89)
        (13 768)
        (10 1587)
        (6 325)
        (8 1696)
        (12 433)
        (0 49620)))
   (8
    (vs (16 134)
        (14 198)
        (15 147)
        (13 191)
        (1 12771)
        (12 532)
        (11 588)
        (10 1626)
        (9 427)
        (3 52553)
        (2 57381)
        (5 7293)
        (4 5047)
        (7 42462)
        (8 88925)
        (0 62190)
        (6 20632)))
   (7
    (vs (1 21673)
        (2 62670)
        (3 49914)
        (4 15020)
        (8 1572)
        (6 27362)
        (0 22393)
        (7 73568)
        (5 7376)))
   (6
    (vs (15 687)
        (16 29)
        (11 2292)
        (14 798)
        (13 1048)
        (12 512)
        (10 2799)
        (9 2322)
        (1 42551)
        (3 63242)
        (2 67967)
        (8 3618)
        (4 32241)
        (7 3897)
        (5 26039)
        (6 84856)
        (0 134646)))
   (5
    (vs (1 63793)
        (2 78164)
        (3 71295)
        (4 43667)
        (8 2275)
        (7 2245)
        (6 1950)
        (0 52625)
        (5 66887)))
   (4
    (vs (15 1668)
        (16 256)
        (14 1007)
        (13 1218)
        (12 2005)
        (11 2600)
        (10 4933)
        (9 4531)
        (8 5833)
        (7 5323)
        (6 3998)
        (1 94669)
        (2 90423)
        (3 84402)
        (5 4536)
        (4 84865)
        (0 216366)))
   (3
    (vs (0 31593)
        (6 1439)
        (5 767)
        (8 1474)
        (7 1261)
        (4 1406)
        (3 125464)
        (1 128894)
        (2 102398)))
   (0
    (vs (16 385)
        (15 3443)
        (14 3477)
        (13 4526)
        (11 7583)
        (12 4232)
        (10 10849)
        (9 9883)
        (8 33034)
        (7 31087)
        (6 25965)
        (5 17752)
        (4 17140)
        (3 34001)
        (1 15961)
        (0 1097422)
        (2 32038)))
   (2
    (vs (15 81)
        (12 122)
        (11 232)
        (10 300)
        (14 29)
        (13 82)
        (9 171)
        (7 2059)
        (6 2065)
        (8 1417)
        (5 1655)
        (4 1375)
        (3 2075)
        (0 56461)
        (2 151632)
        (1 176827)))
   (1
    (vs (8 2258)
        (7 2161)
        (6 1862)
        (5 1258)
        (4 1355)
        (3 2866)
        (0 53953)
        (2 3050)
        (1 2503148))))
  (assimilate
   3871017
   (16 (into (5 84) (1 51) (2 18) (4 110) (3 122)))
   (15 (into (5 63) (4 678) (2 933) (3 1087) (1 682)))
   (14 (into (5 2) (4 336) (1 978) (3 920) (2 1241)))
   (13 (into (5 1) (4 320) (3 717) (1 1671) (2 1817)))
   (11 (into (5 184) (4 790) (2 2594) (3 1676) (1 2339)))
   (12 (into (5 10) (4 480) (3 691) (2 1125) (1 1926)))
   (10 (into (5 28) (4 1274) (1 2234) (3 3821) (2 3492)))
   (9 (into (5 21) (4 1007) (1 3391) (3 2999) (2 2465)))
   (8 (into (9 26780) (1 27398) (8 26367) (7 31) (4 507) (3 2305) (2 15432)))
   (7
    (into (9 9537)
          (8 25203)
          (7 23356)
          (6 70)
          (4 649)
          (3 1687)
          (1 27115)
          (2 14237)))
   (6
    (into (9 5691)
          (8 9492)
          (7 13623)
          (6 34348)
          (5 116)
          (4 605)
          (3 757)
          (2 10708)
          (1 31664)))
   (5
    (into (9 2686)
          (8 776)
          (5 26007)
          (7 4163)
          (6 18477)
          (4 838)
          (3 2117)
          (1 20044)
          (2 6445)))
   (4
    (into (9 267)
          (8 4713)
          (7 10397)
          (6 15473)
          (5 13983)
          (4 18633)
          (3 811)
          (2 6352)
          (1 27292)))
   (3
    (into (8 9768)
          (9 20636)
          (5 7527)
          (7 18744)
          (6 12453)
          (2 14614)
          (1 40786)
          (4 14470)
          (3 17243)))
   (0 (into (5 1882) (4 39143) (3 101311) (2 429876) (1 525210)))
   (2
    (into (9 13904)
          (8 31247)
          (7 13457)
          (6 8439)
          (5 8974)
          (4 11900)
          (1 44443)
          (3 15354)
          (2 32384)))
   (1
    (into (9 4195)
          (8 5890)
          (6 18340)
          (5 21435)
          (7 13884)
          (4 31509)
          (2 1410858)
          (3 34357)
          (1 365254)))))
 (invocation 2297448 (amb-choose 201296)))
;Value 4498: #[sudoku-board 4498]

1 ]=> (apply + (map cdr (cdr '(length (22 2)
          (17 23)
          (18 8)
          (19 9)
          (16 70)
          (15 110)
          (13 248)
          (14 192)
          (10 446)
          (12 329)
          (11 373)
          (1 59)
          (9 469)
          (8 605)
          (7 660)
          (6 906)
          (5 1003)
          (3 1031)
          (4 1297)
          (2 534)))))

;The object (23), passed as the first argument to integer-add, is not the correct type.
;To continue, call RESTART with an option number:
; (RESTART 1) => Return to read-eval-print level 1.

2 error>   C-c C-c
;Quit!

1 ]=> (apply + (map cadr (cdr '(length (22 2)
          (17 23)
          (18 8)
          (19 9)
          (16 70)
          (15 110)
          (13 248)
          (14 192)
          (10 446)
          (12 329)
          (11 373)
          (1 59)
          (9 469)
          (8 605)
          (7 660)
          (6 906)
          (5 1003)
          (3 1031)
          (4 1297)
          (2 534)))))

;Value: 8374

1 ]=> (generate-uninterned-symbol)

;Value 4499: #[uninterned-symbol 4499 |G640|]

1 ]=> (generate-uninterned-symbol)

;Value 4500: #[uninterned-symbol 4500 |G641|]

1 ]=> (apropos "environment")

#[package 1114 (user)]
#[package 1115 ()]
*make-environment
->environment
access-environment
breakpoint/environment
capture-syntactic-environment
compiled-code-block/environment
compiled-procedure/environment
compiler:optimize-environments?
condition-type:fasdump-environment
debugging-info/undefined-environment?
delete-environment-variable!
environment->package
environment-arguments
environment-assign!
environment-assignable?
environment-assigned?
environment-bindings
environment-bound-names
environment-bound?
environment-definable?
environment-define
environment-define-macro
environment-extension-aux-list
environment-extension-parent
environment-extension-procedure
environment-extension?
environment-has-parent?
environment-lambda
environment-link-name
environment-lookup
environment-lookup-macro
environment-macro-names
environment-parent
environment-procedure-name
environment-reference-type
environment-safe-lookup
environment?
extend-ic-environment
extend-top-level-environment
get-environment-variable
guarantee-environment
guarantee-syntactic-environment
ic-environment?
interpreter-environment?
make-null-interpreter-environment
make-root-top-level-environment
make-the-environment
make-top-level-environment
nearest-repl/environment
package/environment
procedure-environment
process-environment-bind
promise-environment
repl/environment
reverse-syntactic-environments
scheme-subprocess-environment
set-environment-extension-parent!
set-environment-variable!
set-repl/environment!
syntactic-closure/environment
syntactic-environment->environment
syntactic-environment/lookup
syntactic-environment/top-level?
syntactic-environment?
system-global-environment
system-global-environment?
the-environment
the-environment?
top-level-environment?
user-initial-environment
;Unspecified return value

1 ]=> (pp environment-define)
(named-lambda (environment-define environment name value)
  (cond ((interpreter-environment? environment)
         (interpreter-environment/define environment name value))
        ((or (stack-ccenv? environment)
             (closure-ccenv? environment))
         (error:bad-range-argument environment (quote environment-define)))
        (else (illegal-environment environment (quote environment-define)))))
;Unspecified return value

1 ]=> (pp environment-assign!)
(named-lambda (environment-assign! environment name value)
  (cond ((interpreter-environment? environment)
         (interpreter-environment/assign! environment name value))
        ((stack-ccenv? environment)
         (stack-ccenv/assign! environment name value))
        ((closure-ccenv? environment)
         (closure-ccenv/assign! environment name value))
        (else (illegal-environment environment (quote environment-assign!)))))
;Unspecified return value

1 ]=> (pp illegal-environment)

;Unbound variable: illegal-environment
;To continue, call RESTART with an option number:
; (RESTART 3) => Specify a value to use instead of illegal-environment.
; (RESTART 2) => Define illegal-environment to a given value.
; (RESTART 1) => Return to read-eval-print level 1.

2 error>   C-c C-c
;Quit!

1 ]=> (pp (access (->environment environment-assign!) illegal-environment))

;Ill-formed special form: (access (->environment environment-assign!) illegal-environment)
;To continue, call RESTART with an option number:
; (RESTART 1) => Return to read-eval-print level 1.

2 error>   C-c C-c
;Quit!

1 ]=> (pp (access illegal-environment (->environment environment-assign!)))
(named-lambda (illegal-environment object name)
  (error:wrong-type-argument object "environment" name))
;Unspecified return value

1 ]=> (pp environment-link-name)
(named-lambda (environment-link-name target-environment source-environment name)
  (link-variables target-environment name source-environment name))
;Unspecified return value

1 ]=> interpreter-environment?

;Value 4501: #[compiled-procedure 4501 ("uenvir" #x1f) #xc #x19f71c]

1 ]=> stack-ccenv?

;Unbound variable: stack-ccenv?
;To continue, call RESTART with an option number:
; (RESTART 3) => Specify a value to use instead of stack-ccenv?.
; (RESTART 2) => Define stack-ccenv? to a given value.
; (RESTART 1) => Return to read-eval-print level 1.

2 error>   C-c C-c
;Quit!

1 ]=> (access stack-ccenv? (->environment environment-assign!))

;Value 4502: #[compiled-procedure 4502 ("uenvir" #x42) #xf #x1a0d63]

1 ]=> (access closure-ccenv? (->environment environment-assign!))

;Value 4503: #[compiled-procedure 4503 ("uenvir" #x5b) #xf #x1a2a8f]

1 ]=> frob

;Unbound variable: frob
;To continue, call RESTART with an option number:
; (RESTART 3) => Specify a value to use instead of frob.
; (RESTART 2) => Define frob to a given value.
; (RESTART 1) => Return to read-eval-print level 1.

2 error>   C-c C-c
;Quit!

1 ]=> (environment-define (the-environment) 'frob 4)

;Value: frob

1 ]=> frob

;Value: 4

1 ]=> (define frob (generate-uninterned-symbol))

;Value: frob

1 ]=> frob

;Value 4504: #[uninterned-symbol 4504 |G642|]

1 ]=> (environment-define (the-environment) frob 4)

;Value 4504: #[uninterned-symbol 4504 |G642|]

1 ]=> (eval frob (the-environment))

;Value: 4

1 ]=> (environment-define (the-environment) frob 8)

;Value 4504: #[uninterned-symbol 4504 |G642|]

1 ]=> (eval frob (the-environment))

;Value: 8

1 ]=> (syntactic-environment? (the-environment))

;Value: #t

1 ]=> (pp interpreter-environment/define)

;Unbound variable: interpreter-environment/define
;To continue, call RESTART with an option number:
; (RESTART 3) => Specify a value to use instead of interpreter-environment/define.
; (RESTART 2) => Define interpreter-environment/define to a given value.
; (RESTART 1) => Return to read-eval-print level 1.

2 error>   C-c C-c
;Quit!

1 ]=> (pp (access interpreter-environment/define (->environment environment-define)))
(named-lambda (interpreter-environment/define environment name value)
  (local-assignment environment name value))
;Unspecified return value

1 ]=> (pp (access local-assignment (->environment environment-define)))
local-assignment
;Unspecified return value

1 ]=> (access interpreter-environment/define (->environment environment-define))

;Value 4505: #[compiled-procedure 4505 (interpreter-environment/define "uenvir" #x26) #xf #x19fadb]

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
;Value 4506: #[test-group 4506]

1 ]=> (prof:show-stats)
()
;Unspecified return value

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
;      Compiling procedure: prof:node-get-child... done
;      Compiling procedure: prof:subnode... done
;      Compiling procedure: prof:node-child-test... done
;      Compiling procedure: |#[unnamed-procedure]|... done
;      Compiling procedure: incrementation-form... done
;      Compiling procedure: node-access-form... done
;      Compiling procedure: fresh-symbol... done
;      Compiling procedure: emit-unevaluated-reference... done
;      Compiling procedure: prof:stats... done
;      Compiling procedure: prof:node-clean-copy... done
;      Compiling procedure: prof:show-stats... done
;      Compiling procedure: prof:reset-stats!... done
;      Compiling procedure: prof:node-reset!... done
;      Compiling procedure: prof:with-reset... 
;Warning: Possible inapplicable operator ()
;      ... done
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
;      Generating SCode for file: "scheduler.scm" => "scheduler.bin"... 
;Warning: Unreferenced bound variable: value (|#[unnamed-procedure]| order-preserving-insert)
;        Dumping "scheduler.bin"... done
;      ... done
;      Compiling file: "scheduler.bin" => "scheduler.com"... 
;        Loading "scheduler.bin"... done
;        Compiling procedure: initialize-scheduler... done
;        Compiling procedure: any-propagators-alerted?... done
;        Compiling procedure: clear-alerted-propagators!... done
;        Compiling procedure: order-preserving-insert... done
;        Compiling procedure: push!... done
;        Compiling procedure: ordered-key-list... done
;        Compiling procedure: alert-propagators... done
;        Compiling procedure: alert-all-propagators!... done
;        Compiling procedure: the-alerted-propagators... done
;        Compiling procedure: with-process-abortion... done
;        Compiling procedure: abort-process... done
;        Compiling procedure: run-alerted... done
;        Compiling procedure: run... done
;        Dumping "scheduler.bci"... done
;        Dumping "scheduler.com"... done
;      ... done
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
;        Compiling procedure: binary-amb... 
;Warning: Coalescing two copies of constant object (0)
;Warning: Coalescing two copies of constant object (0)
;        ... done
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
;Value 4667: #[test-group 4667]

1 ]=> (prof:show-stats)
()
;Unspecified return value

1 ]=> *prof:statistics*

;Value 4668: (0 (hairy-macro-test 0 (data 0) (bar 0) (foo 0)) (nogood 0 (by-computation 0) (assimilate 0) (length 0) (by-resolution 0)) (pairwise-union 0) (tms 0 (assimilate 0) (subsume 0)) (invocation 0 (amb-choose 0)))

1 ]=> (show-time (lambda () (let loop ((i 0)) (if (< i 10000000) (loop (+ i 1)) i))))
process time: 43560 (43500 RUN + 60 GC); real time: 45343
;Value: 10000000

1 ]=> (show-time (lambda () (let loop ((i 0)) (if (< i 10000000) (loop (fix:+ i 1)) i))))
process time: 42300 (42240 RUN + 60 GC); real time: 45733
;Value: 10000000

1 ]=> (show-time (lambda () (let loop ((i 0)) (if (< i 10000000) (loop (fix:+ i 1)) i))))
process time: 42710 (42660 RUN + 50 GC); real time: 44832
;Value: 10000000

1 ]=> (show-time (lambda () (let loop ((i 0)) (if (< i 10000000) (loop i) i))))
  C-c C-c
;Quit!

1 ]=> (show-time (lambda () (let loop ((i 0) (j 0)) (if (< i 10000000) (loop (fix:+ i 1) j) j))))
process time: 43870 (43790 RUN + 80 GC); real time: 47264
;Value: 0

1 ]=> (cf "foo")

;Generating SCode for file: "foo.scm" => "foo.bin"... 
;Unable to open file "/home/axch/phd/thesis/foo.scm" because: No such file or directory.
;To continue, call RESTART with an option number:
; (RESTART 3) => Try to open the same file again.
; (RESTART 2) => Try to open a different file.
; (RESTART 1) => Return to read-eval-print level 1.

2 error>   C-c C-c
;Quit!

1 ]=> (cd "extensions")

;Value 4669: #[pathname 4669 "/home/axch/phd/thesis/extensions/"]

1 ]=> (cf "foo")

;Generating SCode for file: "foo.scm" => "foo.bin"... 
;Unable to open file "/home/axch/phd/thesis/extensions/foo.scm" because: No such file or directory.
;To continue, call RESTART with an option number:
; (RESTART 3) => Try to open the same file again.
; (RESTART 2) => Try to open a different file.
; (RESTART 1) => Return to read-eval-print level 1.

2 error>   C-c C-c
;Quit!

1 ]=> (cd "../examples")

;Value 4670: #[pathname 4670 "/home/axch/phd/thesis/examples/"]

1 ]=> (cf "foo")

;Generating SCode for file: "foo.scm" => "foo.bin"... 
;  Dumping "foo.bin"... done
;... done
;Compiling file: "foo.bin" => "foo.com"... 
;  Loading "foo.bin"... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Dumping "foo.bci"... done
;  Dumping "foo.com"... done
;... done
;Unspecified return value

1 ]=> (load "foo")

;Loading "foo.com"... done
process time: 110 (110 RUN + 0 GC); real time: 136
process time: 70 (70 RUN + 0 GC); real time: 86
process time: 70 (70 RUN + 0 GC); real time: 87
process time: 80 (80 RUN + 0 GC); real time: 93
;Value: 10000000

1 ]=> (cf "foo")

;Generating SCode for file: "foo.scm" => "foo.bin"... 
;  Dumping "foo.bin"... done
;... done
;Compiling file: "foo.bin" => "foo.com"... 
;  Loading "foo.bin"... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Dumping "foo.bci"... done
;  Dumping "foo.com"... done
;... done
;Unspecified return value

1 ]=> (load "foo")

;Loading "foo.com"... done
process time: 200 (200 RUN + 0 GC); real time: 228
process time: 150 (150 RUN + 0 GC); real time: 162
process time: 140 (140 RUN + 0 GC); real time: 164
process time: 150 (150 RUN + 0 GC); real time: 177
;Value: 20000000

1 ]=> (expt 2 23)

;Value: 8388608

1 ]=> (expt 2 24)

;Value: 16777216

1 ]=> (expt 2 26)

;Value: 67108864

1 ]=> (cf "foo")
o
;Generating SCode for file: "foo.scm" => "foo.bin"... 
;  Dumping "foo.bin"... done
;... done
;Compiling file: "foo.bin" => "foo.com"... 
;  Loading "foo.bin"... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Dumping "foo.bci"... done
;  Dumping "foo.com"... done
;... done
;Unspecified return value

1 ]=> (load "foo")

;Loading "foo.com"... done
process time: 94340 (91870 RUN + 2470 GC); real time: 102230
  C-c C-c;Quit!

1 ]=> (fix:* 1000 1000)

;Value: 1000000

1 ]=> (fix:* 1000 1000 1000)

;The procedure multiply-fixnum has been called with 3 arguments; it requires exactly 2 arguments.
;To continue, call RESTART with an option number:
; (RESTART 1) => Return to read-eval-print level 1.

2 error>   C-c C-c
;Quit!

1 ]=> (fix:* (fix:* 1000 1000) 1000)

;The object 1000000, passed as the first argument to multiply-fixnum, is not in the correct range.
;To continue, call RESTART with an option number:
; (RESTART 2) => Specify an argument to use in its place.
; (RESTART 1) => Return to read-eval-print level 1.

2 error>   C-c C-c
;Quit!

1 ]=> (cf "foo")

;Generating SCode for file: "foo.scm" => "foo.bin"... 
;  Dumping "foo.bin"... done
;... done
;Compiling file: "foo.bin" => "foo.com"... 
;  Loading "foo.bin"... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Dumping "foo.bci"... done
;  Dumping "foo.com"... done
;... done
;Unspecified return value

1 ]=> (load "foo")

;Loading "foo.com"... done
process time: 190 (190 RUN + 0 GC); real time: 204
  C-c C-c;Quit!

1 ]=> (cf "foo")

;Generating SCode for file: "foo.scm" => "foo.bin"... 
;  Dumping "foo.bin"... done
;... done
;Compiling file: "foo.bin" => "foo.com"... 
;  Loading "foo.bin"... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Dumping "foo.bci"... done
;  Dumping "foo.com"... done
;... done
;Unspecified return value

1 ]=> (load "foo")

;Loading "foo.com"... done
process time: 200 (200 RUN + 0 GC); real time: 222
;oops
;To continue, call RESTART with an option number:
; (RESTART 1) => Return to read-eval-print level 1.

2 error>   C-c C-c
;Quit!

1 ]=> (load "foo")

;Warning: Source file newer than binary: "/home/axch/phd/thesis/examples/foo.com"
;Loading "foo.com"... done
process time: 170 (170 RUN + 0 GC); real time: 206
  C-c C-c;Quit!

1 ]=> (cf "foo")

;Generating SCode for file: "foo.scm" => "foo.bin"... 
;  Dumping "foo.bin"... done
;... done
;Compiling file: "foo.bin" => "foo.com"... 
;  Loading "foo.bin"... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Dumping "foo.bci"... done
;  Dumping "foo.com"... done
;... done
;Unspecified return value

1 ]=> (load "foo")

;Loading "foo.com"... done
process time: 190 (190 RUN + 0 GC); real time: 217
;oops -33554432
;To continue, call RESTART with an option number:
; (RESTART 1) => Return to read-eval-print level 1.

2 error> (fixnum? (expt 2 25))

;Value: #f

2 error> (fixnum? (expt 2 24))

;Value: #t

2 error>   C-c C-c
;Quit!

1 ]=> (pp make-initialized-vector)
(named-lambda (make-initialized-vector length initialization)
  (let ((vector (make-vector length)))
    ((let ()
       (define loop
         (lambda (index)
           (if (less-than-fixnum? index length)
               (begin (vector-set! vector index (initialization index))
                      (loop (plus-fixnum index 1))))))
       loop)
     0)
    vector))
;Unspecified return value

1 ]=> (cf "foo")

;Generating SCode for file: "foo.scm" => "foo.bin"... 
;  Dumping "foo.bin"... done
;... done
;Compiling file: "foo.bin" => "foo.com"... 
;  Loading "foo.bin"... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Dumping "foo.bci"... done
;  Dumping "foo.com"... done
;... done
;Unspecified return value

1 ]=> (load "foo")

;Loading "foo.com"... done
process time: 200 (200 RUN + 0 GC); real time: 222
process time: 150 (150 RUN + 0 GC); real time: 168
process time: 160 (160 RUN + 0 GC); real time: 162
process time: 160 (160 RUN + 0 GC); real time: 174
process time: 360 (360 RUN + 0 GC); real time: 373
;Value: 100000

1 ]=> (cf "foo")

;Generating SCode for file: "foo.scm" => "foo.bin"... 
;  Dumping "foo.bin"... done
;... done
;Compiling file: "foo.bin" => "foo.com"... 
;  Loading "foo.bin"... done
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
;  Dumping "foo.bci"... done
;  Dumping "foo.com"... done
;... done
;Unspecified return value

1 ]=> (load "foo")

;Loading "foo.com"... done
process time: 190 (190 RUN + 0 GC); real time: 220
process time: 150 (150 RUN + 0 GC); real time: 162
process time: 140 (140 RUN + 0 GC); real time: 167
process time: 150 (150 RUN + 0 GC); real time: 176
process time: 340 (340 RUN + 0 GC); real time: 382
process time: 10 (10 RUN + 0 GC); real time: 1
;The procedure #[compiled-procedure 4716 ("hashtb" #x3e) #xf #x164b07] has been called with 2 arguments; it requires exactly 3 arguments.
;To continue, call RESTART with an option number:
; (RESTART 1) => Return to read-eval-print level 1.

2 error>   C-c C-c
;Quit!

1 ]=> (cf "foo")

;Generating SCode for file: "foo.scm" => "foo.bin"... 
;  Dumping "foo.bin"... done
;... done
;Compiling file: "foo.bin" => "foo.com"... 
;  Loading "foo.bin"... done
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
;  Dumping "foo.bci"... done
;  Dumping "foo.com"... done
;... done
;Unspecified return value

1 ]=> (load "foo")

;Loading "foo.com"... done
process time: 200 (200 RUN + 0 GC); real time: 218
process time: 150 (150 RUN + 0 GC); real time: 161
process time: 160 (160 RUN + 0 GC); real time: 164
process time: 160 (160 RUN + 0 GC); real time: 177
process time: 360 (360 RUN + 0 GC); real time: 374
process time: 0 (0 RUN + 0 GC); real time: 1
process time: 10 (10 RUN + 0 GC); real time: 10
;Value: 100000

1 ]=> (cf "foo")

;Generating SCode for file: "foo.scm" => "foo.bin"... 
;  Dumping "foo.bin"... done
;... done
;Compiling file: "foo.bin" => "foo.com"... 
;  Loading "foo.bin"... done
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
;  Dumping "foo.bci"... done
;  Dumping "foo.com"... done
;... done
;Unspecified return value

1 ]=> (load "foo")

;Loading "foo.com"... done
process time: 200 (200 RUN + 0 GC); real time: 224
process time: 150 (150 RUN + 0 GC); real time: 163
process time: 150 (150 RUN + 0 GC); real time: 164
process time: 150 (150 RUN + 0 GC); real time: 175
process time: 3600 (3600 RUN + 0 GC); real time: 3657
process time: 20 (20 RUN + 0 GC); real time: 16
process time: 100 (100 RUN + 0 GC); real time: 115
;Value: 1000000

1 ]=> (pp hash-table/update)

;Unbound variable: hash-table/update
;To continue, call RESTART with an option number:
; (RESTART 3) => Specify a value to use instead of hash-table/update.
; (RESTART 2) => Define hash-table/update to a given value.
; (RESTART 1) => Return to read-eval-print level 1.

2 error>   C-c C-c
;Quit!

1 ]=> (pp hash-table/update!)

;Unbound variable: hash-table/update!
;To continue, call RESTART with an option number:
; (RESTART 3) => Specify a value to use instead of hash-table/update!.
; (RESTART 2) => Define hash-table/update! to a given value.
; (RESTART 1) => Return to read-eval-print level 1.

2 error>   C-c C-c
;Quit!

1 ]=> (cf "foo")

;Generating SCode for file: "foo.scm" => "foo.bin"... 
;  Dumping "foo.bin"... done
;... done
;Compiling file: "foo.bin" => "foo.com"... 
;  Loading "foo.bin"... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... done
;  Compiling procedure: |#[unnamed-procedure]|... 
;Warning: Procedure called with wrong number of arguments #[primitive-procedure vector-set!] 3
;Primitive called with incorrect number of arguments. #[primitive-procedure vector-set!] 3 2
;To continue, call RESTART with an option number:
; (RESTART 1) => Return to read-eval-print level 1.

2 error>   C-c C-c
;Quit!

1 ]=> (cf "foo")

;Generating SCode for file: "foo.scm" => "foo.bin"... 
;  Dumping "foo.bin"... done
;... done
;Compiling file: "foo.bin" => "foo.com"... 
;  Loading "foo.bin"... done
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
;  Dumping "foo.bci"... done
;  Dumping "foo.com"... done
;... done
;Unspecified return value

1 ]=> (load "foo")

;Loading "foo.com"... done
process time: 190 (190 RUN + 0 GC); real time: 211
process time: 140 (140 RUN + 0 GC); real time: 163
process time: 150 (150 RUN + 0 GC); real time: 164
process time: 170 (170 RUN + 0 GC); real time: 177
process time: 3520 (3520 RUN + 0 GC); real time: 3653
process time: 30 (30 RUN + 0 GC); real time: 31
process time: 260 (260 RUN + 0 GC); real time: 270
;Value: 1008100

1 ]=> (cf "foo")

;Generating SCode for file: "foo.scm" => "foo.bin"... 
;  Dumping "foo.bin"... done
;... done
;Compiling file: "foo.bin" => "foo.com"... 
;  Loading "foo.bin"... done
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
;  Dumping "foo.bci"... done
;  Dumping "foo.com"... done
;... done
;Unspecified return value

1 ]=> (load "foo")

;Loading "foo.com"... done
process time: 210 (210 RUN + 0 GC); real time: 239
process time: 150 (150 RUN + 0 GC); real time: 161
process time: 150 (150 RUN + 0 GC); real time: 164
process time: 170 (170 RUN + 0 GC); real time: 174
(90 . 1008100)
process time: 3440 (3440 RUN + 0 GC); real time: 3647
1008100
process time: 30 (30 RUN + 0 GC); real time: 32
1008100
process time: 230 (230 RUN + 0 GC); real time: 278
;Unspecified return value

1 ]=> (cf "foo")

;Generating SCode for file: "foo.scm" => "foo.bin"... 
;  Dumping "foo.bin"... done
;... done
;Compiling file: "foo.bin" => "foo.com"... 
;  Loading "foo.bin"... done
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
;  Dumping "foo.bci"... done
;  Dumping "foo.com"... done
;... done
;Unspecified return value

1 ]=> (load "foo")

;Loading "foo.com"... done
process time: 200 (200 RUN + 0 GC); real time: 214
process time: 140 (140 RUN + 0 GC); real time: 161
process time: 160 (160 RUN + 0 GC); real time: 163
process time: 150 (150 RUN + 0 GC); real time: 175
(90 . 10008100)
process time: 35220 (35220 RUN + 0 GC); real time: 36841
10008100
process time: 300 (300 RUN + 0 GC); real time: 682
10008100
process time: 2530 (2530 RUN + 0 GC); real time: 2594
;Unspecified return value

1 ]=> (cf "foo")

;Generating SCode for file: "foo.scm" => "foo.bin"... 
;  Dumping "foo.bin"... done
;... done
;Compiling file: "foo.bin" => "foo.com"... 
;  Loading "foo.bin"... done
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
;  Dumping "foo.bci"... done
;  Dumping "foo.com"... done
;... done
;Unspecified return value

1 ]=> (load "foo")

;Loading "foo.com"... done
process time: 200 (200 RUN + 0 GC); real time: 216
process time: 150 (150 RUN + 0 GC); real time: 163
process time: 150 (150 RUN + 0 GC); real time: 164
process time: 160 (160 RUN + 0 GC); real time: 175
(9 . 10000081)
process time: 4330 (4330 RUN + 0 GC); real time: 4442
10000081
process time: 310 (310 RUN + 0 GC); real time: 333
10000081
process time: 2390 (2390 RUN + 0 GC); real time: 2562
;Unspecified return value

1 ]=> (cf "foo")

;Generating SCode for file: "foo.scm" => "foo.bin"... 
;  Dumping "foo.bin"... done
;... done
;Compiling file: "foo.bin" => "foo.com"... 
;  Loading "foo.bin"... done
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
;  Dumping "foo.bci"... done
;  Dumping "foo.com"... done
;... done
;Unspecified return value

1 ]=> (load "foo")

;Loading "foo.com"... done
process time: 210 (210 RUN + 0 GC); real time: 232
process time: 150 (150 RUN + 0 GC); real time: 162
process time: 160 (160 RUN + 0 GC); real time: 163
process time: 160 (160 RUN + 0 GC); real time: 173
(9 . 10000081)
process time: 4360 (4360 RUN + 0 GC); real time: 4444
10000081
process time: 320 (320 RUN + 0 GC); real time: 330
10000081
process time: 2520 (2520 RUN + 0 GC); real time: 2568
10000081
process time: 850 (850 RUN + 0 GC); real time: 881
;Unspecified return value

1 ]=> (cf "foo")

;Generating SCode for file: "foo.scm" => "foo.bin"... 
;  Dumping "foo.bin"... done
;... done
;Compiling file: "foo.bin" => "foo.com"... 
;  Loading "foo.bin"... done
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
;  Dumping "foo.bci"... done
;  Dumping "foo.com"... done
;... done
;Unspecified return value

1 ]=> (load "foo")

;Loading "foo.com"... done
process time: 210 (210 RUN + 0 GC); real time: 235
process time: 150 (150 RUN + 0 GC); real time: 163
process time: 160 (160 RUN + 0 GC); real time: 166
process time: 160 (160 RUN + 0 GC); real time: 175
(9 . 10000081)
process time: 4340 (4340 RUN + 0 GC); real time: 4434
10000081
process time: 310 (310 RUN + 0 GC); real time: 332
10000081
process time: 2190 (2190 RUN + 0 GC); real time: 2261
10000081
process time: 850 (850 RUN + 0 GC); real time: 882
;Unspecified return value

1 ]=> (cf "foo")

;Generating SCode for file: "foo.scm" => "foo.bin"... 
;  Dumping "foo.bin"... done
;... done
;Compiling file: "foo.bin" => "foo.com"... 
;  Loading "foo.bin"... done
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
;  Dumping "foo.bci"... done
;  Dumping "foo.com"... done
;... done
;Unspecified return value

1 ]=> (load "foo")

;Loading "foo.com"... done
process time: 200 (200 RUN + 0 GC); real time: 226
process time: 140 (140 RUN + 0 GC); real time: 162
process time: 150 (150 RUN + 0 GC); real time: 164
process time: 160 (160 RUN + 0 GC); real time: 174
(9 . 10000081)
process time: 4210 (4210 RUN + 0 GC); real time: 4792
10000081
process time: 300 (300 RUN + 0 GC); real time: 332
10000081
process time: 3420 (3420 RUN + 0 GC); real time: 3609
10000081
process time: 840 (840 RUN + 0 GC); real time: 880
;Unspecified return value

1 ]=> (cf "foo")

;Generating SCode for file: "foo.scm" => "foo.bin"... 
;  Dumping "foo.bin"... done
;... done
;Compiling file: "foo.bin" => "foo.com"... 
;  Loading "foo.bin"... done
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
;  Dumping "foo.bci"... done
;  Dumping "foo.com"... done
;... done
;Unspecified return value

1 ]=> (load "foo")

;Loading "foo.com"... done
process time: 190 (190 RUN + 0 GC); real time: 202
process time: 150 (150 RUN + 0 GC); real time: 162
process time: 150 (150 RUN + 0 GC); real time: 163
process time: 160 (160 RUN + 0 GC); real time: 174
(9 . 10000081)
process time: 4190 (4190 RUN + 0 GC); real time: 4441
10000081
process time: 300 (300 RUN + 0 GC); real time: 330
10000081
process time: 2500 (2500 RUN + 0 GC); real time: 2567
10000081
process time: 850 (850 RUN + 0 GC); real time: 882
20000081
process time: 2990 (2990 RUN + 0 GC); real time: 3088
;Unspecified return value

1 ]=> (pp make-vector)
(named-lambda (make-vector size #!optional fill)
  (if (not (index-fixnum? size))
      (error:wrong-type-argument size "vector index" (quote make-vector)))
  (vector-cons size (if (eq? fill #!default) #f fill)))
;Unspecified return value

1 ]=> (pp fix:<)
less-than-fixnum?
;Unspecified return value

1 ]=> (pp vector-set!)
vector-set!
;Unspecified return value

1 ]=> vector-set!

;Value: #[primitive-procedure vector-set!]

1 ]=> vector-for-each

;Value 4842: #[compiled-procedure 4842 ("vector" #xe) #xf #x1da907]

1 ]=> (pp vector-for-each)
(named-lambda (vector-for-each procedure vector . vectors)
  (if (not (vector? vector))
      (error:wrong-type-argument vector "vector" (quote vector-for-each)))
  (for-each
   (lambda (v)
     (if (not (vector? v))
         (error:wrong-type-argument v "vector" (quote vector-for-each))))
   vectors)
  (let ((n (vector-length vector)))
    (for-each
     (lambda (v)
       (if (not (eq? (vector-length v) n))
           (error:bad-range-argument v (quote vector-for-each))))
     vectors)
    ((let ()
       (define do-loop
         (lambda (i)
           (if (less-than-fixnum? i n)
               (begin
                ((access apply #f)
                 procedure
                 (cons (vector-ref vector i)
                       (map (lambda (v) (vector-ref v i)) vectors)))
                (do-loop (plus-fixnum i 1))))))
       do-loop)
     0)))
;Unspecified return value

1 ]=> (pwd)

;Value 4670: #[pathname 4670 "/home/axch/phd/thesis/examples/"]

1 ]=> (cd "..")

;Value 4843: #[pathname 4843 "/home/axch/phd/thesis/"]

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
;Value 4844: #[test-group 4844]

1 ]=> 
;Loading "examples/sudoku.scm"... done
;Unspecified return value

1 ]=> (prof:with-reset
 (lambda ()
   (show-time
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
	 (0 3 1 0 0 0 5 0 0)))))))
327194658
846325179
519687243
172563894
653948721
498712365
764851932
985236417
231479586
process time: 260310 (246760 RUN + 13550 GC); real time: 281757
((pairwise-union
  (54 (with (3 1)))
  (58 (with (3 1)))
  (1
   (with (1 1942)
         (2 451)
         (3 260)
         (4 137)
         (5 96)
         (6 60)
         (7 50)
         (8 38)
         (9 23)
         (10 21)
         (11 20)
         (12 7)
         (13 10)
         (14 5)
         (15 10)
         (16 7)
         (17 11)
         (18 4)
         (19 5)
         (20 3)
         (22 4)
         (23 4)
         (24 1)
         (25 3)))
  (2
   (with (1 589)
         (2 232)
         (3 124)
         (4 54)
         (5 32)
         (6 21)
         (7 18)
         (8 16)
         (9 12)
         (10 11)
         (11 5)
         (12 4)
         (13 3)
         (14 1)
         (15 1)
         (16 1)
         (17 1)
         (18 1)
         (19 3)
         (20 1)
         (21 1)
         (22 2)
         (23 3)
         (26 2)))
  (3
   (with (1 437)
         (2 178)
         (3 96)
         (4 52)
         (5 34)
         (6 17)
         (7 16)
         (8 8)
         (9 6)
         (10 5)
         (11 7)
         (12 7)
         (13 2)
         (14 3)
         (15 4)
         (16 1)
         (17 2)
         (19 1)))
  (4
   (with (1 318)
         (2 136)
         (3 70)
         (4 34)
         (5 30)
         (6 20)
         (7 13)
         (8 16)
         (9 4)
         (10 5)
         (11 3)
         (12 2)
         (13 1)
         (14 2)
         (15 2)
         (16 1)
         (17 3)))
  (5
   (with (1 254)
         (2 82)
         (3 50)
         (4 29)
         (5 22)
         (6 14)
         (7 9)
         (8 8)
         (9 7)
         (10 5)
         (12 4)
         (13 3)
         (15 1)
         (21 1)
         (24 1)))
  (6
   (with (1 173)
         (2 68)
         (3 26)
         (4 19)
         (5 19)
         (6 10)
         (7 9)
         (8 8)
         (9 2)
         (10 5)
         (13 1)
         (23 1)))
  (7
   (with (1 119)
         (2 33)
         (3 27)
         (4 17)
         (5 7)
         (6 5)
         (7 5)
         (8 3)
         (9 4)
         (10 2)
         (11 1)
         (12 4)
         (14 1)
         (17 1)
         (18 1)
         (28 1)))
  (8
   (with (1 86)
         (2 38)
         (3 16)
         (4 10)
         (5 10)
         (6 2)
         (7 1)
         (8 3)
         (9 1)
         (10 2)
         (11 2)
         (13 1)
         (16 1)))
  (9 (with (1 67) (2 36) (3 8) (4 8) (5 4) (6 4) (7 2) (9 1) (11 2) (12 2)))
  (10 (with (1 52) (2 14) (3 9) (4 7) (5 5) (6 2) (7 3) (12 2) (20 1) (33 1)))
  (11 (with (1 40) (2 20) (3 12) (4 3) (5 6) (6 3) (7 1) (8 2)))
  (12
   (with (1 37)
         (2 15)
         (3 2)
         (4 5)
         (5 2)
         (6 3)
         (7 5)
         (8 3)
         (10 1)
         (11 1)
         (20 1)
         (26 1)))
  (13 (with (1 36) (2 11) (3 4) (4 2) (5 2) (7 3) (8 1) (10 1) (13 1) (17 1)))
  (14 (with (1 18) (2 7) (3 2) (4 1) (5 1) (6 1) (7 1) (12 2)))
  (15 (with (1 16) (2 5) (3 3) (4 2) (5 3) (7 1) (8 2) (14 1) (17 1)))
  (16 (with (1 14) (2 2) (3 1) (5 1) (6 1) (11 1)))
  (17 (with (1 9) (2 1) (3 3) (4 4) (6 1) (7 1) (11 1) (15 1)))
  (18 (with (1 5) (2 1) (4 3) (5 1) (6 1) (7 2)))
  (19 (with (1 5) (2 3) (3 1) (4 2) (6 1) (9 1) (12 1)))
  (20 (with (1 6) (3 1) (5 1) (6 1)))
  (21 (with (1 3) (3 1) (4 1)))
  (22 (with (1 5) (2 2) (3 1)))
  (23 (with (1 3) (3 1)))
  (24 (with (3 1) (5 1) (6 1) (10 1)))
  (25 (with (1 2) (2 2) (3 1) (4 1)))
  (26 (with (1 1) (2 3) (3 2) (4 2)))
  (27 (with (1 1) (2 1) (3 1) (10 1)))
  (28 (with (1 1) (5 1)))
  (30 (with (2 3) (21 2)))
  (31 (with (3 1)))
  (33 (with (4 1)))
  (34 (with (3 1) (15 1)))
  (35 (with (2 1) (3 1)))
  (36 (with (4 1)))
  (37 (with (1 1) (6 1)))
  (38 (with (4 1) (12 1)))
  (40 (with (1 1)))
  (41 (with (3 1)))
  (45 (with (1 1) (15 1)))
  (47 (with (1 1)))
  (48 (with (20 1))))
 (nogood
  (by-resolution 7745)
  (assimilate 55483)
  (length (1 59)
          (2 534)
          (3 1031)
          (4 1297)
          (5 1003)
          (6 906)
          (7 660)
          (8 605)
          (9 469)
          (10 446)
          (11 373)
          (12 329)
          (13 248)
          (14 192)
          (15 110)
          (16 70)
          (17 23)
          (18 8)
          (19 9)
          (22 2))
  (by-computation 629))
 (tms
  (subsume
   6962933
   (0
    (vs (0 1097422)
        (1 15961)
        (2 32038)
        (3 34001)
        (4 17140)
        (5 17752)
        (6 25965)
        (7 31087)
        (8 33034)
        (9 9883)
        (10 10849)
        (11 7583)
        (12 4232)
        (13 4526)
        (14 3477)
        (15 3443)
        (16 385)))
   (1
    (vs (0 53953)
        (1 2503148)
        (2 3050)
        (3 2866)
        (4 1355)
        (5 1258)
        (6 1862)
        (7 2161)
        (8 2258)))
   (2
    (vs (0 56461)
        (1 176827)
        (2 151632)
        (3 2075)
        (4 1375)
        (5 1655)
        (6 2065)
        (7 2059)
        (8 1417)
        (9 171)
        (10 300)
        (11 232)
        (12 122)
        (13 82)
        (14 29)
        (15 81)))
   (3
    (vs (0 31593)
        (1 128894)
        (2 102398)
        (3 125464)
        (4 1406)
        (5 767)
        (6 1439)
        (7 1261)
        (8 1474)))
   (4
    (vs (0 216366)
        (1 94669)
        (2 90423)
        (3 84402)
        (4 84865)
        (5 4536)
        (6 3998)
        (7 5323)
        (8 5833)
        (9 4531)
        (10 4933)
        (11 2600)
        (12 2005)
        (13 1218)
        (14 1007)
        (15 1668)
        (16 256)))
   (5
    (vs (0 52625)
        (1 63793)
        (2 78164)
        (3 71295)
        (4 43667)
        (5 66887)
        (6 1950)
        (7 2245)
        (8 2275)))
   (6
    (vs (0 134646)
        (1 42551)
        (2 67967)
        (3 63242)
        (4 32241)
        (5 26039)
        (6 84856)
        (7 3897)
        (8 3618)
        (9 2322)
        (10 2799)
        (11 2292)
        (12 512)
        (13 1048)
        (14 798)
        (15 687)
        (16 29)))
   (7
    (vs (0 22393)
        (1 21673)
        (2 62670)
        (3 49914)
        (4 15020)
        (5 7376)
        (6 27362)
        (7 73568)
        (8 1572)))
   (8
    (vs (0 62190)
        (1 12771)
        (2 57381)
        (3 52553)
        (4 5047)
        (5 7293)
        (6 20632)
        (7 42462)
        (8 88925)
        (9 427)
        (10 1626)
        (11 588)
        (12 532)
        (13 191)
        (14 198)
        (15 147)
        (16 134)))
   (10
    (vs (0 17421)
        (2 4)
        (3 29)
        (4 22)
        (5 50)
        (6 474)
        (7 574)
        (8 318)
        (9 756)
        (10 137)
        (11 513)
        (12 99)
        (13 616)
        (14 2)
        (15 1)
        (16 2)))
   (12
    (vs (0 49620)
        (2 4)
        (3 85)
        (4 89)
        (5 202)
        (6 325)
        (7 719)
        (8 1696)
        (9 1036)
        (10 1587)
        (11 1029)
        (12 433)
        (13 768)
        (14 1683)
        (15 148)
        (16 98)))
   (14
    (vs (0 37650)
        (2 2)
        (3 64)
        (4 123)
        (5 499)
        (6 28)
        (7 151)
        (8 151)
        (9 1498)
        (10 2440)
        (11 1016)
        (12 155)
        (13 219)
        (14 165)
        (15 1611)
        (16 100)))
   (16
    (vs (0 23795)
        (4 30)
        (5 80)
        (6 13)
        (7 84)
        (8 25)
        (9 827)
        (10 1269)
        (11 782)
        (12 197)
        (13 73)
        (14 267)
        (15 1050)
        (16 338))))
  (assimilate
   3871017
   (0 (into (1 525210) (2 429876) (3 101311) (4 39143) (5 1882)))
   (1
    (into (1 365254)
          (2 1410858)
          (3 34357)
          (4 31509)
          (5 21435)
          (6 18340)
          (7 13884)
          (8 5890)
          (9 4195)))
   (2
    (into (1 44443)
          (2 32384)
          (3 15354)
          (4 11900)
          (5 8974)
          (6 8439)
          (7 13457)
          (8 31247)
          (9 13904)))
   (3
    (into (1 40786)
          (2 14614)
          (3 17243)
          (4 14470)
          (5 7527)
          (6 12453)
          (7 18744)
          (8 9768)
          (9 20636)))
   (4
    (into (1 27292)
          (2 6352)
          (3 811)
          (4 18633)
          (5 13983)
          (6 15473)
          (7 10397)
          (8 4713)
          (9 267)))
   (5
    (into (1 20044)
          (2 6445)
          (3 2117)
          (4 838)
          (5 26007)
          (6 18477)
          (7 4163)
          (8 776)
          (9 2686)))
   (6
    (into (1 31664)
          (2 10708)
          (3 757)
          (4 605)
          (5 116)
          (6 34348)
          (7 13623)
          (8 9492)
          (9 5691)))
   (7
    (into (1 27115)
          (2 14237)
          (3 1687)
          (4 649)
          (6 70)
          (7 23356)
          (8 25203)
          (9 9537)))
   (8 (into (1 27398) (2 15432) (3 2305) (4 507) (7 31) (8 26367) (9 26780)))
   (9 (into (1 3391) (2 2465) (3 2999) (4 1007) (5 21)))
   (10 (into (1 2234) (2 3492) (3 3821) (4 1274) (5 28)))
   (11 (into (1 2339) (2 2594) (3 1676) (4 790) (5 184)))
   (12 (into (1 1926) (2 1125) (3 691) (4 480) (5 10)))
   (13 (into (1 1671) (2 1817) (3 717) (4 320) (5 1)))
   (14 (into (1 978) (2 1241) (3 920) (4 336) (5 2)))
   (15 (into (1 682) (2 933) (3 1087) (4 678) (5 63)))
   (16 (into (1 51) (2 18) (3 122) (4 110) (5 84)))))
 (invocation 2297448 (amb-choose 201296)))
;Value 4845: #[sudoku-board 4845]

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
;      Generating SCode for file: "scheduler.scm" => "scheduler.bin"... 
;Warning: Unreferenced bound variable: value (|#[unnamed-procedure]| order-preserving-insert)
;        Dumping "scheduler.bin"... done
;      ... done
;      Compiling file: "scheduler.bin" => "scheduler.com"... 
;        Loading "scheduler.bin"... done
;        Compiling procedure: initialize-scheduler... done
;        Compiling procedure: any-propagators-alerted?... done
;        Compiling procedure: clear-alerted-propagators!... done
;        Compiling procedure: order-preserving-insert... done
;        Compiling procedure: push!... done
;        Compiling procedure: ordered-key-list... done
;        Compiling procedure: alert-propagators... done
;        Compiling procedure: alert-all-propagators!... done
;        Compiling procedure: the-alerted-propagators... done
;        Compiling procedure: with-process-abortion... done
;        Compiling procedure: abort-process... done
;        Compiling procedure: run-alerted... done
;        Compiling procedure: run... done
;        Dumping "scheduler.bci"... done
;        Dumping "scheduler.com"... done
;      ... done
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
;Value 4978: #[test-group 4978]

1 ]=> (load "examples/sudoku")

;Loading "examples/sudoku.scm"... done
;Unspecified return value

1 ]=> (prof:with-reset
 (lambda ()
   (show-time
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
	 (0 3 1 0 0 0 5 0 0)))))))
327194658
846325179
519687243
172563894
653948721
498712365
764851932
985236417
231479586
process time: 339190 (320920 RUN + 18270 GC); real time: 384147
()
;Value 4979: #[sudoku-board 4979]

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
;Value 5109: #[test-group 5109]

1 ]=> (load "examples/sudoku")

;Loading "examples/sudoku.scm"... done
;Unspecified return value

1 ]=> (prof:with-reset
 (lambda ()
   (show-time
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
	 (0 3 1 0 0 0 5 0 0)))))))
327194658
846325179
519687243
172563894
653948721
498712365
764851932
985236417
231479586
process time: 379230 (359130 RUN + 20100 GC); real time: 421018
((nogood (assimilate 55483)))
;Value 5110: #[sudoku-board 5110]

1 ]=> (prof:with-reset
 (lambda ()
   (show-time
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
	 (0 3 1 0 0 0 5 0 0)))))))
327194658
846325179
519687243
172563894
653948721
498712365
764851932
985236417
231479586
process time: 380940 (358930 RUN + 22010 GC); real time: 418091
((nogood (assimilate 55483)))
;Value 5111: #[sudoku-board 5111]

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
;Value 5245: #[test-group 5245]

1 ]=> (load "examples/sudoku")

;Loading "examples/sudoku.scm"... done
;Unspecified return value

1 ]=> (prof:with-reset
 (lambda ()
   (show-time
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
	 (0 3 1 0 0 0 5 0 0)))))))
327194658
846325179
519687243
172563894
653948721
498712365
764851932
985236417
231479586
process time: 396350 (376120 RUN + 20230 GC); real time: 434344
((nogood (by-resolution 7745) (assimilate 55483))
 (invocation (amb-choose 201296))
 (tms (subsume 6962933) (assimilate 3871017)))
;Value 5246: #[sudoku-board 5246]

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
;Value 5375: #[test-group 5375]

1 ]=> (load "examples/sudoku")

;Loading "examples/sudoku.scm"... done
;Unspecified return value

1 ]=> (prof:with-reset
 (lambda ()
   (show-time
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
	 (0 3 1 0 0 0 5 0 0)))))))
327194658
846325179
519687243
172563894
653948721
498712365
764851932
985236417
231479586
process time: 379620 (359370 RUN + 20250 GC); real time: 415758
()
;Value 5376: #[sudoku-board 5376]

1 ]=> (prof:with-reset
 (lambda ()
   (show-time
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
	 (0 3 1 0 0 0 5 0 0)))))))
327194658
846325179
519687243
172563894
653948721
498712365
764851932
985236417
231479586
process time: 381560 (359670 RUN + 21890 GC); real time: 417465
()
;Value 5377: #[sudoku-board 5377]

1 ]=> 
