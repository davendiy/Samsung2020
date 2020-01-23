#!/usr/bin/env python3
# -*- coding: utf-8 -*-

from subprocess import Popen, PIPE, TimeoutExpired


params = ['minicom', '-D', '/dev/ttyUSB0', '-b', '115200']
ps = Popen(params, stdin=PIPE, stdout=PIPE)
