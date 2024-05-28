local wezterm = require 'wezterm'

local weights = {
	L = 'Light',
	R = 'Regular',
	M = 'Medium',
	SB = 'DemiBold',
	B = 'Bold',
	EB = 'ExtraBold',
}

local function build_font(params)
	local function get_font(opts)
		return wezterm.font_with_fallback {
			{
				italic = opts.italic,
				family = params.name,
				weight = params.weight or weights.R,
				harfbuzz_features = params.harfbuzz_features,
			},
			{
				family = 'Symbols Nerd Font Mono',
				scale = params.scale or 0.8,
			},
		}
	end

	return {
		font_size = params.font_size or 12,
		cell_width = params.cell_width or 1,
		line_height = params.line_height or 1,
		font = get_font { italic = params.full_italic },
		font_rules = {
			{
				italic = true,
				font = get_font { italic = params.full_italic or params.italic },
			},
			{
				font = get_font { italic = params.full_italic },
			},
		},
	}
end

return {
	build_font = build_font,
	configs = {
		jet_brains = {
			name = 'JetBrainsMono Nerd Font',
			full_italic = true,
			weight = weights.SB,
			font_size = 11.5,
			cell_width = 1,
			line_height = 1,
		},
		victor = {
			name = 'VictorMono Nerd Font',
			weight = weights.EB,
			font_size = 11,
			cell_width = 1.05,
			line_height = 1,
		},
		caskaydia = {
			name = 'Cascadia Code',
			weight = weights.R,
			font_size = 12,
			cell_width = 1,
			line_height = 1.1,
		},
		input = {
			name = 'Input',
			weight = weights.R,
			font_size = 11.5,
			cell_width = 0.9,
			line_height = 1.15,
		},
		serious = {
			name = 'Serious Sans',
			font_size = 12,
			cell_width = 1,
			line_height = 1.15,
		},
		fant = {
			name = 'Fantasque Sans Mono',
			weight = weights.M,
			font_size = 13,
			cell_width = 1,
			line_height = 1.15,
		},
		sf_mono = {
			name = 'SFMono Nerd Font',
			weight = weights.M,
			font_size = 12,
			cell_width = 0.9,
			line_height = 1.1,
		},
		fira = {
			name = 'Fira Code',
			weight = weights.M,
			font_size = 11,
			cell_width = 0.8,
			line_height = 1.1,
		},
		hack = {
			name = 'Hack Nerd Font JBM Ligatured',
			font_size = 15,
			cell_width = 0.9,
			line_height = 1.15,
		},
		hermit = {
			name = 'Hermit',
			weight = weights.R,
			font_size = 12,
			cell_width = 1,
			line_height = 1,
		},
		space_mono = {
			name = 'Space Mono',
			weight = weights.R,
			font_size = 12,
			cell_width = 1,
			line_height = 1,
		},
		maple_mac = {
			name = 'Maple Mono NF',
			font_size = 11.5,
			cell_width = 0.9,
			line_height = 1.1,
			weight = weights.M,
			harfbuzz_features = {
				'cv01', -- @
				'cv02', -- a
				'cv03', -- i
				'cv04', -- l
			},
		},
		maple_aoc = {
			name = 'Maple Mono NF',
			font_size = 12,
			cell_width = 1,
			line_height = 1,
			weight = weights.SB,
			harfbuzz_features = {
				'cv01', -- @
				'cv02', -- a
				-- 'cv03', -- i
				'cv04', -- l
			},
		},
		zed = {
			name = 'ZedMono Nerd Font Mono SemiBold Extended',
			italic = false,
			font_size = 12,
			cell_width = 0.9,
			line_height = 1,
		},
		blex = {
			name = 'BlexMono Nerd Font',
			full_italic = false,
			weight = weights.M,
			font_size = 11,
			cell_width = 1,
			line_height = 1,
		},
		iosevka = {
			name = 'Iosevka Nerd Font Mono',
			weight = weights.M,
			font_size = 13,
			cell_width = 1,
			line_height = 1.1,
		},
		radon = {
			name = 'Monaspace Radon',
			weight = weights.R,
			font_size = 11.5,
			cell_width = 0.8,
			line_height = 1.15,
			harfbuzz_features = {
				'calt',
				'liga',
				-- 'ss01', ===
				-- 'ss02', =>
				'ss03',
				'ss04',
				'ss05',
				'ss06',
				'ss07',
				'ss08',
			},
		},
	},
}
