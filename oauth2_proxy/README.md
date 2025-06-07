## Deploy OAuth2 Proxy

### Description

Deploy OAuth2 Proxy using Helm with a dynamically generated values file.

### Inputs

| name | description | required | default |
| --- | --- | --- | --- |
| `NAMESPACE` | The Kubernetes namespace for deployment. | `true` | `""` |
| `RELEASE_NAME` | The Helm release name for the OAuth2 Proxy deployment. | `true` | `""` |
| `VERSION` | The version of the OAuth2 Proxy Helm chart to deploy. | `false` | `7.8.0` |
| `OAUTH_CLIENT_ID` | The OAuth2 client ID. | `true` | `""` |
| `OAUTH_CLIENT_SECRET` | The OAuth2 client secret. | `true` | `""` |
| `OAUTH_COOKIE_SECRET` | The OAuth2 cookie secret. | `true` | `""` |
| `OAUTH_COOKIE_DOMAIN` | The domain for OAuth2 cookies. | `true` | `oneacrefund.org` |
| `OAUTH_COOKIE_EXPIRE` | The expiration time for OAuth2 cookies. | `true` | `24h0m0s` |
| `OAUTH_PROXY_UPSTREAM` | The upstream URL for OAuth2 Proxy. | `true` | `""` |
| `OAUTH_PROXY_SET_XAUTHREQUEST` | Set the X-Auth-Request header. | `false` | `true` |

### Runs

This action is a `composite` action.

### Usage

```yaml
- uses: one-acre-fund/oaf-actions/oauth2_proxy@main
  with:
    NAMESPACE:
    # The Kubernetes namespace for deployment.
    #
    # Required: true
    # Default: ""

    RELEASE_NAME:
    # The Helm release name for the OAuth2 Proxy deployment.
    #
    # Required: true
    # Default: ""

    VERSION:
    # The version of the OAuth2 Proxy Helm chart to deploy.
    #
    # Required: false
    # Default: 7.8.0

    OAUTH_CLIENT_ID:
    # The OAuth2 client ID.
    #
    # Required: true
    # Default: ""

    OAUTH_CLIENT_SECRET:
    # The OAuth2 client secret.
    #
    # Required: true
    # Default: ""

    OAUTH_COOKIE_SECRET:
    # The OAuth2 cookie secret.
    #
    # Required: true
    # Default: ""

    OAUTH_COOKIE_DOMAIN:
    # The domain for OAuth2 cookies.
    #
    # Required: true
    # Default: oneacrefund.org

    OAUTH_COOKIE_EXPIRE:
    # The expiration time for OAuth2 cookies.
    #
    # Required: true
    # Default: 24h0m0s

    OAUTH_PROXY_UPSTREAM:
    # The upstream URL for OAuth2 Proxy.
    #
    # Required: true
    # Default: ""

    OAUTH_PROXY_SET_XAUTHREQUEST:
    # Set the X-Auth-Request header.
    #
    # Required: false
    # Default: true
```
