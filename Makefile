
SHELL := /bin/bash

LOCAL_TAG=tex

.PHONY: clean pdf build help test run

clean:
	rm -rf output

test-pdf:
	mkdir -p output
	exec docker run --rm -i --network host \
		-v $(shell pwd):/mounted ${LOCAL_TAG} \
		xelatex -output-directory output test/test.tex

build:
	docker build -t ${LOCAL_TAG} .

help:
	-@echo 'You must log in with:'
	-@echo '    docker login --username=yourhubusername --email=youremail@company.com'
	-@echo 'Then run:'
	-@echo '    docker images'
	-@echo 'Pick the correct ID and then:'
	-@echo '    docker tag ID yourhubusername/tag:latest'
	-@echo 'Finally:'
	-@echo '    docker push yourhubusername/tag'

test:
	make build
	docker run -it --rm --network host -v $(shell pwd):/mounted ${LOCAL_TAG}

# This spins up a container with all ports exposed, mounted on the current directory
run:
	docker run -it --rm --network host -v $(shell pwd):/mounted josephthomashines/${LOCAL_TAG}

