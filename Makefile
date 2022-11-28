# Makefile for Ansible Role
SHELL:=/bin/bash
IMG=artifactory.air-watch.com/docker-local-sde/ws1cs-ansible-ci:ph3-3.x-latest
export WS1CS_DATACENTER=US00-SDLab
export WS1CS_BUILDKEY=AR-WS1JAVA

define dockerCmd
	docker pull ${IMG}
	docker run --rm $(1) \
		-v /var/run/docker.sock:/var/run/docker.sock \
		-v "$(PWD):$(PWD)" \
		--env-file <(env | awk '/^(ANSIBLE|WS1CS|D42|AWS)/') \
		--env-file <(env | awk '/_proxy=/') \
		-e WS1CS_EXEC_ID="$(shell openssl rand -hex 2)" \
		-w "$(PWD)" ${IMG} $(2)
endef

default: build-all

test:
	$(call dockerCmd,-t,mol lint)

console:
	$(call dockerCmd,-it,/bin/bash)

build:
	$(call dockerCmd,-t,mol test -s $(S))

build-all:
	$(call dockerCmd,-t,mol test --all)

cleanup:
	$(call dockerCmd,,/bin/bash -c "rm *.xml")

c: console
b: build
ba: build-all