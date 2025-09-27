# aerospace-sketchybar-config
My own configuration for sketchybar and aerospace. The original design is based off off [omerxxx's](https://github.com/omerxx/dotfiles) dotfiles, however I've added a mode indicator as well which can be configured to whatever you'd like.

Along with the indicator, the config also displays the currently active workspace, and any non-empty workspaces you have. Empty workspaces are hidden until you focus them, but will remain hidden when you leave unless you add a window to them. The bar will also update when you move nodes to other workspaces, and if you add the yabai configuration (which you must), will update whenever windows open or close.

For multi-monitor users, this config will display whatever workspaces are available to a given monitor (with monitor ID mappings defined in the `aerospace_workspace_rebuilder.sh` file, as aerospace and sketchybar have seperate mappings).

Unfortunately, configuring this any more than changing the colors file requires you to get your hands dirty and just edit the logic itself.


# Aerospace

To have sketchybar receive the mode change commands, add this to each of your mode triggers (ie both the entry and corresponding exit keybindings).
You can set the mode names to whatever you'd like, however you need to update the `aerospace_mode.sh` file to reflect the new name being sent.
Example:

```
alt-p = ['mode pane', 'exec-and-forget sketchybar --trigger aerospace_mode MODE=P']
```

Additionally, for a more responsive experience, add an exec callback on your 'move node to workspace x' commands.
Example:

```
alt-shift-1 = ['move-node-to-workspace 1', 'exec-and-forget sketchybar --trigger aerospace_workspace_change FOCUSED_WORKSPACE=$AEROSPACE_FOCUSED_WORKSPACE PREV_WORKSPACE=$AEROSPACE_PREV_WORKSPACE']
```

And finally, just to have regular workspace switching function, add this to the top of your `aerospace.toml` file.

```
exec-on-workspace-change = ['/bin/bash', '-c',
    'sketchybar --trigger aerospace_workspace_change FOCUSED_WORKSPACE=$AEROSPACE_FOCUSED_WORKSPACE'
]
```

# Yabai
To trigger updates when a window is opened or closed, you can install yabai and configure it with the following (so it doesn't clash with Aerospace)
(And I know, the name of the repo lies but this was a last minute addition).

```
#!/usr/bin/env sh

yabai -m config layout float

yabai -m config mouse_follows_focus off
yabai -m config focus_follows_mouse off
yabai -m config auto_balance off

yabai -m rule --add app=".*" manage=off


yabai -m signal --add event=window_created   action='sketchybar --trigger aerospace_workspace_change'
yabai -m signal --add event=window_destroyed action='sketchybar --trigger aerospace_workspace_change'
```
