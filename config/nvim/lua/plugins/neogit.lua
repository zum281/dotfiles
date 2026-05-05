-- Neogit quick reference  (open with <leader>G)
-- All actions are popup-driven: press a letter to open a popup, then a sub-letter to act.
--
-- STAGE / ADD
--   s          stage file or hunk under cursor
--   a          stage all (remapped here from StageAll)
--   <space>    expand/collapse section to reveal hunks, then s to stage individual hunks
--
-- COMMIT
--   c c        commit staged changes (opens editor for message)
--   c a        amend last commit
--
-- PUSH / PULL
--   P p        push to upstream
--   p p        pull from upstream
--   p r        pull with rebase
--
-- MERGE  (e.g. merge main into your feature branch while on the feature branch)
--   m m        open merge popup → type/select branch to merge in
--
-- BRANCHES
--   b b        checkout / switch branch
--   b c        create new branch (and switch)
--   b d        delete branch
--
-- STASH
--   Z z        stash changes
--   Z p        pop stash (apply + drop)
--   Z a        apply stash (keep it in the list)
--   Z d        drop stash
--
-- LOG
--   l l        open log/graph view (graph_style: "ascii" | "unicode" | "kitty")
--   d          open diffview for file under cursor (status) or commit under cursor (log view)
--   x          discard file or hunk under cursor

require("neogit").setup({
  kind                   = "split_above",
  graph_style            = "unicode",
  disable_insert_on_commit = "auto",
  integrations = { diffview = true },
  signs = {
    hunk    = { "", "" },
    item    = { "", "" },
    section = { "", "" },
  },
  mappings = {
    status = {
      ["<space>"] = "Toggle",
      ["x"]       = "Discard",
      ["R"]       = "RefreshBuffer",
      ["a"]       = "StageAll",
    },
  },
})
