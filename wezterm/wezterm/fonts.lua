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
			name = 'JetBrains Mono',
			weight = weights.R,
			italic = false,
			font_size = 11.5,
			cell_width = 1,
			line_height = 1,
		},
		victor = {
			name = 'VictorMono Nerd Font',
			italic = true,
			weight = weights.B,
			font_size = 11.5,
			cell_width = 1.1,
			line_height = 1,
			harfbuzz_features = {
				-- 'ss02',
				'ss06',
				'ss07',
				'ss08',
			},
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
			full_italic = true,
			italic = true,
			name = 'Cascadia Code',
			weight = weights.R,
			cell_width = 1,
			font_size = 10.5,
			line_height = 1,
			harfbuzz_features = {
				'ss01',
			},
		},
		caskaydia_aoc = {
			full_italic = false,
			italic = false,
			name = 'Cascadia Code NF',
			weight = weights.R,
			cell_width = 1,
			font_size = 11.5,
			line_height = 1.15,
			scale = 0.8,
			harfbuzz_features = {
				'ss01',
			},
		},
		input = {
			name = 'Input Mono',
			weight = weights.R,
			font_size = 11,
			cell_width = 1,
			line_height = 1,
		},
		serious = {
			name = 'SeriousShanns Nerd Font',
			italic = false,
			font_size = 12.4,
			cell_width = 1,
			line_height = 1,
		},
		agave = {
			name = 'Agave Nerd Font',
			weight = weights.R,
			font_size = 12.5,
			cell_width = 1,
			line_height = 1,
		},
		menlo = {
			name = 'Menlo',
			weight = weights.R,
			font_size = 11,
			cell_width = 1,
			line_height = 1,
		},
		monaco = {
			name = 'Monaco',
			weight = weights.R,
			font_size = 11,
			cell_width = 1,
			line_height = 1,
		},
		fant = {
			name = 'Fantasque Sans Mono',
			weight = weights.R,
			font_size = 13,
			cell_width = 1,
			line_height = 1,
			scale = 0.6,
		},
		sf_mono = {
			name = 'SF Mono',
			italic = false,
			weight = weights.M,
			font_size = 11.7,
			cell_width = 1,
			line_height = 1.1,
		},
		fira = {
			name = 'Fira Code',
			weight = weights.R,
			font_size = 11.3,
			line_height = 1.1,
			harfbuzz_features = {
				-- 'cv01', -- a
				-- 'cv02', -- g
				'cv10', -- l
				'ss01', -- r
				'cv14', -- 3
				'onum', -- 0123
				'cv18', -- %
				'cv31', -- ()
				'cv29', -- {}
				'ss08', -- ===
			},
		},
		hack = {
			name = 'Hack',
			weight = weights.B,
			italic = false,
			font_size = 11.5,
			cell_width = 1,
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
			full_italic = false,
			italic = false,
			font_size = 11,
			cell_width = 1,
			line_height = 1,
			weight = weights.SB,
			scale = 1,
			harfbuzz_features = {
				'cv01', -- @
				'cv02', -- a
				-- 'cv03', -- i
				'cv04', -- l
				'cv35',
			},
		},
		zed = {
			name = 'Zed Mono Medium Extended',
			font_size = 11.5,
			cell_width = 1,
			line_height = 1.05,
		},
		pt_mono = {
			name = 'PT Mono',
			font_size = 12,
			cell_width = 1,
			line_height = 1,
		},
		mononoki_aoc = {
			name = 'Mononoki Nerd Font',
			italic = false,
			weight = weights.B,
			font_size = 11.9,
			cell_width = 1,
			line_height = 1.15,
			scale = 0.7,
		},
		inconsolata = {
			name = 'Inconsolata',
			italic = false,
			weight = weights.B,
			font_size = 12,
			cell_width = 1,
			line_height = 1,
			scale = 0.6,
			harfbuzz_features = {
				'liga',
				'dlig',
			},
		},
		recursive = {
			name = 'Rec Mono Custom',
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
			name = 'Iosevka Extended',
			weight = weights.B,
			font_size = 12,
			cell_width = 1,
			line_height = 1,
			harfbuzz_features = {
				'ss05',
				'VSAO=1',
				'VLAA=2',
				'VSAL=4',
				'VSAG=3',
				'VSAH=3',
				'VSAC=1',
				'cv10=6',
			},
		},
		roboto = {
			name = 'Roboto Mono',
			italic = true,
			weight = weights.M,
			font_size = 11,
			cell_width = 1,
			line_height = 0.9,
		},
		ubuntu = {
			name = 'Ubuntu Mono',
			weight = weights.R,
			font_size = 14,
			line_height = 1,
		},
		proto = {
			name = '0xProto Nerd Font',
			weight = weights.R,
			font_size = 11.5,
			line_height = 1,
		},
		radon = {
			name = 'Monaspace Radon',
			weight = weights.M,
			font_size = 11,
			cell_width = 1,
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
