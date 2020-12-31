#!/usr/bin/python
#
# From https://www.reddit.com/r/i3wm/comments/8njtwg/anyone_need_to_quickly_switch_to_the_nearest/dzwktps/
#

import sys, json, subprocess

output = subprocess.check_output(['swaymsg', '-t', 'get_workspaces'])
workspaces = json.loads(output)

focused = [ws for ws in workspaces if ws['focused']][0]
focused = int(focused['name'][0])

# See `config` for workspace allocation
lo, hi = (1, 5) if focused >= 1 and focused <= 5 else (6, 10)
next_num = next(i for i in range(lo, hi + 1) if not [ws for ws in workspaces if ws['num'] == i])

if 'move' in sys.argv:
    subprocess.call(['swaymsg', 'move container to workspace number %i' % next_num])
else:
    subprocess.call(['swaymsg', 'workspace number %i' % next_num])
