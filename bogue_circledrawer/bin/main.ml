open Bogue
(* open Tsdl *)
(* open Main *)
module W = Widget
module L = Layout


(* let desc49 = "SDL area which adapts to resizing" *)
  let () =
    let a = W.sdl_area ~w:500 ~h:200 () in
    let area = W.get_sdl_area a in 
  
    (* We draw a thick circle *)
    let circle renderer =
      let w,h = Sdl_area.drawing_size area in
      Draw.circle renderer ~color:Draw.(opaque black) ~thick:2 ~x:(2*w/4) ~y:(h/2)
        ~radius:(h/7)
    in
  
    (* We can remove/add the circle by clicking on a check box. *)
    let element = Sdl_area.add_get ~name:"circle" area circle in
    let b,l = W.check_box_with_label "circle" in
    W.set_check_state b true;
    List.iter (W.on_click ~click:(fun _ ->
        if W.get_state b
        then begin
          Sdl_area.enable element;
          if not (Sdl_area.has_element area element)
          then (print_endline "new circle"; Sdl_area.add_element area element)
        end
        else Sdl_area.disable element;
        Sdl_area.update area)) [b;l];
  
    (* Clear button *)
    let cb = W.button "Clear" in
    W.on_click cb ~click:(fun _ ->
        Sdl_area.clear area;
        W.set_check_state b false);
  
    (* Sdl_area.add area draw; *)
    let options = L.flat ~align:Draw.Center
        [(L.flat_of_w [b;l]);
         Space.hfill ();
         L.resident cb] in
    Space.full_width options;

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
    [circle_layout; button_layout; options; L.resident a]

  |> Bogue.of_layout
  |> Bogue.run 
  


