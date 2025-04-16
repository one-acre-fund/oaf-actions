## Download Certificate from LastPass

### Description

Logs into LastPass CLI and downloads certs based on a prefix, moving them to a specified directory.

### Inputs

| name | description | required | default |
| --- | --- | --- | --- |
| `USER` | LastPass username (email) | `true` | `""` |
| `PASSWORD` | LastPass master password | `true` | `""` |
| `VERSION` | LastPass CLI version to install (default: 1.6.1) | `false` | `1.6.1` |
| `CERTIFICATE_PATH_PREFIX` | Prefix used to identify cert entries in LastPass (e.g., 'Certs/operations.oneacrefund.org') | `true` | `""` |
| `OUTPUT_DIR` | Target directory to place the downloaded certificates (e.g., /etc/ssl/certs) | `true` | `""` |

### Runs

This action is a `composite` action.

### Usage

```yaml
- uses: ***PROJECT***@***VERSION***
  with:
    USER:
    # LastPass username (email)
    #
    # Required: true
    # Default: ""

    PASSWORD:
    # LastPass master password
    #
    # Required: true
    # Default: ""

    VERSION:
    # LastPass CLI version to install (default: 1.6.1)
    #
    # Required: false
    # Default: 1.6.1

    CERTIFICATE_PATH_PREFIX:
    # Prefix used to identify cert entries in LastPass (e.g., 'Certs/operations.oneacrefund.org')
    #
    # Required: true
    # Default: ""

    OUTPUT_DIR:
    # Target directory to place the downloaded certificates (e.g., /etc/ssl/certs)
    #
    # Required: true
    # Default: ""
```
