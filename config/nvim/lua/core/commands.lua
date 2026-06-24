vim.api.nvim_create_user_command("Format", function()
  require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format current buffer" })

-- :Compile {cmd} runs a command async into quickfix; :Recompile re-runs it.
local last_compile_cmd = nil

local function compile(cmd)
  cmd = (cmd and cmd ~= "") and cmd or last_compile_cmd
  if not cmd or cmd == "" then
    vim.notify("Compile: no command (and none remembered)", vim.log.levels.WARN)
    return
  end
  last_compile_cmd = cmd

  vim.fn.setqflist({}, " ", { title = "Compile: " .. cmd, lines = {} })
  vim.notify("Compile: " .. cmd)

  local function append(_, data)
    if data then
      vim.fn.setqflist({}, "a", { lines = data })
    end
  end

  vim.fn.jobstart(cmd, {
    stdout_buffered = true,
    stderr_buffered = true,
    on_stdout = append,
    on_stderr = append,
    on_exit = function(_, code)
      vim.cmd("cwindow")
      vim.notify(
        ("Compile finished (exit %d): %s"):format(code, cmd),
        code == 0 and vim.log.levels.INFO or vim.log.levels.ERROR
      )
    end,
  })
end

vim.api.nvim_create_user_command("Compile", function(o)
  compile(o.args)
end, { nargs = "*", complete = "shellcmd", desc = "Run a command into quickfix (M-x compile)" })

vim.api.nvim_create_user_command("Recompile", function()
  compile(nil)
end, { desc = "Re-run the last :Compile command (recompile)" })

-- :Grep {pattern} searches with 'grepprg' into quickfix; defaults to <cword>.
vim.api.nvim_create_user_command("Grep", function(o)
  local pattern = o.args ~= "" and o.args or vim.fn.expand("<cword>")
  vim.cmd("silent grep! " .. vim.fn.shellescape(pattern))
  vim.cmd("cwindow")
end, { nargs = "*", desc = "Project grep into quickfix (rgrep)" })
