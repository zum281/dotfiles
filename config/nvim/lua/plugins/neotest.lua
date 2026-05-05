require("neotest").setup({
  adapters = {
    require("neotest-vitest")({
      filter_dir = function(name)
        return name ~= "node_modules"
      end,
    }),
  },
})
