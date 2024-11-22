# Variables
K8S_SCRIPT = ./deploy/manage_k8s.sh
DEMO_RUN_SCRIPT = ./deploy/run_demo.sh
DEMO_STOP_SCRIPT = ./deploy/stop_demo.sh
NGINX_CONF = ./deploy/nginx/converter.conf

K8S_NAMESPACE = ./k8s/converter-namespace.yaml
K8S_PV = ./k8s/converter-pv.yaml
K8S_PVC = ./k8s/converter-pvc.yaml
K8S_RABBITMQ = ./k8s/rabbitmq.yaml
K8S_BACKEND = ./k8s/spring-boot-backend.yaml

BACKEND_IMAGE = sajal29/converter-backend
BACKEND_DIR = ./backend

# Targets
.PHONY: build push setup-nginx manage_k8s update_k8s down_k8s redeploy_k8s setup_demo stop_demo setup_k8s

# Default Target
manage_k8s:
	@echo "Usage: make <build|push|setup-nginx|update_k8s|down_k8s|redeploy_k8s|setup_demo|stop_demo|setup_k8s|cleanup_k8s>"
	@echo "  build        - Build the Docker image for the backend."
	@echo "  push         - Push the Docker image to the repository."
	@echo "  setup-nginx  - Set up Nginx with the converter configuration."
	@echo "  setup_demo   - Run the demo locally using Docker containers."
	@echo "  stop_demo    - Stop the demo Docker containers."
	@echo "  setup_k8s    - Deploy all Kubernetes resources."
	@echo "  update_k8s   - Apply Kubernetes resource updates."
	@echo "  redeploy_k8s - Bring down and redeploy Kubernetes resources."
	@echo "  down_k8s     - Bring down Kubernetes resources."

# Build the Docker image for the backend
build:
	@echo "Building Docker image: $(BACKEND_IMAGE)"
	docker build $(BACKEND_DIR) -t $(BACKEND_IMAGE)
	@echo "Docker image built: $(BACKEND_IMAGE)"

# Push the Docker image to the repository
push:
	@echo "Pushing Docker image: $(BACKEND_IMAGE)"
	docker push $(BACKEND_IMAGE)
	@echo "Docker image pushed: $(BACKEND_IMAGE)"

# Run the demo using Docker containers
setup_demo:
	@echo "Setting up demo using Docker containers..."
	bash $(DEMO_RUN_SCRIPT)

# Stop the demo Docker containers
stop_demo:
	@echo "Stopping demo Docker containers..."
	bash $(DEMO_STOP_SCRIPT)
# Set up Nginx configuration
setup-nginx:
	@echo "Setting up Nginx configuration..."
	sudo cp $(NGINX_CONF) /etc/nginx/sites-available/
	sudo ln -fs /etc/nginx/sites-available/converter.conf /etc/nginx/sites-enabled/
	sudo nginx -t
	sudo systemctl reload nginx
	@echo "Nginx setup completed."

# Apply updates to Kubernetes resources
update_k8s:
	@echo "Applying updates to Kubernetes resources..."
	kubectl apply -f $(K8S_NAMESPACE)
	kubectl apply -f $(K8S_PV)
	kubectl apply -f $(K8S_PVC)
	kubectl apply -f $(K8S_RABBITMQ)
	kubectl apply -f $(K8S_BACKEND)

# Delete all Kubernetes resources
down_k8s:
	@echo "Cleaning up all Kubernetes resources..."
	kubectl delete -f $(K8S_BACKEND)
	kubectl delete -f $(K8S_RABBITMQ)
	kubectl delete -f $(K8S_PVC)
	kubectl delete -f $(K8S_PV)
	kubectl delete -f $(K8S_NAMESPACE)
	@echo "Kubernetes resources cleaned up successfully."

# Redeploy Kubernetes resources
redeploy_k8s:
	@echo "Redeploying Kubernetes resources..."
	bash $(K8S_SCRIPT) --down
	kubectl apply -f $(K8S_NAMESPACE)
	kubectl apply -f $(K8S_PV)
	kubectl apply -f $(K8S_PVC)
	kubectl apply -f $(K8S_RABBITMQ)
	kubectl apply -f $(K8S_BACKEND)
	@echo "Kubernetes resources redeployed successfully."
# Deploy all Kubernetes resources
setup_k8s:
	@echo "Deploying all Kubernetes resources..."
	kubectl apply -f $(K8S_NAMESPACE)
	kubectl apply -f $(K8S_PV)
	kubectl apply -f $(K8S_PVC)
	kubectl apply -f $(K8S_RABBITMQ)
	kubectl apply -f $(K8S_BACKEND)
	@echo "Kubernetes resources deployed successfully."	
