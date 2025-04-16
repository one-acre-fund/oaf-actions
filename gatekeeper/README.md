## Deploy OIDC Gatekeeper Proxy

### Description

Automates the deployment of the Gatekeeper (OpenID Connect) proxy using Helm to manage secure access to upstream services.

### Inputs

| name | description | required | default |
| --- | --- | --- | --- |
| `NAMESPACE` | The Kubernetes namespace where the Gatekeeper proxy will be deployed. | `true` | `""` |
| `RELEASE_NAME` | The Helm release name for the Gatekeeper deployment. | `true` | `""` |
| `PROXY_CLIENT_SECRET` | Client secret used for authentication with the OpenID Connect provider. | `true` | `""` |
| `DISCOVER_URL` | The OpenID Connect discovery URL to retrieve the configuration. | `true` | `""` |
| `CLIENT_ID` | Client ID used for identifying the proxy with the OpenID Connect provider. | `true` | `""` |
| `UPSTREAM_URL` | The URL of the upstream service that the proxy will protect. | `true` | `""` |
| `PROXY_ENCRYPTION_KEY` | Encryption key used to secure sensitive data within the proxy. | `true` | `""` |
| `PROXY_REDIRECTION_URL` | URL to redirect unauthenticated users after successful authentication. | `true` | `""` |
| `ROLE` | The role required for accessing the upstream service through the proxy. | `true` | `""` |

### Runs

This action is a `composite` action.

### Usage

```yaml
- uses: ***PROJECT***@***VERSION***
  with:
    NAMESPACE:
    # The Kubernetes namespace where the Gatekeeper proxy will be deployed.
    #
    # Required: true
    # Default: ""

    RELEASE_NAME:
    # The Helm release name for the Gatekeeper deployment.
    #
    # Required: true
    # Default: ""

    PROXY_CLIENT_SECRET:
    # Client secret used for authentication with the OpenID Connect provider.
    #
    # Required: true
    # Default: ""

    DISCOVER_URL:
    # The OpenID Connect discovery URL to retrieve the configuration.
    #
    # Required: true
    # Default: ""

    CLIENT_ID:
    # Client ID used for identifying the proxy with the OpenID Connect provider.
    #
    # Required: true
    # Default: ""

    UPSTREAM_URL:
    # The URL of the upstream service that the proxy will protect.
    #
    # Required: true
    # Default: ""

    PROXY_ENCRYPTION_KEY:
    # Encryption key used to secure sensitive data within the proxy.
    #
    # Required: true
    # Default: ""

    PROXY_REDIRECTION_URL:
    # URL to redirect unauthenticated users after successful authentication.
    #
    # Required: true
    # Default: ""

    ROLE:
    # The role required for accessing the upstream service through the proxy.
    #
    # Required: true
    # Default: ""
```
