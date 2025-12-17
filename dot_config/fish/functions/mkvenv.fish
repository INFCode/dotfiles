function mkvenv
    set -l venv_path (test -n "$argv[1]"; and echo $argv[1]; or echo ".venv")
    set -l python_version $argv[2]

    set -l cmd uv venv $venv_path
    if test -n "$python_version"
        set cmd $cmd --python $python_version
    end

    echo "Creating venv: $cmd"
    $cmd || return 1

    source "$venv_path/bin/activate.fish"

    echo "Running ensurepip..."
    python -m ensurepip --upgrade || return 1

    if not test -e "$venv_path/bin/pip"
        echo "Linking: pip -> pip3..."
        ln -s pip3 $venv_path/bin/pip
    end

    deactivate

    echo "Done!"
end

