fun parse file =
  let
    (* Open input file *)
    val input = TextIO.openIn file
    (* Hocus pocus read an integer *)
    val n = Option.valOf (TextIO.scanStream (Int.scan StringCvt.DEC) input)
    fun read_int input = Option.valOf (TextIO.scanStream (Int.scan StringCvt.DEC) input)
    fun read 0 acc = acc
      | read i acc =
        let
          val pair=(read_int input,read_int input)
        in
          read (i-1) (pair::acc)
        end
  in
    read (n-1) nil
  end


fun addFather (a:int,n:int,b:int) = (a,n,b+1)

fun addChild (_,0,b:int) (c:int) = (c,1,b)
  | addChild (a,1,b) _ = (a,2,b)

fun addNodeToArr arr (father:int,child:int) = 
    let
      val newf = addChild (Array.sub(arr,(father-1))) child
      val newc = addFather (Array.sub(arr,(child-1)))

    in
      let
        val _ = Array.update(arr,(father-1),newf)
        val _ = Array.update(arr,(child-1),newc)
      in
        arr
      end
    end

fun nextNode arr (a,_,_) = 
    (Array.sub(arr,(a-1)),(a-1))

fun nextNodeIndex arr i = 
  let
    val (a,_,_) = Array.sub(arr,i)
  in
    (a-1)
  end



fun findStart arr =
  let
    fun findStart_h arr i (a,b,2) = ((a,b,2),i)
      | findStart_h arr i cur = findStart_h arr (i+1) (Array.sub(arr,(i+1)))
  in
    findStart_h arr 0 (Array.sub(arr,0))
  end






fun findStop arr (start,i) = 
  let
    fun findStop_h arr (start,i) ((a,b,2),j) = findStop_h arr ((a,b,2),j)  (nextNode arr (a,b,2))
      | findStop_h arr (start,i) ((a,2,b),j) = (i,j) 
      | findStop_h arr start     (curr   ,j) = findStop_h arr start (nextNode arr curr)
  in
    findStop_h arr (start,i) (nextNode arr start)
  end

fun getAllelements arr (start,stop) = 
  let 
    fun getallelements_h arr (start,stop) curr acc = if (stop=curr) 
      then rev ((stop+1)::acc) 
      else getallelements_h arr (start,stop) (nextNodeIndex arr curr) ((curr+1)::acc)
  in
    getallelements_h arr (start,stop) start []
  end

fun printAllelements arr (start,stop) = 
  let
    fun printallelements_h arr (start,stop) curr = 
      if (stop=curr) 
        then print((Int.toString(stop+1))^"\n")
      else 
        let 
          val _ = (print(Int.toString(curr+1)^" "))
        in
          printallelements_h arr (start,stop) (nextNodeIndex arr curr) 
        end
  in
    printallelements_h arr (start,stop) start
  end




fun makeArr nodeList = 
  let
    val out = Array.array((length(nodeList)+1),(0,0,0))
    fun makeArr_h arr [] = arr 
      | makeArr_h arr (h::tl) = 
      let
        val n = addNodeToArr arr h
      in
        makeArr_h n tl
      end
  in
    makeArr_h out nodeList
  end


fun grafo file = 
  let
    val arr = makeArr (parse file)
  in
    getAllelements arr (findStop arr (findStart arr))
  end

