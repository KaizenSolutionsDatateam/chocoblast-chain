#!/bin/bash
#
# Copyright IBM Corp All Rights Reserved
#
# SPDX-License-Identifier: Apache-2.0
#
# Exit on first error, print all commands.
set -ev

source ./.env
export KZS_CA_PRIVATE_KEY=$(cd crypto-config/peerOrganizations/lab.kaizen-solutions.net/ca && ls *_sk)

# Shut down the Docker containers that might be currently running.
docker-compose -f docker-compose.yaml stop
