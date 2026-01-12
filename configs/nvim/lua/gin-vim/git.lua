local M = {}

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
  local start_marker = comment_char .. " --- git diff (auto) START ---"
  local end_marker = comment_char .. " --- git diff (auto) END ---"

  local diff_lines = get_diff_lines()
  if #diff_lines == 0 then
    return
  end

  local commented = prefix_comment(diff_lines, comment_char)
  local block = { start_marker }
  for _, l in ipairs(commented) do
    table.insert(block, l)
  end
  table.insert(block, end_marker)

  -- バッファから既存のマーカーを探して削除（上書き）
  local buf_lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  local s, e = find_marker_range(buf_lines, start_marker, end_marker)
  if s and e then
    -- remove existing block (inclusive)
    vim.api.nvim_buf_set_lines(bufnr, s, e + 1, false, {})
  end

  -- 末尾に空行1つ挟んでからブロックを追加
  local line_count = vim.api.nvim_buf_line_count(bufnr)
  local to_add = { "" }
  for _, l in ipairs(block) do
    table.insert(to_add, l)
  end

  vim.api.nvim_buf_set_lines(bufnr, line_count, line_count, false, to_add)
end

return M
