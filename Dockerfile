FROM registry.access.redhat.com/ubi8/nodejs-14
#ENV https_proxy http://10.3.0.3:3128
#ENV http_proxy http://10.3.0.3:3128
WORKDIR /usr/src/app
USER 0
#RUN yum repolist
#RUN yum --disablerepo=* --enablerepo=rhel-8-for-ppc64le-baseos-rpms install yum-utils
#RUN yum install --enablerepo=rhel-8-for-ppc64le-baseos-rpms numactl-devel
#RUN yum-config-manager --enable rhel-8-for-ppc64le-baseos-rpms
#RUN yum install --disableplugin=subscription-manager --enablerepo=rhel-8-for-ppc64le-baseos-rpms numactl-devel
#RUN yum --disableplugin=subscription-manager clean all
COPY . /usr/src/app
RUN npm install
RUN chown -R 1001:0 /usr/src/app
USER 1001
CMD ["npm", "start"]
# EXPOSE 3001
