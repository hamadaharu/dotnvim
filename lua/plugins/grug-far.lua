return  {
    'MagicDuck/grug-far.nvim',
    keys = {
        { "<leader>fr", "<cmd>GrugFar<CR>", mode = "n", desc = "Find And Replace" }
    },
    config = function()
        require('grug-far').setup({});
    end
}
