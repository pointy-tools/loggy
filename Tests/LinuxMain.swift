import XCTest

import loggyTests

var tests = [XCTestCaseEntry]()
tests += loggyTests.allTests()
XCTMain(tests)
