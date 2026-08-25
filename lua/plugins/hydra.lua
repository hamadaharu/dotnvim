return {
  "nvimtools/hydra.nvim",
  enabled = false,
  cmd = "HydraLoad",
  config = function ()
    require("configs.hydra")
  end
}
