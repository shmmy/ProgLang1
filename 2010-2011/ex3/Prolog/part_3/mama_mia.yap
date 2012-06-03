% /* -.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.
% 
% * File Name : mama_mia.yap
% 
% * Purpose :
% 
% * Creation Date : 28-06-2011
% 
% * Last Modified : Mon 08 Aug 2011 09:00:59 PM EEST
% 
% * Created By : Greg Liras <gregliras@gmail.com>
% 
% _._._._._._._._._._._._._._._._._._._._._.*/

  %execuTe(_,_,I,OM,''):- OM=I.
  execuTe(_,M,I,OM,('M',MN)):- 
    OM is exp(M,MN)*I.
  execuTe(A,_,I,OM,('A',AN)):- OM is A * AN + I.

  encode(AM, .((AM,N),TL),RL) :-
    NEWN is N+1,
    RL =  [(AM,NEWN)|TL].
  encode(AM, RLE,RL):-
    RL = [(AM,1)|RLE].

  decode([],RLE,RRLE):- !,RRLE = RLE.
  decode([(A,1)|TL],DRLE,RDRLE):- 
    NEWDRLE = [A|DRLE],
    decode(TL,NEWDRLE,RDRLE).
  decode([(A,N)|TL],DRLE,RDRLE):-
    NEWN is N-1,
    NEWDRLE = [A|DRLE],
    decode([(A,NEWN)|TL],NEWDRLE,RDRLE).



  big_sista(_,_,OMO,OMO,[]).
  big_sista(A,M,I  ,O  ,[P|Prog]):-
    execuTe(A,M,I,I2,P),
    big_sista(A,M,I2,O,Prog).

  bigga_sista(A,M,LI,HI,MLO,MHO,Prog):-
    big_sista(A,M,LI,MLO,Prog),
    big_sista(A,M,HI,MHO,Prog).
    
  reverse([],ACC,RL) :- ACC=RL.
  reverse([H|TL],ACC,RL):- reverse(TL,[H|ACC],RL).

  big_mama(A,M,LI,HI,LO,HO,LIMIT,Prog,RetProg):-
    length(Prog,L),
    bigga_sista(A,M,LI,HI,MLO,MHO,Prog),
    L =< LIMIT,
    (
        MLO > HO -> fail
      ;
        MHO > HO -> fail
      ;
        MW is MHO-MLO,
        W is HO-LO,
        MW > W -> fail
      ;
        MLO >= LO,
        MHO >= LO -> RetProg = Prog
      ;
        moreProg(Prog,RProg),
        big_mama(A,M,LI,HI,LO,HO,LIMIT,RProg,RetProg)
    ).

  moreProg(IProg,OProg):-
      encode('M',IProg,OProg)
    ;
      encode('A',IProg,OProg).

  mama_mia(A,M,LI,HI,LO,HO,Prog):-
    LIMIT1 is HO / A,
    LIMIT2 is ceiling(((log(HO)))/((log(M)))),
    LIMIT is max(LIMIT1,LIMIT2),
    big_mama(A,M,LI,HI,LO,HO,LIMIT,[],SProg),
    decode(SProg,[],S1Prog),
    reverse(S1Prog,[],S2Prog),
    !,
    set_prolog_flag(to_chars_mode,iso),
    atom_chars(Prog,S2Prog).
