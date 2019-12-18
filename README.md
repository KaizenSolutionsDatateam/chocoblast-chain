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

Navigate to the ``network/`` folder (``cd network``).

If a configuration has already been launched, execute stop & clean scripts: 

````bash
./stop.sh
./clean.sh
````

### Generate channel artifacts
````bash
./generate.sh
````

## Create & join channel
````bash
./start.sh
````

----

## Chaincodes

Navigate to the ``chaincode/`` folder (``cd chaincode``).

If a configuration has already been launched, execute clean script: 

````bash
./clean.sh
````

### 1. Install & Instantiate chaincode

````bash
./install.sh
````


### 2. Execute sample queries on chaincode

````bash
./launch.sh
````
