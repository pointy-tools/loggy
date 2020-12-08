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

public func logevent (subsystem: String, category: String, level: String, message: String) -> Bool {
    if #available(OSX 10.12, *) {
        var _type: OSLogType;
        switch level {
        case "info":
            _type = OSLogType.info
        case "debug":
            _type = OSLogType.debug
        case "error":
            _type = OSLogType.error
        case "fault":
            _type = OSLogType.fault
        default:
            _type = OSLogType.default
        }
        let mylog = OSLog(subsystem: subsystem, category: category)
        os_log("%{public}@", log: mylog, type: _type, message)
        return true
    } else {
        print("This version of MacOS is not compatible with this utility. Get yourself at least 10.12")
        return false
    }
}

@_cdecl("logevent")
public func logevent (subsystem: UnsafePointer<CChar>, category: UnsafePointer<CChar>, level: UnsafePointer<CChar>, message: UnsafePointer<CChar>) -> Int {
    if (logevent(subsystem: String(cString: subsystem), category: String(cString: category), level: String(cString: level), message: String(cString: message))) {
        return 0
    } else {
        return 1
    }
}
