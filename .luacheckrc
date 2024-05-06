---@diagnostic disable: lowercase-global

ignore = {
  "111", -- setting non standard global var
  "212/_.*", -- unused arg, for vars with '_' prefix
  "214", -- used var with unused hint ('_' prefix)
  "121", -- setting read-only global var 'vim'
  "122", -- setting read-only field of global var 'vim'
}

read_globals = {
  "vim",
}
