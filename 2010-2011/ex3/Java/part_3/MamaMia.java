/* -.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.

* File Name : MamaMia.java

* Purpose :

* Creation Date : 05-07-2011

* Last Modified : Thu 11 Aug 2011 10:35:19 PM EEST

* Created By : Greg Liras <gregliras@gmail.com>

_._._._._._._._._._._._._._._._._._._._._.*/

import java.util.ArrayList;


public class MamaMia
{
  public static void main(String[] input)
  {
    if(input.length != 6)
    {
      System.out.println("Usage: java MamaMia a m li hi lo ho");
    }
    else
    {
      int a = Integer.parseInt(input[0]);
      int m = Integer.parseInt(input[1]);
      int li = Integer.parseInt(input[2]);
      int hi = Integer.parseInt(input[3]);
      int lo = Integer.parseInt(input[4]);
      int ho = Integer.parseInt(input[5]);
      int minLimit = Math.min((int) Math.floor(lo/a)
                 ,(int) (Math.floor(Math.log(lo)/Math.log(m))))-1;
      int maxLimit = Math.max((int) Math.ceil(ho/a)
                 ,(int) (Math.ceil(Math.log(ho)/Math.log(m))));

      int status=-1;
      ProgramsGenerator PGen = new ProgramsGenerator(minLimit);
      ArrayList<Program> Progs=null;
      ArrayList<Program> newProgs=null;
      Runner runner=null;

      runner = new Runner(a,m,li,hi);
      newProgs = new ArrayList<Program>();
      PGen.fillProgList();
      for(int i = 0 ; i<= maxLimit ; i++)
      {
        Progs = PGen.getProgList();
        newProgs.clear();
        for(Program Prog:Progs)
        {
          runner.SetRunner(Prog);
          runner.run();
          status = runner.outPutCheck(lo,ho);
          if(status==0)
          {
            if(Progs.size()==1)
            {
              System.out.println("empty");
            }
            else
            { 
              System.out.println(Prog);
            }
            return;
          }
          else if (status==1)
          {
            //System.out.println("Status 1");
          }
          else if (status==2)
          {
            newProgs.add(Prog);
            //System.out.println("Status 2");
          }
        //System.out.println(Prog.length()+" "+Progs.size());
        }
        PGen.setProgList(newProgs);
        PGen.makeMoreProgs();
      }
      System.out.println("impossible");
    }
  }
}
