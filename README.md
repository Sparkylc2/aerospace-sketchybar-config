# aerospace-sketchybar-config
My own configuration for sketchybar and aerospace. The original design is based off off omerxxx's dotfiles, however I've added a mode indicator as well which can be configured to whatever you'd like


# Aerospace
To have sketchybar receive the mode change commands, add this to each of your mode triggers (ie both the entry and corresponding exit keybindings).
You can set the mode names to whatever you'd like, however you need to update the `aerospace_mode.sh` file to reflect the new name being sent.
Example:
```
alt-p = ['mode pane', 'exec-and-forget sketchybar --trigger aerospace_mode MODE=P']
```

To have workspace switching function, add this to the top of your `aerospace.toml` file.
```
exec-on-workspace-change = ['/bin/bash', '-c',
    'sketchybar --trigger aerospace_workspace_change FOCUSED_WORKSPACE=$AEROSPACE_FOCUSED_WORKSPACE'
]
```
