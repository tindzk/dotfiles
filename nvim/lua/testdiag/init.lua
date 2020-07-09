local SignsNamespace = 'TestSigns'
local SignPassed = 'TestPassed'
local SignFailed = 'TestFailed'
local SignInfo = 'TestInfo'

vim.fn.sign_define(SignFailed, {text='✗', texthl='LspDiagnosticsError', linehl='', numhl=''})
vim.fn.sign_define(SignPassed, {text='✓', texthl='LspDiagnosticsInformation', linehl='', numhl=''})
vim.fn.sign_define(SignInfo,   {text='‼', texthl='LspDiagnosticsInformation', linehl='', numhl=''})

local floating_winnr = -1

local function closeFloatingBuffer()
	if floating_winnr ~= -1 then
		vim.api.nvim_win_close(floating_winnr, true)
		floating_winnr = -1
	end
end

-- From https://github.com/haorenW1025/diagnostic-nvim/blob/50871844c8f93008c3f2a6dbb281dec48c8ee7f8/lua/diagnostic/util.lua#L71
local function openFloatingBuffer(contents, markdown, opts)
  opts = opts or {}

  -- Trim empty lines from the end.
  contents = vim.lsp.util.trim_empty_lines(contents)

  local width = opts.width
  local height = opts.height or #contents
  if not width then
    width = 0
    for i, line in ipairs(contents) do
      -- Clean up the input and add left pad.
      line = " "..line:gsub("\r", "")
      -- TODO(ashkan) use nvim_strdisplaywidth if/when that is introduced.
      local line_width = vim.fn.strdisplaywidth(line)
      width = math.max(line_width, width)
      contents[i] = line
    end
    -- Add right padding of 1 each.
    width = width + 1
  end

  local floating_bufnr = vim.api.nvim_create_buf(false, true)
  if markdown then
	  vim.api.nvim_buf_set_option(floating_bufnr, 'filetype', 'markdown')
  end
  local float_option = vim.lsp.util.make_floating_popup_options(width, height, opts)
  floating_winnr = vim.api.nvim_open_win(floating_bufnr, false, float_option)
  if markdown then
	  vim.api.nvim_win_set_option(floating_winnr, 'conceallevel', 2)
  end
  vim.api.nvim_buf_set_lines(floating_bufnr, 0, -1, true, contents)
  vim.api.nvim_buf_set_option(floating_bufnr, 'modifiable', false)
  -- Disable InsertCharPre
  --vim.api.nvim_command("autocmd CursorMoved,BufHidden <buffer> ++once lua pcall(vim.api.nvim_win_close, "..floating_winnr..", true)")
  return floating_bufnr, floating_winnr
end

local function clearSigns(bufferId)
	vim.fn.sign_unplace(SignsNamespace)
end

-- Using 0 clashes with vim-gitgutter
signId = 42

local function addSigns(bufferId, diagnostics)
	for i, diag in pairs(diagnostics) do
		if diag['expression'] ~= nil then
			vim.fn.sign_place(signId, SignsNamespace, SignInfo, bufferId, {lnum=diag.line})
		elseif diag.passed then
			vim.fn.sign_place(signId, SignsNamespace, SignPassed, bufferId, {lnum=diag.line})
		else
			vim.fn.sign_place(signId, SignsNamespace, SignFailed, bufferId, {lnum=diag.line})
		end
	end
end

local diagnostics = {}
local hasChecks = false

local function showResult()
	closeFloatingBuffer()

	local lineNumber = vim.api.nvim_win_get_cursor(0)[1]

	for i, diag in pairs(diagnostics) do
		if diag.line == lineNumber then
			if diag['expression'] ~= nil then
				local lines = {}
				if not string.match(diag.value, "\n") then
					table.insert(lines, '**' .. diag.expression .. ':** ' .. diag.value)
				else
					local receivedLines = string.gmatch(diag.leftValue, "[^\n]+")
					table.insert(lines, '**' .. diag.expression .. ':** ')
					for s in string.gmatch(diag.value, "[^\n]+") do
						table.insert(lines, s)
					end
				end
				openFloatingBuffer(lines, true, {})
				break
			elseif not diag.passed then
				local lines = {}
				if not string.match(diag.leftValue, "\n") then
					table.insert(lines, '**' .. diag.leftExpression .. ':** ' .. diag.leftValue)
					table.insert(lines, '**' .. diag.rightExpression .. ':** ' .. diag.rightValue)
				else
					local receivedLines = string.gmatch(diag.leftValue, "[^\n]+")
					table.insert(lines, '**' .. diag.leftExpression .. ':** ')
					for s in string.gmatch(diag.leftValue, "[^\n]+") do
						table.insert(lines, s)
					end
					table.insert(lines, '')
					table.insert(lines, '**' .. diag.rightExpression .. ':** ')
					for s in string.gmatch(diag.rightValue, "[^\n]+") do
						table.insert(lines, s)
					end
				end
				openFloatingBuffer(lines, true, {})
				break
			end
		end
	end
end

local errors = ""
local buildPassed = true

local function has_value (tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end

local function buildStatus()
	if buildPassed and hasChecks then
		failed = 0;
		for i, diag in pairs(diagnostics) do
			if diag['expression'] == nil and not diag.passed then
				failed = failed + 1
			end
		end

		if failed == 0 then
			return 'all checks passed'
		else
			return failed .. ' check(s) failed'
		end
	elseif buildPassed then
			return 'build passed'
	else
		local lines = string.gmatch(errors, "[^\n]+")
		local files = {}
		for line in lines do
			local path = string.match(line, "(.*).c:")
			if path ~= nil then
				file = string.match(path, "^.+/(.+)$")
				if not has_value(files, file) then
					table.insert(files, file)
				end
			end
		end

		return 'build failed in ' .. #files .. ' file(s): ' .. table.concat(files, ', ')
	end
end

local function runTests()
	if 0 then

	closeFloatingBuffer()
	diagnostics = {}
	clearSigns(bufferId)

	local bufferId = vim.api.nvim_get_current_buf()
	local path = vim.api.nvim_buf_get_name(bufferId)

	local test = string.match(path, "test/(.*).c")
	if test ~= nil then
		projectPath = string.match(path, "(.*)/test")
		buildPath   = projectPath .. "/build/test/"
		command =
			"cd " .. buildPath .. " && " ..
			"(make && " ..  " ./test --lua " .. test .. ") 2> /dev/shm/make-errors"

		local f = io.popen(command, 'r')
		local s = f:read('*a')
		f:close()

		local luaCode = string.match(s, "return {(.*)")

		buildPassed = luaCode ~= nil
		if not buildPassed then
			local f = io.open("/dev/shm/make-errors", "rb")
			local s = f:read("*all")
			f:close()
			errors = s
		else
			errors = ""
			if string.match(s, "not found") ~= nil then
				hasChecks = false
			else
				hasChecks = true
				--print(vim.fn.json_decode('{"a":"test"}'))
				--diagnostics = loadstring("return {" .. luaCode)()
				--addSigns(bufferId, diagnostics)
				--showResult()
			end
		end
	end
end
end

return {
	runTests = runTests,
	showResult = showResult,
	buildStatus = buildStatus
}
