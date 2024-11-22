# DOCX to PDF Converter (Spring Boot Application)

## Project Overview

The **DOCX to PDF Converter** is a Spring Boot-based application designed to convert Microsoft Word documents (DOCX) into PDF format. It employs a microservice architecture with RabbitMQ as the communication broker, ensuring asynchronous and scalable processing.

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
# Full script code as uploaded
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
# Full script code as uploaded
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
├── doc-to-pdf
│   └── HELP.md                        # Documentation for the backend
├── frontend
│   └── pdf_man                        # Flutter frontend application
│       ├── lib                        # Flutter Dart files
│       │   └── screen
│       │       └── DocxToPdfConverter.dart
│       ├── pubspec.yaml               # Flutter project configuration
│       ├── web                        # Web-specific Flutter files
│       │   └── index.html
│       ├── android, ios, linux, macos, windows    # Platform-specific files
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
