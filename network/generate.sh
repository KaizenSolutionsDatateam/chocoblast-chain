#!/bin/sh
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

# remove previous crypto material and config transactions
rm -fr channel-artifacts/*
rm -fr crypto-config/*

# generate crypto material
cryptogen generate --config=./crypto-config.yaml
if [ "$?" -ne 0 ]; then
  echo "Failed to generate crypto material..."
  exit 1
fi

# generate genesis block for orderer
configtxgen -profile KaizenOrdererGenesis -outputBlock ./channel-artifacts/genesis.block -channelID $CHANNEL_NAME_GENESIS
if [ "$?" -ne 0 ]; then
  echo "Failed to generate orderer genesis block..."
  exit 1
fi

# generate channel configuration transaction
configtxgen -profile KaizenChannel -outputCreateChannelTx ./channel-artifacts/channel.tx -channelID $CHANNEL_NAME
if [ "$?" -ne 0 ]; then
  echo "Failed to generate channel configuration transaction..."
  exit 1
fi

# generate anchor peer transaction
configtxgen -profile KaizenChannel -outputAnchorPeersUpdate ./channel-artifacts/LabOrgMSPanchors.tx -channelID $CHANNEL_NAME -asOrg LabOrgMSP
if [ "$?" -ne 0 ]; then
  echo "Failed to generate anchor peer update for Org1MSP..."
  exit 1
fi

