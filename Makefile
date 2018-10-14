#
# Project Name:: gke_proj
# File:: Makefile
#
# Copyright (C) 2018 - Present
# Author: 'Mihai Vultur <xanto@e__.ro>'
#
# All rights reserved
#
# Description:
#   Makefile that will help us manage our go app provisioning.

.PHONY: all prereq build db seed

GO_BIN=/usr/local/go/bin/go

all: prereq build db seed

prereq:
	ansible-galaxy install fubarhouse.golang,v2.7.3
	ansible-galaxy install andrewrothstein.kubectl,v1.1.15
	ansible-galaxy install geerlingguy.docker,v2.5.1
	ansible-playbook --ask-become-pass scripts/prereq/playbook.yml

build:
	CGO_ENABLED=0 GOOS=linux ${GO_BIN} build -a -installsuffix cgo -ldflags '-w' src/app/*.go


db:
	@echo "Creating mysql pod"
	kubectl apply -f conf/mysql-provisioning.yml
	sleep 3

seed:
	$(eval MYSQL_POD=$(shell sh -c "kubectl get pod --selector=tier=mysql --output=jsonpath={.items..metadata.name}"))
	kubectl cp src/schema/users.sql ${MYSQL_POD}:/tmp/
	kubectl cp scripts/mysql_seed.sh ${MYSQL_POD}:/tmp/
	@echo "Importing schema"
	kubectl -n default exec -i ${MYSQL_POD} -- /tmp/mysql_seed.sh

mysql: db seed

clean:
	rm -f app
