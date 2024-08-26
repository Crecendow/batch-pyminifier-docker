#!/bin/bash

# 定义要遍历的目录
DIRECTORY="./test"

/usr/local/python/bin/pyminifier --version

# 遍历目录中的所有 .py 文件
for file in $(find "$DIRECTORY" -type f -name "*.py")
do
    # 打印当前处理的文件
    echo "Processing $file"

    # 使用 pyminifier 对当前文件进行加密，并将输出暂存到临时文件
    /usr/local/python/bin/pyminifier --nonlatin --replacement-length=10 "$file" > "${file}.temp"

    # 检查 pyminifier 是否成功执行
    if [ $? -eq 0 ]; then
        # 删除最后一行注释
        sed -i '$d' "${file}.temp"

        # 用临时文件替换原文件
        mv "${file}.temp" "$file"

        echo "$file has been obfuscated, cleaned, and replaced successfully."
    else
        # 如果加密失败，删除临时文件
        rm -f "${file}.temp"
        echo "Failed to obfuscate $file. No changes made."
    fi
done