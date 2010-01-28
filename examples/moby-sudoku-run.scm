Copyright (C) 1986, 1987, 1988, 1989, 1990, 1991, 1992, 1993, 1994,
    1995, 1996, 1997, 1998, 1999, 2000, 2001, 2002, 2003, 2004, 2005,
    2006, 2007, 2008 Massachusetts Institute of Technology
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

Image saved on Thursday April 30, 2009 at 12:19:48 AM
  Release 7.7.90.+ || Microcode 15.1 || Runtime 15.7 || SF 4.41 || LIAR/C 4.118
  Edwin 3.116      || SOS 1.8        || IMAIL 1.21
;You are in an interaction window of the Edwin editor.
;Type `C-h' for help, or `C-h t' for a tutorial.
;`C-h m' will describe some commands.
;`C-h' means: hold down the Ctrl key and type `h'.
;Package: (user)

(gc-flip)
;Value: 511785833

(pwd)
;Value 3: #[pathname 3 "/home/gjs/"]

(cd "metacirc/axch-thesis")
;Value 4: #[pathname 4 "/home/gjs/metacirc/axch-thesis/"]

(load "load")
;Loading "load.scm"... 
;  Loading "new-art/load.scm"... 
;    Loading "../testing/load.scm"... 
;      Loading "portability.scm"... 
;        Loading "mitscheme-conditions.scm"... done
;      ... done
;      Loading "ordered-map.scm"... done
;      Loading "matching.scm"... done
;      Loading "assertions.scm"... done
;      Loading "test-runner.scm"... done
;      Loading "test-group.scm"... done
;      Loading "testing.scm"... done
;    ... done
;    Loading "utils.scm"... done
;    Loading "ghelper.scm"... done
;    Loading "../literate/load.scm"... 
;      Loading "regex-literals.scm"... done
;      Loading "read.scm"... done
;      Loading "test-support.scm"... done
;    ... done
;    Generating SCode for file: "scheduler.scm" => "scheduler.bin"... 
;Warning: Unreferenced bound variable: value (|#[unnamed-procedure]| order-preserving-insert)
;    ... done
;    Compiling file: "scheduler.bin" => "scheduler.c"... 
;      gcc -DHAVE_CONFIG_H -DMIT_SCHEME   -O3 -Wall -Wundef -Wpointer-arith -Winline -Wstrict-prototypes -Wnested-externs -Wredundant-decls -Wextra -Wno-sign-compare -Wno-unused-parameter -Wold-style-definition  -fPIC -DENABLE_LIARC_FILE_INIT -I/usr/local/lib/mit-scheme-c/include -o scheduler.o -c scheduler.c
;      gcc   -shared -fPIC -o scheduler.so scheduler.o
;    ... done
;    Loading "scheduler.so"... done
;    Loading "data-structure-definitions.scm"... done
;    Generating SCode for file: "art.scm" => "art.bin"... 
;Warning: Unreferenced bound variable: content (|#[unnamed-procedure]|)
;Warning: Unreferenced bound variable: increment (|#[unnamed-procedure]|)
;    ... done
;    Compiling file: "art.bin" => "art.c"... 
;      gcc -DHAVE_CONFIG_H -DMIT_SCHEME   -O3 -Wall -Wundef -Wpointer-arith -Winline -Wstrict-prototypes -Wnested-externs -Wredundant-decls -Wextra -Wno-sign-compare -Wno-unused-parameter -Wold-style-definition  -fPIC -DENABLE_LIARC_FILE_INIT -I/usr/local/lib/mit-scheme-c/include -o art.o -c art.c
;      gcc   -shared -fPIC -o art.so art.o
;    ... done
;    Loading "art.so"... 
;      Loading "naive-primitives.scm"... done
;      Loading "generic-primitives.scm"... done
;      Loading "generic-primitives-1-1.scm"... done
;      Generating SCode for file: "generic-primitives-2.scm" => "generic-primitives-2.bin"... 
;Warning: Unreferenced bound variable: v&s (|#[unnamed-procedure]|)
;      ... done
;      Compiling file: "generic-primitives-2.bin" => "generic-primitives-2.c"... 
;        gcc -DHAVE_CONFIG_H -DMIT_SCHEME   -O3 -Wall -Wundef -Wpointer-arith -Winline -Wstrict-prototypes -Wnested-externs -Wredundant-decls -Wextra -Wno-sign-compare -Wno-unused-parameter -Wold-style-definition  -fPIC -DENABLE_LIARC_FILE_INIT -I/usr/local/lib/mit-scheme-c/include -o generic-primitives-2.o -c generic-primitives-2.c
;        gcc   -shared -fPIC -o generic-primitives-2.so generic-primitives-2.o
;      ... done
;      Loading "generic-primitives-2.so"... done
;      Generating SCode for file: "generic-primitives-3.scm" => "generic-primitives-3.bin"... done
;      Compiling file: "generic-primitives-3.bin" => "generic-primitives-3.c"... 
;        gcc -DHAVE_CONFIG_H -DMIT_SCHEME   -O3 -Wall -Wundef -Wpointer-arith -Winline -Wstrict-prototypes -Wnested-externs -Wredundant-decls -Wextra -Wno-sign-compare -Wno-unused-parameter -Wold-style-definition  -fPIC -DENABLE_LIARC_FILE_INIT -I/usr/local/lib/mit-scheme-c/include -o generic-primitives-3.o -c generic-primitives-3.c
;        gcc   -shared -fPIC -o generic-primitives-3.so generic-primitives-3.o
;      ... done
;      Loading "generic-primitives-3.so"... done
;    ... done
;    Loading "masyu.scm"... done
;  ... done
;  Generating SCode for file: "conditionals.scm" => "conditionals.bin"... done
;  Compiling file: "conditionals.bin" => "conditionals.c"... 
;    gcc -DHAVE_CONFIG_H -DMIT_SCHEME   -O3 -Wall -Wundef -Wpointer-arith -Winline -Wstrict-prototypes -Wnested-externs -Wredundant-decls -Wextra -Wno-sign-compare -Wno-unused-parameter -Wold-style-definition  -fPIC -DENABLE_LIARC_FILE_INIT -I/usr/local/lib/mit-scheme-c/include -o conditionals.o -c conditionals.c
;    gcc   -shared -fPIC -o conditionals.so conditionals.o
;  ... done
;  Loading "conditionals.so"... done
;  Generating SCode for file: "abstraction.scm" => "abstraction.bin"... done
;  Compiling file: "abstraction.bin" => "abstraction.c"... 
;    gcc -DHAVE_CONFIG_H -DMIT_SCHEME   -O3 -Wall -Wundef -Wpointer-arith -Winline -Wstrict-prototypes -Wnested-externs -Wredundant-decls -Wextra -Wno-sign-compare -Wno-unused-parameter -Wold-style-definition  -fPIC -DENABLE_LIARC_FILE_INIT -I/usr/local/lib/mit-scheme-c/include -o abstraction.o -c abstraction.c
;    gcc   -shared -fPIC -o abstraction.so abstraction.o
;  ... done
;  Loading "abstraction.so"... done
;  Generating SCode for file: "compound-data.scm" => "compound-data.bin"... 
;Warning: Unreferenced bound variable: more-support (attach-support)
;  ... done
;  Compiling file: "compound-data.bin" => "compound-data.c"... 
;    gcc -DHAVE_CONFIG_H -DMIT_SCHEME   -O3 -Wall -Wundef -Wpointer-arith -Winline -Wstrict-prototypes -Wnested-externs -Wredundant-decls -Wextra -Wno-sign-compare -Wno-unused-parameter -Wold-style-definition  -fPIC -DENABLE_LIARC_FILE_INIT -I/usr/local/lib/mit-scheme-c/include -o compound-data.o -c compound-data.c
;    gcc   -shared -fPIC -o compound-data.so compound-data.o
;  ... done
;  Loading "compound-data.so"... done
;  Loading "test/load.scm"... done
;... done
;Value 191: #[test-group 191]


;Unspecified return value

;Unspecified return value

;Value: empty-board

;Value: board-size

;Value: board-ref

;Value: board-cells

;Value: board-rows

;Value: board-cols

;Value: board-square-at

;Value: board-squares

;Value: add-different-constraints!

;Value: add-known-values!

;Value: add-guessers!

;Value: parse-sudoku

;Value: print-board

;Unspecified return value

;Value: do-sudoku

;Value: count-failures

;Value: all-different

;Value: add-guesser!

;Value: one-choice?

;Value: the-one-choice

;Value: one-choice

;Unspecified return value

;Break!
;To continue, call RESTART with an option number:
; (RESTART 2) => Continue from breakpoint.
; (RESTART 1) => Return to read-eval-print level 1.

(gc-flip)
;Value: 511136109

(define the-answer #f)
;Value: the-answer

the-answer
;Value 223: #[sudoku-board 223]

(map length (map tms-values (map content (board-cells the-answer))))
;The object 8, passed as the first argument to vector-ref, is not the correct type.
;To continue, call RESTART with an option number:
; (RESTART 2) => Return to read-eval-print level 2.
; (RESTART 1) => Return to read-eval-print level 1.
;Start debugger? (y or n): n

(length (hash-table/key-list *premise-nogoods*))
;Value: 582

(map length (hash-table/datum-list *premise-nogoods*))
;Value 233: (37 8 78 10 5 4 32 20 35 62 163 75 5 5 133 5 81 34 106 5 1 36 57 6 21 3 61 2 51 12 1 3 80 68 106 25 17 45 2 50 74 13 66 16 22 3 49 6 92 15 13 18 1 110 65 57 1 23 82 107 93 14 6 6 1 32 27 67 147 13 80 4 68 69 35 140 5 106 1 2 99 1 27 89 109 77 104 10 1 130 77 81 60 126 145 127 21 25 105 89 8 58 118 108 1 35 43 30 5 1 3 94 20 104 16 120 16 1 95 73 90 4 112 120 109 14 51 102 1 46 78 46 152 96 95 62 76 17 79 83 36 1 39 54 67 55 75 8 111 1 37 121 1 36 90 1 110 43 42 33 87 35 1 55 72 22 45 47 1 3 49 119 4 42 1 79 1 1 13 36 47 1 51 42 3 94 31 93 46 131 36 55 10 39 1 1 48 26 47 87 4 11 1 66 69 39 76 64 4 68 1 72 62 1 5 66 1 61 55 12 1 107 36 94 1 5 24 1 1 77 45 91 95 54 48 8 61 119 82 49 60 54 62 6 48 120 16 31 5 118 21 19 2 86 13 6 1 51 55 8 1 50 53 8 44 3 74 1 121 81 77 3 1 1 80 37 78 81 1 52 55 43 76 134 37 84 53 56 19 89 121 79 1 15 1 80 62 79 5 2 56 131 8 4 175 67 9 6 140 3 43 2 124 41 3 116 75 7 105 1 81 76 42 3 2 3 1 107 96 23 1 63 1 19 36 18 1 59 6 8 92 121 1 2 66 47 1 47 4 65 40 48 29 93 40 69 1 8 1 16 76 72 149 40 83 18 31 67 4 4 142 87 116 90 9 6 15 4 92 5 1 1 43 77 72 15 93 118 2 130 5 9 56 77 40 76 69 49 9 111 9 1 1 98 67 109 1 41 49 1 9 2 56 94 13 5 98 1 85 40 6 134 80 90 24 35 45 42 81 88 36 103 42 62 84 146 21 108 109 10 28 8 45 94 74 1 96 56 11 2 115 38 144 2 115 67 78 5 87 1 34 90 8 43 1 79 72 113 2 10 89 48 1 53 30 77 20 1 53 100 4 36 75 68 56 5 80 13 65 40 24 4 5 3 24 6 34 6 111 37 1 68 74 1 48 132 18 76 1 7 82 14 39 3 24 1 33 90 47 116 20 71 104 58 121 94 6 9 61 39 30 134 71 123 51 5 1 1 85 68 16 71 1 1 67 11 79 42 135 4 51 49 144 33 54 2 117 4 45 6 58 1 163 133 105 38 41 1 1 82 14 66 109 50 12 95 72 108 1 31 49 15)

(sort (map length (hash-table/datum-list *premise-nogoods*)) >)
;Value 234: (175 163 163 152 149 147 146 145 144 144 142 140 140 135 134 134 134 133 133 132 131 131 130 130 127 126 124 123 121 121 121 121 121 120 120 120 119 119 118 118 118 117 116 116 116 115 115 113 112 111 111 111 110 110 109 109 109 109 109 108 108 108 107 107 107 106 106 106 105 105 105 104 104 104 103 102 100 99 98 98 96 96 96 95 95 95 95 94 94 94 94 94 94 93 93 93 93 92 92 92 91 90 90 90 90 90 90 89 89 89 89 88 87 87 87 87 86 85 85 84 84 83 83 82 82 82 82 81 81 81 81 81 81 80 80 80 80 80 80 79 79 79 79 79 79 78 78 78 78 77 77 77 77 77 77 77 76 76 76 76 76 76 76 75 75 75 75 74 74 74 74 73 72 72 72 72 72 72 71 71 71 69 69 69 69 68 68 68 68 68 68 67 67 67 67 67 67 67 66 66 66 66 66 65 65 65 64 63 62 62 62 62 62 62 61 61 61 61 60 60 59 58 58 58 57 57 56 56 56 56 56 56 55 55 55 55 55 55 54 54 54 54 53 53 53 53 52 51 51 51 51 51 51 50 50 50 49 49 49 49 49 49 49 48 48 48 48 48 48 47 47 47 47 47 47 46 46 46 45 45 45 45 45 45 44 43 43 43 43 43 43 42 42 42 42 42 42 42 41 41 41 40 40 40 40 40 40 39 39 39 39 39 38 38 37 37 37 37 37 36 36 36 36 36 36 36 36 36 35 35 35 35 35 34 34 34 33 33 33 32 32 31 31 31 31 30 30 30 29 28 27 27 26 25 25 24 24 24 24 24 23 23 22 22 21 21 21 21 20 20 20 20 19 19 19 18 18 18 18 17 17 16 16 16 16 16 16 15 15 15 15 15 14 14 14 14 13 13 13 13 13 13 13 12 12 12 11 11 11 10 10 10 10 10 9 9 9 9 9 9 9 8 8 8 8 8 8 8 8 8 8 8 7 7 6 6 6 6 6 6 6 6 6 6 6 6 6 6 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 3 3 3 3 3 3 3 3 3 3 3 3 3 3 2 2 2 2 2 2 2 2 2 2 2 2 2 2 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)

(restart 2)
;Abort!

(restart 2)
;Break!
;To continue, call RESTART with an option number:
; (RESTART 2) => Continue from breakpoint.
; (RESTART 1) => Return to read-eval-print level 1.

(sort (map length (hash-table/datum-list *premise-nogoods*)) >)
;Value 235: (954 858 834 780 769 764 754 743 688 687 684 678 676 670 668 663 657 657 656 654 650 649 629 626 623 623 620 614 610 608 606 602 602 595 591 586 579 576 564 560 557 555 554 553 553 552 549 547 543 537 537 535 534 531 531 530 530 527 526 524 520 519 518 516 516 516 516 514 509 509 508 507 502 500 498 496 495 493 489 487 487 486 485 483 479 479 478 477 475 474 469 469 467 465 463 460 460 458 458 457 456 453 451 451 449 443 441 438 437 436 435 434 434 433 431 431 430 428 427 427 426 425 425 425 420 419 419 419 416 413 412 411 410 410 405 403 403 402 401 400 399 391 391 390 390 389 388 388 385 385 383 381 380 379 379 378 377 375 375 375 375 372 367 367 366 365 365 364 364 363 361 361 359 356 355 353 353 352 351 351 351 350 350 349 349 349 348 347 345 344 344 343 343 343 343 342 340 338 337 336 333 331 331 330 330 329 329 328 327 326 326 326 325 325 324 322 317 317 316 316 313 313 313 311 309 308 304 302 302 300 300 298 295 293 293 292 290 290 289 289 288 288 286 286 286 285 284 283 282 281 280 280 279 278 278 278 277 275 274 274 274 274 273 271 270 267 267 265 265 262 262 262 261 261 260 258 258 258 257 256 254 253 253 253 251 248 248 247 246 246 244 243 242 241 240 239 238 238 235 235 235 233 233 232 231 227 226 226 225 225 224 224 223 222 221 220 220 219 218 217 215 214 213 213 213 212 212 211 210 210 209 209 209 207 207 205 205 203 201 201 201 200 199 199 198 198 196 196 194 194 194 191 190 189 189 188 188 188 186 185 185 185 183 182 182 182 181 178 178 178 177 176 175 175 175 175 175 174 173 172 171 169 168 167 167 167 164 164 164 163 163 159 158 158 157 156 156 155 151 150 148 147 147 147 147 145 145 144 143 143 141 141 140 138 138 135 135 132 131 129 128 127 125 121 120 119 118 118 117 117 114 112 111 109 109 107 106 105 103 100 97 97 97 97 96 94 91 91 91 91 91 90 89 89 88 88 86 86 84 83 83 81 81 80 79 79 77 77 76 76 76 75 75 75 75 75 74 73 73 73 72 72 71 70 70 68 68 68 68 66 65 64 64 63 63 63 62 62 62 61 61 61 60 60 60 60 59 59 59 59 58 58 57 56 55 53 52 52 51 50 50 49 48 48 47 46 46 45 42 42 41 41 40 38 38 38 37 37 37 36 36 36 35 34 33 33 32 32 31 31 30 29 29 28 27 26 25 25 24 24 23 22 22 22 22 22 22 22 22 22 21 20 20 20 19 18 17 17 17 17 16 16 16 16 16 15 14 14 13 13 13 13 12 12 12 12 12 12 11 10 10 10 10 10 9 9 9 9 9 8 8 8 8 8 8 7 7 7 7 7 7 6 5 5 5 5 5 5 4 4 4 4 4 4 3 3 3 3 3 3 3 3 2 2 2 2 2 2 2 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)

(print-gc-statistics)

constant in use:   190787 words =   186 blocks +  323 words
constant free:         16 words =     0 blocks +   16 words
heap in use:     55632664 words = 54328 blocks +  792 words
heap free:        8370017 words =  8173 blocks +  865 words
;GC #25: took:   0.70   (0%) CPU time,   0.70   (0%) real time; free: 509582575
;GC #26: took:   0.70   (0%) CPU time,   0.70   (0%) real time; free: 509513934
;GC #27: took:   0.70   (0%) CPU time,   0.70   (0%) real time; free: 509406407
;GC #28: took:   0.70   (0%) CPU time,   0.80   (0%) real time; free: 509275797
;GC #29: took:   0.70   (0%) CPU time,   0.80   (0%) real time; free: 509185361
;GC #30: took:   0.80   (0%) CPU time,   0.80   (0%) real time; free: 509102939
;GC #31: took:   0.80   (0%) CPU time,   0.80   (0%) real time; free: 509003034
;Unspecified return value

(gc-flip)
;Value: 508976853

(restart 2)
;Break!
;To continue, call RESTART with an option number:
; (RESTART 2) => Continue from breakpoint.
; (RESTART 1) => Return to read-eval-print level 1.

(print-gc-statistics)

constant in use:   190787 words =   186 blocks +  323 words
constant free:         16 words =     0 blocks +   16 words
heap in use:     49176115 words = 48023 blocks +  563 words
heap free:       14826566 words = 14479 blocks +   70 words
;GC #28: took:   0.70   (0%) CPU time,   0.80   (0%) real time; free: 509275797
;GC #29: took:   0.70   (0%) CPU time,   0.80   (0%) real time; free: 509185361
;GC #30: took:   0.80   (0%) CPU time,   0.80   (0%) real time; free: 509102939
;GC #31: took:   0.80   (0%) CPU time,   0.80   (0%) real time; free: 509003034
;GC #32: took:   0.70   (0%) CPU time,   0.80   (0%) real time; free: 508976853
;GC #33: took:   0.90   (0%) CPU time,   0.80   (0%) real time; free: 508880432
;GC #34: took:   0.90   (0%) CPU time,   0.90   (0%) real time; free: 508791105
;Unspecified return value

(gc-flip)
;Value: 508720585

(print-gc-statistics)

constant in use:   190787 words =   186 blocks +  323 words
constant free:         16 words =     0 blocks +   16 words
heap in use:       435481 words =   425 blocks +  281 words
heap free:       63567200 words = 62077 blocks +  352 words
;GC #29: took:   0.70   (0%) CPU time,   0.80   (0%) real time; free: 509185361
;GC #30: took:   0.80   (0%) CPU time,   0.80   (0%) real time; free: 509102939
;GC #31: took:   0.80   (0%) CPU time,   0.80   (0%) real time; free: 509003034
;GC #32: took:   0.70   (0%) CPU time,   0.80   (0%) real time; free: 508976853
;GC #33: took:   0.90   (0%) CPU time,   0.80   (0%) real time; free: 508880432
;GC #34: took:   0.90   (0%) CPU time,   0.90   (0%) real time; free: 508791105
;GC #35: took:   0.80   (0%) CPU time,   0.80   (0%) real time; free: 508720585
;Unspecified return value

(+ 49176115 14826566)
;Value: 64002681

(+ 63567200 435481)
;Value: 64002681

(restart 2)
;Break!
;To continue, call RESTART with an option number:
; (RESTART 2) => Continue from breakpoint.
; (RESTART 1) => Return to read-eval-print level 1.

(begin (gc-flip) (print-gc-statistics))

constant in use:   190787 words =   186 blocks +  323 words
constant free:         16 words =     0 blocks +   16 words
heap in use:       446428 words =   435 blocks +  988 words
heap free:       63556253 words = 62066 blocks +  669 words
;GC #33: took:   0.90   (0%) CPU time,   0.80   (0%) real time; free: 508880432
;GC #34: took:   0.90   (0%) CPU time,   0.90   (0%) real time; free: 508791105
;GC #35: took:   0.80   (0%) CPU time,   0.80   (0%) real time; free: 508720585
;GC #36: took:   0.80   (0%) CPU time,   0.90   (0%) real time; free: 508629162
;GC #37: took:   0.90   (0%) CPU time,   0.90   (0%) real time; free: 508555462
;GC #38: took:   0.90   (0%) CPU time,   0.90   (0%) real time; free: 508495181
;GC #39: took:   0.90   (0%) CPU time,   0.90   (0%) real time; free: 508450171
;Unspecified return value

(begin (gc-flip)
       (print-gc-statistics)
       (let ((status (gc-space-status)))
	 (let ((heap-start (vector-ref status 4))
	       (heap-frontier (vector-ref status 5))
	       (heap-end (vector-ref status 6)))
	   (pp `(used ,(- heap-frontier heap-start)))
	   (pp `(free ,(- heap-end heap-frontier))))))

constant in use:   190787 words =   186 blocks +  323 words
constant free:         16 words =     0 blocks +   16 words
heap in use:       446551 words =   436 blocks +   87 words
heap free:       63556130 words = 62066 blocks +  546 words
;GC #34: took:   0.90   (0%) CPU time,   0.90   (0%) real time; free: 508791105
;GC #35: took:   0.80   (0%) CPU time,   0.80   (0%) real time; free: 508720585
;GC #36: took:   0.80   (0%) CPU time,   0.90   (0%) real time; free: 508629162
;GC #37: took:   0.90   (0%) CPU time,   0.90   (0%) real time; free: 508555462
;GC #38: took:   0.90   (0%) CPU time,   0.90   (0%) real time; free: 508495181
;GC #39: took:   0.90   (0%) CPU time,   0.90   (0%) real time; free: 508450171
;GC #40: took:   0.90   (2%) CPU time,   0.80   (0%) real time; free: 508449188
(used 3574413)
(free 508447042)
;Unspecified return value

(begin (gc-flip)
       (print-gc-statistics)
       (let ((status (gc-space-status)))
	 (let ((granularity (vector-ref status 0))
	       (heap-start (vector-ref status 4))
	       (heap-frontier (vector-ref status 5))
	       (heap-end (vector-ref status 6)))
	   (define (foo label low high)
	     (pp `(,label ,(quotient (- high low) granularity))))
	   (foo 'used heap-start heap-frontier)
	   (foo 'free heap-frontier heap-end))))

constant in use:   190787 words =   186 blocks +  323 words
constant free:         16 words =     0 blocks +   16 words
heap in use:       446719 words =   436 blocks +  255 words
heap free:       63555962 words = 62066 blocks +  378 words
;GC #35: took:   0.80   (0%) CPU time,   0.80   (0%) real time; free: 508720585
;GC #36: took:   0.80   (0%) CPU time,   0.90   (0%) real time; free: 508629162
;GC #37: took:   0.90   (0%) CPU time,   0.90   (0%) real time; free: 508555462
;GC #38: took:   0.90   (0%) CPU time,   0.90   (0%) real time; free: 508495181
;GC #39: took:   0.90   (0%) CPU time,   0.90   (0%) real time; free: 508450171
;GC #40: took:   0.90   (2%) CPU time,   0.80   (0%) real time; free: 508449188
;GC #41: took:   0.80   (2%) CPU time,   0.80   (0%) real time; free: 508447846
(used 446969)
(free 63555712)
;Unspecified return value

(vector-ref (gc-space-status) 0)
;Value: 8

(restart 2)
;Break!
;To continue, call RESTART with an option number:
; (RESTART 2) => Continue from breakpoint.
; (RESTART 1) => Return to read-eval-print level 1.

(sort (map length (hash-table/datum-list *premise-nogoods*)) >)
;Value 236: (1966 1767 1618 1593 1592 1580 1550 1478 1475 1427 1426 1359 1346 1281 1271 1252 1240 1231 1224 1221 1220 1217 1217 1213 1192 1186 1181 1172 1164 1161 1156 1149 1144 1142 1136 1118 1107 1097 1089 1086 1085 1085 1084 1073 1067 1066 1066 1062 1062 1061 1061 1058 1056 1056 1055 1051 1040 1034 1030 1028 1028 1019 1011 1010 1009 1008 1003 1000 997 997 996 992 992 991 988 985 981 980 980 974 973 973 971 971 969 969 965 962 960 947 941 939 938 937 932 931 928 928 927 922 921 920 920 920 920 913 913 913 906 902 900 899 898 896 895 895 890 887 886 886 884 881 878 869 868 856 855 851 850 844 841 839 835 830 829 822 821 820 819 807 804 803 798 797 795 790 790 790 789 786 785 784 782 777 773 773 765 765 765 759 758 757 755 753 751 748 747 744 743 736 736 732 725 723 723 721 719 715 703 696 695 690 688 687 686 676 669 668 663 662 662 661 660 658 658 655 653 653 652 652 642 642 642 642 637 636 636 635 634 633 633 631 629 623 620 610 607 607 604 598 597 596 595 593 592 592 590 586 585 585 583 583 581 580 579 579 577 569 566 565 565 555 554 552 552 548 547 546 545 544 543 542 542 540 537 534 534 532 530 530 527 526 526 526 525 525 513 512 512 510 500 499 498 496 492 492 491 491 488 487 485 484 482 478 477 476 473 472 469 469 466 461 459 458 450 448 448 447 446 444 444 442 441 439 436 436 436 435 431 431 430 427 426 424 421 420 420 419 419 418 418 416 415 414 408 407 406 402 401 400 399 393 391 390 390 389 387 386 385 382 377 376 376 375 373 372 372 370 369 368 367 366 365 364 363 361 360 359 358 357 352 348 347 344 340 340 337 337 335 335 333 332 329 327 324 321 319 317 316 316 316 315 313 312 310 309 309 308 307 302 302 301 300 296 293 292 292 292 288 288 284 282 279 279 274 274 270 267 265 265 265 265 263 261 261 259 258 253 252 252 250 250 245 242 242 240 237 234 233 232 228 228 226 224 223 223 222 222 222 219 218 218 215 214 213 213 213 210 209 209 209 207 206 205 204 203 203 202 200 197 196 195 194 189 188 187 187 184 180 179 178 177 177 176 175 174 174 174 173 172 171 171 171 171 169 169 169 169 167 165 164 161 160 159 159 158 152 145 144 143 141 138 138 137 136 136 135 135 132 131 130 130 129 129 129 128 128 128 126 125 125 124 122 121 119 119 119 119 115 115 113 112 112 110 110 110 110 109 109 107 105 105 104 104 103 102 100 97 97 97 93 92 91 90 88 85 85 84 83 82 82 80 78 78 76 75 75 73 72 72 71 71 71 70 70 69 68 67 67 67 65 64 63 61 61 60 59 58 56 53 50 49 49 48 47 47 45 44 42 42 42 42 41 39 39 39 39 39 38 37 35 35 35 34 33 32 32 32 31 31 31 30 29 29 28 27 26 26 26 25 25 25 23 23 22 22 22 21 21 21 21 21 20 20 20 19 19 18 18 18 17 17 17 17 16 16 16 16 15 14 14 14 13 13 12 12 12 12 12 11 11 11 11 10 10 10 10 10 9 9 7 7 7 7 7 7 7 6 6 5 5 5 5 5 5 5 5 4 4 4 4 4 3 3 3 3 3 2 2 2 2 2 2 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)


(restart 2)
;Break!
;To continue, call RESTART with an option number:
; (RESTART 2) => Continue from breakpoint.
; (RESTART 1) => Return to read-eval-print level 1.

(sort (map length (hash-table/datum-list *premise-nogoods*)) >)
;Value 237: (1974 1767 1633 1618 1615 1608 1550 1538 1519 1479 1446 1410 1400 1297 1289 1285 1270 1260 1259 1240 1227 1227 1226 1225 1220 1214 1194 1185 1184 1178 1162 1161 1151 1151 1149 1142 1138 1130 1127 1118 1109 1102 1098 1097 1095 1091 1089 1084 1082 1080 1074 1071 1068 1067 1066 1066 1061 1060 1056 1049 1049 1048 1041 1036 1036 1032 1029 1026 1025 1018 1015 1010 1010 1007 998 996 993 992 992 991 987 985 985 984 983 983 982 980 975 973 960 959 958 955 953 949 948 942 941 940 939 934 929 928 928 928 927 926 925 922 920 920 916 916 914 914 911 911 910 907 898 896 887 886 886 884 880 878 875 874 869 865 859 857 855 853 850 848 845 835 833 832 822 806 805 805 804 804 801 801 800 795 789 787 785 784 783 782 778 777 773 765 757 757 756 755 751 750 749 748 747 745 743 743 740 729 723 719 705 703 701 701 695 691 688 687 687 682 682 678 675 668 667 667 663 663 662 662 661 660 657 654 653 652 647 645 642 642 642 638 636 636 634 634 633 631 631 623 620 620 612 611 607 607 606 604 601 598 596 594 593 592 590 589 585 585 580 579 577 574 568 561 561 560 554 553 552 552 551 547 547 546 545 543 543 541 540 537 536 532 530 530 530 530 529 527 526 519 516 513 512 510 504 501 500 500 499 498 496 496 493 492 492 487 487 484 478 477 477 476 466 462 461 460 458 455 450 450 449 448 448 448 448 444 444 444 442 439 439 436 436 435 432 431 430 429 428 426 425 423 422 420 419 418 415 414 407 406 405 402 401 399 398 393 392 390 390 390 389 387 385 382 382 382 377 375 374 373 372 372 372 370 368 366 365 363 361 360 359 358 358 354 352 351 350 348 344 342 340 337 335 335 332 332 327 324 321 319 317 317 316 316 316 316 313 312 311 310 308 307 305 305 304 301 300 296 293 293 293 292 292 290 284 282 279 275 275 274 273 267 265 265 265 262 261 260 259 258 258 254 253 252 250 247 245 244 242 241 240 237 234 234 232 228 227 226 224 223 223 223 222 222 219 219 218 215 214 214 214 211 211 209 209 209 207 205 205 204 203 203 200 199 198 197 195 194 191 189 187 187 184 180 180 179 178 177 177 176 175 174 174 174 174 173 172 172 171 169 169 168 165 162 161 160 159 159 158 152 147 146 145 145 143 138 138 136 136 135 135 132 131 131 131 131 130 130 129 129 129 128 126 125 124 123 122 121 119 119 119 119 115 113 112 112 110 110 110 110 109 107 107 105 105 104 103 102 102 101 97 97 93 92 91 90 90 85 85 85 83 82 82 80 78 78 78 76 75 75 74 72 72 72 71 71 71 71 70 70 70 69 67 67 64 64 61 61 60 59 56 53 52 50 49 48 47 47 45 44 43 43 42 42 41 39 39 39 39 39 38 37 35 35 35 34 33 32 32 32 31 31 31 30 29 29 29 28 27 26 26 26 25 25 23 23 22 22 22 21 21 21 21 21 21 20 20 20 19 19 18 18 18 18 18 17 17 16 16 16 16 15 14 14 14 13 13 13 12 12 12 11 11 11 11 10 10 10 10 10 9 9 7 7 7 7 7 7 7 6 6 5 5 5 5 5 5 5 5 4 4 4 4 4 3 3 3 3 3 2 2 2 2 2 2 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)

*number-of-calls-to-fail*
;Value: 940

(restart 2)
;Break!
;To continue, call RESTART with an option number:
; (RESTART 2) => Continue from breakpoint.
; (RESTART 1) => Return to read-eval-print level 1.

*number-of-calls-to-fail*
;Value: 942

(sort (map length (hash-table/datum-list *premise-nogoods*)) >)
;Value 238: (1983 1767 1692 1647 1618 1613 1579 1571 1550 1541 1470 1410 1403 1355 1346 1326 1289 1279 1262 1261 1257 1256 1244 1240 1238 1225 1219 1208 1205 1196 1193 1192 1181 1181 1173 1162 1161 1158 1155 1154 1151 1149 1148 1142 1138 1131 1131 1124 1118 1105 1099 1097 1096 1091 1091 1089 1086 1085 1085 1082 1075 1074 1074 1071 1067 1066 1065 1056 1042 1041 1036 1029 1028 1028 1026 1023 1019 1018 1017 1016 1016 1014 1011 1010 1000 1000 999 998 998 995 993 992 992 985 982 975 974 973 971 969 964 960 958 955 955 952 949 949 944 943 943 939 934 929 928 926 922 921 920 920 912 911 910 908 905 899 898 896 895 887 886 886 884 882 878 869 862 859 858 855 853 853 853 850 835 835 822 818 805 805 804 802 801 795 789 788 787 785 785 784 782 779 773 767 765 758 757 755 751 750 748 747 746 745 743 742 729 723 723 720 719 712 708 703 701 700 700 698 695 694 694 693 691 689 686 683 678 677 677 676 674 670 668 662 661 660 653 650 647 645 643 643 642 642 640 636 636 635 634 633 629 623 620 614 613 612 611 607 607 604 598 596 593 592 591 590 586 585 585 585 583 580 579 570 560 558 554 553 552 551 551 547 547 546 546 545 543 543 541 540 540 537 536 536 536 530 530 530 530 529 527 526 520 512 510 507 504 501 499 496 496 494 493 492 488 487 487 484 478 477 477 476 466 462 461 458 457 450 450 449 448 448 448 448 444 444 444 442 439 439 438 436 436 435 431 430 429 428 426 425 423 422 421 419 418 415 414 410 406 405 403 402 401 399 398 393 392 390 390 389 387 387 385 382 382 378 377 377 375 373 372 372 372 368 366 366 365 363 361 360 359 358 358 356 352 349 344 342 340 337 335 335 335 332 332 327 326 324 322 321 317 317 316 316 316 316 313 312 311 311 310 308 307 304 301 300 300 298 296 293 293 292 290 284 282 279 278 275 275 275 274 274 267 265 265 265 262 261 260 259 258 258 254 254 253 252 250 247 245 244 242 240 237 235 234 234 232 229 226 223 223 223 222 222 221 219 219 218 215 214 214 214 211 211 209 209 209 208 207 206 205 205 203 200 197 195 194 191 189 187 187 187 184 180 180 179 178 178 177 177 176 175 174 174 174 173 172 172 172 169 169 165 162 162 159 159 158 152 147 146 145 145 143 141 138 138 136 136 135 135 132 131 131 131 130 130 129 129 129 128 126 125 124 123 122 121 121 119 119 119 115 113 112 112 111 110 110 110 110 109 107 107 105 105 104 103 102 101 97 97 93 92 91 90 90 85 85 85 83 82 82 80 78 78 78 76 75 75 74 72 72 72 71 71 71 71 70 70 70 69 67 67 64 64 61 61 60 59 56 53 52 50 49 48 47 47 45 44 43 43 42 42 41 39 39 39 39 39 38 37 35 35 35 34 33 32 32 32 32 31 31 30 29 29 29 28 27 26 26 26 25 25 23 23 22 22 22 21 21 21 21 21 21 20 20 20 19 19 18 18 18 18 18 17 17 16 16 16 16 15 14 14 14 13 13 13 12 12 12 11 11 11 11 10 10 10 10 10 9 9 7 7 7 7 7 7 7 7 6 6 5 5 5 5 5 5 5 5 4 4 4 4 4 3 3 3 3 2 2 2 2 2 2 2 2 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)

(restart 2)
738519246
941632785
256478391
865741932
197263458
423895617
312957864
689124573
574386129
(failed 942 times)
;process time: 8596030 (8589200 RUN + 6830 GC); real time: 9728842
;Value 223: #[sudoku-board 223]

