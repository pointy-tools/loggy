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

import subprocess
from setuptools import setup
from distutils.command.build import build

with open("VERSION") as fh:
    version = fh.read()

with open("README.md") as fh:
    readme = fh.read()

classifiers = [
    "License :: OSI Approved :: Apache Software License"
    "Operating System :: MacOS :: MacOS X",
    "Programming Language :: Python :: 3",
    "Topic :: System :: Logging",
    "Development Status :: 4 - Beta",
    ]


class BuildLoggy(build):
    def run(self):
        subprocess.call(['make', 'clean-python'])
        subprocess.call(['make', 'build-python'])
        build.run(self)


setup(
    name="loggy",
    version=version,
    description="Loggy - CLI/Python tool for interacting with MacOS Unified Logging system",
    long_description=readme,
    author="Ryan D Williams",
    author_email="rdw@pointy-tools.com",
    url="https://github.com/pointy-tools/loggy",
    packages=["loggy"],
    package_dir={"loggy": "python"},
    package_data={"loggy": ["libloggy.dylib"]},
    classifiers=classifiers,
    cmdclass={'build': BuildLoggy},
    license="Apache-2.0",
)
