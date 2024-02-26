open Bogue
module W = Widget
module L = Layout

let celsius_to_fahrenheit c =
  c *. 1.8 +. 32.0

let fahrenheit_to_celsius f =
  (f -. 32.0) /. 1.8

let main () =
  let style = Style.(of_bg (color_bg Draw.(opaque (find_color "beige")))
                     |> with_border
                       (mk_border
                          (mk_line ~width:3 ~color:Draw.(opaque grey) ()))) in

  let celsiusInput = W.text_input ~max_size:100 ~prompt:"Enter Celsius" () in
  let cLayout = Layout.resident ~w:150 ~background:(Layout.style_bg style) celsiusInput in

  let celsiusLabel = W.label ~size:15 "Celsius = " in
  let cTLayout = Layout.resident celsiusLabel in

  let fahrenheitInput = W.text_input ~max_size:100 ~prompt:"Enter Fahrenheit" () in
  let fLayout = Layout.resident ~w:150 ~background:(Layout.style_bg style) fahrenheitInput in

  let fahrenheitLabel = W.label ~size:15 "Fahrenheit" in
  let fTLayout = Layout.resident fahrenheitLabel in

  let layout = L.flat [cLayout; cTLayout; fLayout; fTLayout] in

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
