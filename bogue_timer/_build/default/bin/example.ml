open Bogue
open Main
module W = Widget
module L = Layout
module T = Trigger
open Printf

(* let desc15 = "Two (independent) clocks in text label; one is starting \
              automatically." *)
let () =
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
  let l' = W.label ~size:40 "Autostarts" in
  let c = W.connect l l clock T.buttons_down in
  let c' = W.connect l' l' clock [T.startup] in
  let lay =  L.flat_of_w [l;l'] in
  let board = of_layout ~connections:[c;c'] lay in
  run board