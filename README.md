# aerospace-sketchybar-config
My own configuration for sketchybar and aerospace. The original design is based off off [omerxxx's](https://github.com/omerxx/dotfiles) dotfiles, however I've added a mode indicator as well which can be configured to whatever you'd like.

Along with the indicator, the config also displays the currently active workspace, and any non-empty workspaces you have. Empty workspaces are hidden until you travel to them, but will remain hidden when you leave unless you add a window to them. The bar will also update when you move nodes to other workspaces.


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
`
