#####################################################################
#
# Copyright 2020 Ryan D Williams <rdw@pointy-tools.com>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
#####################################################################

prefix ?= /usr/local
bindir = $(prefix)/bin

build:
	swift build -c release --disable-sandbox

build-python: build
	swiftc -emit-library -o ".build/libloggy.dylib" "Sources/loggy/lib.swift"
	install ".build/libloggy.dylib" "python"

build-all: build build-python

install: build
	install ".build/release/loggy" "$(bindir)"

install-python: build-python
	python3 setup.py install

install-all: install install-python

uninstall:
	rm -rf "$(bindir)/loggy"

clean:
	rm -rf .build

clean-python:
	rm python/libloggy.dylib
	python3 setup.py clean --all
	rm -rf dist
	rm -rf loggy.egg-info

clean-all: clean clean-python

.PHONY: build install uninstall clean
