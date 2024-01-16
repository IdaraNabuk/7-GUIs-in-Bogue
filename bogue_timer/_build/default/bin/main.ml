open Bogue
module W = Widget
module L = Layout
module T = Trigger

let counter = ref 0
let pause = ref false

let to_hh_mm_ss time_in_sec =
  let seconds = time_in_sec in
  let hours = seconds / 3600 in
  let minutes = (seconds - (hours * 3600)) / 60 in
  let seconds = seconds - (hours * 3600) - (minutes * 60) in
  let hours_str = if hours < 10 then "0" ^ string_of_int hours else string_of_int hours in
  let minutes_str = if minutes < 10 then "0" ^ string_of_int minutes else string_of_int minutes in
  let seconds_str = if seconds < 10 then "0" ^ string_of_int seconds else string_of_int seconds in
  hours_str ^ ":" ^ minutes_str ^ ":" ^ seconds_str

let updatedisplayval c n = W.set_text c (to_hh_mm_ss n)

let startcountdown c =
     while !counter > 0 && not !pause do
      decr counter;
      updatedisplayval c !counter;
      W.update c;
      Unix.sleep 1;
    done

let () =
  let timer_label = W.label ~size:20 "Timer" in
  let label_timer = L.flat_of_w [timer_label] in
  let label_layout = L.tower ~margins:0 [label_timer] 
in
  let count = W.label ~size:30 "   00:00:00   " in
  let count_field = L.flat_of_w [count;] in
  let count_layout = L.tower ~margins:0 [count_field;] 
in
let inc_button = W.button ~border_radius:100
~label:(Label.icon "plus-circle")
~action: (fun _ ->
  incr counter;
  updatedisplayval count !counter) "" in
  let dec_button = W.button ~border_radius:100
~label:(Label.icon "minus-circle")
~action: (fun _ ->
  decr counter;
  updatedisplayval count !counter) "" in
  let timer_buttons = L.flat_of_w [dec_button; inc_button;] in
  let timer_layout = L.tower [timer_buttons;] 
in
  let start_button = W.button "Start" in
let connect =
  W.connect ~priority:Forget start_button count
    (fun _source target _ -> pause := false; if !counter > 0 then startcountdown target)
    Trigger.buttons_down in
  let pause_button = W.button
    ~action:(fun _ -> pause := true; updatedisplayval count !counter) "Pause" in
  let reset_button = W.button
    ~action:(fun _ -> pause := true; counter := 0; updatedisplayval count !counter) "Reset" in
  let action_buttons = L.flat_of_w [start_button; pause_button; reset_button;] in
  let action_layout = L.tower ~margins:0 [action_buttons;] 
in

  Layout.tower ~name:"Countdown Timer" ~align:Draw.Center
    [label_layout; count_layout; timer_layout; action_layout]
  |> Bogue.of_layout ~connections:[connect]
  |> Bogue.run
  