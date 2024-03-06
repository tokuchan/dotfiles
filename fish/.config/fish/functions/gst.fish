function gst --wraps='g st' --description 'alias gst=g st'
  set -lx file /tmp/git-log-$fish_pid

  function display
    argparse -i 'title=' -- $argv
    or return
    printf "%s\n--------\n```\n" "$_flag_title" >> $file
    for l in (printf "$argv")
      printf "%s\n" $l >> $file
    end
    printf "```\n" >> $file
  end

  function hr
    printf "\n---\n" >> $file
  end

  printf "Status\n========\n" > $file

  display --title="SmartLog" (for l in (g sl 'stack()'); echo "$l\\n"; end)
  hr
  display --title="Changes" (for l in (g changes -n 15); echo "$l\\n"; end)

  if git branch | grep patches
  then
    hr
    display --title="Patches" (for l in (g patches -n 15); echo "$l\\n"; end)
  end

  hr
  display --title="Status" (for l in (g st); echo "$l\\n"; end)

  cat $file | rich -a rounded -m -

  rm -f $file
end
