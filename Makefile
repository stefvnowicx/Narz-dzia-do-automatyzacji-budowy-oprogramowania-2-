.PHONY: deps lint test run docker_build docker_run docker_push

deps:
	python -m pip install -r requirements.txt
	python -m pip install -r test_requirements.txt

lint:
	python -m flake8 hello_world test

test: lint
	python -m pytest -q

run:
	python main.py

docker_build:
	docker build -t hello-world-printer .

docker_run: docker_build
	docker run \
		--name hello-world-printer-dev \
		-p 5000:5000 \
		-d hello-world-printer

TAG=$(USERNAME)/hello-world-printer-k7-2026

docker_push: docker_build
	@docker login --username $(USERNAME) --password $${DOCKER_PASSWORD}; \
	docker tag hello-world-printer $(TAG); \
	docker push $(TAG); \
	docker logout;