open Bogue

let create_timer () =
  let time = ref 0 in
  let label = Label.create (string_of_int !time) in
  let timer = Widget.label ~size:30 label in
  let _ =
    Thread.create
      (fun () ->
        while true do
          Thread.delay 1.0 ;
          incr time ;
          Label.set_text label (string_of_int !time) ;
          timer#draw
        done )
      ()
  in
  timer

let () =
  let timer = create_timer () in
  timer |> Layout.resident |> Bogue.of_layout |> Bogue.run

(* open Bogue

   let create_timer () = let time = ref 0 in let timer = Widget.label
   ~size:30 (string_of_int !time) in let _ = Thread.create (fun () -> while
   true do Thread.delay 1.0; incr time; timer#set_text (string_of_int !time);
   timer#draw done ) () in timer

   let () = let timer = create_timer () in timer |> Layout.resident |>
   Bogue.of_layout |> Bogue.run *)

(*let () = Widget.label "Timer" |> Layout.resident |> Bogue.of_layout |>
  Bogue.run *)
