function pyact
    set -l dir (pwd)
    while test "$dir" != "/"
        for name in .venv .*env* venv *env*
            set -l candidate "$dir/$name/bin/activate.fish"
            if test -f "$candidate"
                echo "Activating: $dir/$name"
                source "$candidate"
                return 0
            end
        end
        set dir (dirname "$dir")
    end

    echo "No virtual environment found" >&2
    return 1
end

