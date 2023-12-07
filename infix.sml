fun findValue s nil = raise NotDefined
| findValue (s : string) ((headname : string, headvalue : int)::t) =
if s = headname then headvalue
else (findValue s t)

fun compute s mapL =
let
    fun EXP nil = raise SyntaxError
    | EXP s =
    let
        val (v1,t1) = TERM s
        in
        if t1 = nil then (v1,t1)
        else if (hd t1) = "+" then
        let
            val (v2, t2) = EXP (tl t1 handle Empty => raise SyntaxError)
            in
            (v1 + v2, t2)
            end
        else if (hd t1) = "-" then
        let
            val (v2, t2) = EXP (tl t1 handle Empty => raise SyntaxError)
            in
            (v1 - v2, t2)
            end
        else (v1,t1)
        end
    and TERM nil = raise SyntaxError
    | TERM s =
    let
        val (v1,t1) = BASE s
        in
        if t1 = nil then (v1,t1)
        else if (hd t1) = "*" then
        let
            val (v2, t2) = TERM (tl t1) handle Empty => raise SyntaxError
            in
            (v1 * v2, t2)
            end
        else if (hd t1) = "/" then
        let
            val (v2, t2) = TERM (tl t1) handle Empty => raise SyntaxError
            in
            (v1 div v2, t2)
            end
        else (v1,t1)
        end
    and BASE nil = raise SyntaxError
    | BASE (h::t) =
    if isInt h then (toInt h, t)
    else if h = "fact" orelse h = "fibo" then
    FUNC (h::t)
    else if isAlp h then (findValue h mapL, t)
    else if h = "(" then
    let
        val (v1,t1) = EXP (t)
        val next = (hd t1) handle Empty => raise SyntaxError
        in
        if next = ")" then
        (v1,(tl t1)) handle Empty => raise SyntaxError
        else raise SyntaxError
        end
    else raise SyntaxError
    and FUNC nil = raise SyntaxError
    | FUNC (h::t) =
    let
        val (v1, t1) = BASE t
        in
        if h = "fact" then ((fact v1), t1)
        else if h = "fibo" then ((fibo v1), t1)
        else raise SyntaxError
        end
    in
    let
        val (result,rest) = EXP (separate s)
        in
        if rest = nil then result else raise SyntaxError
        end
    end;
