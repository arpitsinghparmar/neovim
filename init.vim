set number
set numberwidth=2
set autoindent
set tabstop=4
set shiftwidth=4
set smarttab
set smartindent
set softtabstop=4
set mouse=a
set ruler
set hidden
set undofile
set signcolumn=yes
set completeopt=menu,menuone,noselect

call plug#begin()
Plug 'mfussenegger/nvim-jdtls'
Plug 'windwp/nvim-autopairs'
"Theme
Plug 'navarasu/onedark.nvim'

"BottomLine
Plug 'nvim-lualine/lualine.nvim'
"UpperLine
Plug 'akinsho/bufferline.nvim', { 'tag': 'v2.*' }

"
"NvimTree
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'

"Completion
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'onsails/lspkind-nvim'

"TreeSitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
call plug#end()

"NvimTree config
nnoremap <C-n> :NvimTreeToggle<CR>
nnoremap <leader>r :NvimTreeRefresh<CR>
nnoremap <leader>n :NvimTreeFindFile<CR>
set termguicolors
"highlight NvimTreeFolderIcon guibg=blue
"Plugin
:lua require('nvimtree')
:lua require('ncm')
:lua require('treesitter')
:lua require('line')
:lua require('upperline')
:lua require('lsp')


"Set Theme
let g:onedark_config = {
    \ 'style': 'warmer',
\}
colorscheme onedark

lua <<EOF
require('nvim-autopairs').setup{}
EOF

lua <<EOF
  function OrgImports(wait_ms)
    local params = vim.lsp.util.make_range_params()
    params.context = {only = {"source.organizeImports"}}
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
    for _, res in pairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          vim.lsp.util.apply_workspace_edit(r.edit, "UTF-8")
        else
          vim.lsp.buf.execute_command(r.command)
        end
      end
    end
  end
EOF

autocmd BufWritePre *.go lua OrgImports(1000)