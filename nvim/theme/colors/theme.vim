lua <<EOF
  package.loaded['theme'] = nil

  local lush = load 'lush'
  if not lush then return end

  lush(
    require("theme.theme")
  )
EOF
