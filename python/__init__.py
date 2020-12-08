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

import os
import ctypes
from logging import Handler
from pathlib import Path


BASE_DIR = Path(__file__).parent
LEVEL_MAP = {
    "info": "notice",
    "critical": "fault"
}


class LoggyHandler(Handler):
    """Handler that logs events to the MacOS unified logging system.

    Usage:
    loggyh = LoggyHandler(
        subsystem="com.pointy-tools.loggy",
        category="default"
    )
    logger.addHandler(loggyh)
    """

    def __init__(self, subsystem: str, category: str):
        Handler.__init__(self)
        self.subsystem = subsystem
        self.category = category

    def emit(self, record):
        msg = self.format(record)
        logevent(self.subsystem, self.category, record.levelname, msg)


class LoggyException(Exception):
    pass


try:
    mod = ctypes.CDLL(os.path.join(BASE_DIR, "libloggy.dylib"))
except OSError:
    raise LoggyException("Extension module not found. Please re-inståll")

mod.logevent.argtypes = (
    ctypes.c_char_p, ctypes.c_char_p, ctypes.c_char_p, ctypes.c_char_p)
mod.logevent.restype = ctypes.c_int


def logevent(subsystem: str, category: str, level: str, message: str) -> int:
    """Publishes event to MacOS Unified Logging system"""
    level = level.lower()
    if level in LEVEL_MAP:
        level = LEVEL_MAP[level]
    subsystem = ctypes.c_char_p(subsystem.encode())
    category = ctypes.c_char_p(category.encode())
    level = ctypes.c_char_p(level.encode())
    message = ctypes.c_char_p(message.encode())
    return not bool(int(mod.logevent(subsystem, category, level, message)))
