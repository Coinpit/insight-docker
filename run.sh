#!/bin/bash

if [ -z $INSIGHT_DATA ]
then
  INSIGHT_DATA=/var/lib/insight
fi

if [ -z $NETWORK ]
then
    NETWORK=livenet
fi

for net in livenet testnet
do
  if [ ! -d ${INSIGHT_DATA}/$net ]
    cp -r /opt/insight/$net ${INSIGHT_DATA}
    cp -r /opt/insight/node_modules ${INSIGHT_DATA}/$net
  fi
done

cd $INSIGHT_DATA}/${NETWORK}
bitcore-node start

bash
