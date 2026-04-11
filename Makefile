.PHONY: deps lint test run

deps:
	python -m pip install -r requirements.txt
	python -m pip install -r test_requirements.txt

lint:
	python -m flake8 hello_world test

test: lint
	python -m pytest -q

run:
	python main.py

