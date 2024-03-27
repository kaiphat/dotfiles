local wezterm = require 'wezterm'

local weights = {
	L = 'Light',
	R = 'Regular',
	B = 'Bold',
	SB = 'DemiBold',
	EB = 'ExtraBold',
	M = 'Medium',
}

local function build_font_params(name, with_italic, weight, params)
	local scale = 0.8

	local font = wezterm.font_with_fallback {
		{ family = name, weight = weight },
        { family = 'Symbols Nerd Font Mono', scale = scale },
	}

	return merge(params, {
		font = font,
		font_rules = {
			{
				italic = true,
				font = wezterm.font(name, { italic = with_italic, weight = weight }),
			},
			{
				font = font,
			},
		},
	})
end

return {
	jet_brains = build_font_params('JetBrainsMono Nerd Font', true, weights.B, {
		font_size = 10.8,
		cell_width = 1,
		line_height = 1.15,
	}),
	mononoki = build_font_params('mononoki Nerd Font', true, weights.B, {
		font_size = 10,
		cell_width = 0.8,
		line_height = 1.3,
	}),
	mononoki_liga = build_font_params('Ligamononoki Nerd Font', false, weights.R, {
		font_size = 13.5,
		cell_width = 0.9,
		line_height = 1.3,
	}),
	agave = build_font_params('Agave Nerd Font', false, weights.R, {
		font_size = 11,
		cell_width = 0.8,
		line_height = 1.25,
	}),
	agave_code = build_font_params('Agave Code', false, weights.R, {
		font_size = 14,
		cell_width = 1,
		line_height = 1.26,
	}),
	operator = build_font_params('OperatorMonoLig Nerd Font', false, weights.R, {
		font_size = 13,
		cell_width = 0.92,
		line_height = 1.15,
	}),
	victor = build_font_params('Victor Mono', false, weights.B, {
		font_size = 10.5,
		cell_width = 1.1,
		line_height = 1.2,
	}),
	iosevka = build_font_params('Iosevka Term', false, weights.R, {
		font_size = 10,
		cell_width = 1,
		line_height = 1.1,
	}),
	iosevka_custom = build_font_params('Iosevka Custom', false, weights.M, {
		font_size = 13.3,
		cell_width = 1,
		line_height = 1,
	}),
	iosevka_nerd_font = build_font_params('Iosevka Nerd Font', false, weights.SB, {
		font_size = 13,
		cell_width = 1,
		line_height = 1,
	}),
	iosevka_ss12 = build_font_params('Iosevka SS12', false, weights.SB, {
		font_size = 13,
		cell_width = 1,
		line_height = 1,
	}),
	caskaydia = build_font_params('Cascadia Code', true, weights.R, {
		font_size = 8,
		cell_width = 1,
		line_height = 1.25,
	}),
	caskaydia_nerd_font = build_font_params('CaskaydiaCove Nerd Font', false, weights.R, {
		font_size = 12,
		cell_width = 0.9,
		line_height = 1.15,
	}),
	fant = build_font_params('Fantasque Sans Mono', false, weights.R, {
		font_size = 13.1,
		cell_width = 1,
		line_height = 1.3,
	}),
	sf_mono = build_font_params('SFMono Nerd Font', false, weights.B, {
		font_size = 12,
		cell_width = 0.85,
		line_height = 1.05,
	}),
	fira = build_font_params('FiraCode Nerd Font', false, weights.R, {
		font_size = 11,
		cell_width = 0.9,
		line_height = 1.1,
	}),
	ubuntu = build_font_params('Ubuntu Mono Ligaturized', false, weights.M, {
		font_size = 15.3,
		cell_width = 0.85,
		line_height = 1.15,
	}),
	hack = build_font_params('Hack Nerd Font JBM Ligatured', false, weights.M, {
		font_size = 15,
		cell_width = 0.9,
		line_height = 1.15,
	}),
	hermit = build_font_params('Hurmit Nerd Font Mono', false, weights.M, {
		font_size = 12,
		cell_width = 1,
		line_height = 0.85,
	}),
	maple = build_font_params('Maple Mono NF', false, weights.R, {
		font_size = 11.5,
		cell_width = 1,
		line_height = 1,
		harfbuzz_features = {
			'cv01',
			'cv03',
			'cv04',
			'ss01',
			'ss02',
			'ss04',
			'ss05',
		},
	}),
}
