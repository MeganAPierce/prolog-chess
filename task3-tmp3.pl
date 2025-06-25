%Code is only for task 3

% TASK 3: Modified to automatically play the game
play(Board) :-
    execute_command(playerA, Board, NewBoard),
    execute_command(playerB,NewBoard,NextNewBoard),
    play(NextNewBoard).

execute_command(Player,Board,NewBoard) :-
    respond_to(Player,Board,NewBoard), !.

execute_command(X, Board, _) :-
    write('What?'),
    halt(0).