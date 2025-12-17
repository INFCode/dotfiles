function proxy_socks
    set -lx all_proxy socks5://127.0.0.1:10808
    set -lx ALL_PROXY $all_proxy

    eval $argv
end
