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

.PHONY: all prereq app

GO_BIN=/usr/local/go/bin/go

all: prereq app

prereq:
	ansible-galaxy install fubarhouse.golang,v2.7.3
	ansible-galaxy install andrewrothstein.kubectl,v1.1.15
	ansible-playbook --ask-become-pass scripts/prereq/playbook.yml

app:
	CGO_ENABLED=0 GOOS=linux ${GO_BIN} build -a -installsuffix cgo -ldflags '-w' src/app/*.go

clean:
	rm -f app
