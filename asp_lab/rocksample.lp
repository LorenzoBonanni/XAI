#include <incmode>.


#program base.

rock(0..4).
cell((0..10,0..10)).

good(0).
good(1).

loc(0, (2,5)).
loc(1, (5,2)).
loc(2, (8,6)).
loc(3, (1,9)).

at((0,0), 1). %location (0,0) at time 1


#program step(t).
%TO BE COMPLETED (action preconditions as aggregates; effects and constraints...)
%possible actions are east/north/south/west(t) + sample(R, t)
1 {east(t); north(t); south(t); west(t); sample(R, t): at((X,Y),t), loc(R, (X,Y)), rock(R)} 1.
% 1 {sample(R, t): rock(R)} 1.

% movements actions
at((X,Y+1), t+1)            :- north(t), at((X,Y), t).
at((X,Y-1), t+1)            :- south(t), at((X,Y), t).
at((X-1,Y), t+1)            :- west(t), at((X,Y), t).
at((X+1,Y), t+1)            :- east(t), at((X,Y), t).

at((X,Y), t+1)              :- sample(R, t), at((X,Y), t).
sampled(R,t+1)              :- sample(R, t).
sampled(R,t+1)              :- sampled(R,t).


% Constraints
:- east(t), at((10, Y), t).
:- west(t), at((0, Y), t).
:- south(t), at((X, 0), t).
:- north(t), at((X, 10), t).
:- sample(R, t), sampled(R,t).

#program check(t).
% :- query(t), t<40. %debug purpose
:- query(t), not sampled(R,t), rock(R), good(R). %all good rocks must be sampled

#show sample/2.
#show sampled/2.
#show at/2.
#show east/1.
#show south/1.
#show north/1.
#show west/1.