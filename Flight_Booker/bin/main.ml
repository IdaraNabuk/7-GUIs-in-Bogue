open Bogue
module W = Widget
module L = Layout

let flight = [|
  "One-way flight";
  "Return flight"
 |]

(* let check_date_format date =
  let regex = Str.regexp "^\\([0-9]\\{4\\}-[0-1][0-9]-[0-3][0-9]\\)$" in
  Str.string_match regex date 0 *)

let () =
let style = Style.(of_bg (color_bg Draw.(opaque (find_color "white")))
|> with_border
  (mk_border
      (mk_line ~width:3 ~color:Draw.(opaque grey) ()))) 
in
  let select = Select.create flight 0 in
  let f_button_lay = L.tower [L.flat [select;]] 
in
  let start_date = W.text_input ~prompt: " " () in
  let start_layout = L.resident ~w:150 start_date ~background:(Layout.style_bg style)
in
  let end_date = W.text_input 
  (* ~filter:(fun _ ->  check_date_format) *)
  ~prompt: " " () 
in
  let end_layout = L.resident ~w:150 end_date ~background:(Layout.style_bg style)
in
  let book_button = W.button "Book" in
  let b_button_lay = L.resident book_button 
in
  Layout.tower ~name:"Flight Booker" ~align:Draw.Center
  [f_button_lay; start_layout; end_layout; b_button_lay;]
  |> Bogue.of_layout
  |> Bogue.run
