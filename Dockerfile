FROM google/golang:1.4
MAINTAINER Acaleph <admin@acale.ph>

ENV CONSUL_VERSION 0.5.2
RUN apt-get install unzip -y
ADD "https://dl.bintray.com/mitchellh/consul/${CONSUL_VERSION}_linux_amd64.zip" /tmp/consul.zip
RUN cd /bin && unzip /tmp/consul.zip && chmod +x /bin/consul && rm /tmp/consul.zip

WORKDIR /gopath/src/consul-alerts
ADD . /gopath/src/consul-alerts
RUN go get consul-alerts

EXPOSE 9000
CMD []
ENTRYPOINT [ "/gopath/bin/consul-alerts", "--alert-addr=0.0.0.0:9000", "start", "--consul-addr=consul:8500", "--watch-checks" ]
