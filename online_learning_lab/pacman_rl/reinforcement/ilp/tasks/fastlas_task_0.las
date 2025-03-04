#pos(ex1@0, {move(west)}, {move(south), move(north), move(east)}, {food(west, 3). wall(east). wall(west). wall(south). ghost(east, 9). food(west, 5). food(west, 10). food(east, 10). food(west, 6). food(west, 8). food(west, 9). capsule(west, 7). ghost(east, 6). food(east, 8). food(east, 6). food(east, 7). food(east, 9). food(west, 4). wall(north). food(west, 7). capsule(east, 9). capsule(east, 4).}).
#pos(ex2@0, {move(west)}, {move(south), move(north), move(east)}, {food(west, 3). wall(east). wall(west). wall(south). food(west, 5). food(east, 10). food(west, 6). food(west, 8). food(west, 9). capsule(west, 6). capsule(east, 10). food(east, 8). capsule(east, 5). ghost(west, 9.0). food(east, 7). ghost(east, 6.0). food(east, 9). food(west, 4). wall(north). food(west, 2). food(west, 7).}).
#pos(ex3@0, {move(west)}, {move(south), move(north), move(east)}, {capsule(west, 5). food(west, 8). food(east, 9). food(west, 4). food(east, 8). ghost(west, 7.0). ghost(east, 6.0). food(west, 3). wall(east). wall(north). wall(west). wall(south). food(west, 2). food(west, 1). capsule(east, 6). food(west, 5). food(east, 10). food(west, 7). food(west, 6).}).
#pos(ex4@1, {move(west)}, {move(south), move(north), move(east)}, {ghost(east, 6.0). food(east, 9). food(west, 4). wall(north). food(west, 3). food(west, 7). wall(east). wall(west). wall(south). food(west, 2). food(west, 1). food(west, 5). food(east, 10). food(north, 1). ghost(west, 5.0). capsule(east, 7). capsule(west, 4). food(west, 6).}).
#pos(ex5@1, {move(west)}, {move(south), move(north), move(east)}, {ghost(east, 6.0). food(west, 4). wall(north). ghost(west, 3.0). food(west, 3). capsule(west, 3). wall(east). food(east, 2). wall(west). wall(south). food(west, 2). food(west, 1). capsule(east, 8). food(west, 5). food(east, 10). food(west, 6).}).
#pos(ex6@1, {move(west)}, {move(south), move(north), move(east)}, {ghost(east, 6.0). food(west, 4). capsule(north, 2). food(east, 3). wall(north). food(west, 3). wall(east). wall(south). wall(west). food(west, 2). food(west, 1). food(west, 5). capsule(east, 9). ghost(west, 1.0).}).
ranges_dist(0..10).
dir(north).
dir(south).
dir(east).
dir(west).


dist_thr(0).
dist_thr(1).
dist_thr(2).
dist_thr(4).


food_dist_geq(D, D1, D2) :- food(D, D1), dist_thr(D2), D1 >= D2.
food_dist_leq(D, D1, D2) :- food(D, D1), dist_thr(D2), D1 <= D2.
ghost_dist_geq(D, D1, D2) :- ghost(D, D1), dist_thr(D2), D1 >= D2.
ghost_dist_leq(D, D1, D2) :- ghost(D, D1), dist_thr(D2), D1 <= D2.
caps_dist_geq(D, D1, D2) :- capsule(D, D1), dist_thr(D2), D1 >= D2.
caps_dist_leq(D, D1, D2) :- capsule(D, D1), dist_thr(D2), D1 <= D2.

#modeb(1,food_dist_geq(var(dir), var(ranges_dist), const(dist_thr))).
#modeb(1,food_dist_leq(var(dir), var(ranges_dist), const(dist_thr))).
#modeb(1,ghost_dist_geq(var(dir), var(ranges_dist), const(dist_thr))).
#modeb(1,ghost_dist_leq(var(dir), var(ranges_dist), const(dist_thr))).
#modeb(1,caps_dist_geq(var(dir), var(ranges_dist), const(dist_thr))).
#modeb(1,caps_dist_leq(var(dir), var(ranges_dist), const(dist_thr))).
#modeb(not wall(var(dir))).

#modeh(move(var(dir))).

#maxv(3).

%bias declarations to ensure direction variables are the same
#bias(":- in_head(move(V0)), in_body(wall(X)), V0!=X.").
#bias(":- in_head(move(V0)), in_body(food_dist_geq(X,_,_)), V0!=X.").
#bias(":- in_head(move(V0)), in_body(food_dist_leq(X,_,_)), V0!=X.").
#bias(":- in_head(move(V0)), in_body(ghost_dist_leq(X,_,_)), V0!=X.").
#bias(":- in_head(move(V0)), in_body(ghost_dist_geq(X,_,_)), V0!=X.").
#bias(":- in_head(move(V0)), in_body(caps_dist_leq(X,_,_)), V0!=X.").
#bias(":- in_head(move(V0)), in_body(caps_dist_geq(X,_,_)), V0!=X.").

%bias declarations to add rule penalties (bias search towards more general rules)
#bias("penalty(2, head(X)) :- in_head(X).").
#bias("penalty(1, body(X)) :- in_body(X).").