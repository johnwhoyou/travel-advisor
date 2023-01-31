filter([],_,[]).
filter([A|T1],M,[A|T2]) :- A < M, filter(T1,M,T2).
filter([A|T1],M,T2) :- A >= M, filter(T1,M,T2).

% usage
:- filter([1,2,3],2,[1]).
