return {
  'f-person/git-blame.nvim',
  event = "VeryLazy",
  opts = {
    message_template = "<<sha>> • <date> • <author> • • <summary>",
    date_format = "%Y-%m-%d %H:%M:%S",
  },
  config = function ()
    vim.g.gitblame_display_virtual_text = 0 -- Disable virtual text
    vim.g.gitblame_message_template = "<<sha>> • <date> • <author> • • <summary>"
    local git_blame = require('gitblame')
    require('lualine').setup({
      tabline = {
        lualine_b = {
          { git_blame.get_current_blame_text, cond = git_blame.is_blame_text_available }
        }
      }
    })
  end
}
