return {
  'easymotion/vim-easymotion',
  config = function() 
    vim.g.EasyMotion_do_mapping = 0 -- Disable default mappings
    vim.api.nvim_set_keymap('n', 's', '<Plug>(easymotion-overwin-f2)', {})
    vim.g.EasyMotion_smartcase = 1
    vim.api.nvim_set_keymap('n', '<Leader>j', '<Plug>(easymotion-j)', {})
    vim.api.nvim_set_keymap('n', '<Leader>k', '<Plug>(easymotion-k)', {})
    vim.cmd('hi link EasyMotionTarget Statement')
    vim.cmd('hi link EasyMotionShade Comment')	
  end
}
