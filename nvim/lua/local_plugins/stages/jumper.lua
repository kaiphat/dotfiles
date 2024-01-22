local Jumper = {}

Jumper.__index = Jumper

function Jumper:new()
    return setmetatable({}, self)
end

function Jumper:get_row_col()
    local cursor = vim.api.nvim_win_get_cursor(0)
    return {
        row = cursor[1],
        col = cursor[2],
    }
end

function Jumper:get_row_text(row, bufnr)
    bufnr = bufnr or 0
    return vim.api.nvim_buf_get_lines(bufnr, row - 1, row, false)[1]
end

function Jumper:is_valid_row(row, bufnr)
    local text = vim.trim(self:get_row_text(row, bufnr))
    return text ~= ''
end

function Jumper:mark_position()
    vim.cmd 'normal! m\''
end

function Jumper:get_row_indent(row)
    return string.find(self:get_row_text(row), '[^%s]') or 0
end

function Jumper:jump_to_parent()
    self:mark_position()

    local cursor = self:get_row_col()
    local row = cursor.row

    while not self:is_valid_row(row) do
        row = row - 1

        if row < 1 then
            return
        end
    end

    local indent = math.huge
    local start_indent = self:get_row_indent(row)

    while not (self:is_valid_row(row) and indent < start_indent) do
        row = row - 1

        if row < 1 then
            return
        end

        indent = self:get_row_indent(row)
    end

    vim.api.nvim_win_set_cursor(0, { row, indent - 1 })
end

function Jumper:jump_up()
    self:mark_position()

    local cursor = self:get_row_col()
    local row = cursor.row

    local indent = math.huge
    local start_indent = self:get_row_indent(row)

    if start_indent == 0 then
        start_indent = math.huge
    end

    while not (self:is_valid_row(row) and indent <= start_indent) do
        row = row - 1

        if row < 1 then
            return
        end

        indent = self:get_row_indent(row)
    end

    vim.api.nvim_win_set_cursor(0, { row, indent - 1 })
end

function Jumper:jump_down()
    self:mark_position()

    local max_row = vim.fn.line '$'
    local cursor = self:get_row_col()
    local row = cursor.row

    local indent = -1
    local start_indent = self:get_row_indent(row)

    if start_indent == 0 then
        start_indent = -1
    end

    while not (self:is_valid_row(row) and indent == start_indent) do
        row = row + 1

        if row > max_row then
            return
        end

        indent = self:get_row_indent(row)

        if indent < start_indent and self:is_valid_row(row) then
            return
        end
    end

    vim.api.nvim_win_set_cursor(0, { row, indent - 1 })
end

function Jumper:setup() end

return Jumper
