/////////////////////////////////////////////////////////////////////
//
// Copyright 2020 Ryan D Williams <rdw@pointy-tools.com>
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
/////////////////////////////////////////////////////////////////////


import os
import OSLog
import Foundation
import ArgumentParser

var status: Int32 = 1
let allowed_levels = ["notice", "info", "debug", "error", "fault"]

struct Loggy: ParsableCommand {
    @Option(name: .shortAndLong, help: "The category")
    var category = "default"

    @Option(name: .shortAndLong, help: "The subsystem")
    var subsystem = "com.pointy-tools.loggy"
    
    @Option(name: .shortAndLong, help: "The log level")
    var level = "notice"
    
    @Argument(help: "The message to log")
    var message: String
    
    mutating func validate() throws {
        guard allowed_levels.contains(level) else {
            throw ValidationError(String(format: "Allowed levels: %@", allowed_levels))
        }

    }
    
    mutating func run() throws {
        if (logevent(subsystem: subsystem, category: category, level: level, message: message)) {
            status = 0
        }
    }
}

Loggy.main()

exit(status)
