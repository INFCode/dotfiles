set --query _fisher_path_initialized && exit
set --global _fisher_path_initialized

if test -z "$fisher_path" || test "$fisher_path" = "$__fish_config_dir"
    exit
end

set fish_complete_path $fish_complete_path[1] $fisher_path/completions $fish_complete_path[2..]
set fish_function_path $fish_function_path[1] $fisher_path/functions $fish_function_path[2..]

# ensure fisher is installed
if not functions -q fisher && not set -q _fisher_is_installing
    echo "Fisher not found, installing..."
    
    # no recursive fisher check when fisher is installing
    set -gx _fisher_is_installing 1
    
    curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher update
    
    set -e _fisher_is_installing
end

for file in $fisher_path/conf.d/*.fish
    if ! test -f (string replace --regex "^.*/" $__fish_config_dir/conf.d/ -- $file)
        and test -f $file && test -r $file
        source $file
    end
end
