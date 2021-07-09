
FROM registry.redhat.io/rhel8/nodejs-12

ENV https_proxy http://10.3.0.3:3128
ENV http_proxy http://10.3.0.3:3128

WORKDIR /usr/src/app
USER 0
COPY . /usr/src/app
RUN chown -R 1001:0 /usr/src/app
USER 1001
CMD ["npm", "install"]
CMD ["npm", "start"]

EXPOSE 3000
