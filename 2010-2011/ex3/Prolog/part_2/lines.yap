% /* -.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.
% 
% * File Name : lines.yap
% 
% * Purpose :
% 
% * Creation Date : 28-06-2011
% 
% * Last Modified : Mon 08 Aug 2011 08:19:29 PM EEST
% 
% * Created By : Greg Liras <gregliras@gmail.com>
% 
% _._._._._._._._._._._._._._._._._._._._._.*/


  gcd(A, 0, A).
  gcd(A, B, D) :- (A>B),(B>0),R is A mod B,gcd(B,R,D).
  gcd(A, B, D) :- (A<B), gcd(B,A,D).


  acceptable(LMINSQ,LMAXSQ,DX,DY):-
    !,
    MHKOS is DX*DX+DY*DY,
    LMINSQ =< MHKOS,
    MHKOS =< LMAXSQ,
    gcd(DX,DY,1).

  init(X,Y,R):-
    R is 4*X*Y+X+Y.
  box(X,Y,DX,DY,R):-
    R is 2*(X+1-DX)*(Y+1-DY).

  linesH(W,H,DX,DY,LMINSQ,LMAXSQ,ACC,RET):-
    (
        W<DX,
        H<DY -> ACC=RET
      ; 
        (
            DX =< W -> DX2 is DX+1 , DY2=DY
          ;
            DX2 = 1 , DY2 is DY+1
        ),
        (
            acceptable(LMINSQ,LMAXSQ,DX,DY) -> 
              box(W,H,DX,DY,ADD),
              NEWACC is ACC+ADD,
              linesH(W,H,DX2,DY2,LMINSQ,LMAXSQ,NEWACC,RET)
          ;
            linesH(W,H,DX2,DY2,LMINSQ,LMAXSQ,ACC,RET)
        )
    ).



  lines(W,H,LMIN,LMAX,LINES) :-
    (
        LMIN =< 1 -> init(W,H,START)
      ;
        START=0
    ),
      LMINSQ is LMIN*LMIN,
      LMAXSQ is LMAX*LMAX,
      linesH(W,H,2,1,LMINSQ,LMAXSQ,START,LINES).
