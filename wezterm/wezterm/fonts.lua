local wezterm = require 'wezterm'

local weights = {
	L = 'Light',
	SL = 'DemiLight',
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
				scale = params.scale or 0.75,
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
	fonts = {
		jet_brains = {
			name = 'JetBrainsMono Nerd Font',
			weight = weights.M,
			italic = true,
			font_size = 12,
			cell_width = 1,
			line_height = 1,
		},
		victor = {
			name = 'VictorMono Nerd Font',
			italic = true,
			weight = weights.B,
			font_size = 12,
			cell_width = 1,
			line_height = 1,
		},
		plex = {
			name = 'IBMPlexMono',
			italic = false,
			full_italic = false,
			weight = weights.B,
			font_size = 10,
			cell_width = 1,
			line_height = 1,
		},
		caskaydia = {
			italic = true,
			name = 'Cascadia Code',
			weight = weights.SL,
			cell_width = 0.91,
			font_size = 12,
			line_height = 1,
			harfbuzz_features = {
				'ss01',
			},
		},
		input = {
			name = 'Input Mono Condensed',
			weight = weights.R,
			font_size = 11.5,
			cell_width = 1,
			line_height = 1.1,
		},
		serious = {
			name = 'SeriousShanns Nerd Font',
			italic = true,
			font_size = 12.5,
			cell_width = 1,
			line_height = 1.15,
		},
		agave = {
			name = 'Agave Nerd Font',
			weight = weights.R,
			font_size = 12.5,
			cell_width = 1,
			line_height = 1.15,
		},
		fant = {
			name = 'Fantasque Sans Mono',
			weight = weights.M,
			font_size = 12.5,
			cell_width = 1.1,
			line_height = 1.15,
			scale = 0.6,
		},
		sf_mono = {
			name = 'SF Mono',
			italic = false,
			weight = weights.B,
			font_size = 10,
			cell_width = 1,
			line_height = 1.3,
		},
		fira = {
			name = 'FiraCode Nerd Font',
			weight = weights.R,
			font_size = 11.5,
			line_height = 1,
		},
		hack = {
			name = 'Hack',
			font_size = 12,
			cell_width = 1,
			line_height = 1,
		},
		hermit = {
			name = 'Hermit',
			weight = weights.R,
			font_size = 12,
			cell_width = 1,
			line_height = 0.9,
		},
		space_mono = {
			name = 'Space Mono',
			weight = weights.R,
			font_size = 12,
			cell_width = 1,
			line_height = 1,
			harfbuzz_features = {
				'liga=off',
			},
		},
		maple_mac = {
			name = 'Maple Mono NF',
			italic = true,
			font_size = 11.5,
			cell_width = 1,
			line_height = 0.9,
			weight = weights.R,
			scale = 1,
			harfbuzz_features = {
				'zero',
				-- 'cv01', -- @
				'cv02', -- a
				-- 'cv03', -- i
				'cv04', -- l
				'ss02',
			},
		},
		maple_aoc = {
			name = 'Maple Mono NF',
			italic = true,
			font_size = 12,
			cell_width = 1,
			line_height = 1,
			weight = weights.R,
			scale = 1,
			harfbuzz_features = {
				'cv01', -- @
				'cv02', -- a
				-- 'cv03', -- i
				'cv04', -- l
			},
		},
		zed = {
			name = 'Zed Mono SemiBold Extended',
			font_size = 11.5,
			cell_width = 1,
			line_height = 1.15,
		},
		pt_mono = {
			name = 'PT Mono',
			font_size = 12,
			cell_width = 1,
			line_height = 1.1,
		},
		mononoki_aoc = {
			name = 'mononoki',
			italic = false,
			weight = weights.B,
			font_size = 11.9,
			cell_width = 1,
			line_height = 1,
			scale = 0.8,
		},
		inconsolata = {
			name = 'Inconsolata',
			italic = false,
			weight = weights.B,
			font_size = 14,
			cell_width = 1,
			line_height = 1.2,
			scale = 0.6,
			harfbuzz_features = {
				'liga',
				'dlig',
			},
		},
		recursive = {
			name = 'Rec Mono Casual',
			weight = weights.R,
			font_size = 11.5,
			line_height = 1,
			scale = 0.7,
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
			name = 'Iosevka',
			weight = weights.SB,
			font_size = 12.5,
			cell_width = 1,
			line_height = 1,
		},
		roboto = {
			name = 'Roboto Mono',
			italic = true,
			weight = weights.M,
			font_size = 11,
			cell_width = 1,
			line_height = 1,
		},
		test = {
			name = 'Ubuntu Mono',
			weight = weights.M,
			font_size = 14,
			line_height = 1.25,
		},
		radon = {
			name = 'Monaspace Radon',
			weight = weights.M,
			font_size = 10.1,
			cell_width = 1,
			line_height = 1.2,
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
