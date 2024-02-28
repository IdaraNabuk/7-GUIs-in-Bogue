open Bogue
module W = Widget
module L = Layout

(* let names = ref [] *)

let () =
let style = Style.(of_bg (color_bg Draw.(opaque (find_color "white")))
|> with_border
  (mk_border
      (mk_line ~width:3 ~color:Draw.(opaque blue) ()))) 
in
let flight_button = W.button ~border_radius:10 "One-way-flight" in
let f_button_lay = L.resident flight_button in
  let start_date = W.text_input ~prompt: " " () in
  let start_layout = L.resident ~w:100 start_date ~background:(Layout.style_bg style)
in
  let end_date = W.text_input ~prompt: " " () in
  let end_layout = L.resident ~w:100 end_date ~background:(Layout.style_bg style)
in
let book_button = W.button ~border_radius:10 "Book" in
let b_button_lay = L.resident book_button in
  Layout.tower ~name:"Flight Booker" ~align:Draw.Center
  [f_button_lay; start_layout; end_layout; b_button_lay;]
  |> Bogue.of_layout
  |> Bogue.run