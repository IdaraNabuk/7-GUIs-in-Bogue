open Bogue
module W = Widget
module L = Layout

let names = ref []

let () =
let style = Style.(of_bg (color_bg Draw.(opaque (find_color "white")))
|> with_border
  (mk_border
      (mk_line ~width:3 ~color:Draw.(opaque grey) ()))) 
in
  let prefix_label = W.label "Filter Prefix:" in
  let p_label_layout = L.resident prefix_label 
in
  let prefix_input = W.text_input ~prompt: " " () in
  let p_input_layout = L.resident ~w:80 prefix_input ~background:(Layout.style_bg style)
in
  let prefix_layout = L.flat [p_label_layout; p_input_layout]
in
  let box = W.label ~size:15 "List: " in
  let b_label_layout = L.flat_of_w [box]
in
  let box_display = L.resident ~w:180 ~h:180 box ~background:(Layout.style_bg style)
in
  let box_layout = L.flat [b_label_layout; box_display]
in
  let name_label = W.label "Name: " in
  let n_label_layout = L.resident name_label
in
  let name_input = W.text_input ~prompt:"Enter name" () in
  let n_input_layout = L.resident ~w:150 name_input ~background:(Layout.style_bg style)
in
  let name_layout = L.flat [n_label_layout; n_input_layout;] 
in
  let surname_label = W.label "Surname: " in
  let s_label_layout = L.resident surname_label
in
  let surname_input = W.text_input ~prompt:"Enter Surname" () in
  let s_input_layout = L.resident ~w:150 surname_input ~background:(Layout.style_bg style)
in
  let surname_layout = L.flat [s_label_layout; s_input_layout;] in
  let names_layout = L.tower [ name_layout; surname_layout] 
in
  let naming = L.flat ~margins:0 [box_layout; names_layout] 
in
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