local function get_git_branch()
    local git_branch = vim.fn.systemlist('git branch --show-current')[1]
    return git_branch or ''
end

return {
    get_git_branch = get_git_branch,
}
