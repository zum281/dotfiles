-- Default makeprg: compile current file into ./out/, capturing javac errors in qflist.
-- javac's "File.java:LINE: error: ..." format matches vim's default errorformat,
-- so :copen after :make will show clickable errors.
vim.bo.makeprg = "javac -d out -Xlint:all %"

local set = vim.keymap.set
local terminal_buf = nil

local function project_root()
  local markers = { "pom.xml", "build.gradle", "build.gradle.kts", "mvnw", "gradlew" }
  local found = vim.fs.find(markers, { upward = true, path = vim.fn.expand("%:p:h") })[1]
  if not found then
    return nil, nil
  end
  local dir = vim.fs.dirname(found)
  local kind = vim.fs.basename(found):match("pom%.xml") and "maven" or "gradle"
  return dir, kind
end

local function open_terminal(cmd)
  if terminal_buf and vim.api.nvim_buf_is_valid(terminal_buf) then
    for _, win in ipairs(vim.fn.win_findbuf(terminal_buf)) do
      vim.api.nvim_win_close(win, true)
    end
    vim.api.nvim_buf_delete(terminal_buf, { force = true })
  end
  vim.cmd("botright 15split | terminal " .. cmd)
  terminal_buf = vim.api.nvim_get_current_buf()
  set("n", "q", "<cmd>close<cr>", { buffer = terminal_buf })
  set("n", "<Esc>", "<cmd>close<cr>", { buffer = terminal_buf })
end

-- Single-file build: :make → qflist on error
local function build_singlefile()
  vim.cmd("silent! update")
  vim.cmd("silent! make")
  local errors = vim.tbl_filter(function(e)
    return e.valid == 1
  end, vim.fn.getqflist())
  if #errors > 0 then
    vim.cmd("copen")
    return false
  end
  vim.cmd("cclose")
  return true
end

local function build()
  vim.cmd("silent! update")
  local root, kind = project_root()
  if kind == "maven" then
    open_terminal("cd " .. vim.fn.shellescape(root) .. " && mvn compile")
  elseif kind == "gradle" then
    open_terminal("cd " .. vim.fn.shellescape(root) .. " && ./gradlew build -x test")
  else
    build_singlefile()
  end
end

local function run()
  vim.cmd("silent! update")
  local root, kind = project_root()
  if kind == "maven" then
    open_terminal("cd " .. vim.fn.shellescape(root) .. " && mvn -q exec:java")
  elseif kind == "gradle" then
    open_terminal("cd " .. vim.fn.shellescape(root) .. " && ./gradlew run -q --console=plain")
  else
    if not build_singlefile() then
      return
    end
    open_terminal("java -cp out " .. vim.fn.expand("%:t:r"))
  end
end

set("n", "<leader>m", build, { buffer = 0, desc = "make (build)" })
set("n", "<leader>r", run, { buffer = 0, desc = "run" })
