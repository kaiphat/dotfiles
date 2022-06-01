local rest = load('rest-nvim')
if not rest then return end

rest.setup {
  env_file = 'http-client.env'
}
