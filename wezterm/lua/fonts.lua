local wezterm = require 'wezterm'

local weights = {
	L = 'Light',
	R = 'Regular',
	M = 'Medium',
	SB = 'DemiBold',
	B = 'Bold',
	EB = 'ExtraBold',
	Extended = 'Extended',
}

local function build_font(name, params)
	local weight = params.weight or weights.R

	local font = wezterm.font_with_fallback {
		{ family = name, weight = weight, harfbuzz_features = params.harfbuzz_features },
		{ family = 'Symbols Nerd Font Mono', scale = params.scale or 0.8 },
	}

	return {
		font_size = params.font_size or 12,
		cell_width = params.cell_width or 1,
		line_height = params.line_height or 1,
		harfbuzz_features = params.harfbuzz_features,
		font = font,
		font_rules = {
			{
				italic = true,
				font = wezterm.font(name, {
					italic = params.italic or false,
					weight = weight,
				}),
			},
			{
				font = font,
			},
		},
	}
end

return {
	jet_brains = build_font('JetBrainsMono Nerd Font', {
		weight = weights.B,
		font_size = 11,
		cell_width = 1,
		line_height = 1.1,
	}),
	victor = build_font('VictorMono Nerd Font', {
		weight = weights.EB,
		font_size = 11.5,
		cell_width = 1.05,
		line_height = 1.1,
	}),
	caskaydia = build_font('Cascadia Code', {
		font_size = 8,
		cell_width = 1,
		line_height = 1.25,
	}),
	fant = build_font('Fantasque Sans Mono', {
		weight = weights.M,
		font_size = 14,
		cell_width = 1,
		line_height = 1.15,
	}),
	sf_mono = build_font('SFMono Nerd Font', {
		font_size = 12,
		cell_width = 0.85,
		line_height = 1.05,
	}),
	fira = build_font('FiraCode Nerd Font', {
		font_size = 11,
		cell_width = 0.9,
		line_height = 1.1,
	}),
	hack = build_font('Hack Nerd Font JBM Ligatured', {
		font_size = 15,
		cell_width = 0.9,
		line_height = 1.15,
	}),
	hermit = build_font('Hurmit Nerd Font Mono', {
		font_size = 12,
		cell_width = 1,
		line_height = 0.85,
	}),
	maple_mac = build_font('Maple Mono NF', {
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
	}),
	maple_aoc = build_font('Maple Mono NF', {
		font_size = 10,
		cell_width = 1,
		line_height = 1.15,
		weight = weights.SB,
		harfbuzz_features = {
			'cv01', -- @
			'cv02', -- a
			'cv03', -- i
			'cv04', -- l
		},
	}),
	zed = build_font('ZedMono Nerd Font Mono SemiBold Extended', {
		italic = false,
		font_size = 12,
		cell_width = 0.9,
		line_height = 1.15,
	}),
	iosevka = build_font('Iosevka Nerd Font Mono', {
		weight = weights.M,
		font_size = 13,
		cell_width = 1,
		line_height = 1.1,
	}),
	radon = build_font('Monaspace Radon', {
		weight = weights.M,
		font_size = 11,
		cell_width = 0.85,
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
	}),
}
