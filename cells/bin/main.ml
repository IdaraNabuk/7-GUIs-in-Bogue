open Bogue
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
  
  let cells, _ = Table.create ~h:400 (Array.to_list columns) in

  let board = Bogue.of_layout cells in
  Bogue.run board
