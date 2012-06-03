fun gcd (0,y) = y
  | gcd (x,y) = gcd (y mod x, x)
fun init x y =4*(x)*(y)+x+y

fun box x y dx dy =  Int.toLarge(2*(x+1-dx)*(y+1-dy))


fun accept lminsq lmaxsq dx dy = 
  let 
    val mhkos = dx*dx+dy*dy
  in
    (lminsq <= mhkos) andalso (lmaxsq >= mhkos) andalso (gcd(dx,dy)=1)
  end


fun lines w h lmin lmax = 
  let
    val start = if lmin <= 1 then init w h else 0
    val lminsq=lmin*lmin
    val lmaxsq=lmax*lmax
    fun linesH w h dx dy lmin lmax (acc:IntInf.int) = 
      if w<dx andalso h<dy 
        then acc
        else
          let
            val (nextdx,nextdy)=if dx<=w then ((dx+1),dy) else (1,dy+1)
          in
            if accept lminsq lmaxsq dx dy 
              then linesH w h nextdx nextdy lmin lmax (acc+(box w h dx dy))
              else linesH w h nextdx nextdy lmin lmax acc
          end
  in
    linesH w h 2 1 lmin lmax (Int.toLarge(start))
  end
    


(* MLTON STUFF *)


fun main () = 
  let
    val b = (CommandLine.arguments())
    val st = if (length(b) = 4 )
    then
      let
        val w = Int.fromString (hd(b))
        val h = Int.fromString (hd(tl(b)))
        val lmin = Int.fromString (hd(tl(tl(b))))
        val lmax = Int.fromString (hd(tl(tl(tl(b)))))
        val ln = lines (Option.valOf(w)) (Option.valOf(h)) (Option.valOf(lmin)) (Option.valOf(lmax))
      in
        LargeInt.toString ln
      end
    else
        "Usage: lines W H Lmin Lmax"
  in
    print (st^"\n")
  end
val _ = main ()
