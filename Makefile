#
# Project Name:: gke_prok
# File:: Makefile
#
# Copyright (C) 2018 - Present
# Author: 'Mihai Vultur <xanto@e__.ro>'
#
# All rights reserved
#
# Description:
#   Makefile that will help us manage our go app provisioning.


GO_BIN=/usr/local/go/bin/go


prereq:
	ansible-galaxy install fubarhouse.golang
	ansible-playbook --ask-become-pass scripts/prereq/playbook.yml

