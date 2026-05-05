:- use_module(library(lists)).
:- discontiguous sector_course/2.
:- discontiguous concentration_course/2.
:- discontiguous prereq/2.
:- discontiguous coreq/2.
% Facts
% Freshman/Sophomore 
core_course(isat112, 4).
core_course(isat113, 3).
core_course(isat113l, 1).
core_course(isat211, 3).
core_course(isat212, 3).

% Freshman/Sophomore
core_course(isat151, 4).
core_course(isat152, 4).
core_course(isat251, 3).
core_course(isat252, 3).
core_course(isat300, 3).

% Social Context
core_course(isat171, 3).
core_course(isat271, 3).

% Junior/Senior
core_course(isat190, 1).
core_course(isat290, 3).
core_course(isat390, 3).
core_course(isat391, 3).

% Senior Capstone Project
capstone(isat490, 1).
capstone(isat491, 1).
capstone(isat492, 2).
capstone(isat493, 2).

% Sector Requirements (choose 2)
% Applied Biotechnology
sector_course(isat305, 1).
sector_course(isat350, 3).
sector_course(isat351, 3).

% Applied Computing
sector_course(isat340, 3).
sector_course(isat341, 3).

% Energy
sector_course(isat301, 1).
sector_course(isat310, 3).
sector_course(isat311, 3).

% Environment and Sustainability
sector_course(isat320, 3).
sector_course(isat321, 3).

% Industrial and Manufacturing systems
sector_course(isat303, 1).
sector_course(isat330, 3).
sector_course(isat331, 3).

% Concentration Courses
% Applied Biotechnology Concentration
concentration_course(isat451, 3).
concentration_course(isat452, 3).
concentration_course(isat454, 3).
concentration_course(isat455, 3).
concentration_course(isat456, 3).
concentration_course(isat459, 3).
concentration_course(isat4885, 3).

% Applied Computing Concentration
concentration_course(isat440, 3).
concentration_course(isat441, 3).
concentration_course(isat445, 3).
concentration_course(isat447, 3).
concentration_course(isat449, 3).

% Energy Concentration
% Required Energy Concentration Courses: 6 Credit Hours
concentration_course(isat411, 3).
concentration_course(isat413, 3).

% Energy Concentration Electives: 6 Credit Hours
concentration_course(isat410, 3).
concentration_course(isat414, 3).
concentration_course(isat416, 3).

% Environment and Sustainability Concentration
concentration_course(isat420, 3).
concentration_course(isat421, 3).
concentration_course(isat422, 3).
concentration_course(isat423, 3).
concentration_course(isat424, 3).
concentration_course(isat425, 3).
concentration_course(isat426, 3).
concentration_course(isat427, 3).
concentration_course(isat428, 3).
concentration_course(isat429, 3).
concentration_course(isat473, 4).
concentration_course(isat474, 3).

% Industrial and Manufacturing Systems Concentration
concentration_course(isat430, 3).
concentration_course(isat431, 3).
concentration_course(isat432, 3).
concentration_course(isat433, 3).
concentration_course(isat434, 3).
concentration_course(isat435, 3).
concentration_course(isat437, 3).

% Public Interest Technology and Science Concentration
concentration_course(isat411, 3).
concentration_course(isat421, 3).
concentration_course(isat440, 3).
concentration_course(isat455, 3).
concentration_course(isat456, 3).
concentration_course(isat485, 3).
concentration_course(isat483, 3).
concentration_course(isat487, 3).

% Link courses to Sectors
% Applied Biotechnology
sector_course(biotech, isat305).
sector_course(biotech, isat350).
sector_course(biotech, isat351).

% Applied Computing
sector_course(computing, isat340).
sector_course(computing, isat341).

% Energy
sector_course(energy, isat301).
sector_course(energy, isat310).
sector_course(energy, isat311).

% Environment and Sustainability
sector_course(environment, isat320).
sector_course(environment, isat321).

% Industrial and Manufacturing systems
sector_course(manufacturing, isat303).
sector_course(manufacturing, isat330).
sector_course(manufacturing, isat331).

% Link Courses to Concentrations
% Applied Biotechnology
concentration_course(biotech, isat451).
concentration_course(biotech, isat452).
concentration_course(biotech, isat454).
concentration_course(biotech, isat455).
concentration_course(biotech, isat456).
concentration_course(biotech, isat459).
concentration_course(biotech, isat485).

% Applied Computing
concentration_course(computing, isat440).
concentration_course(computing, isat441).
concentration_course(computing, isat445).
concentration_course(computing, isat447).
concentration_course(computing, isat449).

% Energy
concentration_course(energy, isat411).
concentration_course(energy, isat413).
concentration_course(energy, isat410).
concentration_course(energy, isat414).
concentration_course(energy, isat416).

% Environment
concentration_course(environment, isat420).
concentration_course(environment, isat421).
concentration_course(environment, isat422).
concentration_course(environment, isat423).
concentration_course(environment, isat424).
concentration_course(environment, isat425).
concentration_course(environment, isat426).
concentration_course(environment, isat427).
concentration_course(environment, isat428).
concentration_course(environment, isat429).
concentration_course(environment, isat473).
concentration_course(environment, isat474).

% Manufacturing
concentration_course(manufacturing, isat430).
concentration_course(manufacturing, isat431).
concentration_course(manufacturing, isat432).
concentration_course(manufacturing, isat433).
concentration_course(manufacturing, isat434).
concentration_course(manufacturing, isat435).
concentration_course(manufacturing, isat437).

% Public Interest
concentration_course(public_interest, isat411).
concentration_course(public_interest, isat421).
concentration_course(public_interest, isat440).
concentration_course(public_interest, isat455).
concentration_course(public_interest, isat456).
concentration_course(public_interest, isat485).
concentration_course(public_interest, isat483).
concentration_course(public_interest, isat487).

% How many courses for each concentration_course
required_concentration_courses(biotech, 4).
required_concentration_courses(computing, 4).
required_concentration_courses(energy, 4).
required_concentration_courses(environment, 4).
required_concentration_courses(manufacturing, 4).
required_concentration_courses(public_interest, 4).

% Term and Year
% Semester Progression
next_semester(semester(fall, Y), semester(spring, Y1)) :-
    Y1 is Y + 1.

next_semester(semester(spring, Y), semester(fall, Y)).


% Build Schedule With Limit
build_schedule(_, 0, []).
build_schedule(S, N, [S|Rest]) :-
    N > 0,
    next_semester(S, Next),
    N1 is N - 1,
    build_schedule(Next, N1, Rest).

% pick courses from concentration
choose_courses(S1, S2, Conc, Selected) :-
    findall(C, core_course(C, _), Core),
    findall(C1, sector_course(S1, C1), Sector1),
    findall(C2, sector_course(S2, C2), Sector2),
    choose_concentration_courses(Conc, ConcCourses),
    findall(Cap, capstone(Cap, _), Capstone),

    append(Core, Sector1, Temp1),
    append(Temp1, Sector2, Temp2),
    append(Temp2, ConcCourses, Temp3),
    append(Temp3, Capstone, Selected).

choose_concentration_courses(Conc, Selected) :-
    required_concentration_courses(Conc, N),
    findall(C, concentration_course(Conc, C), All),
    subset_of_size(N, All, Selected).

% helper rule
subset_of_size(0, _, []).
subset_of_size(N, [H|T], [H|Rest]) :-
    N > 0,
    N1 is N - 1,
    subset_of_size(N1, T, Rest).
subset_of_size(N, [_|T], Rest) :-
    N > 0,
    subset_of_size(N, T, Rest).

% ============================================================================
% AI PLANNING MODULE: Constraint-aware schedule generation with state-space search
% ============================================================================
% Uses forward-chaining search with intelligent course selection heuristics
% to find valid schedules that respect prerequisites, capacity, and constraints.

% Main entry point: plan schedule using AI search
assign_courses(Courses, Semesters, Schedule) :-
    length(Semesters, _SemCount),
    analyze_dependencies(Courses, DepMap),
    plan_search(
        state(1, [], Courses, DepMap, Semesters),
        Placement
    ),
    build_grouped_schedule(Semesters, Placement, Schedule).

% State: state(CurrentSem, ScheduledCourses, RemainingCourses, DependencyMap, AllSemesters)
% Scheduled format: [Course-Sem, Course-Sem, ...]

% Main search procedure: forward-chaining with backtracking
plan_search(state(_, Scheduled, [], _, _), Scheduled) :- !.
plan_search(state(Sem, Scheduled, Remaining, DepMap, Semesters), Placement) :-
    length(Semesters, SemCount),
    Sem =< SemCount,
    % Select best course candidate for current semester using heuristics
    select_best_course(Remaining, Scheduled, DepMap, Semesters, Sem, SemCount, Course),
    % Try to schedule course in current semester
    (   schedule_course(Course, Sem, Scheduled, Semesters, NewScheduled)
    ->  % Success: continue with remaining courses
        delete(Remaining, Course, NewRemaining),
        plan_search(
            state(Sem, NewScheduled, NewRemaining, DepMap, Semesters),
            Placement
        )
    ;   % Can't fit in this semester: try next semester
        Sem < SemCount,
        NextSem is Sem + 1,
        plan_search(
            state(NextSem, Scheduled, Remaining, DepMap, Semesters),
            Placement
        )
    ).

% Analyze course dependencies: count how many courses depend on each course
analyze_dependencies(Courses, DepMap) :-
    findall(
        Course-DepCount,
        (
            member(Course, Courses),
            count_dependents(Course, Courses, DepCount)
        ),
        DepMap
    ).

% Count how many courses in the list depend on a given course
count_dependents(Course, AllCourses, Count) :-
    findall(
        Dep,
        (member(Dep, AllCourses), prereq(Dep, Course)),
        Dependents
    ),
    length(Dependents, Count).

% Select best course to schedule next using heuristics
% Heuristics prioritize:
%  1. Courses with many dependents (high in-degree) - unblock others
%  2. Courses with prerequisites already met
%  3. Courses critical to the path
%  4. Later defer capstones and high-level courses
select_best_course(Remaining, Scheduled, DepMap, Semesters, Sem, SemCount, Selected) :-
    findall(
        Score-Course,
        (
            member(Course, Remaining),
            can_schedule_eventually(Course, Remaining, Scheduled),
            calculate_score(
                Course, Remaining, Scheduled, DepMap, Semesters, Sem, SemCount, Score
            )
        ),
        Scores
    ),
    Scores \= [],  % At least one candidate
    sort(Scores, SortedScores),
    reverse(SortedScores, [_-Selected|_]).

% Heuristic score calculation: higher score = higher priority
calculate_score(Course, Remaining, Scheduled, DepMap, _Semesters, Sem, _SemCount, Score) :-
    % Component 1: Number of dependents (unblock others)
    (   member(Course-DepCount, DepMap) -> Dep = DepCount * 80 ; Dep = 0 ),
    
    % Component 2: Prerequisites ready (can take now)
    (   all_prereqs_met(Course, Scheduled) -> Prereq = 60 ; Prereq = 0 ),
    
    % Component 3: Required minimum semester check
    (   min_semester_for_course(Course, Scheduled, MinSem),
        Sem >= MinSem
    ->  MinCheck = 40
    ;   MinCheck = 0
    ),
    
    % Component 4: Is this on critical path (blocks others)
    (   is_critical_course(Course, Remaining, Scheduled) -> Critical = 50 ; Critical = 0 ),
    
    % Component 5: Penalty for taking capstones too early
    (   capstone(Course, _), Sem < 5 -> Penalty = -30 ; Penalty = 0 ),
    
    % Component 6: Bonus for prerequisite courses (foundation)
    (   is_prerequisite_for_many(Course, Remaining) -> PrerqBonus = 25 ; PrerqBonus = 0 ),
    
    Score is Dep + Prereq + MinCheck + Critical + Penalty + PrerqBonus.

% Check if course can eventually be scheduled (prerequisites exist in plan)
can_schedule_eventually(Course, Remaining, Scheduled) :-
    forall(
        prereq(Course, Pre),
        (member(Pre-_, Scheduled) ; member(Pre, Remaining))
    ).

% Find minimum semester a course can be taken (after prerequisites)
min_semester_for_course(Course, Scheduled, MinSem) :-
    findall(
        ReqSem,
        (prereq(Course, Pre), member(Pre-PreSem, Scheduled), ReqSem is PreSem + 1),
        ReqSems
    ),
    capstone_min_sem(Course, CapMin),
    (   ReqSems = [] -> MaxReq = 1 ; max_list(ReqSems, MaxReq) ),
    MinSem is max(MaxReq, CapMin).

capstone_min_sem(Course, 5) :- capstone(Course, _), !.
capstone_min_sem(_, 1).

% Is this course critical (has dependent courses with no alternative path)
is_critical_course(Course, Remaining, _Scheduled) :-
    findall(
        Dep,
        (
            member(Dep, Remaining),
            prereq(Dep, Course),
            \+ has_alternative_prereq(Dep, Course, Remaining)
        ),
        Dependents
    ),
    length(Dependents, N), N > 0.

% Check if a course has an alternative way to satisfy prerequisite
has_alternative_prereq(Course, TargetPre, Remaining) :-
    prereq(Course, OtherPre),
    OtherPre \= TargetPre,
    member(OtherPre, Remaining).

% Is a course a prerequisite for many others
is_prerequisite_for_many(Course, Remaining) :-
    findall(
        Dep,
        (member(Dep, Remaining), prereq(Dep, Course)),
        Dependents
    ),
    length(Dependents, N), N >= 2.

% Attempt to schedule a course in given semester
schedule_course(Course, Sem, Scheduled, Semesters, NewScheduled) :-
    % All prerequisites must be scheduled
    all_prereqs_met(Course, Scheduled),
    
    % Corequisite constraints (same or earlier semester)
    check_corequisites(Course, Sem, Scheduled),
    
    % Capacity constraint (≤18 credits/semester)
    get_course_credits(Course, Credits),
    current_semester_load(Sem, Scheduled, CurrentLoad),
    TotalLoad is CurrentLoad + Credits,
    TotalLoad =< 18,
    
    % Valid semester (not past the last semester)
    length(Semesters, SemCount), Sem =< SemCount,
    
    % Add course to schedule
    NewScheduled = [Course-Sem | Scheduled].

% Check if all prerequisites are satisfied
all_prereqs_met(Course, Scheduled) :-
    forall(prereq(Course, Pre), member(Pre-_, Scheduled)).

% Check corequisite constraints
check_corequisites(Course, Sem, Scheduled) :-
    forall(
        coreq(Course, CoReq),
        (member(CoReq-CoSem, Scheduled), CoSem =< Sem)
    ).

% Get current load for a semester
current_semester_load(Sem, Scheduled, Load) :-
    findall(
        Cred,
        (member(C-Sem, Scheduled), get_course_credits(C, Cred)),
        Credits
    ),
    sum_list(Credits, Load).

% Unified course credit lookup
get_course_credits(Course, Credits) :-
    core_course(Course, Credits), !.
get_course_credits(Course, Credits) :-
    capstone(Course, Credits), !.
get_course_credits(Course, Credits) :-
    sector_course(Course, Credits), number(Credits), !.
get_course_credits(Course, Credits) :-
    concentration_course(Course, Credits), number(Credits), !.


% ============================================================================
% SCHEDULE BUILDING & VALIDATION
% ============================================================================

prereqs_covered(Courses) :-
    forall(
        (member(Course, Courses), prereq(Course, Pre)),
        member(Pre, Courses)
    ).

build_grouped_schedule(Semesters, Placement, Schedule) :-
    build_grouped_schedule(Semesters, Placement, 1, Schedule).

build_grouped_schedule([], _, _, []).
build_grouped_schedule([Sem|RestSems], Placement, Index, [(Sem, CoursesInSem)|Rest]) :-
    findall(C, member(C-Index, Placement), CoursesInSem),
    NextIndex is Index + 1,
    build_grouped_schedule(RestSems, Placement, NextIndex, Rest).

generate_schedule(S1, S2, Conc, Start, N, Schedule) :-
    valid_concentration_choice(S1, S2, Conc),
    build_schedule(Start, N, Semesters),
    choose_courses(S1, S2, Conc, Courses),
    prereqs_covered(Courses),
    assign_courses(Courses, Semesters, Schedule).

valid_concentration_choice(S1, S2, Conc) :-
    Conc = S1 ;
    Conc = S2.

map_courses_with_level([], _, []).
map_courses_with_level([C|Cs], AllCourses, [Level-C|Rest]) :-
    course_level(C, AllCourses, Level),
    map_courses_with_level(Cs, AllCourses, Rest).

course_level(Course, AllCourses, Level) :-
    findall(
        PreLevel,
        (
            prereq(Course, Pre),
            member(Pre, AllCourses),
            course_level(Pre, AllCourses, PreLevel)
        ),
        PreLevels
    ),
    (
        PreLevels = [] -> Level = 0
    ;
        max_list(PreLevels, MaxPre),
        Level is MaxPre + 1
    ).

extract_courses([], []).
extract_courses([_-C|Rest], [C|Courses]) :-
    extract_courses(Rest, Courses).

place_courses([], _, Placement, Placement).
place_courses([Course|Rest], SemCount, Acc, Placement) :-
    earliest_allowed_semester(Course, Acc, MinSem),
    select_semester_for_course(Course, MinSem, SemCount, Acc, ChosenSem),
    place_courses(Rest, SemCount, [Course-ChosenSem|Acc], Placement).

earliest_allowed_semester(Course, Placement, MinSem) :-
    findall(
        ReqSem,
        (
            prereq(Course, Pre),
            member(Pre-PreSem, Placement),
            ReqSem is PreSem + 1
        ),
        ReqSems
    ),
    capstone_floor(Course, CapFloor),
    max_of_list_with_default(ReqSems, 1, ReqFloor),
    MinSem is max(ReqFloor, CapFloor).

capstone_floor(Course, 5) :-
    capstone(Course, _),
    !.
capstone_floor(_, 1).

max_of_list_with_default([], Default, Default).
max_of_list_with_default(List, _, Max) :-
    max_list(List, Max).

select_semester_for_course(Course, Sem, SemCount, Placement, Sem) :-
    Sem =< SemCount,
    semester_has_capacity(Sem, Placement, Course),
    coreq_constraint_ok(Course, Sem, Placement),
    !.
select_semester_for_course(Course, Sem, SemCount, Placement, Chosen) :-
    Sem < SemCount,
    Next is Sem + 1,
    select_semester_for_course(Course, Next, SemCount, Placement, Chosen).

semester_has_capacity(Sem, Placement, Course) :-
    get_course_credits(Course, NewCredits),
    findall(Credits,
        (
            member(C-Sem, Placement),
            get_course_credits(C, Credits)
        ),
        CreditList
    ),
    sum_list(CreditList, CurrentCredits),
    TotalCredits is CurrentCredits + NewCredits,
    TotalCredits =< 18.

coreq_constraint_ok(Course, Sem, Placement) :-
    forall(
        coreq(Course, Co),
        (
            member(Co-CoSem, Placement)
            -> CoSem =< Sem
            ; true
        )
    ).


% Core class Prereqs
prereq(isat152, isat151).
prereq(isat300, isat252).
prereq(isat300, isat251).
prereq(isat271, isat171).
prereq(isat290, isat212).
prereq(isat290, isat190).
prereq(isat390, isat290).
prereq(isat391, isat390).
prereq(isat212, isat152).
prereq(isat390, isat271).

% Sector prereqs
% Applied Biotechnology sector prereqs
prereq(isat305, isat113).
prereq(isat305, isat113l).
prereq(isat350, isat113).
prereq(isat350, isat113l).
prereq(isat351, isat113).
prereq(isat351, isat350).

% Applied Computing sector prereqs
prereq(isat340, isat252).
prereq(isat341, isat340).

% Energy sector prereqs
prereq(isat301, isat212).
prereq(isat301, isat300).
prereq(isat310, isat212).
prereq(isat311, isat212).
prereq(isat311, isat310).

% Environment and Sustainability sector prereqs
prereq(isat320, isat112).
prereq(isat321, isat320).

% Industrial and Manufacturing Systems sector prereqs
prereq(isat330, isat211).
prereq(isat330, isat251).
prereq(isat331, isat211).

% Capstone (start junior year)
prereq(isat491, isat490).
prereq(isat492, isat491).
prereq(isat493, isat492).

% Corequisites
coreq(isat113l, isat113).

% Applied Biotechnology Concentration prereqs
prereq(isat451, isat330).
prereq(isat452, isat351).
prereq(isat454, isat351).
prereq(isat455, isat350).
prereq(isat456, isat171).
prereq(isat456, isat271).

% applied computing concentration prereqs
prereq(isat440, isat271).
prereq(isat441, isat211).
prereq(isat445, isat340).
prereq(isat449, isat341).

% Required Energy Concentration prereqs
prereq(isat411, isat311).
prereq(isat413, isat310).
prereq(isat413, isat311).

% Energy Concentration Electives prereqs
prereq(isat410, isat310).
prereq(isat414, isat310).
prereq(isat416, isat212).
prereq(isat416, isat300).

% Environment and Sustainability Concentration prereqs
prereq(isat420, isat321).
prereq(isat421, isat321).
prereq(isat423, isat321).
prereq(isat424, isat321).
prereq(isat425, isat320).
prereq(isat429, isat320).

% public interest concentration prereqs
prereq(isat411, isat311).
prereq(isat421, isat321).
prereq(isat440, isat271).
prereq(isat455, isat350).
prereq(isat456, isat171).
prereq(isat456, isat271).
prereq(isat483, isat171).
prereq(isat483, isat271).
prereq(isat487, isat171).

% Check if all prerequisites are met in the schedule
valid_prereqs(Schedule) :-
    forall(
        (member((Course, Sem), Schedule),
         prereq(Course, Pre)),
        (member((Pre, PreSem), Schedule),
         comes_before(PreSem, Sem))
    ).

% Check if all corequisites are met in the schedule
valid_coreqs(Schedule) :-
    forall(
        (member((Course, Sem), Schedule),
         coreq(Course, Co)),
        (member((Co, CoSem), Schedule),
         same_or_before(CoSem, Sem))
    ).

% Check if capstone courses are in the last two semesters
valid_capstones(Schedule) :-
    findall(Sem, member((_, Sem), Schedule), Sems),
    sort(Sems, Unique),
    length(Unique, Total),

    forall(
        (member((Course, Sem), Schedule),
         capstone(Course, _)),
        later_semester(Sem, Unique, Total)
    ).

% valid capstone 

% Helper predicates for semester ordering
comes_before(semester(fall, Y), semester(spring, Y1)) :-
    Y1 is Y + 1.

comes_before(semester(fall, Y), semester(fall, Y1)) :-
    Y1 > Y.

comes_before(semester(spring, Y), semester(spring, Y1)) :-
    Y1 > Y.

comes_before(semester(spring, Y), semester(fall, Y)).



% corequisites can be in the same semester or the coreq can come before
same_or_before(S, S).

same_or_before(semester(fall, Y), semester(spring, Y1)) :-
    Y1 is Y + 1.

same_or_before(semester(fall, Y), semester(fall, Y1)) :-
    Y1 > Y.

same_or_before(semester(spring, Y), semester(spring, Y1)) :-
    Y1 > Y.

same_or_before(semester(spring, Y), semester(fall, Y)).

% Capstones must be in the last four semesters
later_semester(Sem, List, Total) :-
    nth1(Index, List, Sem),
    Index > Total // 4.