/* -.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.

* File Name : Program.java

* Purpose :

* Creation Date : 04-08-2011

* Last Modified : Thu 11 Aug 2011 11:18:36 PM EEST

* Created By : Greg Liras <gregliras@gmail.com>

_._._._._._._._._._._._._._._._._._._._._.*/

import java.util.ArrayList;

public class Program implements Cloneable
{ 
  private ArrayList<PR> Prog = null;
  private PR last = null;
  public Program()
  {
    Prog = new ArrayList<PR>();
  }
  public Program(ArrayList<PR> newP)
  {
    Prog = newP;
  }
  public void add(char C)
  {
    try
    {
      last = Prog.get(Prog.size()-1);
      if(last.getC()==C)
      {
        last.inc();
      }
      else
      {
        last = new PR(C);
        Prog.add(last);
      }
    }
    catch(java.lang.IndexOutOfBoundsException e)
    {
      last = new PR(C);
      Prog.add(last);
    }
  }
  public Program clone()
  {
    ArrayList<PR> newProg = new ArrayList<PR>(Prog);
    int lastIndex = Prog.size()-1;
    if(lastIndex>=0)
    {
      newProg.set(lastIndex,last.clone());
    }
    return new Program(newProg);
  } 

  public ArrayList<PR> getProg()
  {
    return Prog;
  }
  public Program addM()
  {
    Program p = clone();
    p.add('M');
    return p;
  }
  public Program addA()
  {
    Program p = clone();
    p.add('A');
    return p;
  }
  public String toString()
  {
    StringBuilder S = new StringBuilder();
    for(PR p : Prog)
    {
      int t = p.getTimes();
      char c = p.getC();
      for(int i=0;i<t;i++)
      {
        S.append(c);
      }
    }
    return S.toString();
  }
}

