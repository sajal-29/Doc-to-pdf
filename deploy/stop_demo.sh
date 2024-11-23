#!/bin/bash

# Define colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Function to print a line separator
print_line() {
  echo -e "${CYAN}===========================================${NC}"
}

# Stop and remove a container
cleanup_containers() {
  local container=$1
  if [ "$(docker ps -q -f name=$container)" ]; then
    echo -e "${YELLOW}Stopping container: ${container}${NC}"
    docker stop "$container"
  fi
  if [ "$(docker ps -aq -f name=$container)" ]; then
    echo -e "${YELLOW}Removing container: ${container}${NC}"
    docker rm "$container"
  fi
}

# Remove a Docker network
cleanup_network() {
  local network=$1
  if [ "$(docker network ls -q -f name=$network)" ]; then
    echo -e "${YELLOW}Removing network: ${network}${NC}"
    docker network rm $network
    if [ $? -eq 0 ]; then
      echo -e "${GREEN}Network '${network}' removed successfully.${NC}"
    else
      echo -e "${RED}Failed to remove network '${network}'!${NC}"
    fi
  else
    echo -e "${GREEN}Network '${network}' does not exist.${NC}"
  fi
}

# Print header
print_line
echo -e "${BLUE}Stopping and Cleaning Demo Environment${NC}"
print_line

# Stop and remove containers
cleanup_containers "rabbit-broker"
cleanup_containers "backend"

# Remove Docker network
NETWORK_NAME="demo-network"
cleanup_network $NETWORK_NAME

# Final message
print_line
echo -e "${GREEN}Demo environment cleanup complete!${NC}"
print_line
