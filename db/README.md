## Helm PostgreSQL

### Description

GitHub Action for deploying PostgreSQL with Helm

### Inputs

| name | description | required | default |
| --- | --- | --- | --- |
| `NAMESPACE` | The namespace to deploy the Postgresql server to. | `true` | `""` |
| `RELEASE_NAME` | The name of the release for the Postgresql server. | `true` | `db` |
| `INSTALL_POSTGRES` | Whether to install Postgresql or not. | `true` | `false` |
| `POSTGRES_DATABASE_NAME` | The name of the Postgresql database. | `true` | `""` |
| `POSTGRES_DATABASE_USER` | The username for the Postgresql database. | `true` | `""` |
| `POSTGRES_DATABASE_PASSWORD` | The password for the Postgresql database. | `true` | `""` |
| `POSTGRES_IMAGE_TAG` | The image tag for the Postgresql server if a kubernetes managed service is used. | `false` | `""` |
| `POSTGRES_STORAGE_CLASS` | The storage class for the Postgresql server if a kubernetes managed service is used. | `false` | `""` |
| `POSTGRES_STORAGE_SIZE` | The storage size for the Postgresql if a kubernetes managed service is used. | `false` | `15Gi` |
| `MAX_CONNECTIONS` | The maximum number of connections to the Postgresql server if a kubernetes managed service is used. | `true` | `""` |
| `POSTGRES_CPU_LIMIT` | The CPU limit for the Postgresql server if a kubernetes managed service is used. | `false` | `2` |
| `POSTGRES_MEMORY_LIMIT` | The memory limit for the Postgresql server if a kubernetes managed service is used. | `false` | `3Gi` |
| `POSTGRES_CPU_REQUEST` | The CPU request for the Postgresql server if a kubernetes managed service is used. | `false` | `1` |
| `POSTGRES_MEMORY_REQUEST` | The memory request for the Postgresql server if a kubernetes managed service is used. | `false` | `1Gi` |

### Runs

This action is a `composite` action.

### Usage

```yaml
- uses: ***PROJECT***@***VERSION***
  with:
    NAMESPACE:
    # The namespace to deploy the Postgresql server to.
    #
    # Required: true
    # Default: ""

    RELEASE_NAME:
    # The name of the release for the Postgresql server.
    #
    # Required: true
    # Default: db

    INSTALL_POSTGRES:
    # Whether to install Postgresql or not.
    #
    # Required: true
    # Default: false

    POSTGRES_DATABASE_NAME:
    # The name of the Postgresql database.
    #
    # Required: true
    # Default: ""

    POSTGRES_DATABASE_USER:
    # The username for the Postgresql database.
    #
    # Required: true
    # Default: ""

    POSTGRES_DATABASE_PASSWORD:
    # The password for the Postgresql database.
    #
    # Required: true
    # Default: ""

    POSTGRES_IMAGE_TAG:
    # The image tag for the Postgresql server if a kubernetes managed service is used.
    #
    # Required: false
    # Default: ""

    POSTGRES_STORAGE_CLASS:
    # The storage class for the Postgresql server if a kubernetes managed service is used.
    #
    # Required: false
    # Default: ""

    POSTGRES_STORAGE_SIZE:
    # The storage size for the Postgresql if a kubernetes managed service is used.
    #
    # Required: false
    # Default: 15Gi

    MAX_CONNECTIONS:
    # The maximum number of connections to the Postgresql server if a kubernetes managed service is used.
    #
    # Required: true
    # Default: ""

    POSTGRES_CPU_LIMIT:
    # The CPU limit for the Postgresql server if a kubernetes managed service is used.
    #
    # Required: false
    # Default: 2

    POSTGRES_MEMORY_LIMIT:
    # The memory limit for the Postgresql server if a kubernetes managed service is used.
    #
    # Required: false
    # Default: 3Gi

    POSTGRES_CPU_REQUEST:
    # The CPU request for the Postgresql server if a kubernetes managed service is used.
    #
    # Required: false
    # Default: 1

    POSTGRES_MEMORY_REQUEST:
    # The memory request for the Postgresql server if a kubernetes managed service is used.
    #
    # Required: false
    # Default: 1Gi
```
