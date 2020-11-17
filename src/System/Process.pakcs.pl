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
