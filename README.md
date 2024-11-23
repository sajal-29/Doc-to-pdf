# DOCX to PDF Converter (Spring Boot Application)

## Project Overview

The **DOCX to PDF Converter** is a Spring Boot-based application designed to convert Microsoft Word documents (DOCX) into PDF format. It employs a microservice architecture with RabbitMQ as the communication broker, ensuring asynchronous and scalable processing.

---

## Microservice Architecture 

[![](https://mermaid.ink/img/pako:eNqVVO9vmzAQ_VcsV6paiaC02dqGSpNWTKZNqpY1rTYN8sGBI7AQnNkm6VT6v8_YBo1kv8qXO9vP73jvDp5wzBLAHk4LtoszyiW6JxGPSqQev8ihlCehifPTdv9hUzCahJO8AJujGfBtHsO8hcwk43QJ4YkG2dVpd_ypggrC8BaEUPtmOe9OPzO-Ah6acEBNWPw4TdKwifdMZYe1qaxE-IEtbHpA8a9oBKPB4E195lqFTTnUqKmt5r4bGnzuNkoBkY_-l7pV_RvcyH0HJXAqAX1ji_cJOkZB-b0xoTZe9HzSV165U85i5RdSumprUd8wjXvt3oHkOWz_8Ba_QC9cn5VbUC2_A1VcyLr1ds9qjb602qZk8jfSK-VX0ggz1tc29nujkWPq-hnEqw5pXN-bIANduITtSu2frt-HtjEuqBAEUiRMv1GaF4V3NB4GwXjoCMnZCryj0Whk88EuT2TmnW8erw8pbHlDMZncXPhnL6TQDbUEV5d-ENy8kCA2Y2gYCHk7JOT_GHpMdvAc0yTH9tSxnbBW9Yt35lsX9k71VDpqHpMqVozNFJktlYlqrSZBS9-7ZT8qI-oaO1gB1zRP1M_nqcFFWGawhgh7Kk0gpVUhIxyVzwpKK8lmP8oYe5KrOpizaplhL6WFUKtKTxzJ6ZLTdbe7oeVXxtr180_dVqW5?type=png)](https://mermaid.live/edit#pako:eNqVVO9vmzAQ_VcsV6paiaC02dqGSpNWTKZNqpY1rTYN8sGBI7AQnNkm6VT6v8_YBo1kv8qXO9vP73jvDp5wzBLAHk4LtoszyiW6JxGPSqQev8ihlCehifPTdv9hUzCahJO8AJujGfBtHsO8hcwk43QJ4YkG2dVpd_ypggrC8BaEUPtmOe9OPzO-Ah6acEBNWPw4TdKwifdMZYe1qaxE-IEtbHpA8a9oBKPB4E195lqFTTnUqKmt5r4bGnzuNkoBkY_-l7pV_RvcyH0HJXAqAX1ji_cJOkZB-b0xoTZe9HzSV165U85i5RdSumprUd8wjXvt3oHkOWz_8Ba_QC9cn5VbUC2_A1VcyLr1ds9qjb602qZk8jfSK-VX0ggz1tc29nujkWPq-hnEqw5pXN-bIANduITtSu2frt-HtjEuqBAEUiRMv1GaF4V3NB4GwXjoCMnZCryj0Whk88EuT2TmnW8erw8pbHlDMZncXPhnL6TQDbUEV5d-ENy8kCA2Y2gYCHk7JOT_GHpMdvAc0yTH9tSxnbBW9Yt35lsX9k71VDpqHpMqVozNFJktlYlqrSZBS9-7ZT8qI-oaO1gB1zRP1M_nqcFFWGawhgh7Kk0gpVUhIxyVzwpKK8lmP8oYe5KrOpizaplhL6WFUKtKTxzJ6ZLTdbe7oeVXxtr180_dVqW5)

---

## Server Architecture 

[![](https://mermaid.ink/img/pako:eNqVVGFvmzAQ_SsWVadWIihttrah0qQVkmmTqqVJp02DfDBwBBaCM9sknUr_-4xtGA1UW_3FZ_z8fHfvmUcjJBEYthFnZB8mmHJ07_rUz5EYx8fIyVLI-Ymn5uVpa-vrNiM48qZpBjpGC6C7NIRlC7XghOIVeCcSp1enbcRdAQV43i0wJrbUctkGfCN0DdRTU98dLgkfZlHsVfM9EVFvHpgXzPtMAh0-I6qBrAhWFG8TNMdBkPLbu3qjGjNKoiIUmdRBJ5dqOCTfqZJCEQFlKcmtX7KoAxgrNoKsDnrJmpsGg_d_meuVPFfDIY_q8KW50bMiKM8srVrVNlTJU2odOyJL_LlVqQfI_eJ8L2sl-6Ej6yPkQDEH9JMEnyL0Bk1y2YNS6Xsovzz11hLlhsIGSKhUatk7PpDQd9YcOE1h93I6LfSF5UgpOJqDyILxsrZM10TywKUudeZO_0F9JZoYVXUqU5V67hhPgsfYchII1w1YqdF9LQodWC7Z57KpMpHn6NapMMOMuRAjpiyE4jTL7KPxcDIZD03GKVmDfTQajXQ82KcRT-zz7cN1L4tOQrFMpzcXztnrWaTcmuPq0plMbl7PESq3KhLX_TB03f8jOSTT5jSVcqbW2tTa6LZ1Umjk0B3pAqR5zfqVms0LNZtXLdvQPajfoSrw2jANgd3gNBJ_4scK6hs8gQ34hi3CCGJcZNw3_PxJQHHByeJ3Hho2p-Iqg5JilRh2jDMmVoX0o5ti8SPbNF-3OP9BSL1--gMUPPEB?type=png)](https://mermaid.live/edit#pako:eNqVVGFvmzAQ_SsWVadWIihttrah0qQVkmmTqqVJp02DfDBwBBaCM9sknUr_-4xtGA1UW_3FZ_z8fHfvmUcjJBEYthFnZB8mmHJ07_rUz5EYx8fIyVLI-Ymn5uVpa-vrNiM48qZpBjpGC6C7NIRlC7XghOIVeCcSp1enbcRdAQV43i0wJrbUctkGfCN0DdRTU98dLgkfZlHsVfM9EVFvHpgXzPtMAh0-I6qBrAhWFG8TNMdBkPLbu3qjGjNKoiIUmdRBJ5dqOCTfqZJCEQFlKcmtX7KoAxgrNoKsDnrJmpsGg_d_meuVPFfDIY_q8KW50bMiKM8srVrVNlTJU2odOyJL_LlVqQfI_eJ8L2sl-6Ej6yPkQDEH9JMEnyL0Bk1y2YNS6Xsovzz11hLlhsIGSKhUatk7PpDQd9YcOE1h93I6LfSF5UgpOJqDyILxsrZM10TywKUudeZO_0F9JZoYVXUqU5V67hhPgsfYchII1w1YqdF9LQodWC7Z57KpMpHn6NapMMOMuRAjpiyE4jTL7KPxcDIZD03GKVmDfTQajXQ82KcRT-zz7cN1L4tOQrFMpzcXztnrWaTcmuPq0plMbl7PESq3KhLX_TB03f8jOSTT5jSVcqbW2tTa6LZ1Umjk0B3pAqR5zfqVms0LNZtXLdvQPajfoSrw2jANgd3gNBJ_4scK6hs8gQ34hi3CCGJcZNw3_PxJQHHByeJ3Hho2p-Iqg5JilRh2jDMmVoX0o5ti8SPbNF-3OP9BSL1--gMUPPEB)

---

## Features

1. **File Upload and Storage**:

   - Accepts DOCX files through REST APIs and stores them securely.

2. **Asynchronous Conversion**:

   - Uses RabbitMQ for job queuing and worker services for processing.

3. **DOCX to PDF Conversion**:

   - Maintains high-quality formatting using OpenSAGRES and Apache POI libraries.

4. **Status Tracking**:

   - Tracks the progress of conversion jobs with states: `PENDING`, `PROCESSING`, `COMPLETED`, `FAILED`.

5. **Result Retrieval**:
   - Allows users to download the converted PDF upon job completion.

---

## Microservice Architecture

### Key Components

1. **File Upload Service**:

   - Handles user file uploads.
   - Generates a `jobId` and enqueues the job in RabbitMQ.

2. **Conversion Worker Service**:

   - Listens to RabbitMQ, retrieves jobs, processes DOCX to PDF conversion, and updates job statuses.

3. **Message Queue (RabbitMQ)**:

   - Facilitates communication between services, ensuring decoupling and scalability.

4. **Job Status Service**:

   - Manages job statuses and stores conversion results.

5. **File Storage Service**:
   - Handles file storage and retrieval for uploaded DOCX files and converted PDFs.

---

## Workflow

1. User uploads a DOCX file via `/api/upload`.
2. A `jobId` is returned, and the job is added to RabbitMQ.
3. A worker service retrieves the job, converts the file, and updates the status.
4. The user can check the job status via `/api/status/{jobId}`.
5. Upon completion, the converted PDF can be downloaded via `/api/download/{jobId}`.

---

## Prerequisites

1. **Java 8 or later**
2. **Maven**
3. **Docker** (for RabbitMQ and backend containerization)

---

## Setup and Running

### 1. Manual Steps

1. Clone the repository:

   ```bash
   git clone https://github.com/sajal-29/Doc-to-pdf.git
   cd Doc-to-pdf
   ```

2. Configure `application.properties`:

   - RabbitMQ host details.
   - Storage directory (`storage.location`).

3. Build and run:
   ```bash
   mvn clean install
   mvn spring-boot:run
   ```

---

### 2. Automated Scripts

#### `run_demo.sh`

This script sets up the entire environment, including RabbitMQ and the backend service, in Docker containers.

**Script Highlights**:

- Cleans up any existing Docker containers and networks.
- Creates a custom Docker network.
- Runs RabbitMQ and backend services in Docker containers.

**Usage**:

1. Make the script executable:
   ```bash
   chmod +x run_demo.sh
   ```
2. Execute the script:
   ```bash
   ./run_demo.sh
   ```

**Output**:

- RabbitMQ Management UI: [http://localhost:15672](http://localhost:15672)
- Backend API: [http://localhost:8080/api](http://localhost:8080/api)

<details>
<summary>Click to view script code</summary>

```bash
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
```

</details>

---

#### `stop_demo.sh`

This script stops and cleans up the Docker environment created by `run_demo.sh`.

**Usage**:

1. Make the script executable:
   ```bash
   chmod +x stop_demo.sh
   ```
2. Execute the script:
   ```bash
   ./stop_demo.sh
   ```

**Output**:

- Stops and removes all containers.
- Cleans up the custom Docker network.

<details>
<summary>Click to view script code</summary>

```bash
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
```

</details>

---

## API Endpoints

1. **File Upload**:

   - **Endpoint**: `/api/upload`
   - **Method**: `POST`
   - **Description**: Accepts a DOCX file and initiates a conversion job.

2. **Check Job Status**:

   - **Endpoint**: `/api/status/{jobId}`
   - **Method**: `GET`
   - **Description**: Returns the status of a job.

3. **Download Result**:
   - **Endpoint**: `/api/download/{jobId}`
   - **Method**: `GET`
   - **Description**: Downloads the converted PDF.

---

## Configuration

1. **RabbitMQ**:

   - Queue name (`queue.conversion.name`) configurable in `application.properties`.

2. **Storage**:
   - Configurable via `storage.location`.

---

## Directory Structure

```nim
.
├── backend
│   ├── Dockerfile                # Backend Docker configuration
│   ├── mvnw                      # Maven Wrapper script for Linux/Mac
│   ├── mvnw.cmd                  # Maven Wrapper script for Windows
│   ├── pom.xml                   # Maven project configuration file
│   ├── src                       # Backend source code
│   │   ├── main
│   │   │   ├── java              # Java source code
│   │   │   │   └── com
│   │   │   │       └── DocxToPdf
│   │   │   │           └── doc_to_pdf_converter
│   │   │   │               ├── config
│   │   │   │               ├── controller
│   │   │   │               ├── model
│   │   │   │               ├── service
│   │   │   │               └── storage
│   │   │   ├── resources
│   │   │       ├── application.yml    # Spring Boot configuration
│   │   │       └── templates          # HTML templates
│   │   └── test
│   │       └── java                   # Unit tests
│   └── target                         # Compiled backend files
│       ├── doc-to-pdf-converter-0.0.1-SNAPSHOT.jar   # Compiled JAR file
│       └── classes                    # Compiled class files
├── deploy
│   ├── nginx                          # Nginx configuration
│   │   └── converter.conf
│   ├── run_demo.sh                    # Script to run the demo
│   └── stop_demo.sh                   # Script to stop the demo
|
├── frontend
│   └── pdf_man                        # Flutter frontend application
│       ├── lib                        # Flutter Dart files
│       │   └── screen
│       │       └── DocxToPdfConverter.dart
│       ├── pubspec.yaml               # Flutter project configuration
│       ├── web                        # Web-specific Flutter files
│       │   └── index.html
│       |
│       └── test                       # Frontend test cases
├── k8s
│   ├── converter-namespace.yaml       # Kubernetes namespace configuration
│   ├── converter-pv.yaml              # Persistent Volume configuration
│   ├── converter-pvc.yaml             # Persistent Volume Claim
│   ├── rabbitmq.yaml                  # RabbitMQ deployment configuration
│   └── spring-boot-backend.yaml       # Backend deployment configuration
├── Makefile                           # Automation for building and running
└── README.md                          # Project documentation
```

---
