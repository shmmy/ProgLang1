public class Lines 
{
  
  public static void main(String[] args)
  {
    if (args.length!=4)
    {
      System.out.println("Usage: java Lines W H Lmin Lmax");
    }
    else
    {
      
      long w = Integer.parseInt(args[0]); 
      long h = Integer.parseInt(args[1]); 
      long lmin = Integer.parseInt(args[2]); 
      long lmax = Integer.parseInt(args[3]); 
      Lines ls = new Lines(w,h,lmin,lmax);
      ls.lines();
    }
  }
  private long w; 
  private long h; 
  private long lmin; 
  private long lmax; 
  public Lines(long w,long h,long lmin,long lmax)
  {
    this.w = w;
    this.h = h;
    this.lmin = lmin;
    this.lmax = lmax;
  }
  private long box(long w,long h,long dx,long dy)
  {
    return 2*(w+1-dx)*(h+1-dy);
  }
  private void lines()
  {
      long i = 0;
      long j = 0;
      long lminsq=lmin*lmin;
      long lmaxsq=lmax*lmax;
      long acc = 0;
      if (lmin<=1)
      {
        acc=4*w*h+w+h;
      }

      for (i=1,j=2;i<=h;i++)
      {
        for (;j<=w;j++)
        {
          if (accept(lminsq,lmaxsq,j,i))
          {
            acc+=box(w,h,j,i);
          }
        }
        j=1;
      }
      System.out.println(acc);
  }
  private boolean accept(long lminsq,long lmaxsq,long dx,long dy)
  {
    long length = dx*dx+dy*dy;
    return  (((length >= lminsq) && (length <= lmaxsq)) && (gcd(dx,dy)==1));
  }
  private long gcd(long x,long y)
  {
    if (y==0) 
      return x;
    else
      return gcd(y,x%y);
  }

}
