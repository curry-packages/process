%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Definitions of builtins of module System.Process:
%

'System.Process.getPID'(Pid) :- currentPID(Pid).

'System.Process.prim_system'(S,Status) :-
	string2Atom(S,Cmd),
	shellCmd(Cmd,Status).

'System.Process.prim_exitWith'(Code,_) :- halt(Code).

'System.Process.prim_sleep'(S,'Prelude.()') :- sleepSeconds(S).

'System.Process.getEnvironment'(Result) :-
	catch(findall((Var,Value), system:environ(Var, Value), Reslist), _, Reslist = []),
	allAtom2String(Reslist,Result).

allAtom2String([],[]).
allAtom2String([X|Xs],[Y|Ys]) :- bothAtom2String(X,Y), allAtom2String(Xs, Ys).

bothAtom2String((X1,Y1),'Prelude.(,)'(X2,Y2)) :- basics:atom2String(X1,X2),
                                                 basics:atom2String(Y1,Y2).

