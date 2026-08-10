def main [path] {
  $path | str replace $env.HOME '~'
}
