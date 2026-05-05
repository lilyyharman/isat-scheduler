:- discontiguous sector_course/2.
:- discontiguous concentration_course/2.
:- discontiguous prereq/2.
:- discontiguous coreq/2.

:- consult('schedule.pl').

ai_generate_schedule(S1, S2, Conc, Start, N, Schedule) :-
    valid_concentration_choice(S1, S2, Conc),
    build_schedule(Start, N, Semesters),
    choose_courses(S1, S2, Conc, Goals0),
    sort(Goals0, Goals),
    plan_semesters(Semesters, Goals, [], 1, Schedule).

plan_semesters([], [], _, _, []) :- !.
plan_semesters([], _, _, _, []) :- !.
plan_semesters([Sem|Rest], Remaining, Taken, SemIndex, [(Sem, Courses)|PlanRest]) :-
    select_semester_courses(Remaining, Taken, SemIndex, Courses),
    remove_selected(Remaining, Courses, NextRemaining),
    append(Taken, Courses, NextTaken),
    NextIndex is SemIndex + 1,
    plan_semesters(Rest, NextRemaining, NextTaken, NextIndex, PlanRest).

select_semester_courses(Remaining, Taken, SemIndex, Courses) :-
    findall(
        Score-Course,
        (
            member(Course, Remaining),
            course_ready(Course, Taken, SemIndex),
            course_score(Course, Remaining, Taken, SemIndex, Score)
        ),
        ScoredCourses
    ),
    ScoredCourses \= [],
    sort(ScoredCourses, SortedScores),
    reverse(SortedScores, OrderedScores),
    pack_semester(OrderedScores, 18, [], Courses).

pack_semester([], _, _, []).
pack_semester([_-Course|Rest], CreditsLeft, Selected, [Course|PickedRest]) :-
    course_credits(Course, Credits),
    Credits =< CreditsLeft,
    NewCreditsLeft is CreditsLeft - Credits,
    pack_semester(Rest, NewCreditsLeft, [Course|Selected], PickedRest).
pack_semester([_|Rest], CreditsLeft, Selected, Picked) :-
    pack_semester(Rest, CreditsLeft, Selected, Picked).

course_ready(Course, Taken, SemIndex) :-
    prereqs_satisfied(Course, Taken),
    coreqs_satisfied(Course, Taken),
    capstone_allowed(Course, SemIndex).

prereqs_satisfied(Course, Taken) :-
    forall(prereq(Course, Pre), member(Pre, Taken)).

coreqs_satisfied(Course, Taken) :-
    forall(coreq(Course, Co), member(Co, Taken)).

capstone_allowed(Course, SemIndex) :-
    ( capstone(Course, _) -> SemIndex >= 5 ; true ).

course_score(Course, Remaining, Taken, SemIndex, Score) :-
    dependent_count(Course, Remaining, DepCount),
    ( prereqs_satisfied(Course, Taken) -> PrereqBonus = 50 ; PrereqBonus = 0 ),
    ( capstone(Course, _) -> capstone_bonus(SemIndex, CapstoneBonus) ; CapstoneBonus = 0 ),
    ( high_impact_course(Course, Remaining) -> ImpactBonus = 25 ; ImpactBonus = 0 ),
    Score is DepCount * 100 + PrereqBonus + CapstoneBonus + ImpactBonus.

capstone_bonus(SemIndex, Bonus) :-
    ( SemIndex >= 5 -> Bonus = 20 ; Bonus = -40 ).

dependent_count(Course, Remaining, Count) :-
    findall(Dep, (member(Dep, Remaining), prereq(Dep, Course)), Dependents),
    length(Dependents, Count).

high_impact_course(Course, Remaining) :-
    dependent_count(Course, Remaining, Count),
    Count >= 2.

remove_selected(Remaining, Selected, NextRemaining) :-
    subtract(Remaining, Selected, NextRemaining).