(* open Bogue
module T = Table
module L = Layout
module W = Widget

let rows = [|
  "1";
  "2";
  "3";
  "4";
  "5";
  "6";
  "7";
  "8";
  "9";
  "10";
  "11";
  "12";
  "13";
  "14";
  "15";
  "16";
  "17";
  "18";
  "19";
  "20";
  "21";
  "22";
  "23";
  "24";
  "25";
  "26";
  "27";
  "28";
  "29";
  "30" |]

let () =
  let create_column title = T.{
    title;
    length = Array.length rows;
    rows = (fun _ -> L.resident (W.text_input ()));
    compare = None;
    width = Some 30} in

  let col0 = T.{
    title = "";
    length = Array.length rows;
    rows = (fun i -> L.resident (W.label rows.(i)));
    compare = None;
    width = Some 30} in

  let columns = Array.init 27 (fun i -> 
    let title = String.make 1 (char_of_int (64 + i)) in
    if i = 0 then col0 else create_column title) in
  
  let cells, _ = Table.create ~name:"Cells" ~h:400 (Array.to_list columns) in

  let board = Bogue.of_layout cells in
  Bogue.run board *)





open Bogue

(* let style = Style.(of_bg (color_bg Draw.(opaque (find_color "beige")))
                     |> with_border
                       (mk_border
                          (mk_line ~width:3 ~color:Draw.(opaque grey) ()))) *)

let () =

    (* Create input fields *)

  let label_a = Widget.label "A" in
  let input1 = Widget.text_input ~size: 10 ~prompt: "     " () in
  let layout_a = Layout.tower_of_w ~align:Draw.Center [label_a; input1];
  in
  let label_b = Widget.label "B" in
  let input2 = Widget.text_input ~size: 10 ~prompt: "     "() in
  let layout_b = Layout.tower_of_w ~align:Draw.Center [label_b; input2];
  in
  let label_c = Widget.label "C" in
  let input3 = Widget.text_input ~size: 10 ~prompt: "     "() in
  let layout_c = Layout.tower_of_w ~align:Draw.Center [label_c; input3];
  in
  let label_d = Widget.label "D" in
  let input4 = Widget.text_input ~prompt: "     "() in
  let layout_d = Layout.tower_of_w ~align:Draw.Center [label_d; input4];
  in
  let label_e = Widget.label "E" in
  let input5 = Widget.text_input ~prompt: "     "() in
  let layout_e = Layout.tower_of_w ~align:Draw.Center [label_e; input5];
  in
  let label_f = Widget.label "F" in
  let input6 = Widget.text_input ~prompt: "     "() in
  let layout_f = Layout.tower_of_w ~align:Draw.Center [label_f; input6];
  in
  let label_g = Widget.label "G" in
  let input7 = Widget.text_input ~prompt: "     "() in
  let layout_g = Layout.tower_of_w ~align:Draw.Center [label_g; input7];
  in
  let label_h = Widget.label "H" in
  let input8 = Widget.text_input ~prompt: "     "() in
  let layout_h = Layout.tower_of_w ~align:Draw.Center [label_h; input8];
  in
  let label_i = Widget.label "I" in
  let input9 = Widget.text_input ~prompt: "     "() in
  let layout_i = Layout.tower_of_w ~align:Draw.Center [label_i; input9];
  in
  let label_j = Widget.label "J" in
  let input10 = Widget.text_input ~prompt: "     "() in
  let layout_j = Layout.tower_of_w ~align:Draw.Center [label_j; input10];
  in
  let label_k = Widget.label "K" in
  let input11 = Widget.text_input ~prompt: "     "() in
  let layout_k = Layout.tower_of_w ~align:Draw.Center [label_k; input11];
  in
  let label_l = Widget.label "L" in
  let input12 = Widget.text_input ~prompt: "     "() in
  let layout_l = Layout.tower_of_w ~align:Draw.Center [label_l; input12];
  in
  let label_m = Widget.label "M" in
  let input13 = Widget.text_input ~prompt: "     "() in
  let layout_m = Layout.tower_of_w ~align:Draw.Center [label_m; input13];
  in
  let label_n = Widget.label "N" in
  let input14 = Widget.text_input ~prompt: "     "() in
  let layout_n = Layout.tower_of_w ~align:Draw.Center [label_n; input14];
  in
  let label_o = Widget.label "O" in
  let input15 = Widget.text_input ~prompt: "     "() in
  let layout_o = Layout.tower_of_w ~align:Draw.Center [label_o; input15];
  in
  let label_p = Widget.label "P" in
  let input16 = Widget.text_input ~prompt: "     "() in
  let layout_p = Layout.tower_of_w ~align:Draw.Center [label_p; input16];
  in
  let label_q = Widget.label "Q" in
  let input17 = Widget.text_input ~prompt: "     "() in
  let layout_q = Layout.tower_of_w ~align:Draw.Center [label_q; input17];
  in
  let label_r = Widget.label "R" in
  let input18 = Widget.text_input ~prompt: "     "() in
  let layout_r = Layout.tower_of_w ~align:Draw.Center [label_r; input18];
  in
  let label_s = Widget.label "S" in
  let input19 = Widget.text_input ~prompt: "     "() in
  let layout_s = Layout.tower_of_w ~align:Draw.Center [label_s; input19];
  in
  let label_t = Widget.label "T" in
  let input20 = Widget.text_input ~prompt: "     "() in
  let layout_t = Layout.tower_of_w ~align:Draw.Center [label_t; input20];
  in
  let label_u = Widget.label "U" in
  let input21 = Widget.text_input ~prompt: "     "() in
  let layout_u = Layout.tower_of_w ~align:Draw.Center [label_u; input21];
  in
  let label_v = Widget.label "V" in
  let input22 = Widget.text_input ~prompt: "     "() in
  let layout_v = Layout.tower_of_w ~align:Draw.Center [label_v; input22];
  in
  let label_w = Widget.label "W" in
  let input23 = Widget.text_input ~prompt: "     "() in
  let layout_w = Layout.tower_of_w ~align:Draw.Center [label_w; input23];
  in
  let label_x = Widget.label "X" in
  let input24 = Widget.text_input ~prompt: "     "() in
  let layout_x = Layout.tower_of_w ~align:Draw.Center [label_x; input24];
  in
  let label_y = Widget.label "Y" in
  let input25 = Widget.text_input ~prompt: "     "() in
  let layout_y = Layout.tower_of_w ~align:Draw.Center [label_y; input25];
  in
  let label_z = Widget.label "Z" in
  let input26 = Widget.text_input ~prompt: "     "() in
  let layout_z = Layout.tower_of_w ~align:Draw.Center [label_z; input26];
  in

  Layout.flat ~name:"Cells"
    [layout_a; layout_b; layout_c; layout_d; layout_e; layout_f; layout_g; layout_h; layout_i; layout_j; layout_k; layout_l; layout_m; layout_n; layout_o; layout_p; layout_q; layout_r; layout_s; layout_t; layout_u; layout_v; layout_w; layout_x; layout_y; layout_z;]
  |> Bogue.of_layout
  |> Bogue.run
