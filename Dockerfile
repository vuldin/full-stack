FROM registry.redhat.io/rhscl/nodejs-14-rhel7
ENV https_proxy http://10.3.0.3:3128
ENV http_proxy http://10.3.0.3:3128
WORKDIR /usr/src/app

USER 0
RUN yum install sudo -y
RUN yum update
# RUN yum install -y make gcc gcc-c++ kernel-devel openssl-devel bzip2-devel python2
RUN yum repolist
RUN yum-config-manager --enable ubi-7-server-for-power-le-devtools-rpms && \
    yum-config-manager --enable ubi-7-for-power-le-extras-rpms && \
    yum-config-manager --enable rhel-7-for-power-le-rpms > /dev/null
RUN yum update
RUN yum repolist all
RUN yum install numactl-devel
RUN echo updated


# RUN sudo subscription-manager list --available
# RUN sudo subscription-manager repos --enable codeready-builder-for-rhel-8-x86_64-rpms
# RUN sudo yum repolist


COPY . /usr/src/app
# RUN npm install --unsafe-perm ibm_db
RUN npm install
RUN chown -R 1001:0 /usr/src/app
USER 1001
CMD ["npm", "start"]
# EXPOSE 3000
