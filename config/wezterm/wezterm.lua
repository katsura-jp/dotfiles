local wezterm = require 'wezterm'
local keys = require 'keys'
require 'events'

return {
    -- Rendering
    front_end = 'WebGpu',
    webgpu_power_preference = 'HighPerformance',

    -- Nightly features
    window_content_alignment = {
        horizontal = 'Center',
        vertical = 'Center',
    },
    quick_select_remove_styling = true,
    show_close_tab_button_in_tabs = false,
    native_macos_fullscreen_mode = false,
    macos_fullscreen_extend_behind_notch = true,

    -- Scrollback
    scrollback_lines = 10000,

    -- Window padding
    window_padding = {
        left = 4,
        right = 4,
        top = 4,
        bottom = 4,
    },

    -- Pane
    inactive_pane_hsb = {
        saturation = 0.7,
        brightness = 0.5,
    },

    -- Font
    window_frame = {
        font = wezterm.font { family = 'Moralerspace Neon', weight = 'Bold' },
        font_size = 20.0,
    },
    font = wezterm.font_with_fallback {
        'Moralerspace Neon',
        'Source Han Code JP',
        'Inconsolata',
        'JetBrains Mono',
    },
    font_size = 18.0,
    line_height = 1.2,

    -- Appearance
    color_scheme = 'tokyonight',
    audible_bell = 'Disabled',
    use_fancy_tab_bar = true,

    -- Quick Select patterns
    quick_select_patterns = {
        '[0-9a-f]{7,40}',        -- git hash
        '/[\\w./\\-]+',           -- file paths
        '[\\w.\\-]+@[\\w.\\-]+',  -- email addresses
    },

    -- Key bindings
    keys = keys.keys,
    key_tables = keys.key_tables,
    mouse_bindings = keys.mouse_bindings,
}
