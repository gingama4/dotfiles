local M = {}

local default_opts = {
  recent_commits = 5,
}

local function get_comment_char()
  local res = vim.fn.systemlist("git config core.commentChar")
  if vim.v.shell_error ~= 0 or #res == 0 or res[1] == "" then
    return "#"
  end
  return res[1]
end

local function get_diff_lines()
  -- ステージ済み差分を取得。なければ非ステージ差分を取得
  local staged = vim.fn.systemlist("git diff --staged --no-color --unified=3 2>/dev/null")
  if vim.v.shell_error == 0 and #staged > 0 then
    return staged
  end
  local unstaged = vim.fn.systemlist("git diff --no-color --unified=3 2>/dev/null")
  if vim.v.shell_error == 0 and #unstaged > 0 then
    return unstaged
  end
  return {}
end

local function get_recent_commit_lines(count)
  if not count or count <= 0 then
    return {}
  end

  local cmd = string.format('git log --no-color -n %d --pretty="format:%%h %%s%%n%%b%%n--COMMIT--" 2>/dev/null', count)
  local lines = vim.fn.systemlist(cmd)
  if vim.v.shell_error ~= 0 or #lines == 0 then
    return {}
  end
  local blocks = {}
  local cur = {}
  for _, l in ipairs(lines) do
    if l == "--COMMIT--" then
      table.insert(blocks, cur)
      cur = {}
    else
      table.insert(cur, l)
    end
  end

  local out = {}
  table.insert(out, "Previous commits (most recent first):")
  table.insert(out, "")
  for i, blk in ipairs(blocks) do
    table.insert(out, string.format("---- commit %d ----", i))
    for _, l in ipairs(blk) do
      table.insert(out, l)
    end
    table.insert(out, "")
  end

  return out
end

local function prefix_comment(lines, comment_char)
  local out = {}
  for _, l in ipairs(lines) do
    if l == "" then
      table.insert(out, comment_char)
    else
      table.insert(out, comment_char .. " " .. l)
    end
  end
  return out
end

local function find_marker_range(buf_lines, start_marker, end_marker)
  local s, e
  for i, l in ipairs(buf_lines) do
    if l == start_marker then
      s = i - 1 -- 0-index for nvim_buf_set_lines
    end
    if l == end_marker then
      e = i - 1
    end
  end
  if s and e and e >= s then
    return s, e
  end
  return nil, nil
end

function M.attach(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  if not vim.api.nvim_buf_is_valid(bufnr) then
    return
  end
  if not vim.api.nvim_buf_get_option(bufnr, "modifiable") then
    return
  end

  -- 対象は COMMIT_EDITMSG または filetype=gitcommit
  local name = vim.api.nvim_buf_get_name(bufnr)
  local ft = vim.api.nvim_buf_get_option(bufnr, "filetype")
  if not (name:match("COMMIT_EDITMSG$") or ft == "gitcommit") then
    return
  end

  local comment_char = get_comment_char()

  local commits_start = comment_char .. " --- git recent commits (auto) START ---"
  local commits_end = comment_char .. " --- git recent commits (auto) END ---"

  local diff_start = comment_char .. " --- git diff (auto) START ---"
  local diff_end = comment_char .. " --- git diff (auto) END ---"

  local recent_lines = get_recent_commit_lines(default_opts.recent_commits)
  local diff_lines = get_diff_lines()

  if (#recent_lines == 0) and (#diff_lines == 0) then
    return
  end

  local commented_commits = prefix_comment(recent_lines, comment_char)
  local commented_diff = prefix_comment(diff_lines, comment_char)

  local commits_block = { commits_start }
  for _, l in ipairs(commented_commits) do
    table.insert(commits_block, l)
  end
  table.insert(commits_block, commits_end)

  local diff_block = { diff_start }
  for _, l in ipairs(commented_diff) do
    table.insert(diff_block, l)
  end
  table.insert(diff_block, diff_end)

  -- バッファから既存のマーカーを探して削除（上書き）
  local buf_lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  local s1, e1 = find_marker_range(buf_lines, commits_start, commits_end)
  if s1 and e1 then
    -- remove existing block (inclusive)
    vim.api.nvim_buf_set_lines(bufnr, s1, e1 + 1, false, {})
  end
  local s2, e2 = find_marker_range(buf_lines, diff_start, diff_end)
  if s2 and e2 then
    -- remove existing block (inclusive)
    vim.api.nvim_buf_set_lines(bufnr, s2, e2 + 1, false, {})
  end

  -- 末尾に空行1つ挟んでからブロックを追加
  local line_count = vim.api.nvim_buf_line_count(bufnr)
  local to_add = { "" }
  if #commits_block > 0 then
    for _, l in ipairs(commits_block) do
      table.insert(to_add, l)
    end
    table.insert(to_add, "")
  end
  if #diff_block > 0 then
    for _, l in ipairs(diff_block) do
      table.insert(to_add, l)
    end
  end

  vim.api.nvim_buf_set_lines(bufnr, line_count, line_count, false, to_add)
end

return M
