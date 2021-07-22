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
#RUN yum --disableplugin=subscription-manager repolist
#RUN yum --disableplugin=subscription-manager install -y yum-utils
#RUN yum-config-manager --disableplugin=subscription-manager --enable cecc-rhel8.3-ppc64le-baseos
#RUN yum --disableplugin=subscription-manager install numactl-devel
#RUN yum --disableplugin=subscription-manager clean all

# Copy entitlements
COPY /etc/pki/entitlement /etc/pki/entitlement
# Copy subscription manager configurations
COPY /etc/rhsm /etc/rhsm
#COPY /rhsm/ca /etc/rhsm/ca
# Delete /etc/rhsm-host to use entitlements from the build container
#RUN #rm /etc/rhsm-host && \
RUN yum --disableplugin=subscription-manager repolist --disablerepo=* && \
    subscription-manager repos --enable cecc-rhel8.3-ppc64le-baseos && \
    yum --disableplugin=subscription-manager -y update && \
    yum --disableplugin=subscription-manager -y install numactl-devel && \
    # Remove entitlements and Subscription Manager configs
    rm -rf /etc/pki/entitlement && \
    rm -rf /etc/rhsm
COPY . /usr/src/app
RUN npm install --unsafe-perm
RUN chown -R 1001:0 /usr/src/app
USER 1001
CMD ["npm", "start"]
# EXPOSE 3001
