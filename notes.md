# Table of contents

  1. Modules and functions
    * defining a module
    * calling a module (`:gen_tcp`) and Erlang interaction
    * TCP basics

  2. Data structures
    * atoms (`:ok`, `:gen_tcp`)
    * tuples (`{:ok, socket}`)
    * lists
    * kw lists (`:gen_tcp.connect/3` options)

  3. Recursion
    * `loop` function

  4. Pattern matching
    * maps
    * define a clause for `handle_server_message` even without talking to the server

  5. Message passing
    * `:gen_tcp` message loop

  6. Spawning processes
    * spawning the `gets` process
    * mention monitors with `kill_and_wait`
    * turn `spawn` into `spawn_link` when spawning the `gets` process to mention links

  7. OTP
    * turn handrolled loop into `GenServer`
    * use tasks for better error messages when spawning the `gets` process
