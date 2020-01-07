#!/bin/bash
#
# Copyright IBM Corp All Rights Reserved
#
# SPDX-License-Identifier: Apache-2.0
#
# Exit on first error, print all commands.
set -ev

docker exec peer0.lab.kaizen-solutions.net sh -c 'rm -rf /var/hyperledger/production/chaincodes/chocoblastcc.1.0'
docker exec peer1.lab.kaizen-solutions.net sh -c 'rm -rf /var/hyperledger/production/chaincodes/chocoblastcc.1.0'

docker container stop chocoblastcc

docker container rm chocoblastcc

docker rmi $(docker images chocoblastcc -q)