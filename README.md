# KZS-Chocoblast-Chain
Installation guide for the Kaizen Hyperledger Fabric

## Hyperledger Fabric installation

_TODO_

## Network configuration

1. __Create file ``crypto-config.yaml`` :__ Definition of the global organization
2. __Create file ``configtx.yaml`` :__ Configuration of the organization
3. __Create file ``.env`` :__ Configuration of environment variables such as ``IMAGE_TAG=1.4.3``

__REMEMBER__

* To change the name of the ``FABRIC_CA_SERVER_TLS_KEYFILE`` using the generated name under ``crypto-config/peerOrganizations/lab.kaizen-solutions.net/ca/`` (ex: 31bd33998ce74f094307f082eb5578f5e77d618039d4967d26a09c754de5631f_sk)

* And in the ``command`` as well.

## Network initialization

### Generate network cryptographic material
````bash
cryptogen generate --config=./crypto-config.yaml
````

### Generate channel artifacts
````bash
mkdir channel-artifacts
configtxgen -profile KaizenOrdererGenesis -outputBlock ./channel-artifacts/genesis.block -channelID kaizenchannel
configtxgen -profile KaizenChannel -outputCreateChannelTx ./channel-artifacts/channel.tx -channelID kaizenchannel
configtxgen -profile KaizenChannel -outputAnchorPeersUpdate ./channel-artifacts/LabOrgMSPanchors.tx -channelID kaizenchannel -asOrg LabOrgMSP
````

## Launch the network

The file ``docker-compose-e2e.yaml`` is used to launch the whole network on one machine :

````bash
docker-compose -f docker-compose-e2e.yaml up -d
````


