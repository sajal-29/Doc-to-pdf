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

# Stop and remove existing containers if they exist
cleanup_containers() {
  local container=$1
  if [ "$(docker ps -q -f name=$container)" ]; then
    echo -e "${YELLOW}Stopping container: ${container}${NC}"
    docker stop $container
  fi
  if [ "$(docker ps -aq -f name=$container)" ]; then
    echo -e "${YELLOW}Removing container: ${container}${NC}"
    docker rm $container
  fi
}

# Check and create a custom network
setup_network() {
  local network=$1
  if [ ! "$(docker network ls -q -f name=$network)" ]; then
    echo -e "${YELLOW}Creating custom Docker network: ${network}${NC}"
    docker network create $network
    if [ $? -eq 0 ]; then
      echo -e "${GREEN}Network '${network}' created successfully.${NC}"
    else
      echo -e "${RED}Failed to create network '${network}'!${NC}"
      exit 1
    fi
  else
    echo -e "${GREEN}Network '${network}' already exists.${NC}"
  fi
}

# Print header
print_line
echo -e "${BLUE}Starting Demo Environment Setup${NC}"
print_line

# Cleanup existing containers
echo -e "${YELLOW}Checking and cleaning up existing containers...${NC}"
cleanup_containers "rabbit-broker"
cleanup_containers "backend"

# Setup custom Docker network
NETWORK_NAME="demo-network"
setup_network $NETWORK_NAME

# Run RabbitMQ container
print_line
echo -e "${GREEN}Starting RabbitMQ container...${NC}"
docker run -d --name rabbit-broker --hostname rabbit-broker \
  --network $NETWORK_NAME \
  -p 5672:5672 -p 15672:15672 \
  rabbitmq:management
if [ $? -eq 0 ]; then
  echo -e "${GREEN}RabbitMQ is running. Management UI available at http://localhost:15672${NC}"
else
  echo -e "${RED}Failed to start RabbitMQ container!${NC}"
  exit 1
fi

# Run backend container
print_line
echo -e "${GREEN}Starting Backend container...${NC}"
docker run -d --name backend \
  --network $NETWORK_NAME \
  -p 8080:8080 \
  -e SPRING_RABBITMQ_HOST=rabbit-broker \
  sajal29/converter-backend:latest
if [ $? -eq 0 ]; then
  echo -e "${GREEN}Backend is running. API available at http://localhost:8080/api${NC}"
else
  echo -e "${RED}Failed to start Backend container!${NC}"
  exit 1
fi

# Print final message
print_line
echo -e "${BLUE}Demo setup complete!${NC}"
echo -e "${CYAN}RabbitMQ Management UI: ${GREEN}http://localhost:15672${NC}"
echo -e "${CYAN}Backend API: ${GREEN}http://localhost:8080/api${NC}"
print_line
