/*
 * Name: Jaiden Gann
 * Date: 7/26/23
 * I didn't copy my solution from another person or from an outside source
 * Environment: swi-porlog sandbox (https://swish.swi-prolog.org/)
 */
 
% The main predicate that checks if two lists are disjoint.
disjoint([], _).
disjoint([Head | Tail], List2) :-
    \+ member(Head, List2),
    disjoint(Tail, List2).

% 2
% Base case: list is empty which is count of 0
countValues(_, [], 0).

% Recursive clause 1: If the Element is the head of the list,
% increment the count by 1 and continue recursively with the tail of the list.
countValues(Element, [Element|Tail], Count) :-
    countValues(Element, Tail, SubCount),
    Count is SubCount + 1.
% Recursive clause 2: If the Element is not equal to the Head of the list,
% ignore the Head and continue recursively with the tail of the list.
countValues(Element, [Head|Tail], Count) :-
    Element \= Head,
    countValues(Element, Tail, Count).

% 3. Bind Letter grade to a given integer
letter(Grade, 'A') :- number(Grade), Grade >= 90, Grade =< 100.
letter(Grade, 'B') :- number(Grade), Grade >= 80, Grade < 90.
letter(Grade, 'C') :- number(Grade), Grade >= 70, Grade < 80.
letter(Grade, 'D') :- number(Grade), Grade >= 60, Grade < 70.
letter(Grade, 'F') :- number(Grade), Grade < 60, Grade >= 0.
letter(_, 'Invalid Grade').