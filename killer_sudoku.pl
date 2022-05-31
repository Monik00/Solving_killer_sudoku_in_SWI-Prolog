
:- use_module(library(clpfd)).

sudoku(Matrix) :- length(Matrix, 9),
				  maplist(same_length(Matrix), Matrix),
				  append(Matrix, Vars), Vars ins 1..9,
				  maplist(all_distinct, Matrix),
				  transpose(Matrix, TransMatrix),
				  maplist(all_distinct, TransMatrix),
				  Matrix = [L1,L2,L3,L4,L5,L6,L7,L8,L9],
				  L1 = [E11, E12, E13, E14, E15, E16, E17, E18, E19], 
				  L2 = [E21, E22, E23, E24, E25, E26, E27, E28, E29],
				  L3 = [E31, E32, E33, E34, E35, E36, E37, E38, E39],
				  L4 = [E41, E42, E43, E44, E45, E46, E47, E48, E49],
				  L5 = [E51, E52, E53, E54, E55, E56, E57, E58, E59],
				  L6 = [E61 ,E62, E63, E64, E65, E66, E67, E68, E69],
				  L7 = [E71, E72, E73, E74, E75, E76, E77, E78, E79],
				  L8 = [E81, E82, E83, E84, E85, E86, E87, E88, E89],
				  L9 = [E91, E92, E93, E94, E95, E96, E97, E98, E99], 
				  
				  5 #= E11 + E12,
				  11 #= E13 + E23,
				  9 #= E14 + E15,
				  18 #= E16 + E26 + E27,
				  12 #= E17 + E18 + E28,
				  22 #= E19 + E29 + E38 + E39,
				  15 #= E21 + E31,
				  6 #= E22 + E32,
				  10 #= E33 + E34,
				  15 #= E24 + E25 + E35, 
				  12 #= E36 + E37,
				  12 #= E41 + E51,
				  14 #= E42 + E43,
				  3 #= E44 + E45,
				  9 #= E46 + E47,
				  15 #= E48 + E49,
				  9 #= E52 + E62,
				  6 #= E53 + E54,
				  16 #= E55 + E56,
				  16 #= E57 + E65 + E66 + E67,
				  14 #= E58 + E68,
				  21 #= E59 + E69 + E79 + E78,
				  9 #= E61 + E71,
				  7 #= E63 + E64,
				  16 #= E72 + E73,
				  31 #= E74 + E84 + E85 + E94 + E95,
				  4 #= E75 + E76,
				  21 #= E77 + E86 + E87,
				  18 #= E81 + E82 + E91 + E92,
				  9 #= E83 + E93,
				  3 #= E88 + E89,
				  9 #= E96 + E97,
				  8 #= E98 + E99,
				  
				  blocks(L1,L2,L3),
				  blocks(L4,L5,L6),
				  blocks(L7,L8,L9).
				  
				  
/*				  
blocks(+L1, +L2, +L3)
  it is true if the blocks 3x3 build for 
  L1, L2 and L3 has different values.
*/


blocks([], [], []).
blocks([E1,E2,E3|Tail1],
	   [E4,E5,E6|Tail2],
	   [E7,E8,E9|Tail3]):-
	   all_distinct([E1,E2,E3,E4,E5,E6,E7,E8,E9]),
	   blocks(Tail1, Tail2, Tail3).
	   
sudoku1([
		 [_,_,_,_,_,_,_,_,_],
		 [_,_,_,_,_,_,_,_,_],
		 [_,_,_,_,_,_,_,_,_],
		 [_,_,_,_,_,_,_,_,_],
		 [_,_,_,_,_,_,_,_,_],
		 [_,_,_,_,_,_,_,_,_],
		 [_,_,_,_,_,_,_,_,_],
		 [_,_,_,_,_,_,_,_,_],
		 [_,_,_,_,_,_,_,_,_]
		 ]). 
	   
	   
	   