$ns_ at 24.91 "$node_(45) color orange"
$ns_ at 24.91 "$node_(5) color orange"
set inf0 [attach-CBR-traffic $node_(5) $sink(7) 512 0.08]
$ns_ at 24.91 "$inf0 start"
$ns_ at 25.91 "$inf0 stop"
$ns_ at 24.935 "$ns_ trace-annotate \"Node - 5 sends Data packet to Node - 7 \""
$ns_ at 24.91 "$node_(7) color orange"
$ns_ at 24.91 "$node_(5) color orange"
$ns_ at 25.91 "$node_(7) color black"
$ns_ at 25.91 "$node_(5) color black"
set inf1 [attach-CBR-traffic $node_(7) $sink(8) 512 0.08]
$ns_ at 24.92 "$inf1 start"
$ns_ at 25.92 "$inf1 stop"
$ns_ at 24.945 "$ns_ trace-annotate \"Node - 7 sends Data packet to Node - 8 \""
$ns_ at 24.92 "$node_(8) color orange"
$ns_ at 24.92 "$node_(7) color orange"
$ns_ at 25.92 "$node_(8) color black"
$ns_ at 25.92 "$node_(7) color black"
set inf2 [attach-CBR-traffic $node_(8) $sink(12) 512 0.08]
$ns_ at 24.93 "$inf2 start"
$ns_ at 25.93 "$inf2 stop"
$ns_ at 24.955 "$ns_ trace-annotate \"Node - 8 sends Data packet to Node - 12 \""
$ns_ at 24.93 "$node_(12) color orange"
$ns_ at 24.93 "$node_(8) color orange"
$ns_ at 25.93 "$node_(12) color black"
$ns_ at 25.93 "$node_(8) color black"
set inf3 [attach-CBR-traffic $node_(12) $sink(10) 512 0.08]
$ns_ at 24.94 "$inf3 start"
$ns_ at 25.94 "$inf3 stop"
$ns_ at 24.965 "$ns_ trace-annotate \"Node - 12 sends Data packet to Node - 10 \""
$ns_ at 24.94 "$node_(10) color orange"
$ns_ at 24.94 "$node_(12) color orange"
$ns_ at 25.94 "$node_(10) color black"
$ns_ at 25.94 "$node_(12) color black"
set inf4 [attach-CBR-traffic $node_(10) $sink(27) 512 0.08]
$ns_ at 24.95 "$inf4 start"
$ns_ at 25.95 "$inf4 stop"
$ns_ at 24.975 "$ns_ trace-annotate \"Node - 10 sends Data packet to Node - 27 \""
$ns_ at 24.95 "$node_(27) color orange"
$ns_ at 24.95 "$node_(10) color orange"
$ns_ at 25.95 "$node_(27) color black"
$ns_ at 25.95 "$node_(10) color black"
set inf5 [attach-CBR-traffic $node_(27) $sink(28) 512 0.08]
$ns_ at 24.96 "$inf5 start"
$ns_ at 25.96 "$inf5 stop"
$ns_ at 24.985 "$ns_ trace-annotate \"Node - 27 sends Data packet to Node - 28 \""
$ns_ at 24.96 "$node_(28) color orange"
$ns_ at 24.96 "$node_(27) color orange"
$ns_ at 25.96 "$node_(28) color black"
$ns_ at 25.96 "$node_(27) color black"
set inf6 [attach-CBR-traffic $node_(28) $sink(29) 512 0.08]
$ns_ at 24.97 "$inf6 start"
$ns_ at 25.97 "$inf6 stop"
$ns_ at 24.995 "$ns_ trace-annotate \"Node - 28 sends Data packet to Node - 29 \""
$ns_ at 24.97 "$node_(29) color orange"
$ns_ at 24.97 "$node_(28) color orange"
$ns_ at 25.97 "$node_(29) color black"
$ns_ at 25.97 "$node_(28) color black"
set inf7 [attach-CBR-traffic $node_(29) $sink(41) 512 0.08]
$ns_ at 24.98 "$inf7 start"
$ns_ at 25.98 "$inf7 stop"
$ns_ at 25.005 "$ns_ trace-annotate \"Node - 29 sends Data packet to Node - 41 \""
$ns_ at 24.98 "$node_(41) color orange"
$ns_ at 24.98 "$node_(29) color orange"
$ns_ at 25.98 "$node_(41) color black"
$ns_ at 25.98 "$node_(29) color black"
set inf8 [attach-CBR-traffic $node_(41) $sink(45) 512 0.08]
$ns_ at 24.99 "$inf8 start"
$ns_ at 25.99 "$inf8 stop"
$ns_ at 25.015 "$ns_ trace-annotate \"Node - 41 sends Data packet to Node - 45 \""
$ns_ at 24.99 "$node_(45) color orange"
$ns_ at 24.99 "$node_(41) color orange"
$ns_ at 25.99 "$node_(45) color black"
$ns_ at 25.99 "$node_(41) color black"