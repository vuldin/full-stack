FROM registry.redhat.io/rhscl/nodejs-14-rhel7
ENV https_proxy http://10.3.0.3:3128
ENV http_proxy http://10.3.0.3:3128
WORKDIR /usr/src/app

USER 0
RUN yum install sudo -y
RUN adduser docker
RUN yum list available gcc-toolset-N-\*
# RUN sudo yum-config-manager --enable rhel-server-rhscl-7-rpms
# RUN sudo subscription-manager repos --enable rhel-7-server-devtools-rpms 
# RUN sudo subscription-manager repos --enable rhel-7-server-extras-rpms
# RUN sudo subscription-manager repos --enable rhel-7-server-optional-rpms
# RUN sudo subscription-manager repos --enable rhel-server-rhscl-7-rpms
RUN sudo yum update
RUN sudo yum install devtoolset-8
RUN scl enable devtoolset-8 bash
RUN sudo yum install libnuma-dev
COPY . /usr/src/app
RUN chown -R 1001:0 /usr/src/app
RUN npm install

USER docker
CMD ["npm", "start"]
EXPOSE 3000
