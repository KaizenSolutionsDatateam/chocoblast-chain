#!/bin/bash

# Print all commands.
set -v

docker container rm orderer.kaizen-solutions.net peer0.lab.kaizen-solutions.net peer1.lab.kaizen-solutions.net cli ca_peerLabOrg

docker volume rm kzs_orderer.kaizen-solutions.net kzs_peer0.lab.kaizen-solutions.net  kzs_peer1.lab.kaizen-solutions.net

docker network disconnect --force chocoblastchain chocoblastcc

docker network rm chocoblastchain