public class Grafo 
{

	public static void main(String[] args)
	{
    ArrayFileParser boom = new ArrayFileParser();
    boom.parseIn();
    int[][] tick = boom.getNodeArray();

    NodeArrayParser myparser = new NodeArrayParser(tick);
    myparser.parseArray();

    myparser.printSolution();
	}

}
