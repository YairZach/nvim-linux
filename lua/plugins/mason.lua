return {
  "williamboman/mason.nvim",
  cmd = "Mason",
  event = "BufReadPre",
  config = {
    ui = {
      icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗"
      }
    }
  },
  opts = {
    ensure_installed = {
      "clangd",
      "clang_format",
      "coedelldb",
    }
  }
}
