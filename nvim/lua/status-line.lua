-- Taken from https://raw.githubusercontent.com/haorenW1025/dotfiles/master/nvim/lua/status-line.lua

local api = vim.api
local icons = require 'devicon'
local M = {}

-- Different colors for mode
local purple = '#B48EAD'
local light_blue = '#81a1c1'
local blue = '#81A1C1'
local dark_blue = '#4a7096'
local yellow = '#EBCB8B'
local green = '#A3BE8C'
local red = '#BF616A'

-- fg and bg
local white_fg = '#e6e6e6'
local black_fg = '#282c34'
local bg = '#4d4d4d'

-- Separators
local left_separator = ''
local right_separator = ''

-- Blank Between Components
local blank = ' '

------------------------------------------------------------------------
--                             StatusLine                             --
------------------------------------------------------------------------

-- Mode Prompt Table
local current_mode = setmetatable({
      ['n'] = 'NORMAL',
      ['no'] = 'N·Operator Pending',
      ['v'] = 'VISUAL',
      ['V'] = 'V·Line',
      ['^V'] = 'V·Block',
      ['s'] = 'Select',
      ['S'] = 'S·Line',
      ['^S'] = 'S·Block',
      ['i'] = 'INSERT',
      ['ic'] = 'INSERT',
      ['ix'] = 'INSERT',
      ['R'] = 'Replace',
      ['Rv'] = 'V·Replace',
      ['c'] = 'COMMAND',
      ['cv'] = 'Vim Ex',
      ['ce'] = 'Ex',
      ['r'] = 'Prompt',
      ['rm'] = 'More',
      ['r?'] = 'Confirm',
      ['!'] = 'Shell',
      ['t'] = 'TERMINAL'
    }, {
      -- fix weird issues
      __index = function(_, _)
        return 'V·Block'
      end
    }
)

-- Filename Color
local file_bg = purple
local file_fg = black_fg
local file_gui = 'bold'
api.nvim_command('hi File guibg='..file_bg..' guifg='..file_fg..' gui='..file_gui)
api.nvim_command('hi FileSeparator guifg='..file_bg)

-- Working directory Color
local dir_bg = bg
local dir_fg = white_fg
local dir_gui = 'bold'
api.nvim_command('hi Directory guibg='..dir_bg..' guifg='..dir_fg..' gui='..dir_gui)
api.nvim_command('hi DirSeparator guifg='..dir_bg)

-- FileType Color
local filetype_bg = 'None'
local filetype_fg = dark_blue
local filetype_gui = 'bold'
api.nvim_command('hi Filetype guibg='..filetype_bg..' guifg='..filetype_fg..' gui='..filetype_gui)

-- row and column Color
local line_bg = light_blue
local line_fg = white_fg
local line_gui = 'bold'
api.nvim_command('hi Line guibg='..line_bg..' guifg='..line_fg..' gui='..line_gui)
api.nvim_command('hi LineSeparator guifg='..line_bg)

-- Redraw different colors for different mode
local RedrawColors = function(mode)
  if mode == 'n' then
    api.nvim_command('hi Mode guibg='..green..' guifg='..black_fg..' gui=bold')
    api.nvim_command('hi ModeSeparator guifg='..green)
  end
  if mode == 'i' then
    api.nvim_command('hi Mode guibg='..blue..' guifg='..black_fg..' gui=bold')
    api.nvim_command('hi ModeSeparator guifg='..blue)
  end
  if mode == 'v' or mode == 'V' or mode == '^V' then
    api.nvim_command('hi Mode guibg='..purple..' guifg='..black_fg..' gui=bold')
    api.nvim_command('hi ModeSeparator guifg='..purple)
  end
  if mode == 'c' then
    api.nvim_command('hi Mode guibg='..yellow..' guifg='..black_fg..' gui=bold')
    api.nvim_command('hi ModeSeparator guifg='..yellow)
  end
  if mode == 't' then
    api.nvim_command('hi Mode guibg='..red..' guifg='..black_fg..' gui=bold')
    api.nvim_command('hi ModeSeparator guifg='..red)
  end
end

local TrimmedDirectory = function(dir)
  local home = os.getenv("HOME")
  local _, index = string.find(dir, home, 1)
  if index ~= nil and index ~= string.len(dir) then
    -- TODO Trimmed Home Directory
    return string.gsub(dir, home, '~')
  end
  return dir
end

function M.activeLine()
  local statusline = ""

  -- Component: Mode
  local mode = api.nvim_get_mode()['mode']
  RedrawColors(mode)
  statusline = statusline.."%#ModeSeparator#"..left_separator.."%#Mode# "..current_mode[mode].." %#ModeSeparator#"..right_separator
  statusline = statusline..blank

  -- Component: File path
  local path = api.nvim_call_function('expand', {'%'})
  local shortenedPath = api.nvim_call_function('fnamemodify', {path, ":~:."})
  statusline = statusline.."%#DirSeparator#"..left_separator.."%#Directory# "..shortenedPath.." %#DirSeparator#"..right_separator
  statusline = statusline..blank

  local bufferId = vim.api.nvim_get_current_buf()
  local modified = vim.fn.getbufvar(bufferId, '&mod')
  if modified ~= 0 then
	  -- TODO Do not repeat DirSeparator
	  statusline = statusline.."%#DirSeparator#"..left_separator.."%#Directory#+".." %#DirSeparator#"..right_separator
	  statusline = statusline..blank
  end

  -- Alignment to left
  statusline = statusline.."%="

  statusline = statusline.."%#Filetype# " .. api.nvim_call_function('WebDevIconsGetFileTypeSymbol', {})
  statusline = statusline..blank

  -- Component: FileType
  -- Component: row and col
  local line = api.nvim_call_function('line', {"."})
  local column = api.nvim_call_function('col', {"."})
  statusline = statusline.."%#LineSeparator#"..left_separator.."%#Line# " .. line .. ":" .. column.." %#LineSeparator#"..right_separator

  return statusline
end

local InactiveLine_bg = '#DCDCDC'
local InactiveLine_fg = white_fg
api.nvim_command('hi InActive guibg='..InactiveLine_bg..' guifg='..InactiveLine_fg)

function M.inActiveLine()
  local file_name = api.nvim_call_function('expand', {'%F'})
  return "%#InActive# "..file_name
end

------------------------------------------------------------------------
--                              TabLine                               --
------------------------------------------------------------------------

local getTabLabel = function(n)
  local current_win = api.nvim_tabpage_get_win(n)
  local current_buf = api.nvim_win_get_buf(current_win)
  local file_name = api.nvim_buf_get_name(current_buf)
  if string.find(file_name, 'term://') ~= nil then
    return ' '..api.nvim_call_function('fnamemodify', {file_name, ":p:t"})
  end
  file_name = api.nvim_call_function('fnamemodify', {file_name, ":p:t"})
  if file_name == '' then
    return "No Name"
  end
  local icon = icons.deviconTable[file_name]
  if icon ~= nil then
    return icon..' '..file_name
  end
  return file_name
end

api.nvim_command('hi TabLineSel gui=Bold guibg=#BF616A guifg=' .. white_fg)
api.nvim_command('hi TabLineSelSeparator gui=bold guifg=#BF616A')
api.nvim_command('hi TabLine guibg=#4d4d4d guifg=#c7c7c7 gui=None')
api.nvim_command('hi TabLineSeparator guifg=#4d4d4d')
api.nvim_command('hi TabLineFill guibg=None gui=None')


function M.TabLine()
  local tabline = ''
  local tab_list = api.nvim_list_tabpages()
  local current_tab = api.nvim_get_current_tabpage()
  for _, val in ipairs(tab_list) do
    local file_name = getTabLabel(val)
    if val == current_tab then
      tabline = tabline.."%#TabLineSelSeparator# "..left_separator
      tabline = tabline.."%#TabLineSel# "..file_name
      tabline = tabline.." %#TabLineSelSeparator#"..right_separator
    else
      tabline = tabline.."%#TabLineSeparator# "..left_separator
      tabline = tabline.."%#TabLine# "..file_name
      tabline = tabline.." %#TabLineSeparator#"..right_separator
    end
  end
  tabline = tabline.."%="
--  if session.data ~= nil then
--    tabline = tabline.."%#TabLineSeparator# "..left_separator
--    tabline = tabline.."%#TabLine# session: ???"
--    tabline = tabline.." %#TabLineSeparator#"..right_separator
--  end
  return tabline
end
return M
