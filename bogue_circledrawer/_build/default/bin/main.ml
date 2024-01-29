open Bogue
module W = Widget
module L = Layout

let () =
  let circle_label = W.label ~size:20 "Circledrawer" in
  let drawer_label = L.flat_of_w [circle_label] in
  let circle_layout = L.tower ~margins:0 [drawer_label] 
in
  let undo_button = W.button ~border_radius:200
~label:(Label.icon "undo") "" 
in
  let redo_button = W.button ~border_radius:600
~label:(Label.icon "redo") "" 
in
  let circle_buttons = L.flat_of_w [undo_button; redo_button;] in
  let button_layout = L.tower [circle_buttons;] 
in
Layout.tower ~name:"Circledrawer" ~align:Draw.Center
    [circle_layout; button_layout;]
  |> Bogue.of_layout
  |> Bogue.run