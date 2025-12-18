#!/usr/bin/env python3
import json

def main():
    result = {
        "use_neovim": False,
        "email": "INFCode@163.com",
        "user": "INFCode"
    }
    
    # 输出 JSON 字符串到 stdout
    print(json.dumps(result))

if __name__ == "__main__":
    main()

