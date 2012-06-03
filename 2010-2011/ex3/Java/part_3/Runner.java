/* -.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.

* File Name : Runner.java

* Purpose :

* Creation Date : 05-07-2011

* Last Modified : Thu 11 Aug 2011 10:55:34 PM EEST

* Created By : Greg Liras <gregliras@gmail.com>

_._._._._._._._._._._._._._._._._._._._._.*/

import java.util.ArrayList;
public class Runner
{
  private int a=0;
  private int m=0;
  private int li=0;
  private int hi=0;
  private int mlo=0;
  private int mho=0;
  private int mul=0;
  private double pow=0;
  private Program prog;

  public Runner(int a,int m,int li,int hi)
  {
    this.a=a;
    this.m=m;
    this.li=li;
    this.hi=hi;
  }
  public void SetRunner(Program prog)
  {
    mlo=li;
    mho=hi;
    this.prog = prog;
  }
  public void run()
  {
    ArrayList<PR> P = prog.getProg();
    int t = 0;
    char c = '0';
    for(PR rlP : P)
    {
      t = rlP.getTimes();
      c = rlP.getC();

      if (c=='A')
      {
        mul = a*t;
        mlo+=mul;
        mho+=mul;
      }
      else 
      {
        pow=Math.pow(m,t);
        mlo*=pow;
        mho*=pow;
      }
    }
  }
  public int outPutCheck(int lo,int ho)
  {
    if(mho-mlo>ho - lo) return 1; //high out width
    if(mho>ho) return 1; //high out exceeded
    if(mlo>ho) return 1; //
    if(mlo<lo) return 2; //low out not reached
    if(mho<lo) return 2; //
    return 0;
  }
}
