FROM registry.redhat.io/rhel8/nodejs-14
ENV https_proxy http://10.3.0.3:3128
ENV http_proxy http://10.3.0.3:3128
WORKDIR /usr/src/app

USER 0
RUN apt-get update \
 && apt-get install -y sudo
# RUN yum-config-manager --enable rhel-server-rhscl-7-rpms
RUN yum install devtoolset-8
RUN scl enable devtoolset-8 bash
RUN yum install libnuma-dev
COPY . /usr/src/app
RUN chown -R 1001:0 /usr/src/app
RUN npm install

USER 1001
CMD ["npm", "start"]
EXPOSE 3000
