return {
  "3rd/image.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  event = { "BufReadPre", "BufNewFile" },
  -- Only options that differ from image.nvim's defaults
  opts = {
    backend = "kitty",
    -- Use the ImageMagick CLI; the magick luarock cannot find libMagickWand without pkg-config
    processor = "magick_cli",
    integrations = {
      neorg = { enabled = false },
      typst = { enabled = false },
    },
    max_width = 100,
    max_height = 12,
    max_height_window_percentage = 40,
  },
}
