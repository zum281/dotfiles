local dap = require("dap")
local dapui = require("dapui")

dapui.setup({})

require("nvim-dap-virtual-text").setup({
  enabled = true,
  enabled_commands = true,
  highlight_changed_variables = true,
  highlight_new_as_changed = false,
  show_stop_reason = true,
  commented = false,
  only_first_definition = true,
  all_references = false,
  filter_references_pattern = "<module",
  virt_text_pos = "eol",
  all_frames = false,
  virt_lines = false,
  virt_text_win_col = nil,
})

dap.listeners.after.event_initialized.dapui_config = function() dapui.open() end
dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

dap.adapters.codelldb = {
  type = "server",
  port = "${port}",
  executable = {
    command = "codelldb",
    args = { "--port", "${port}" },
  },
}

dap.configurations.c = {
  {
    type = "codelldb",
    request = "launch",
    name = "Debug Executable",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
  },
  {
    type = "codelldb",
    request = "launch",
    name = "Debug Executable (with args)",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    args = function()
      local input = vim.fn.input("Arguments: ")
      return vim.split(input, " ", { trimempty = true })
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
  },
}

-- Java: nvim-dap wiki pattern. Adapter must be a function because the port
-- comes from jdtls at launch time. `enrich_config` can't be used here
-- (it's a table-adapter-only field), so mainClass/classPaths are hardcoded
-- in dap.configurations.java below.
dap.adapters.java = function(callback)
  local client = vim.lsp.get_clients({ name = "jdtls_ls" })[1]
  if not client then
    vim.notify("jdtls not attached — open a .java file first", vim.log.levels.ERROR)
    return
  end
  client.request("workspace/executeCommand", { command = "vscode.java.startDebugSession" }, function(err, port)
    if err then
      vim.notify("startDebugSession failed: " .. vim.inspect(err), vim.log.levels.ERROR)
      return
    end
    callback({ type = "server", host = "127.0.0.1", port = port })
  end)
end

dap.configurations.java = {
  {
    type = "java",
    request = "launch",
    name = "Debug (Launch) — jlox",
    mainClass = "com.craftinginterpreters.lox.Lox",
    projectName = "jlox",
    cwd = "${workspaceFolder}",
    console = "integratedTerminal",
    classPaths = { vim.fn.expand("~/s/p/lox/jlox/bin") },
  },
}

vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointCondition", { text = "◆", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointRejected", { text = "○", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapLogPoint", { text = "◆", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "▶", texthl = "", linehl = "", numhl = "" })

local set = vim.keymap.set
set("n", "<leader>zb", function() dap.toggle_breakpoint() end, { desc = "breakpoint" })
set("n", "<leader>zc", function() dap.continue() end, { desc = "continue" })
set("n", "<leader>zi", function() dap.step_into() end, { desc = "step into" })
set("n", "<leader>zo", function() dap.step_out() end, { desc = "step out" })
set("n", "<leader>zO", function() dap.step_over() end, { desc = "step over" })
set("n", "<leader>zr", function() dap.repl.toggle() end, { desc = "repl" })
set("n", "<leader>zx", function() dap.terminate() end, { desc = "terminate" })
set("n", "<leader>zw", function() require("dap.ui.widgets").hover() end, { desc = "inspect variable" })
set("n", "<leader>zu", function() dapui.toggle() end, { desc = "toggle ui" })
