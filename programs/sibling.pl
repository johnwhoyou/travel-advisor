% demonstrates backtracking over rules
brother(fred,john).
sister(brionna,rona).

sibling(X,Y) :- sister(X,Y) . 
sibling(X,Y) :- brother(X,Y).

% example query
:- sibling(fred,john).
