import java.util.StringTokenizer;
import java.util.Iterator;
import java.io.InputStreamReader;
import java.io.BufferedReader;
import java.util.Arrays;
public class  ArrayFileParser
{
  private int nodes=0;
  private InputStreamReader isr=null;
  private BufferedReader br=null;
  private StringTokenizer strTzer= null;
  private int[][] NodeArray = null;

  public ArrayFileParser()
  {
    isr = new InputStreamReader(System.in);
    br = new BufferedReader(isr);
    try
    {
      nodes = Integer.parseInt(br.readLine())-1;
      NodeArray = new int[nodes+1][3];

    }
    catch (java.io.IOException e)
    {
    }
  }
  
  public void parseIn()
  {
    int current = 0;
    for(current = 0; current < nodes ; current++)
    { 
      try
      {
        strTzer = new StringTokenizer(br.readLine());
        int father;
        int child;
        father = Integer.parseInt(strTzer.nextToken());
        child = Integer.parseInt(strTzer.nextToken());
        putChildInNode(NodeArray[father-1],child); 
        if(child<=nodes)
        increaseFathers(NodeArray[child-1]); 
      }
      catch ( java.io.IOException e )
      {
      }
    }
  }
  public int[][] getNodeArray()
  {
    return NodeArray;
  }
  private void putChildInNode(int[] node,int child)
  {
    if (node[0]==0)
    {
      node[0]=child;
    }
    node[1]++;
  }
  private void increaseFathers(int[] node)
  {
    node[2]++;
  }

}
