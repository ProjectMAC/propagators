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

(do-puzzle '(
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

(do-puzzle '(
"   X      O O    X"
"    O   O   O   X "
"O        O  O  X  "
"OO  X XX   X      "
"      XX  O       "
"             O   X"
"X  OOOOX   O   O  "
"            X  O O"
"X O O    X      OO"
"       O    XX    "))

#;
(do-puzzle '(
"           OX O  OX    X  O    X    "
"X   O X        X     X        O   X "
"   X     X  O               X O     "
"   X         X   X X    XX          "
"  O    O  XX    X    O    O XX  O  X"
" O   X       O         O        O  O"
"          O    X  O     X X    O  O "
"X   X   X   O O      X  X   X       "
"        X  O       O XO   O     X X "
"X  O   O      X O       O      O    "
"    X    O       O   X        X X X "
" X O       X  O X  O    OO     O    "
"      X X O  XO X      X   OX O O   "
" O X       O         X           X  "
"  O   XX  X     OX X      X  OO  X  "
"           O X        XX   O   X    "
"        O         O  O     O       X"
"X   O X        X       X        OO  "
" O X  OO  X     O  O     O   X      "
"             X      X     X     O O "))

(in-test-group
 riddle-of-the-knights
 (define-test (correct-solution)
   (check
    (generic-match
     `(#(knight sir-sigismund ,s1 ,h4)
       #(knight sir-gerard    ,s2 ,h3)
       #(knight sir-fernando  ,s4 ,h6)
       #(knight sir-harold    ,s7 ,h1)
       #(knight sir-emilio    ,s5 ,h5)
       #(knight sir-almeric   ,s0 ,h7)
       #(knight sir-gawain    ,s3 ,h2)
       #(knight sir-caspar    ,s6 ,h0)
       #(knight sir-jules     ,s8 ,h8)
       #(knight sir-balthus   ,s9 ,h9))
     (map v&s-value (map tms-query (show-time find-solution)))))))

(in-test-group
 albatross-conundrum
 (define-test (correct-solution)
   (check
    (generic-match
     '(#(deck poop windlass galliard-lute rum)
       #(deck quarter bosun tamarind-jewels biscuits)
       #(deck main draconio calypso-figure firearms)
       #(deck gun scurvy casket-of-magenta ropes)
       #(deck lower kraken goldenhall-talisman spare-sails))
     (map v&s-value (map tms-query (show-time find-albatross-solution)))))))
