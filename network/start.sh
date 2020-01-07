#!/bin/bash
#
# Copyright IBM Corp All Rights Reserved
#
# SPDX-License-Identifier: Apache-2.0
#
# Exit on first error, print all commands.
set -ev

# load environment variables
export MSYS_NO_PATHCONV=1
source ./.env
export KZS_CA_PRIVATE_KEY=$(cd crypto-config/peerOrganizations/lab.kaizen-solutions.net/ca && ls *_sk)

docker network create chocoblastchain || true

docker-compose -f docker-compose.yaml down

docker-compose -f docker-compose.yaml up -d lab-ca orderer.kaizen-solutions.net peer0.lab.kaizen-solutions.net peer1.lab.kaizen-solutions.net cli
docker ps -a

# wait for Hyperledger Fabric to start
# incase of errors when running later commands, issue export FABRIC_START_TIMEOUT=<larger number>
sleep $FABRIC_START_TIMEOUT

# Create the channel
docker exec \
	-e CORE_PEER_ADDRESS=peer0.lab.kaizen-solutions.net:7051 \
	cli \
	peer channel create \
		-o orderer.kaizen-solutions.net:7050 \
		-c $CHANNEL_NAME \
		-f /opt/gopath/src/github.com/hyperledger/fabric/peer/channel-artifacts/channel.tx \
		--tls $CORE_PEER_TLS_ENABLED \
		--cafile $ORDERER_CA
		
# Join peer0.lab.kaizen-solutions.net to the channel
docker exec \
	-e CORE_PEER_ADDRESS=peer0.lab.kaizen-solutions.net:7051 \
	cli \
	peer channel join \
		-b kaizenchannel.block 
		
# Join peer1.lab.kaizen-solutions.net to the channel
docker exec \
	-e CORE_PEER_ADDRESS=peer1.lab.kaizen-solutions.net:8051 \
	cli \
	peer channel join \
		-b kaizenchannel.block
