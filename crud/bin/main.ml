open Bogue
module W = Widget
module L = Layout

let names = ref []

let () =
  let input = W.text_input ~prompt:"Enter name" () in
  let create_button = W.button "Create" in
  let box = W.label ~size:15 "Names: " in
  let _ = W.on_click ~click: (fun _ ->
    let name = W.get_text input in
    names := name :: !names;
    W.set_text box (String.concat ", " !names);
  ) create_button in
  Layout.tower_of_w ~name:"CRUD" ~w:400 ~align:Draw.Center
  [box; input; create_button;]
  |> Bogue.of_layout
  |> Bogue.run
