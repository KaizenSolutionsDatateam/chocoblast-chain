# KZS-Chocoblastchain

The KZS-Chocoblastchain is a prototype of a private blockchain dedicated to keeping score of who has been [chocoblasted](http://www.chocoblast.fr/) within a company and validating the fulfilment of one's duty via Smart Contracts.

It is based on [Hyperledger Fabric](https://hyperledger-fabric.readthedocs.io/en/latest/blockchain.html).


## Hyperledger Fabric installation

[Prerequisites](https://hyperledger-fabric.readthedocs.io/en/latest/prereqs.html)

[Samples, Binaries and Docker Images](https://hyperledger-fabric.readthedocs.io/en/latest/install.html)

````bash
curl -sSL http://bit.ly/2ysbOFE | bash -s
````

## Network configuration

1. __Create file ``crypto-config.yaml`` :__ Definition of the global organization
2. __Create file ``configtx.yaml`` :__ Configuration of the organization
3. __Create file ``.env`` :__ Configuration of environment variables such as ``IMAGE_TAG=1.4.3``

## Network initialization

Navigate to the ``network/`` folder (``cd network``).

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

Sample ``.env`` file:

````dotenv
IMAGE_TAG=1.4.3
FABRIC_CA_SERVER_TLS_KEYFILE=6b386ec770eaa4ff65ef703851009558ed957b8beb03523a8e4426509d95150d_sk
COMPOSE_PROJECT_NAME=kzs
CHAINCODE_DEV=true
````

You need to replace the ``FABRIC_CA_SERVER_TLS_KEYFILE`` value by __the name of the file__ under ``/network/crypto-config/peerOrganizations/lab.kaizen-solutions.net/ca/``

----

Then the file ``docker-compose.yaml`` is used to launch the whole network on one machine :

````bash
docker-compose -f docker-compose.yaml up -d
````

## Chaincodes

https://hyperledger-fabric.readthedocs.io/en/release-1.4/chaincode4ade.html

Navigate to the ``chaincode/`` folder (``cd chaincode``).

### 1. Create & Join channel



### 2. Run the chaincode

````bash
docker cp ./chaincode.js peer0.lab.kaizen-solutions.net:/opt/gopath/src/github.com/hyperledger/fabric/peer/
docker exec -it peer0.lab.kaizen-solutions.net bash
peer chaincode install -n chocoblastcc -v 1.0 -l node -p /opt/gopath/src/github.com/hyperledger/fabric/peer/

docker-compose up --build -d
docker exec -it chocoblastcc bash
CORE_CHAINCODE_ID_NAME="chocoblastcc:v0" node chaincode.js --peer.address peer0.lab.kaizen-solutions.net:7051
````
