function proxy_http 
    set -lx http_proxy  http://127.0.0.1:10808
    set -lx https_proxy http://127.0.0.1:10808
    set -lx HTTP_PROXY  $http_proxy
    set -lx HTTPS_PROXY $https_proxy
    eval $argv
end

