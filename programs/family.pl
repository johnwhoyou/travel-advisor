% these are the family facts 
woman(pam).
woman(liz).
woman(ann).
woman(pat).

man(tom).
man(bob).
man(jim).

% the following a binary facts. the binary
% predicate 'parent(pam,bob)' can be read 
% as 'pam is a parent of bob'
parent(bob,pat).
parent(pat,jim).
parent(pam,bob).   
parent(tom,bob).
parent(tom,liz).
parent(bob,ann).

mother(X,Y) :-
  woman(X),
  parent(X,Y).

% sample queries
:- writeln('Executing some sample queries...').
:- woman(liz).
:- parent(bob,ann).
:- mother(pam,bob).