function czcd --wraps=cd --description 'the real `chezmoi cd`'
    cd $(chezmoi source-path)
end
