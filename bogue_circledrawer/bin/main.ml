open Bogue
module W = Widget
module L = Layout
module M = Mouse
module T = Trigger

let () =
    let a = W.sdl_area ~w:500 ~h:300 () in
    let area = W.get_sdl_area a in 

    (* We store the circle positions in a mutable list *)
    let circle_positions = ref [] in
    (* We store the undone circle positions in a mutable list *)
    let undone_positions = ref [] in

    (* We draw a thick circle at each stored position *)
    let circle renderer =
      let _w,h = Sdl_area.drawing_size area in
      List.iter (fun (x, y) ->
        Draw.circle renderer ~color:Draw.(opaque black) ~thick:2 ~x:x ~y:y
          ~radius:(h/20)
      ) !circle_positions
    in

    let connect =
      W.connect a a
        (fun _source _target e -> 
          let x,y = Sdl_area.pointer_pos area e in
          circle_positions := (x, y) :: !circle_positions;  (* We store the click position *)
          undone_positions := [];  (* We clear the undone positions when a new circle is drawn *)

          let element = Sdl_area.add_get ~name:"circle" area circle in
          Sdl_area.enable element;
          if not (Sdl_area.has_element area element)
          then (print_endline "new circle"; Sdl_area.add_element area element);
          Sdl_area.update area) 
        T.buttons_down in

    (* Undo button *)
    let undo_button = W.button ~border_radius:100 "Undo" in
      W.on_click undo_button ~click:(fun _ ->
        match !circle_positions with
        | h :: t -> 
            circle_positions := t;  (* We remove the last circle position *)
            undone_positions := h :: !undone_positions;  (* We store the undone position *)
            Sdl_area.update area
        | [] -> print_endline "No circles to undo.");  (* Print a message when there are no circles to undo *)

    (* Redo button *)
    let redo_button = W.button ~border_radius:100 "Redo" in
      W.on_click redo_button ~click:(fun _ ->
        match !undone_positions with
        | h :: t -> 
            undone_positions := t;  (* We remove the last undone position *)
            circle_positions := h :: !circle_positions;  (* We restore the undone position *)
            Sdl_area.update area
        | [] -> print_endline "No circles to redo.");  (* Print a message when there are no circles to redo *)

    let clear_button = W.button ~border_radius:100 "Clear" in
      W.on_click clear_button ~click:(fun _ -> circle_positions := [];
      Sdl_area.update area);

    let circle_label = W.label ~size:20 "Circle Drawer" in
    let drawer_label = L.flat_of_w [circle_label] in
    let circle_layout = L.tower ~margins:0 [drawer_label] 
  in
    let circle_buttons = L.flat_of_w [undo_button; redo_button; clear_button;] in
    let button_layout = L.tower [circle_buttons;] in

    Layout.tower ~name:"Circle Drawer" ~align:Draw.Center
        [circle_layout; L.resident a; button_layout]

    |> Bogue.of_layout ~connections:[connect]
    |> Bogue.run
