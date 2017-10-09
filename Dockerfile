FROM coinpit/nodejs:v8

ENV TESTNET livenet
ENV USER root
WORKDIR /opt/insight

RUN apt-get update \
    && apt-get install -y wget \
    && apt-get autoremove -y \
    && apt-get clean -y \
    && apt-get autoclean -y \
    && apt-get install libtool pkg-config build-essential autoconf automake -y \
    && apt-get install software-properties-common -y \
    && add-apt-repository ppa:chris-lea/zeromq \
    && apt-get update \
    && apt-get install libzmq3-dev -y \
    && npm install -g https://github.com/bitpay/bitcore-node

ADD . /opt/insight

#create livenet insight
RUN cd /opt/insight \
    && bitcore-node create livenet \
    && cd livenet \
    && bitcore-node install insight-api \
    && bitcore-node install insight-ui \
    && mv node_modules ..

#create testnet insight
RUN cd /opt/insight \
    && bitcore-node create -t testnet \
    && cd testnet \
    && bitcore-node install insight-api \
    && bitcore-node install insight-ui \
    && rm -rf node_modules

RUN rm -rf /var/lib/apt/lists/*


VOLUME /var/lib/insight

RUN chmod 755 run.sh

EXPOSE 3001
CMD ./run.sh
