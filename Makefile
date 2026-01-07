.ONESHELL: 
SHELL := /bin/bash
PYTHON_VERSION := $(shell cat .python-version)
.PHONY: clean uv-init-venv format install test

clean:
	rm -rf .venv
	uv cache clean

uv-init-venv: clean
	uv venv --python $(PYTHON_VERSION)

format:
	uv run -- black . -q
	uv run -- isort --profile black .


install: uv-init-venv
	source .venv/bin/activate
	uv sync --frozen
	uv pip install -e .
	uv pip install --group dev


test: install
	uv run -- pytest -vv .
