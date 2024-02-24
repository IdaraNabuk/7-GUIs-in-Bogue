open Bogue
module W = Widget
module L = Layout

let names = ref []

let () =
  let prefix_label = W.label "Filter Prefix:" in
  let prefix_input = W.text_input ~prompt: " " () in
  let prefix_layout = L.flat_of_w [prefix_label; prefix_input;] 
in
let box = W.label ~size:15 "Names: " in
  let box_layout = L.flat_of_w [box;] 
in
  let name_label = W.label "Name: " in
  let name_input = W.text_input ~prompt:"Enter name" () in
  let name_layout = L.flat_of_w [name_label; name_input;] in
  let surname_label = W.label "Surname: " in
  let surname_input = W.text_input ~prompt:"Enter Surname" () in
  let surname_layout = L.flat_of_w [surname_label; surname_input;] in
  let names_layout = L.tower [name_layout; surname_layout] 
in
  let naming = L.flat ~margins:0 [box_layout; names_layout] in
  let create_button = W.button "Create" in
  let _ = W.on_click ~click: (fun _ ->
    let name = W.get_text name_input in
    let surname = W.get_text surname_input in
    let full_name = name ^ " " ^ surname in
    names := full_name :: !names;
    W.set_text box (String.concat ", " !names);
    (* W.set_text name_input "";
    W.set_text surname_input ""; *)
  ) create_button 
in
  let update_button = W.button "Update" in
  let _ = W.on_click ~click: (fun _ ->
    let name = W.get_text name_input in
    let surname = W.get_text surname_input in
    let full_name = name ^ " " ^ surname in
    names := List.map (fun n -> if n = full_name then name ^ " " ^ surname else n) !names;
    W.set_text box (String.concat ", " !names);
  ) update_button 
in
  let delete_button = W.button "Delete" in
  let _ = W.on_click ~click: (fun _ ->
    let name = W.get_text name_input in
    let surname = W.get_text surname_input in
    let full_name = name ^ " " ^ surname in
    names := List.filter (fun n -> n <> full_name) !names;
    W.set_text box (String.concat ", " !names);
  ) delete_button 
in
  let button_layout = L.flat_of_w ~align:Draw.Center [create_button; update_button; delete_button;]
in
  Layout.tower ~name:"CRUD"
  [prefix_layout; naming; button_layout]
  |> Bogue.of_layout
  |> Bogue.run
