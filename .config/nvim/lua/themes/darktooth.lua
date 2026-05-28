-- Darktooth theme for NvChad base46
-- Colors from https://github.com/jasonm23/emacs-theme-darktooth

local M = {}

M.base_30 = {
  white        = "#D5C4A1",
  darker_black = "#141617",
  black        = "#1D2021", -- nvim bg
  black2       = "#272A2B",
  one_bg       = "#2A2D2E",
  one_bg2      = "#32302F",
  one_bg3      = "#3A3835",
  grey         = "#504945",
  grey_fg      = "#5A524C",
  grey_fg2     = "#665C54",
  light_grey   = "#928374",
  red          = "#FB543F",
  baby_pink    = "#FF7060",
  pink         = "#D65D8A",
  line         = "#32302F",
  green        = "#95C085",
  vibrant_green = "#A8C888",
  nord_blue    = "#457A8B",
  blue         = "#0D6678",
  yellow       = "#FAC03B",
  sun          = "#FE8625",
  purple       = "#8F4673",
  dark_purple  = "#B06090",
  teal         = "#8BA59B",
  orange       = "#FE8625",
  cyan         = "#8BA59B",
  statusline_bg = "#232728",
  lightbg      = "#2A2D2E",
  pmenu_bg     = "#457A8B",
  folder_bg    = "#8BA59B",
}

M.base_16 = {
  base00 = "#1D2021",
  base01 = "#32302F",
  base02 = "#504945",
  base03 = "#665C54",
  base04 = "#928374",
  base05 = "#A89984",
  base06 = "#D5C4A1",
  base07 = "#FDF4C1",
  base08 = "#FB543F",
  base09 = "#FE8625",
  base0A = "#FAC03B",
  base0B = "#95C085",
  base0C = "#8BA59B",
  base0D = "#0D6678",
  base0E = "#8F4673",
  base0F = "#A87322",
}

M.type = "dark"

M = require("base46").override_theme(M, "darktooth")

return M
