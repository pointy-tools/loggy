# loggy

This tool providers a CLI interface on top of the MacOS Unified Logging system.  Used similiarly to the unix `logger` utility, this tool allows the setting of the `subsystem` and `category` fields on MacOS log event object, allowing for easy filtering and use with the NSPredicate system.

Also included is a wrapper and `logging` handler for use with Python.

The default subsystem is `com.pointy-tools.loggy` and category is `default`.

## Installation

This package requires MacOS 10.12+, XCode, make and some other dependencies. Brew install to come.

### CLI

```
make install
```

### Python Logging Handler

```
make install-python
```

### All the things

```
make install-all
```


## Usage

### CLI

```
USAGE: loggy [--category <category>] [--subsystem <subsystem>] [--level <level>] <message>

ARGUMENTS:
  <message>               The message to log

OPTIONS:
  -c, --category <category>
                          The category (default: default)
  -s, --subsystem <subsystem>
                          The subsystem (default: com.pointy-tools.loggy)
  -l, --level <level>     The log level (default: notice)
  -h, --help              Show help information.
```

### Python

```
loggyh = LoggyHandler(
    subsystem="com.pointy-tools.loggy",
    category="default"
)
logger.addHandler(loggyh)
```