#!/usr/bin/env python3
"""
Update Sway workspace icon based on active window

Dependencies: python-i3ipc>=2.0.1 (i3ipc-python), python-xlib

Requires that you use the Sway message 'workspace number N' instead of 'workspace N'.

Based on wsdnames-i3ipc by Piotr Miller, licenced under GPLv3
"""

from i3ipc import Connection, Event

# Create the Connection object that can be used to send commands and subscribe to events.
i3 = Connection()

appMapping = {
        "nvim-qt": "",
        "neovide": "",
        "kitty": "",
        "firefox": "",
        "org.octave.Octave": "",
        "jetbrains-idea-ce": "",
        "nemo": "",
        "smerge": "",
        "sublime_merge": "",
        "org.pwmt.zathura": "",
        "com.github.johnfactotum.Foliate": ""
}

def change_glyph(i3, change, containerId):
    if not change == 'rename':  # avoid looping
        con = i3.get_tree().find_focused()
        if con is None: return
        if not con.type == 'workspace':  # avoid renaming new empty workspaces on 'binding' event
            if not change == 'new':
                ws_num = con.workspace().num
                app  = con.app_id if con.app_id else con.window_class
                icon = appMapping[app] if app in appMapping else ''
                ws_name = "%s:%s" % (ws_num, icon)
                i3.command('rename workspace number %s to "%s"' % (ws_num, ws_name))
            else:
                # We may open a new window w/o moving focus; give the workspace a name anyway.
                con = i3.get_tree().find_by_id(containerId)
                ws_num = con.workspace().num
                if ws_num:
                    app  = con.app_id if con.app_id else con.window_class
                    icon = appMapping[app] if app in appMapping else ''
                    ws_name = "%s:%s" % (ws_num, icon)
                    i3.command('rename workspace number %s to "%s"' % (ws_num, ws_name))
        else:
            # Give the (empty) workspace a generic name: "number: glyph" (like "1: ")
            ws_num = con.workspace().num
            ws_new_name = "%s:" % ws_num
            i3.command('rename workspace to "{}"'.format(ws_new_name))

def assign_generic_name(i3, e):
    change_glyph(i3, e.change, e.container.id if e.change == 'new' else '')

i3.on(Event.WORKSPACE_FOCUS, assign_generic_name)
i3.on(Event.WINDOW_FOCUS, assign_generic_name)
i3.on(Event.WINDOW_TITLE, assign_generic_name)
i3.on(Event.WINDOW_CLOSE, assign_generic_name)
i3.on(Event.WINDOW_NEW, assign_generic_name)
i3.on(Event.BINDING, assign_generic_name)

i3.main()
