open Ast

(* Globals *)
let assembly = ref ""
let freereg = ref 0
let freelabel = ref 0
let symbols: (string * int) list ref = ref []

let get_freereg _ =
  let r = !freereg in
  incr freereg;
  r

let get_freelabel _ =
  let l = !freelabel in
  incr freelabel;
  l

let write_assembly asm =
  let a = !assembly in
  assembly := a^asm

let get_symbol id =
  if (List.mem_assoc id !symbols)
  then (List.assoc id !symbols)
  else
    let id_reg = get_freereg() in
    symbols:= (id,id_reg)::!symbols;
    id_reg

(* Compilation *)
let compile_atom a = match a with
    Const (n) ->
    let expr_reg = get_freereg() in
    write_assembly (Printf.sprintf "  set r%d #%d\n" expr_reg n);
    expr_reg
  | Id (id) ->
    let id_reg = get_symbol(id) in
    let expr_reg = get_freereg() in
    write_assembly (Printf.sprintf "  set r%d r%d\n" expr_reg id_reg);
    expr_reg

let rec compile_expression expr = match expr with
    Atom (a) ->
    compile_atom a
  | Neg (a) ->
    let expr_reg = compile_atom a in
    write_assembly (Printf.sprintf "  sub r%d #0 r%d\n" expr_reg expr_reg);
    expr_reg
  | BinOp (op,expr,a) ->
    let op_str = (List.assoc op [("+","add");("-","sub")]) in
    let expr_reg = compile_expression expr in
    let atom_reg = compile_atom a in
    write_assembly (Printf.sprintf "  %s r%d r%d r%d\n" op_str expr_reg expr_reg atom_reg);
    expr_reg

let compile_condition cond = match cond with
    Cond (op,expr1,expr2) ->
    let op_str = (List.assoc op [("==","eq");("!=","ne");(">=","ge");(">","gt");("<=","le");("<","lt")]) in
    let expr1_reg = compile_expression expr1 in
    let expr2_reg = compile_expression expr2 in
    let cond_reg = get_freereg() in
    write_assembly (Printf.sprintf "  test_%s r%d r%d r%d\n" op_str cond_reg expr1_reg expr2_reg);
    cond_reg

let rec compile_statement stmt = match stmt with
    Assignment (id,expr) ->
    let expr_reg = compile_expression expr in
    let id_reg = (get_symbol id) in
    write_assembly (Printf.sprintf "  set r%d r%d\n" id_reg expr_reg)
  | Call (f,a) -> (
      match a with
        Const (n) ->
        write_assembly (Printf.sprintf "  call %s #%d\n" f n)
      | Id (id) ->
        let id_reg = (get_symbol id) in
        write_assembly (Printf.sprintf "  call %s r%d\n" f id_reg)
    )
  | Branch (cond,if_seq,else_seq) -> (
      let label = get_freelabel() in
      let cond_reg = (compile_condition cond) in
      write_assembly (Printf.sprintf "  goto else%d r%d\n" label cond_reg);
      compile_sequence if_seq;
      write_assembly (Printf.sprintf "  goto end%d #0\n" label);
      write_assembly (Printf.sprintf "label else%d\n" label);
      compile_sequence else_seq;
      write_assembly (Printf.sprintf "label end%d\n" label);
    )
  | While (cond,seq) -> (
      let label = get_freelabel() in
      write_assembly (Printf.sprintf "label cond%d\n" label);
      let cond_reg = (compile_condition cond) in
      write_assembly (Printf.sprintf "  goto end%d r%d\n" label cond_reg);
      compile_sequence seq;
      write_assembly (Printf.sprintf "  goto cond%d #0\n" label);
      write_assembly (Printf.sprintf "label end%d\n" label);
    )
  | For (id,start_expr,step_expr,end_expr,seq) -> (
      let label = get_freelabel() in
      let id_reg = (get_symbol id) in
      let start_reg = (compile_expression start_expr) in
      let step_reg = (compile_expression step_expr) in
      let end_reg = (compile_expression end_expr) in
      write_assembly (Printf.sprintf "  set r%d r%d\n" id_reg start_reg);
      write_assembly (Printf.sprintf "label cond%d\n" label);
      let cond_reg = get_freereg() in
      write_assembly (Printf.sprintf "  test_le r%d r%d r%d\n" cond_reg id_reg end_reg);
      write_assembly (Printf.sprintf "  goto end%d r%d\n" label cond_reg);
      compile_sequence seq;
      write_assembly (Printf.sprintf "  add r%d r%d r%d\n" id_reg id_reg step_reg);
      write_assembly (Printf.sprintf "  goto cond%d #0\n" label);
      write_assembly (Printf.sprintf "label end%d\n" label);
    )

and compile_sequence seq = match seq with
    [] -> ()
  | stmt::seq' ->
    let _ = compile_statement stmt in
    let _ = compile_sequence seq' in
    ()

let compile_program prog = match prog with
    Main (seq) -> (
      write_assembly ("label start\n");
      compile_sequence seq;
      write_assembly ("  stop\n");
    )

let _ =
  let lexbuf = Lexing.from_channel stdin in
  let ast = Parser.main Lexer.token lexbuf in
  let str = string_of_program(ast,"; ") in
  let _ = compile_program ast in
  print_string (str^"\n"^(!assembly));
  flush stdout
