(* -.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.

* File Name : mama_mia.sml

* Purpose :

* Creation Date : 06-08-2011

* Last Modified : Tue 23 Aug 2011 01:44:39 PM EEST

* Created By : Greg Liras <gregliras@gmail.com>

_._._._._._._._._._._._._._._._._._._._._.*)





fun encode (c:char) [] = [(c,1)]
  | encode (c:char) ((hc:char,hn:int)::tl) = 
    if (c=hc)
      then (c,(hn+1))::tl
      else (c,1)::(hc,hn)::tl



fun decode rle =
  let
    fun decodeH [] (s:char list) = rev s
      | decodeH ((hc:char,1)::tl) (s:char list) = decodeH tl (hc::s)
      | decodeH ((hc:char,hn)::tl) (s:char list) = decodeH ((hc,hn-1)::tl) (hc::s)
  in
    decodeH rle []
  end
fun addA t = encode #"A" t
fun addM t = encode #"M" t

fun pow a b =
    let
      fun powH (a:int) (0:int) acc = acc
        | powH (a:int) (b:int) acc = powH a (b-1) (acc*a)
    in
      powH a b 1
    end

fun execute a m li hi [] = (li,hi)
  | execute a m li hi ((#"A",hn:int)::tl) = execute a m (li+a*hn) (hi+a*hn) tl
  | execute a m li hi ((#"M",hn:int)::tl) = 
    let
      val p=pow m hn
    in
      execute a m (li*p) (hi*p) tl
    end
  | execute a m li hi ((c,hn:int)::tl) = execute a m li hi tl

fun initProgs() = addA []::addM []::[]

fun nextProgs progs = 
  let
    fun nextProgsH []        acc = acc
      | nextProgsH (p::rogs) acc = nextProgsH rogs ( addA p ::addM p ::acc)
  in
    nextProgsH progs []
  end



fun outPutCheck a m li hi lo ho []    = 
    let
      fun minLimit a m li hi lo = 
        if a=0 andalso m>1
          then
            ceil( Math.ln (real lo) / Math.ln (real m))
          else
            if a>0 andalso m=1
              then
                ceil ((real lo) / (real a))
              else
                 Int.min(floor(real lo/real a),floor(Math.ln(real lo)/Math.ln(real m))) 
      fun makeStartProgs minLim []    = makeStartProgs (minLim-1) (initProgs())
        | makeStartProgs 0      progs = progs
        | makeStartProgs minLim progs = makeStartProgs (minLim-1) (nextProgs progs)
      val minl = minLimit a m li hi lo
    in
      outPutCheck a m li hi lo ho (makeStartProgs (minl) [])
    end

  | outPutCheck a m li hi lo ho progs =
    let
      fun maxLimit a m li hi ho = 
        if a=0 andalso m>1
          then
            ceil( Math.ln (real ho) / Math.ln (real m))
          else
            if a>0 andalso m=1
              then
                ceil ((real ho) / (real a))
              else
                Int.max(ceil ((real ho) / (real a)), ceil( Math.ln (real ho) / Math.ln (real m)))
      val maxl = maxLimit a m li hi ho
      val startl = length (hd progs)
      fun outPutLess mlo mho lo ho = mho < lo orelse mlo < lo
      fun outPutExceeded mlo mho lo ho = 
        mho>ho orelse mlo > ho orelse (mho-mlo)>(ho-lo)
      fun outPutCheckH _ _ _  _  _  _  _     _       []               []    []  =  []
        | outPutCheckH a m li hi lo ho maxl  l       []               []    acc = 
          if l > maxl 
            then 
              []
            else
              outPutCheckH a m li hi lo ho maxl  (l+1)   (nextProgs acc)  []    []
        | outPutCheckH _ _ _  _  _  _  _     _       []               found _   = found
        | outPutCheckH a m li hi lo ho maxl  l       (p::rogs)        found acc = 
            if l > maxl 
              then 
                  []
              else
                let
                  val (mlo,mho)=execute a m li hi p
                in
                  if  (outPutExceeded mlo mho lo ho) (*exceed output*)
                    then 
                      outPutCheckH a m li hi lo ho maxl  l rogs found acc
                    else
                      if outPutLess mlo mho lo ho
                        then
                          outPutCheckH a m li hi lo ho maxl  l rogs found (p::acc)
                        else
                          outPutCheckH a m li hi lo ho maxl  l rogs (p::found) acc
                end
    in
      outPutCheckH a m li hi lo ho maxl startl progs [] []
    end
           


      
fun lexTest [] = "impossible"  
  | lexTest ls =  
  let
    val decoded = map implode (map decode ls)
    fun lexTestH [] less = less
      | lexTestH (d::ls) ""  = lexTestH ls d
      | lexTestH (d::ls) less = 
        if String.compare(d,less) = General.LESS
          then
            lexTestH ls d
          else
            lexTestH ls less
  in
    lexTestH decoded ""
  end
fun mama_mia a m li hi lo ho = 
  let
    fun primeCheck li hi lo ho = 
      li >= lo andalso li <= ho andalso hi >= lo andalso hi <=ho
  in
    if primeCheck li hi lo ho 
      then
        "empty"
      else
        lexTest (outPutCheck a m li hi lo ho [])
  end


(*MLton part*)

fun main() =
  let
    val t = (CommandLine.arguments())
    val st = if not ((length (t)) = 6)
      then 
        "Usage mama_mia a m li hi lo ho"
      else
        let
          val sa::sm::sli::shi::slo::sho::[] = t
        in
          mama_mia  (Option.valOf(Int.fromString(sa))) 
                    (Option.valOf(Int.fromString(sm))) 
                    (Option.valOf(Int.fromString(sli))) 
                    (Option.valOf(Int.fromString(shi))) 
                    (Option.valOf(Int.fromString(slo))) 
                    (Option.valOf(Int.fromString(sho)))
        end
  in 
    print (st^"\n")
  end
  
val _ = main()
