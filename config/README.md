# Configuration files
This directory contains files used to configure the PingAuthorize Policy Editor.

## options.yml
This file, used by the `setup` command-line tool, allows system administrators to alter the output `configuration.yml` 
file generated during `setup`. It uses the YAML file format, and is provided to `setup` via the following shell command
fragment:

```
bin/setup --optionsFile options.yml <additional-setup-arguments>
```

The file is included with the standard PingAuthorize Policy Editor distribution, and is additionally provided here
for reference.

