def main [cwd file commit] {
    cd $cwd;

    let file_name = ($file | path basename);
    let relative_file_path = ($file | path relative-to $cwd);
    let new_file = $'/tmp/kaiphat_commit_file_($commit)_($file_name)';
    let diff = git show $'($commit):./($relative_file_path)' | complete

    if ($diff.stderr | is-not-empty) {
        return ''
    }

    $diff.stdout | save -f $new_file;
    return $new_file
}
