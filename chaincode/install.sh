#!/bin/bash
#
# Copyright IBM Corp All Rights Reserved
#
# SPDX-License-Identifier: Apache-2.0
#
# Exit on first error, print all commands.
set -ev

# don't rewrite paths for Windows Git Bash users
export MSYS_NO_PATHCONV=1
source ../network/.env

docker-compose -f docker-compose.yaml down

docker-compose -f docker-compose.yaml up -d chocoblastcc
docker ps -a

# wait for Hyperledger Fabric to start
# incase of errors when running later commands, issue export FABRIC_START_TIMEOUT=<larger number>
sleep $FABRIC_START_TIMEOUT

# Install chaincode on peer0
docker exec \
  -e CORE_PEER_ADDRESS=peer0.lab.kaizen-solutions.net:7051 \
  cli \
  peer chaincode install \
    -n chocoblastcc \
    -v 1.0 \
    -p /opt/gopath/src/github.com/chaincode \
    -l node

# Install chaincode on peer1
docker exec \
  -e CORE_PEER_ADDRESS=peer1.lab.kaizen-solutions.net:8051 \
  cli \
  peer chaincode install \
    -n chocoblastcc \
    -v 1.0 \
    -p /opt/gopath/src/github.com/chaincode \
    -l node

# Instantiate chaincode on kaizenchannel
docker exec \
  cli \
  peer chaincode instantiate \
    -o orderer.kaizen-solutions.net:7050 \
    -C $CHANNEL_NAME \
    -n chocoblastcc \
    -l node \
    -v 1.0 \
    -c '{"Args":["init","a","100","b","200"]}' \
    -P "AND('LabOrgMSP.member')" \
	--tls $CORE_PEER_TLS_ENABLED \
	--cafile $ORDERER_CA
