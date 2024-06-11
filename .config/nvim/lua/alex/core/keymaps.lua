-- need a way to silence diagnostics!!!

local keymap = vim.keymap
local buildable_filetypes = {"python", "lua", "tex"}
local tree_mode = "side-bar"
local globals = require('modules.globals')

keymap.set('n', '<leader>rc', globals.source_config, { desc = "Resource config files" })
keymap.set('n', '<leader>tt', globals.toggle_transparency, { desc = "Toggle transparency" })

keymap.set('n', '<leader>kb', '<cmd>bd<cr>', {desc = "Kill active buffer", silent = true }) 

keymap.set('i', '<C-z>', '<Nop>', { noremap = true, silent = true })
keymap.set('v', '<C-z>', '<Nop>', { noremap = true, silent = true })
keymap.set('s', '<C-z>', '<Nop>', { noremap = true, silent = true })
keymap.set('c', '<C-z>', '<Nop>', { noremap = true, silent = true })

-- Shortcuts for leaving insert mode
keymap.set('i', 'jk', '<ESC>', {silent = true})
keymap.set('i', 'kj', '<ESC>', {silent = true})

keymap.set('n', '<leader>rd', ':Dashboard<cr>', {desc = "Return to dashboard", silent = true})

-- Wrapping
keymap.set('n', '<S-p>', ':lua change_wrap_mode()<cr>', {desc = "Toggle word wrap", silent = true})

-- Neat little shortcuts for incrementing/decrementing numbers
keymap.set('n', '<leader>+', '<C-a>', {desc = 'Increment number', silent = true})
keymap.set('n', '<leader>-', '<C-x>', {desc = 'Decrement number', silent = true})

-- quick-fix window (mostly only useful for tex right now)
keymap.set('n', '<leader>qo', ':copen<cr>', {desc = "Open quick-fix window", silent = true})
keymap.set('n', '<leader>qc', ':cclose<cr>', {desc = "Close quick-fix window", silent = true})

-- tmux pane/nvim pane integrated navigation
keymap.set('n', '<C-h>', '<C-w>h', { silent = true })
keymap.set('n', '<C-h>', ':TmuxNavigateLeft<cr>', { silent = true })
keymap.set('n', '<C-l>', '<C-w>l', { silent = true })
keymap.set('n', '<C-l>', ':TmuxNavigateRight<cr>', { silent = true })
keymap.set('n', '<C-j>', '<C-w>j', { silent = true })
keymap.set('n', '<C-j>', ':TmuxNavigateDown<cr>', { silent = true })
keymap.set('n', '<C-k>', '<C-w>k', { silent = true })
keymap.set('n', '<C-k>', ':TmuxNavigateUp<cr>', { silent = true })

-- Splits
keymap.set('n', '<leader>sv', ':vsp<CR>', {desc = "Split window vertically", silent = true})
keymap.set('n', '<leader>sh', ':sp<CR>', {desc = "Split window horizontally", silent = true})
keymap.set('n', '<leader>se', ':<C-w>=', {desc = "Make splits equal size", silent = true})
keymap.set('n', '<leader>sc', '<cmd>close<cr>', {desc = "Close current split", silent = true})

-- Undo tree
keymap.set('n', '<leader>u', ':UndotreeToggle<cr>', {desc = "Toggle undo tree", silent = true})

-- Suppress highlights 
keymap.set('n', '<leader>nh', ':nohl<cr>', {desc = "Clear search highlights", silent = true})

-- Git integration
keymap.set('n', '<leader>gg', ':Git ', { desc = "Open manual git command prompt" })
keymap.set('n', '<leader>ga', ':Git add .<cr>', {desc = "Add all files to staging environment"})
keymap.set('n', '<leader>gs', ':Git status<cr>', {desc = "Get git status", silent = true})
keymap.set('n', '<leader>gC', ':lua lazy_commit()<cr>', {desc = "Add, commit, push all files (date as message)"})
keymap.set('n', '<leader>gc', ':Git commit -m ', {noremap = true, desc = "Commit all files (manually type message)"})
keymap.set('n', '<leader>gpl', ':Git pull', {desc = "Pull from github"})
keymap.set('n', '<leader>gps', ':Git push', {desc = "Push to github"})
keymap.set('n', '<leader>gh', ':Gitsigns preview_hunk<cr>', {desc = "Git preview", silent = true})
keymap.set('n', '<leader>gb', ':Gitsigns toggle_current_line_blame<cr>', {desc = "Toggle current line blame", silent = true})

-- Treesitter stuff
-- Incremental selection
keymap.set({'n', 'v'}, '<C-space>', '<cmd>lua require("nvim-treesitter.incremental_selection").init_selection()<CR>', { desc = "Init and increment selection", noremap = true, silent = true })
keymap.set({'n', 'v'}, '<C-space>', '<cmd>lua require("nvim-treesitter.incremental_selection").node_incremental()<CR>', { noremap = true, silent = true })
keymap.set({'n', 'v'}, '<C-z>', '<cmd>lua require("nvim-treesitter.incremental_selection").scope_incremental()<CR>', { desc = "Increment selected scope", noremap = true, silent = true })
keymap.set({'n', 'v'}, '<bs>', '<cmd>lua require("nvim-treesitter.incremental_selection").node_decremental()<CR>', { desc = 'Decrement selected scope', noremap = true, silent = true })

-- Text objects
keymap.set({'o', 'x'}, 'af', '<cmd>lua require"nvim-treesitter.textobjects".select("function.outer")<CR>', { noremap = true, silent = true })
keymap.set({'o', 'x'}, 'if', '<cmd>lua require"nvim-treesitter.textobjects".select("function.inner")<CR>', { noremap = true, silent = true })
keymap.set({'o', 'x'}, 'ac', '<cmd>lua require"nvim-treesitter.textobjects".select("class.outer")<CR>', { noremap = true, silent = true })
keymap.set({'o', 'x'}, 'ic', '<cmd>lua require"nvim-treesitter.textobjects".select("class.inner")<CR>', { noremap = true, silent = true })

-- Movement
keymap.set('n', ']m', '<cmd>lua require"nvim-treesitter.textobjects.move".goto_next_start("@function.outer")<CR>', { noremap = true, silent = true })
keymap.set('n', ']]', '<cmd>lua require"nvim-treesitter.textobjects.move".goto_next_start("@class.outer")<CR>', { noremap = true, silent = true })
keymap.set('n', ']M', '<cmd>lua require"nvim-treesitter.textobjects.move".goto_next_end("@function.outer")<CR>', { noremap = true, silent = true })
keymap.set('n', '][', '<cmd>lua require"nvim-treesitter.textobjects.move".goto_next_end("@class.outer")<CR>', { noremap = true, silent = true })

keymap.set('n', '[m', '<cmd>lua require"nvim-treesitter.textobjects.move".goto_previous_start("@function.outer")<CR>', { noremap = true, silent = true })
keymap.set('n', '[M', '<cmd>lua require"nvim-treesitter.textobjects.move".goto_previous_end("@function.outer")<CR>', { noremap = true, silent = true })
keymap.set('n', '[[' , '<cmd>lua require"nvim-treesitter.textobjects.move".goto_previous_start("@class.outer")<CR>', { noremap = true, silent = true })
keymap.set('n', '[]' , '<cmd>lua require"nvim-treesitter.textobjects.move".goto_previous_end("@class.outer")<CR>', { noremap = true, silent = true })

-- Build shortcuts
keymap.set('n', '<C-b>', ':lua build_in_tmux()<cr>', {desc = "Build current file in a tmux terminal", silent = true}) -- build
keymap.set({'i','v'}, '<C-b>', '<ESC>:lua build_in_tmux()<cr>', {desc = "Build current file in a tmux terminal", silent = true}) -- build
keymap.set('n', '<C-t>', ':lua build_in_vim()<cr>', {desc = "Build current file in a vim terminal", silent = true})
keymap.set({'i', 'v'}, '<C-t>', '<ESC>:lua build_in_vim()<cr>', {desc = "Build current file in a vim terminal", silent = true})

-- File tree navigation
keymap.set('n', '<leader>et', ':lua tree_toggle()<CR>', {desc = "Toggle explorer side bar", silent = true}) -- explorer toggle
keymap.set('n', '<leader>ef', ':Neotree focus<CR>', {desc = "Shift focus to explorer", silent = true}) -- explorer focus
keymap.set('n', '<leader>eo', ':Neotree toggle current reveal_force_cwd<cr>', {desc = "Open file tree", silent = true}) -- explorer open
keymap.set('n', '<leader>ec', ':Neotree close<cr>', {desc = "Close explorer side bar", silent = true}) -- explorer close
keymap.set('n', '<C-d>', ':lua cd_active_directory()<cr>', {desc = "Cd to curent file location", silent = true})
keymap.set('n', '<leader>cc', ':lua nav_nvim_config()<cr>', {desc = 'Navigate to nvim config', silent = true})
keymap.set('n', '<leader>e.', ':lua tree_mode_toggle()<cr>', {noremap = true, desc = 'Toggle between floating and side-bar view', silent = true})

-- Tab navigation
keymap.set('n', "<leader>to", "<cmd>tabnew<cr>", { desc = "Open new tab", silent = true }) -- tab open
keymap.set('n', "<leader>tc", "<cmd>tabclose<cr>", { desc = "Close current tab", silent = true }) -- tab close
keymap.set('n', "<leader>tn", "<cmd>tabn<cr>", { desc = "Go to next tab", silent = true }) -- tab next
keymap.set('n', "<leader>tp", "<cmd>tabp<cr>",  { desc = "Go to previous tab", silent = true }) -- tab prev
keymap.set('n', "<leader>tm", "<cmd>tabnew %<cr>", { desc = "Open current buffer in new tab", silent = true }) --tab migrate

-- Telescope fuzzy finder
keymap.set('n', '<leader>ff', ':Telescope find_files<cr>', { desc = "Find files", silent = true })
keymap.set('n', '<leader>fF', ':Telescope find_files hidden=true<cr>', { desc = "Find files", silent = true })
keymap.set('n', '<leader>fg', ':Telescope live_grep<cr>', { desc = "Live grep", silent = true })
keymap.set('n', '<leader>fb', ':Telescope buffers<cr>', { desc = "Search for buffers", silent = true })
keymap.set('n', '<leader>fh', ':Telescope help_tags<cr>', { desc = "Find help", silent = true })
keymap.set('n', '<leader>fo', ':ObsidianSearch<cr>', { desc = "Search notes", silent = true })
keymap.set('n', '<leader>fr', '<cmd>Telescope oldfiles<cr>', { desc = "Fuzzy find recent files" })
keymap.set('n', '<leader>fc', '<cmd>Telescope grep_string<cr>', { desc = "Find string under cursor cwd" })
keymap.set('n', '<leader>ft', '<cmd>TodoTelescope<cr>', { desc = "Find todos" })
-- Should be control+d causes telescope to delete the buffer but it doesn't seem to be working
keymap.set('n', '<leader>bd', '<cmd>bd<cr>', { desc = 'Delete buffer' })

-- LSP 
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
        -- See :help vim.lsp.* for documentation on any of the below fuctions
        keymap.set("n", "gR", "<cmd>Telescope lsp_references<cr>", { desc = "Show LSP references", buffer = ev.buf, silent = true })
        keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = "Go to declaration", buffer = ev.buf, silent = true })
        keymap.set('n', 'gd', '<cmd>Telescope lsp_definitions<cr>',  { desc = "Show LSP definitions", buffer = ev.buf, silent = true })
        keymap.set('n', 'gi', '<cmd>Telescope lsp_implementations<cr>',  { desc = "Show LSP implementations", buffer = ev.buf, silent = true })
        keymap.set('n', 'gt', '<cmd>Telescope lsp_type_definitions<cr>', { desc = "Show LSP type definitions", buffer = ev.buf, silent = true })
        keymap.set({'n', 'v'}, '<leader>ca', vim.lsp.buf.code_action, { desc = "See available code actions", buffer = ev.buf, silent = true })
        keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = "Smart rename", buffer = ev.buf })
        keymap.set('n', "<leader>D", '<cmd>lua toggle_diagnostics()<cr>',  { desc = "Toggle diagnostics", buffer = ev.buf, silent = true })
        keymap.set('n', '<leader>d', vim.diagnostic.open_float,  { desc = "Show line diagnostics", buffer = ev.buf, silent = true })
        keymap.set('n', "[d", vim.diagnostic.goto_prev,  { desc = "Go to previous diagnostic", buffer = ev.buf, silent = true })
        keymap.set('n', "]d", vim.diagnostic.goto_next,  { desc = "Go to next diagnostic", buffer = ev.buf, silent = true })
        keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Show documentation for what is under cursor", buffer = ev.buf, silent = true })
        keymap.set("n", "<leader>rs", ":LspRestart<cr>", { desc = "Restart LSP", buffer = ev.buf, silent = true })
        keymap.set("n", "<leader>ct", "<cmd>lua toggle_completions()<cr>", { desc = "Toggle completions", buffer = ev.buf, silent = true })
    end
})

-- Python specific
keymap.set("n", '<localleader>pf', ':lua format_python_code()<cr>', {desc = "Autoformat python code", silent = true})
vim.api.nvim_create_autocmd('FileType', {
    pattern = 'python',
    callback = function(ev)
        keymap.set('n', '<leader>ba', ":lua require('dap').toggle_breakpoint()<cr>", {desc = "Set breakpoint", buffer = ev.buf})
        keymap.set('n', '<leader>bc', ":lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>", {desc = "Set breakpoint condition", buffer = ev.buf})
        -- keymap.set("n", "<leader>bl", "<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>")
        keymap.set('n', '<leader>bc', ":lua require('dap').clear_breakpoints()<cr>", {desc = "Clear breakpoints", buffer = ev.buf})
        keymap.set("n", '<leader>bl', '<cmd>Telescope dap list_breakpoints<cr>', {desc = "List breakpoints", buffer = ev.buf})
        keymap.set("n", "<leader>ds", "<cmd>lua require('dap').continue()<cr>", {desc = "Start debugger", buffer = ev.buf})
        keymap.set("n", "<leader>dc", "<cmd>lua require('dap').continue()<cr>", {desc = "Debugger continue", buffer = ev.buf})
        keymap.set("n", "<leader>do", "<cmd>lua require('dap').step_over()<cr>", {desc = "Debugger step over", buffer = ev.buf})
        keymap.set("n", "<leader>di", "<cmd>lua require('dap').step_into()<cr>", {desc = "Debugger step into", buffer = ev.buf})
        keymap.set("n", "<leader>du", "<cmd>lua require('dap').step_out()<cr>", {desc = "Debugger step out", buffer = ev.buf})
        keymap.set("n", '<leader>dx', function() require('dap').disconnect(); require('dapui').close(); end, {desc = "Disconnect debugger", buffer = ev.buf})
        keymap.set("n", '<leader>dX', function() require('dap').terminate(); require('dapui').close(); end, {desc = "Terminate debugger", buffer = ev.buf})
        -- keymap.set("n", "<leader>pdr", "<cmd>lua require('dap').repl.toggle()<cr>") -- ??
        -- keymap.set("n", "<leader>pdl", "<cmd>lua require('dap').run_last()<cr>") -- ??
        keymap.set("n", '<leader>di', function() require("dap.ui.widgets").hover() end, {desc = "Display info", buffer = ev.buf})
        keymap.set("n", '<leader>d?', function() local widgets = require("dap.ui.widgets"); widgets.centered_float(widgets.scopes) end)
        -- keymap.set("n", '<leader>df', '<cmd>Telescope dap frames<cr>')
        -- keymap.set("n", '<leader>dh', '<cmd>Telescope dap commands<cr>')
        -- keymap.set("n", '<leader>de', function() require('telescope.builtin').diagnostics({default_text=":E:"}) end)
    end
})

function format_python_code()
    local filetype = vim.bo.filetype
    if filetype ~= "python" then
        return
    end
    vim.cmd("silent! w")
    vim.cmd("Isort")
    vim.cmd("Black")
end

function lazy_commit()
    vim.cmd('Git add .')
    local datetime = os.date()
    local command_string = ':Git commit -m ' .. '"' .. datetime .. '"'
    vim.cmd(command_string)
    vim.cmd('Git push')
end

function build_in_vim()
    local filetype = vim.bo.filetype

    if filetype == "python" then
        vim.cmd('silent! w')
        for _,buffer_number in ipairs(vim.api.nvim_list_bufs()) do
            local type = vim.api.nvim_buf_get_option(buffer_number, 'buftype')
            if type == 'terminal' then
                -- win = get_window_from_buffer(buffer_number)
                -- if win then
                --     vim.api.nvim_win_close(win, true)
                -- end
                vim.api.nvim_buf_delete(buffer_number, {force = true})
            end
        end
        current_buffer = vim.api.nvim_get_current_buf()
        local filepath = vim.api.nvim_buf_get_name(current_buffer)

        vim.cmd('split')
        vim.cmd('resize 17')
        vim.cmd('terminal' .. '!python3 ' .. filepath)
        vim.cmd('startinsert')
    elseif filetype == 'tex' then
        if vim.bo.modified then
            vim.cmd('VimtexCompile')
        end
        vim.cmd('VimtexView')
    elseif filetype == 'lua' then
        vim.cmd('silent! w')
        vim.cmd('silent! source %')
        for _,buffer_number in ipairs(vim.api.nvim_list_bufs()) do
            local type = vim.api.nvim_buf_get_option(buffer_number, 'buftype')
            if type == 'terminal' then
                vim.api.nvim_buf_delete(buffer_number, {force = true})
            end
        end
        current_buffer = vim.api.nvim_get_current_buf()
        local filepath = vim.api.nvim_buf_get_name(current_buffer)

        vim.cmd('split')
        vim.cmd('resize 17')
        vim.cmd('terminal' .. '!lua ' .. filepath)
        vim.cmd('startinsert')
    end
end

function cd_active_directory()
    local current_buffer = vim.api.nvim_get_current_buf()
    local current_file_path = vim.api.nvim_buf_get_name(current_buffer)
    local current_directory = vim.fn.fnamemodify(current_file_path, ':h')
    vim.api.nvim_command('cd' .. current_directory)
end

local diagnostic_counter = 0
function toggle_diagnostics()
    if diagnostic_counter == 0 then
        vim.diagnostic.disable()
        diagnostic_counter = (diagnostic_counter+1)%2
    elseif diagnostic_counter == 1 then
        vim.diagnostic.enable()
        diagnostic_counter = (diagnostic_counter+1)%2
    end
end

local completions_counter = 0
function toggle_completions()
    if completions_counter == 0 then
        require("cmp").setup.buffer({ enabled = false })
        completions_counter = (completions_counter+1)%2
    elseif completions_counter == 1 then
        require("cmp").setup.buffer({ enabled = true })
        completions_counter = (completions_counter+1)%2
    end
end

local wrap_counter = 0
function change_wrap_mode()
    if wrap_counter == 0 then
        vim.cmd('SoftWrapMode')
        wrap_counter = (wrap_counter+1)%3
    elseif wrap_counter == 1 then
        vim.cmd('HardWrapMode')
        wrap_counter = (wrap_counter+1)%3
    elseif wrap_counter == 2 then
        vim.o.wrap = false
        print('Wrapping disabled')
        wrap_counter = (wrap_counter+1)%3
    end
end

function build_in_tmux()
    vim.cmd('silent! w')
    vim.cmd('silent! source %')

    local filetype = vim.bo.filetype
    local filetype_valid = false
    for i, value in ipairs(buildable_filetypes) do
        if value == filetype then
            filetype_valid = true
            break
        end
    end
    if not filetype_valid then
        print("No build procedure defined for " .. filetype .. " files.")
        return
    end
    -- get current filepath
    current_buffer = vim.api.nvim_get_current_buf()
    local filepath = vim.api.nvim_buf_get_name(current_buffer)
    if filetype ~= "tex" then
        -- If a pane has ever been created before, check if it still exists
        if vim.g.tmux_pane_id then
            local pane_id = vim.g.tmux_pane_id
            local exists = vim.fn.system("tmux list-panes | grep -q " .. pane_id)
            if vim.v.shell_error == 1 then
                -- If it doesn't, create a new one
                pane_id = create_pane()
                vim.g.tmux_pane_id = pane_id
            end
        else
            -- Also create a new one if it's never existed
            pane_id = create_pane()
            vim.g.tmux_pane_id = pane_id
        end
    end
    local command
    if filetype == 'tex' then
        if vim.bo.modified then
            vim.cmd('VimtexCompile')
        end
        vim.cmd('VimtexView')
    elseif filetype == 'python' then
        command = 'python3 ' .. filepath
        local wrapped_command = '"' .. command .. '"'
        os.execute('tmux send-keys -t ' .. vim.g.tmux_pane_id .. ' ' .. wrapped_command .. ' C-m')
    elseif filetype == 'lua' then
        command = 'lua ' .. filepath
        local wrapped_command = '"' .. command .. '"'
        os.execute('tmux send-keys -t ' .. vim.g.tmux_pane_id .. ' ' .. wrapped_command .. ' C-m')
    end
end

function create_pane()
    local handle = io.popen('tmux split-window -P -F "#{pane_id}" -l 25%')
    local pane_id = handle:read("*a"):gsub("%s", "")
    handle:close()
    vim.cmd('sleep 300m')
    return pane_id
end

function nav_nvim_config()
    vim.api.nvim_command('cd ~/.config/nvim')
    vim.cmd('Telescope find_files')
end

function tree_mode_toggle()
    if tree_mode == "floating" then
        tree_mode = "side-bar"
        return
    end
    if tree_mode == 'side-bar' then
        tree_mode = "floating"
        return
    end
end

function tree_toggle()
    if tree_mode == "side-bar" then
        vim.cmd('Neotree left toggle')
    elseif tree_mode == 'floating' then
        vim.cmd('Neotree float toggle')
    end
end
-- Other hotkeys that are either not defined here or built-in:
-- COMMENTARY PLUGIN:
--  gcc comments/uncomments a line, can type 9gcc to command 9 lines etc
--  can also highling a block of code and type gc to toggle  
--  gcap comments a paragraph, gcgc uncomments?

