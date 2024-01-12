open Bogue
module W = Widget
module L = Layout
module T = Trigger

let counter = ref 0
let pause = ref false

let updateDisplayVal c n = W.set_text c (string_of_int n)

let startCountdown c =
     while !counter > 0 && not !pause do
      decr counter;
      updateDisplayVal c !counter;
      W.update c;
      Unix.sleep 1;
    done

let () =
  let timer_label = W.label ~size:20 "Timer" in
  let label_timer = L.flat_of_w [timer_label] in
  let label_layout = L.tower ~margins:0 [label_timer] 
in
  let count = W.label ~size:30 "   0   " in
  let count_field = L.flat_of_w [count;] in
  let count_layout = L.tower ~margins:0 [count_field;] 
in
let inc_button = W.button ~border_radius:100
~label:(Label.icon "plus-circle")
~action: (fun _ ->
  incr counter;
  updateDisplayVal count !counter) "" in
  let dec_button = W.button ~border_radius:100
~label:(Label.icon "minus-circle")
~action: (fun _ ->
  decr counter;
  updateDisplayVal count !counter) "" in
  let timer_buttons = L.flat_of_w [dec_button; inc_button;] in
  let timer_layout = L.tower [timer_buttons;] 
in
  let start_button = W.button "Start" in
let connect =
  W.connect ~priority:Forget start_button count
    (fun _source target _ -> pause := false; if !counter > 0 then startCountdown target)
    Trigger.buttons_down in
  let pause_button = W.button
    ~action:(fun _ -> pause := true; updateDisplayVal count !counter) "Pause" in
  let reset_button = W.button
    ~action:(fun _ -> pause := true; counter := 0; updateDisplayVal count !counter) "Reset" in
  let action_buttons = L.flat_of_w [start_button; pause_button; reset_button;] in
  let action_layout = L.tower ~margins:0 [action_buttons;] 
in

  Layout.tower ~name:"Countdown Timer" ~align:Draw.Center
    [label_layout; count_layout; timer_layout; action_layout]
  |> Bogue.of_layout ~connections:[connect]
  |> Bogue.run
  

  (* let () =
  let clock w1 _ ev =
    let rec loop () =
      let tm = Unix.localtime (Unix.time ()) in
      let s = Unix.(sprintf "%02u:%02u:%02u" tm.tm_hour tm.tm_min tm.tm_sec) in
      Label.set (W.get_label w1) s;
      W.update w1;
      let drift = Unix.gettimeofday () -. (Unix.time ()) in
      (* printf "Drift = %f\n" drift; *) (* we try to keep the drift near 0.5 *)
      if drift < 0.45 then Thread.delay (0.51 -. drift)
      else if drift > 0.55 then Thread.delay (1.49 -. drift) (* we are too late *)
      else T.nice_delay ev 0.999;
      if T.should_exit ev
      then (print_endline "Stopping Clock"; T.will_exit ev)
      else loop () in
    print_endline "Starting new clock";
    loop () in
  let l = W.label "Click to start clock" in
  (* let l' = W.label ~size:40 "Autostarts" in *)
  let c = W.connect l l clock T.buttons_down in
  (* let c' = W.connect l' l' clock [T.startup] in *)
  let lay =  L.flat_of_w [l;] in
  let board = of_layout ~connections:[c;] lay in
  run board *)
  

(* let () = 


let clock w1 _ ev =
  let rec loop () =
    let tm = Unix.localtime (Unix.time ()) in
    let s = Unix.(sprintf "%02u:%02u:%02u" tm.tm_hour tm.tm_min tm.tm_sec) in
    Label.set (W.get_label w1) s;
    W.update w1;
    let drift = Unix.gettimeofday () -. (Unix.time ()) in
    (* printf "Drift = %f\n" drift; *) (* we try to keep the drift near 0.5 *)
    if drift < 0.45 then Thread.delay (0.51 -. drift)
    else if drift > 0.55 then Thread.delay (1.49 -. drift) (* we are too late *)
    else T.nice_delay ev 0.999;
    if T.should_exit ev
    then (print_endline "Stopping Clock"; T.will_exit ev)
    else loop () in
  print_endline "Starting new clock";
  loop () in

let button = W.button "Start Clock" in
let c_button = W.connect button button clock T.buttons_down in

let time_label = W.label "Time will be displayed here" in

let c_time = W.connect time_label time_label clock [T.startup] in

(* let c_time = W.connect time_label time_label (clock time_label) [T.startup] in *)

let lay = L.flat_of_w [button; time_label] in
let board = of_layout ~connections:[c_button; c_time] lay in
run board *)
