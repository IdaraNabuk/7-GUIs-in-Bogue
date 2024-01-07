open Bogue
module W = Widget
module L = Layout

let counter = ref 0
let pause = ref false

let updateDisplayVal c n = W.set_text c (string_of_int n)

let startCountdown c _ = 
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
    ~action: (fun _ -> incr counter; updateDisplayVal count !counter) " + " in
  let dec_button = W.button ~border_radius:100
    ~action:(fun _ -> decr counter; updateDisplayVal count !counter) " - " in
  let timer_buttons = L.flat_of_w [dec_button; inc_button;] in
  let timer_layout = L.tower [timer_buttons;] 
in
  let start_button = W.button
    ~action:(fun _ -> pause := false; if !counter > 0 then Thread.create(startCountdown count) () |> ignore) "Start" in
  let pause_button = W.button
    ~action:(fun _ -> pause := true) "Pause" in
  let reset_button = W.button
    ~action:(fun _ -> pause := true; counter := 0; updateDisplayVal count !counter) "Reset" in
  let action_buttons = L.flat_of_w [start_button; pause_button; reset_button;] in
  let action_layout = L.tower ~margins:0 [action_buttons;] 
in

  Layout.tower ~name:"Countdown Timer" ~align:Draw.Center
    [label_layout; count_layout; timer_layout; action_layout]
  |> Bogue.of_layout 
  |> Bogue.run
