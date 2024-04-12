#!/bin/bash
# Process a diff command line, then use diffr to show nice output.

# All arguments are passed to git show.

diffr \
  --colors refine-added:background:0,64,0:foreground:0,255,0:bold \
  --colors refine-removed:background:64,0,0:foreground:255,0,0:bold \
  --colors added:background:0,0,0:foreground:0,128,0:bold \
  --colors removed:background:0,0,0:foreground:128,0,0:bold
