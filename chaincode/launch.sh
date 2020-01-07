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

docker exec \
  -e CORE_PEER_ADDRESS=peer0.lab.kaizen-solutions.net:7051 \
  cli \
   peer chaincode query \
	-C $CHANNEL_NAME \
	-n chocoblastcc \
	-c '{"Args":["query","a"]}'

SLEEP 3s

docker exec \
  -e CORE_PEER_ADDRESS=peer0.lab.kaizen-solutions.net:7051 \
  cli \
   peer chaincode invoke \
	-C $CHANNEL_NAME \
	-n chocoblastcc \
	-c '{"Args":["invoke","a","b","10"]}'\
	--tls $CORE_PEER_TLS_ENABLED \
	--cafile $ORDERER_CA

SLEEP 3s
   
docker exec \
  -e CORE_PEER_ADDRESS=peer0.lab.kaizen-solutions.net:7051 \
  cli \
   peer chaincode query \
	-C $CHANNEL_NAME \
	-n chocoblastcc \
	-c '{"Args":["query","a"]}'