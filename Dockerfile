FROM ubi8/nodejs-14
ENV https_proxy http://10.3.0.3:3128
ENV http_proxy http://10.3.0.3:3128
WORKDIR /usr/src/app
USER 0
RUN yum repolist
RUN yum install numactl-devel
COPY . /usr/src/app
RUN npm install
RUN chown -R 1001:0 /usr/src/app
USER 1001
CMD ["npm", "start"]
# EXPOSE 3001
