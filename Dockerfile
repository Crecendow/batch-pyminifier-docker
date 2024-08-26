# 使用最新的 Python 镜像作为基础镜像
FROM python:latest AS builder

# 添加项目文件到容器中
ADD ./test /test
ADD obfuscate_files.sh /obfuscate_files.sh

# 设置时区和字符编码
ENV TimeZone=Asia/Shanghai
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
RUN ln -snf /usr/share/zoneinfo/$TimeZone /etc/localtime && echo $TimeZone > /etc/timezone

# 安装 pyminifier
RUN pip install pyminifier

# 给脚本赋权
RUN chmod u+x /obfuscate_files.sh

# 设置工作目录
WORKDIR /

# 执行混淆脚本
RUN bash obfuscate_files.sh

# 暴露端口
EXPOSE 19901

# 设置启动脚本
CMD ["bash"]
