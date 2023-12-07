fun findValue s nil = raise NotDefined
| findValue (s : string) ((headname : string, headvalue : int)::t) =
if s = headname then headvalue
else (findValue s t)

fun isInside (a : int) nil = false
| isInside (a : int) ((h : int) :: (t : int list)) =
if a = h then true
else isInside a t

fun sadd a nil = a
| sadd a (h::t) =
if (isInside h a) then sadd a t
else sadd (h::a) t

fun smult a nil = nil
| smult a (h::t) =
if isInside h a then h::(smult a t)
else smult a t

fun ssub nil b = nil
| ssub (h::t) b =
if isInside h b then ssub t b
else h::(ssub t b)

fun compute s mapL =
let
    fun START nil = raise SyntaxError
    | START (h::t) =
    if h = "{" then SET (t)
    else if h = "(" then (SCOMP ((hd t)::(tl t)) handle Empty => raise SyntaxError)
    else raise SyntaxError
    and SET nil = raise SyntaxError
    | SET (h::t) =
    if h = "}" then (nil, t)
    else
    let
        val (v1,t1) = EXP (h::t)
        val (v2,t2) = SET t1
        in
        (v1::v2, t2)
        end
    and SCOMP nil = raise SyntaxError
    | SCOMP (h::t) =
    let
        val (v1, t1) = START t
        val (v2, t2) = START t1
        in
        if (hd t2) = ")" then
        let
            val t3 = (tl t2)
            in
            if h = "+" then (sadd v1 v2, t3)
            else if h = "-" then (ssub v1 v2, t3)
            else if h = "*" then (smult v1 v2, t3)
            else raise SyntaxError
            end
        else
        if h = "+" then
        let
            val (v4,t4) = SCOMP(h::t1)
            in
            (sadd v1 v4, t4)
            end
        else if h = "-" then
        let
            val (v4,t4) = SCOMP("+"::t1)
            in
            (ssub v1 v4, t4)
            end
        else if h = "*" then
        let
            val (v4,t4) = SCOMP(h::t1)
            in
            (smult v1 v4, t4)
            end
        else raise SyntaxError
        end
    and EXP nil = raise SyntaxError
    | EXP (h::t) =
    if isInt h then (toInt h, t)
    else if isAlp h then (findValue h mapL, t)
    else if h = "(" then
    if isAlp (hd t) then (FUNC ((hd t)::(tl t)) handle Empty => raise SyntaxError)
    else (COMP ((hd t)::(tl t)) handle Empty => raise SyntaxError)
    else raise SyntaxError
    and COMP nil = raise SyntaxError
    | COMP (h::t) =
    let
        val (v1,t1) = EXP t
        val (v2,t2) = EXP t1
        in
        if (hd t2) = ")" then
        let
            val t3 = (tl t2)
            in
            if h = "+" then (v1 + v2, t3)
            else if h = "-" then (v1 - v2, t3)
            else if h = "*" then (v1 * v2, t3)
            else if h = "/" then (v1 div v2, t3)
            else raise SyntaxError
            end
        else
        if h = "+" then
        let
            val (v4,t4) = COMP(h::t1)
            in
            (v1+v4, t4)
            end
        else if h = "-" then
        let
            val (v4,t4) = COMP("+"::t1)
            in
            (v1-v4, t4)
            end
        else if h = "*" then
        let
            val (v4,t4) = COMP(h::t1)
            in
            (v1*v4, t4)
            end
        else if h = "/" then
        let
            val (v4,t4) = COMP("*"::t1)
            in
            (v1 div v4, t4)
            end
        else raise SyntaxError
        end
    and FUNC nil = raise SyntaxError
    | FUNC (h::t) =
    let
        val (v1,t1) = EXP t
        in
        if (hd t1) = ")" then
        let
            val t2 = (tl t1)
            in
            if h = "fact" then ((fact v1), t2)
            else if h = "fibo" then ((fibo v1), t2)
            else raise SyntaxError
            end
        else raise SyntaxError
        end
    in
    let
        val (result,rest) = START (separate s)
        in
        if rest = nil then result else raise SyntaxError
        end
    end;
