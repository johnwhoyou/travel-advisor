member([A|_],A).
member([_|T],E) :- member(T,E).

% usage
:- member([a,b,c],b).

% the following query will fail
% :- member([a,b,c],d).

