on run argv
  set source_path to item 1 of argv
  set cd_command to "cd(\"" & source_path & "\")."
    
  tell application "Terminal"     
    set tm_w_id to 0
    set w_ids to (id of every window)

    repeat with w_id in w_ids
      set w_name to name of window id w_id
      if w_name contains "Erlang Textmate Shell" then
        set tm_w_id to w_id
      end
    end repeat

    if tm_w_id is equal to 0 then
      do script "echo -n -e \"\\033]0;Erlang Textmate Shell\\007\"; cd " & source_path & "; clear; erl"
      set tm_w_id to id of front window
    end

    activate
    
    if length of argv is 2
      set source_file to item 2 of argv
      set compile_cmd to "c(\"" & source_file & "\")."
      do script compile_cmd in window id tm_w_id
    else
      do script cd_command in window id tm_w_id
    end if
  end tell
end run