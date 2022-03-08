#!/usr/bin/python
import os
from subprocess import Popen, PIPE, STDOUT

layouts = [
	["English", "us-custom", 0],
	["Ukrainian", "ua-custom", 1],
	["German", "de-custom", 2],
	["Turkish", "tr-custom", 3]
]

p = Popen(
	["wofi", "--show", "dmenu", "-i"],
	stdout=PIPE,
	stdin=PIPE,
	stderr=PIPE
)
stdin = "\n".join([l[0] for l in layouts])
selection = p.communicate(input=stdin.encode())[0].decode().strip()

if selection != '':
    for l, _, id in layouts:
        if l == selection:
            os.system(f"swaymsg input '*' xkb_switch_layout {id}")
            break
