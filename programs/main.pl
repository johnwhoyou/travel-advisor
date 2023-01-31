% overall rule to check if passenger accomplishes all requirements
travel_advice(X, turkey) :-
  complete_requirements(X),
  travel_rules(X).

% Helper Rules
citizen(X, Y) :-
  passport(X, Y).

tourist(X, Y) :-
  purpose(X, tourist/work),
  \+ citizen(X, Y).

ofw(X) :-
  purpose(X, ofw),
  \+ citizen(X, turkey).

needs_pcr(X) :-
  age(X, Y),
  Y > 12.

child(X) :-
  age(X, Y),
  Y < 18.

adult(X) :-
  \+ child(X).

is_group_member(X) :-
  group(List),
  memberchk(X, List).

get_legal_guardian(X) :-
  write("Input name of legal guardian"),
  read(Y),
  ((is_group_member(Y), adult(Y), assertz(legal_guardian(X, Y))) ; error("Legal guardian required.")).

error(X) :-
  format("Error: ~w", [X]),
  abort.

% Profile Information
valid_profile(X) :-
  (adult(X); child(X), legal_guardian(X, Y), adult(Y)),
  citizen(X, turkey);
  turkish_resident(X, _);
  tourist(X, turkey);
  ofw(X).

% Travel Information
valid_group(X) :-
  length(X, Y),
  Y < 5,
  Y > 0.

% Travel Requirements
complete_requirements(X) :-
  recommend_visa(X),
  check_vaccination(X),
  check_exposure(X).

check_vaccination(X) :-
  (\+ needs_pcr(X), (vaccinated(X, true); vaccinated(X, false)));
  (needs_pcr(X), (vaccinated(X, true); (vaccinated(X, false), require_pcr(X)))).

require_pcr(X) :-
  format("~w must present PCR test taken 72 hours before departure ~n", [X]).

check_exposure(X) :-
  covid_exposure(X, false);
  (covid_exposure(X, true), require_exposure_documents(X)).

require_exposure_documents(X) :-
  format("~w must submit exposure related documents ~n", [X]).

recommend_visa(X) :-
  (tourist(X, turkey),
  format("~w must present a valid passport and apply for a Turkey eVisa. ~n", [X]));
  (ofw(X),
  format("~w must present a valid passport and apply for POEA-conforming visa. ~n", [X]));
  ((citizen(X, turkey); turkish_resident(X, true)),
  format("~w must present a valid passport but does not require a visa. ~n", [X])).

% Travel Rules
travel_rules(X) :-
  needs_quarantine(X).

needs_quarantine(X) :-
  (vaccinated(X, true), format("~w does not need to quarantine upon arrival ~n", [X]));
  (vaccinated(X, false), format("~w needs to quarantine for 7 days upon arrival.~n", [X])).

% User Input
start :-
  write("Input name of traveler(s) "), read(X),
  append([], X, Group),
  assertz(group(Group)),
  valid_group(Group),
  maplist(advise, Group).
  
advise(X) :-
  build_profile(X),
  valid_profile(X),
  travel_advice(X, turkey),
  format("~n~n~n").

build_profile(X) :-
  format("Hi ~w, please input your age.", [X]),
  read(Age),
  assertz(age(X, Age)),
  ((child(X) -> get_legal_guardian(X)); adult(X)),
  write("Input passport place of issue."),
  read(Passport),
  assertz(passport(X, Passport)),
  write("Input reason for travel. <tourist/work|ofw|returning>"),
  read(Purpose),
  assertz(purpose(X, Purpose)),
  write("You are a Turkish resident. <true|false>"),
  read(Resident),
  assertz(turkish_resident(X, Resident)),
  write("You have a valid vaccination card. <true|false>"),
  read(Vaccination),
  assertz(vaccinated(X, Vaccination)),
  write("You have been exposed to COVID-19 within the past 6 months. <true|false>"),
  read(Exposure),
  assertz(covid_exposure(X, Exposure)),
  format("~n~n").