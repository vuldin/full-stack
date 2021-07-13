FROM registry.redhat.io/rhscl/nodejs-14-rhel7
ENV https_proxy http://10.3.0.3:3128
ENV http_proxy http://10.3.0.3:3128
WORKDIR /usr/src/app

USER 0
RUN yum install sudo -y
RUN sudo yum update
RUN dnf install gcc
RUN yes | dnf install python2
# RUN sudo yum install numactl
RUN cat /etc/yum.conf
RUN cat /etc/yum.repos.d/redhat.repo



# RUN sudo subscription-manager list --available
# RUN sudo subscription-manager repos --enable codeready-builder-for-rhel-8-x86_64-rpms
# RUN sudo yum repolist


COPY . /usr/src/app
RUN npm install --unsafe-perm ibm_db
RUN npm install
RUN chown -R 1001:0 /usr/src/app
USER 1001
CMD ["npm", "start"]
EXPOSE 3000
