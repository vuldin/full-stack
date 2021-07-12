FROM registry.redhat.io/rhel8/nodejs-14
ENV https_proxy http://10.3.0.3:3128
ENV http_proxy http://10.3.0.3:3128
WORKDIR /usr/src/app

USER 0
RUN yum install sudo -y

RUN sudo yum update
# RUN dnf install gcc

RUN sudo yum install unixODBC unixODBC-devel
RUN npm install odbc


# RUN sudo yum install devtoolset-8
# RUN scl enable devtoolset-8 bash
# RUN sudo yum install libnuma-dev

COPY . /usr/src/app
RUN chown -R 1001:0 /usr/src/app
# RUN npm install
USER 1001
CMD ["npm", "start"]
EXPOSE 3000
