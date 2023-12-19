open Bogue
module W = Widget

let counter = ref 0

let increment () = counter := !counter + 1

let decrement () = counter := !counter - 1

let update c n = W.set_text c (string_of_int n)

let () =
  let label = W.label "Cookies:" in
  let count = W.label "0 " in
  let inc_button =
    W.button
      ~action:(fun _ -> increment () ; update count !counter)
      "Increment"
  in
  let dec_button =
    W.button
      ~action:(fun _ -> decrement () ; update count !counter)
      "Decrement"
  in
  Layout.flat_of_w ~name:"Counter tutorial" ~align:Draw.Center
    [label; count; inc_button; dec_button]
  |> Bogue.of_layout |> Bogue.run
