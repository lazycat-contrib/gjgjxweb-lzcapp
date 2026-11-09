# syntax=docker/dockerfile:1
# 搞机工具箱 Web：纯静态站 + 上游极简 node http 静态服务器。
# 上游无 Dockerfile/镜像，源码内嵌构建（server.cjs 默认绑 127.0.0.1，
# 容器内必须监听 0.0.0.0 才能被平台入口反代到）。
FROM node:22-alpine
WORKDIR /app
COPY . /app
ENV PORT=8080
# server.cjs 监听 127.0.0.1，加一个 sed 在容器内改为 0.0.0.0（不改上游文件语义）
RUN sed -i "s/server.listen(port,.127.0.0.1./server.listen(port,\x270.0.0.0\x27/" /app/server.cjs \
  && grep -q "0.0.0.0" /app/server.cjs
EXPOSE 8080
CMD ["node", "server.cjs"]
