# Self-documented Makefile
# Run `make` on your shell, you will see the manual.
# Reference: https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
# -u $(shell id -u):$(shell id -g)

.PHONY: help
.DEFAULT_GOAL := help


help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

run: ## Run fisheye-image-pair-streamer Docker image
	docker run \
	-v $(shell pwd):/usr/src/app \
	-v $(shell pwd)/../SKU110K_fixed:/usr/src/data \
	-p 8002:8888 \
	-t shinyeyes/sku-110k-dense-object-detection:dev

build: ## Build Docker image for fisheye-image-pair-streamer
	docker build -f docker/Dockerfile \
	--network=host \
	-t shinyeyes/sku-110k-dense-object-detection:dev \
	.


ci: ## Build a CI image, and run unit tests. This will be run on Jenkins.
	bash tools/docker_ci.sh

shell: ## Enter a shell into fisheye-image-pair-streamer Docker container
	docker-compose run shell-dev bash
	
mypy: ## Run a Python static type checker
	docker-compose run mypy

push-docker-image: ## Push a specific Docker image issue 
	bash tools/docker_dev_issue.sh
