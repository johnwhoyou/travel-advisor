% 'Hello World!' written in Prolog

hello :- 
  nl, 
  writeln('Hello World!'), 
  nl.

% query to run the program
:- hello, halt.
