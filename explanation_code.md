# Explanation File for Killer Sudoku 

In this file we will explain how our code is working.


#### :- use_module(library(clpfd)). 
At first we are importing the "CLPFD"-Library by using the function **use_module**. CLPFD means Constraint Logic Programming over Finite Domains. With this library we make integer constraints available in our program. This is advisable because almost all Prolog programs also reason about integers in one way or another. For example we can use it for our additions in the Killer Sudoku. For defining the rules we can write  **5 #= E11 + E12**, so that Prolog calculates that Element11 and Element12 has to be 5.


##### sudoku(Matrix) :- length(Matrix, 9),
On the left side of the '**:-**' we are defining our "main function". The name of our main function is **sudoku**. The name of our input is **Matrix**. On the right side we have our first function named **length** with input **(Matrix, 9)**. This will make an empty list with the length 9 (`[_,_,_,_,_,_,_,_,_]`) and the name **Matrix**. The symbol '**:-**', sometimes called a turnstile, can be pronounced "if''. So this whole line can be written as "Matrix is a sudoku if Matrix is a list with length 9". This is only the first rule which is determined. In the following lines there will be more rules to define the sudoku. The '**,**' at the end means that more rules will follow. For finishing the function a '**.**' has to be used in Prolog.

##### maplist(same_length(Matrix), Matrix),
This is the second rule for the sudoku. The function maplist takes a function and a list and applies the function to each item in the list. At this point we could also use `maplist(length, Matrix, [9,9,9,9,9,9,9,9,9])`." -> The length of every element in the list would be 9, so maplist would add 9 empty positions to every element in the list. (`[_,_,_,_,_,_,_,_,_],[_,_,_,_,_,_,_,_,_],...` ). So the result is a list of lists or, with other words, a 9x9 matrix.  Using the function **same_length** is a different way to do exactly the same because the length of our list named **Matrix** is 9 (we defined this before). 

##### append(Matrix, Vars), Vars ins 1..9,
The function **append** defines a rule that in every position only numbers between 1 and 9 are allowed in the matrix. 

##### maplist(all_distinct, Matrix),
The function **all_distinct** defines that in every row every position has to get a different number. 

##### transpose(Matrix, TransMatrix),
The function **transpose** transposes the matrix. For example if the matrix would be `[1,2,3; 4,5,6; 7,8,9]` after transposing it would be `[1,4,7;2,5,8;3,6,9]`. This is useful for defining the **all_distinct**-rule for the columns as well.

##### maplist(all_distinct, TransMatrix),
This function defines the rule that in every column every position has to get a different number.

##### Matrix = [L1,L2,L3,L4,L5,L6,L7,L8,L9],
This line is labeling each row in the matrix with a specific name. This is needed for defining the 9 blocks.

##### blocks(L1,L2,L3),
##### blocks(L4,L5,L6),
##### blocks(L7,L8,L9),

here we are using our block function to define our block. This is a new function, which we will explain right now:

At first we have to define the empty solution: 
##### blocks([], [], []).
##### blocks([E1,E2,E3|Tail1],
##### 	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   [E4,E5,E6|Tail2],
##### 	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   [E7,E8,E9|Tail3]):-
##### 	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   all_distinct([E1,E2,E3,E4,E5,E6,E7,E8,E9]),
##### 	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   blocks(Tail1, Tail2, Tail3).

The first line means that we take the first three elements of our first input (e.g. L1). The rest of L1 is in Tail1. In the second line the same happens for the second input (e.g. L2) and in the third line for the third input (e.g. L3). So our first block would be the first three elements of the first three rows. With "all_distinct" we define that all these elements won't have the same number. The last line "blocks(Tail1, Tail2, Tail3)." means that we will repeat this clause with every tail. So in the second round E1 would be the forth element of L1 and so on. 

In total we have to call the blocks-function three times (first time: L1,L2,L3; second time: L4,L5,L6; third time: L7,L8,L9) so that we get our 9 blocks.


With this code we can solve every normal Sudoku. 

The following code is the specifation for solving killer sudokus. 

__L1 = [E11, E12, E13, E14, E15, E16, E17, E18, E19], <br />
L2 = [E21, E22, E23, E24, E25, E26, E27, E28, E29], <br />
L3 = [E31, E32, E33, E34, E35, E36, E37, E38, E39],<br />
L4 = [E41, E42, E43, E44, E45, E46, E47, E48, E49],<br />
L5 = [E51, E52, E53, E54, E55, E56, E57, E58, E59],<br />
L6 = [E61, E62, E63, E64, E65, E66, E67, E68, E69],<br />
L7 = [E71, E72, E73, E74, E75, E76, E77, E78, E79],<br />
L8 = [E81, E82, E83, E84, E85, E86, E87, E88, E89],<br />
L9 = [E91, E92, E93, E94, E95, E96, E97, E98, E99],<br />__

With this code we defined each position/element in our Matrix. We have to do it because we have to define the special rules for our killer sudoku.

#### 5 #= E11 + E12, 
This is an example for defining a cage in our sudoku. 5 is the sum, which the elements E11 and E12 have to build together. Like this we continued with all cages:
 
 __11 #= E13 + E23,<br />
				  9 #= E14 + E15,<br />
				  18 #= E16 + E26 + E27,<br />
				  12 #= E17 + E18 + E28,<br />
				  22 #= E19 + E29 + E39 + E38,<br />
				  15 #= E21 + E31,<br />
				  6 #= E22 + E32,<br />
				  15 #= E24 + E25 + E35,<br />
				  10 #= E33 + E34,<br />
				  12 #= E36 + E37,<br />
				  12 #= E41 + E51,<br />
				  14 #= E42 + E43,<br />
				  3 #= E44 + E45, <br />
				  9 #= E46 + E47,<br />
				  15 #= E48 + E49,<br />
				  9 #= E52 + E62, <br />
				  6 #= E53 + E54, <br />
				  16 #= E55 + E56,<br />
				  16 #= E57 + E67 + E66 + E65,<br />
				  14 #= E58 + E68,<br />
				  21 #= E59 + E69 + E79 + E78,<br /> 
				  9 #= E61 + E71, <br />
				  7 #= E63 + E64,<br />
				  16 #= E72 + E73,<br />
				  31 #= E74  + E84 + E85 + E94 + E95,<br /> 
				  4 #= E75 + E76, <br />
				  21 #= E77 + E87 + E86,<br /> 
				  18 #= E81 + E82 + E91 + E92, <br />
				  9 #= E83 + E93,<br />
				  3 #= E88 + E89,<br />
				  9 #= E96 + E97,<br />
				  8 #= E98 + E99.__
     
In SWI-Prolog we can ask for the solution of our sudoku with the following input:

##### sudoku(Matrix),write(Matrix).

In this case we don't get a concret result. If we want to get concret numbers, we have to add a labeling:

#### sudoku(Matrix),maplist(labeling([ff]),Matrix),write(Matrix).

If we want a better view of the result, we also can add: **maplist(portray_clause.Matrix)**

##### sudoku(Matrix),maplist(labeling([ff]),Matrix),maplist(portray_clause, Matrix).

The final result in SWI-Prolog will be shown like this: 
![image](https://user-images.githubusercontent.com/101565106/173626024-f6bbc180-1622-4262-874d-4a5136cb3dd6.png)





