return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local harpoon = require("harpoon")
        
        -- REQUIRED
        harpoon:setup()
        -- REQUIRED
        
        vim.keymap.set("n", "<leader>ha", function() harpoon:list():append() end, {desc = "Append file"})

        vim.keymap.set("n", "<leader>he", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, {desc = "List files"})

        
        vim.keymap.set("n", "<A-1>", function() harpoon:list():select(1) end)
        vim.keymap.set("n", "<A-2>", function() harpoon:list():select(2) end)
        vim.keymap.set("n", "<A-3>", function() harpoon:list():select(3) end)
        vim.keymap.set("n", "<A-4>", function() harpoon:list():select(4) end)
        
        -- Toggle previous & next buffers stored within Harpoon list
        vim.keymap.set("n", "<leader>h,", function() harpoon:list():prev() end, {desc = "Prev file"})
        vim.keymap.set("n", "<leader>h.", function() harpoon:list():next() end, {desc = "Next file"})

        local conf = require("telescope.config").values
        local function toggle_telescope(harpoon_files)
            local file_paths = {}
            for _, item in ipairs(harpoon_files.items) do
                table.insert(file_paths, item.value)
            end

            require("telescope.pickers").new({}, {
                prompt_title = "Harpoon",
                finder = require("telescope.finders").new_table({
                    results = file_paths,
                }),
                previewer = conf.file_previewer({}),
                sorter = conf.generic_sorter({}),
            }):find()
        end
        vim.keymap.set('n', '<leader>sh', function() toggle_telescope(harpoon:list()) end, { desc = "Open harpoon window" })
    end
}
