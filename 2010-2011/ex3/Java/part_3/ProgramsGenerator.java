/* -.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.

* File Name : ProgramsGenerator.java

* Purpose :

* Creation Date : 05-07-2011

* Last Modified : Thu 11 Aug 2011 11:19:44 PM EEST

* Created By : Greg Liras <gregliras@gmail.com>

_._._._._._._._._._._._._._._._._._._._._.*/

import java.util.ArrayList;


public class ProgramsGenerator
{
  private int minLim=0;
  private ArrayList<Program> ProgList = null;
  private ArrayList<Program> StartList = null;
  private Program BuffA = null;
  private Program BuffM = null;

  public ProgramsGenerator(int minLim)
  {
    this.minLim=minLim;
    ProgList = new ArrayList<Program>();

    StartList=new ArrayList<Program>();
  }
  public void fillProgList()
  {
    ProgList.add(new Program());
    for(int i=0;i<minLim;i++)
    {
      makeMoreProgs();
    }
  }
  public void makeMoreProgs()
  {
    StartList=new ArrayList<Program>();
    for(Program S : ProgList)
    {
      //BuffA=S.clone();
      //BuffM=S.clone();
      //BuffA.add('A');
      //BuffM.add('M');

      //StartList.add(BuffA);
      //StartList.add(BuffM);
      StartList.add(S.addA());
      StartList.add(S.addM());
    }
    ProgList=StartList;
  }
  public void setProgList(ArrayList<Program> newPLst)
  {
    ProgList=newPLst;
  }
  public ArrayList<Program> getProgList()
  {
    return ProgList;
  }
}

