open Bogue
module W = Widget
module L = Layout

let celsius_to_fahrenheit c =
  c *. 1.8 +. 32.0

let fahrenheit_to_celsius f =
  (f -. 32.0) /. 1.8

let thick_grey_line = Style.mk_line ~color:Draw.(transp grey)
  ~width:3 ~style:Solid ()
(* let round_blue_box = let open Style in
let border = mk_border thick_grey_line in
  create ~border () *)

  let input_field = let open Style in
  let border = mk_border ~radius:10 thick_grey_line in
  let _ = W.text_input ~prompt:"Enter Celsius" () in
  create ~border ()

let main () =
  let celsiusInput = W.text_input ~max_size:200 ~prompt:"Enter Celsius" () in
  let celsiusLabel = W.label ~size:15 "Celsius = " in
  let fahrenheitInput = W.text_input ~max_size:200 ~prompt:"Enter Fahrenheit" () in
  let fahrenheitLabel = W.label ~size:15 "Fahrenheit" in
  (* let rect = W.box ~w:150 ~h:30 ~style:round_blue_box () in *)
  (* let nameInput = W.text_input ~max_size:200 ~prompt:"Enter Name" () in *)
  (* let rect = W.box ~w:150 ~h:30 ~action:(fun _ ->
    W.text_input ~max_size:200 ()) ~style:round_blue_box () in
  let rect, nameInput = rect_with_text_input text; *)
  (* let customWidget = W.connect rect  in *)

  let box = W.box ~w:150 ~h:30 ~style:input_field () in

  let layout = L.flat_of_w [box; celsiusInput; celsiusLabel; fahrenheitInput; fahrenheitLabel] in

  let c_to_f inputc inputf _ =
    let text = W.get_text inputc in
    if text = "" then
      W.set_text inputf ""
    else
      let celsius = float_of_string text in
      let fahrenheit = celsius_to_fahrenheit celsius in
      W.set_text inputf (string_of_float fahrenheit) in

  let f_to_c inputf inputc _ =
    let text = W.get_text inputf in
    if text = "" then
      W.set_text inputc ""
    else
      let fahrenheit = float_of_string text in
      let celsius = fahrenheit_to_celsius fahrenheit in
      W.set_text inputc (string_of_float celsius) in

  let c = W.connect celsiusInput fahrenheitInput c_to_f Trigger.[text_input; key_up] in
  let f = W.connect fahrenheitInput celsiusInput f_to_c Trigger.[text_input; key_up] in

  let board = Bogue.make [c; f] [layout] in
  Bogue.run board

let _ = main ();
  Draw.quit ()
