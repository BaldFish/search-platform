 # 指定我们的基础镜像是node，版本是v8.0.0
 FROM node:latest
 # 指定制作我们的镜像的联系人信息（镜像创建者）
 MAINTAINER EOI
 
 # 将根目录下的文件都copy到container（运行此镜像的容器）文件系统的app文件夹下
 ADD . /app/
 # cd到app文件夹下
 WORKDIR /app
 
 # 安装项目依赖包
 RUN npm install
 RUN npm run build
 
 # 容器对外暴露的端口号
 EXPOSE 5000
 
 # 容器启动时执行的命令，类似npm run dev
 CMD ["npm", "start"]