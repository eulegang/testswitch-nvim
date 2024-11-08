local M = {}

function M.is_test(path, parent)
  if parent ~= nil and parent(path) then
    return true
  end

  if path.name:match("_spec$") then
    return true
  end

  return false
end

function M.test_paths(path, parent)
  print(vim.inspect(path))
  local res = {}
  if parent ~= nil then
    res = parent(path)
  end

  if path.dir:match("^lua/") then
    table.insert(res, {
      dir = path.dir:gsub("^lua/", "tests/"),
      name = path.name .. "_spec",
      ext = path.ext,
    })
  end

  print(vim.inspect(res))
  return res
end

function M.origin_paths(path, parent)
  print(vim.inspect(path))
  local res = {}
  if parent ~= nil then
    res = parent(path)
  end

  if path.dir:match("^tests/") then
    table.insert(res, {
      dir = path.dir:gsub("^tests/", "lua/"),
      name = path.name:gsub("_spec$", ""),
      ext = path.ext,
    })
  end

  print(vim.inspect(res))
  return res
end

return M
