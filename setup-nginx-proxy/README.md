## Add NGINX Proxy Site

### Description

Configures a reverse proxy in NGINX for Dozzle or other apps

### Inputs

| name | description | required | default |
| --- | --- | --- | --- |
| `SITE_NAME` | The domain name for the NGINX server block | `true` | `""` |
| `DOMAIN` | The domain name for the app to be proxied | `true` | `""` |
| `PROXY_PORT` | The local port the proxy will forward to | `true` | `""` |
| `LISTEN_PORT` | The port NGINX will listen on (default: 443) | `false` | `443` |
| `TLS_CERTIFICATE_PATH` | Path to the SSL certificate file | `false` | `""` |
| `TLS_PRIVATE_KEY_PATH` | Path to the SSL key file | `false` | `""` |

### Runs

This action is a `composite` action.

### Usage

```yaml
- uses: one-acre-fund/oaf-actions/setup-nginx-proxy@main
  with:
    SITE_NAME:
    # The domain name for the NGINX server block
    #
    # Required: true
    # Default: ""

    DOMAIN:
    # The domain name for the app to be proxied
    #
    # Required: true
    # Default: ""

    PROXY_PORT:
    # The local port the proxy will forward to
    #
    # Required: true
    # Default: ""

    LISTEN_PORT:
    # The port NGINX will listen on (default: 443)
    #
    # Required: false
    # Default: 443

    TLS_CERTIFICATE_PATH:
    # Path to the SSL certificate file
    #
    # Required: false
    # Default: ""

    TLS_PRIVATE_KEY_PATH:
    # Path to the SSL key file
    #
    # Required: false
    # Default: ""
```
