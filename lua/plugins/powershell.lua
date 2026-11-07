return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        powershell_es = {
          init_options = { enableProfileLoading = false },
          settings = {
            powershell = {
              scriptAnalysis = { enable = true },
            },
          },
        },
      },
    },
  },
}
