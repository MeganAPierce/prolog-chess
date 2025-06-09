%Code is only for task 2

%----------------------- DO NOT OVERRIDE -----------------------
strengthA([], _, _, Rand) :- noise_level(Level), random(0, Level, Number),
Rand is Number.               % Add random value to avoid deadlock
%---------------------------------------------------------------

% ------------------------------------------------------------------------------
% YOUR CODE STARTS HERE
% +++++++++++++++++++++++++++++++++ playerA Code +++++++++++++++++++++++++++++++

% TASK 2: IMPLEMENT playerA CODE HERE

strengthA([state(_, _, _, _)|Board], Color, OppositeColor, Strength) :- 
	strengthA(Board, Color, OppositeColor, Strength), !.
strengthA([piece(_, Color, Type)|Board], Color, OppositeColor, Strength) :-
	valueA(Type, Value),
	strengthA(Board, Color, OppositeColor, PartialStrength),
	Strength is PartialStrength + Value, !.
strengthA([piece(_, OppositeColor, Type)|Board], Color, OppositeColor, Strength) :-
	valueA(Type, Value),
	strengthA(Board, Color, OppositeColor, PartialStrength),
	Strength is PartialStrength - Value.

ply_depthA(3). 
% Define the utility function for playerA
% MAKE SURE that the SUM of all pieces is smaller than 32000
valueA(king, 10000) :- ! .
valueA(queen, 900) :- ! .
valueA(rook, 500) :- ! .
valueA(night, 300) :- ! .
valueA(bishop, 300) :- ! .
valueA(pawn, 100) :- ! .

%PlayerA book moves, black
bookA([state(white, WhiteKing, WhiteKingRook, WhiteQueenRook), %e2e4
    state(black, BlackKing, BlackKingRook, BlackQueenRook), %respond with
    piece(a-8, black, rook ), piece(b-8, black, night ), % ... e7e5
    piece(c-8, black, bishop), piece(d-8, black, queen ),
    piece(e-8, black, king ), piece(f-8, black, bishop),
    piece(g-8, black, night ), piece(h-8, black, rook ),
    piece(a-7, black, pawn ), piece(b-7, black, pawn ),
    piece(c-7, black, pawn ), piece(d-7, black, pawn ),
    piece(e-7, black, pawn ), piece(f-7, black, pawn ),
    piece(g-7, black, pawn ), piece(h-7, black, pawn ),
    piece(a-1, white, rook ), piece(b-1, white, night ),
    piece(c-1, white, bishop), piece(d-1, white, queen ),
    piece(e-1, white, king ), piece(f-1, white, bishop),
    piece(g-1, white, night ), piece(h-1, white, rook ),
    piece(a-2, white, pawn ), piece(b-2, white, pawn ),
    piece(c-2, white, pawn ), piece(d-2, white, pawn ),
    piece(f-2, white, pawn ), piece(g-2, white, pawn ),
    piece(h-2, white, pawn ), piece(e-2, white, pawn ) ], e-2, e-4).

%Code for alpha beta prunning
%Player is playerA, Turn is the player whose turn is to play
sufficientA(Player, Board, Turn, [], Depth, Alpha, Beta, Move, Val, Move, Val) :- !.
sufficientA(Player, Board, Turn, Moves, Depth, Alpha, Beta, Move, Val, Move, Val) :-
    Player \== Turn, % It is the opponent turn to play, MIN node at Turn
    Val < Alpha, !. % Pruning the branch since it is not useful
sufficientA(Player, Board, Turn, Moves, Depth, Alpha, Beta, Move, Val, Move, Val) :-
    Player = Turn, % It is the Player turn to play, MAX node at Turn
    Val > Beta, !. % Pruning the branch since it is not useful
sufficientA(Player, Board, Turn, Moves, Depth, Alpha, Beta, Move, Val, BestMove, BestVal) :-
    new_bounds(Player, Turn, Alpha, Beta, Val, NewAlpha, NewBeta),
    find_best(Player, Board, Turn, Moves, Depth, NewAlpha, NewBeta, Move1, Val1),
    better_of(Player, Turn, Move, Val, Move1, Val1, BestMove, BestVal).
% Code to collect moves given the current state Board
% If Moves is empty, it should return FAIL.
collect_movesA(Board, Color, Moves) :-
    bagof(move(From, To), Piece^move(Board,From,To,Color,Piece), Moves).

% ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
% ------------------------------------------------------------------------------
% YOUR CODE ENDS HERE