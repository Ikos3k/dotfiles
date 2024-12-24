-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- Window and Appearance Settings
config.window_background_opacity = 1.0  -- Opacity is set between 0 and 1
config.window_decorations = "NONE"  -- "NONE" for no decorations, "TITLE" for title bar only, "RESIZE" for both title bar and borders

-- Cursor Settings
config.default_cursor_style = 'SteadyBlock'

-- Colors
-- config.colors = {
--     background = "#181818",
--     foreground = "#fefefe",
--     brights = {
--         '#FFf1f2',
--         '#d57e85',
--         '#50fa7b',
--         '#dcb16c',
--         '#ffea00',
--         '#bb99b4',
--         '#ffffa7',
--         '#8b81FF',
--     },
--     ansi = {
--         'black',
--         'maroon',
--         'green',
--         '#ff0000',
--         '#ff0000',
--         'purple',
--         'teal',
--         'silver',
--     },
-- 
--     cursor_border = '#aa8198',
--     cursor_bg = '#501818',
--     selection_bg = '#30181f'
-- }	

-- Font Settings
config.font_size = 14.0
config.font = wezterm.font("Iosevka", { weight = "Medium" })

-- Font Rules for Bold and Italic
config.font_rules = {
    {
        italic = true,
        font = wezterm.font("Iosevka", { weight = "Light", italic = true }),
    },
    {
        intensity = "Bold",
        font = wezterm.font("Iosevka", { weight = "Medium" }),
    },
}

-- Return the configuration
return config
