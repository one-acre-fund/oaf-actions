## Helm Couchbase Dependencies

### Description

GitHub Action for deploying Couchbase dependencies.

### Inputs

| name | description | required | default |
| --- | --- | --- | --- |
| `ACR_PULL_PASSWORD` | Azure Registry Password. | `true` | `""` |
| `ACR_PULL_USERNAME` | Azure Registry Username. | `true` | `""` |
| `NAMESPACE` | The namespace for Couchbase. | `true` | `""` |
| `RELEASE_NAME` | The release name for Couchbase. | `true` | `""` |
| `COUCHBASE_CLUSTER` | The Couchbase cluster name. | `true` | `""` |
| `COUCHBASE_PASSWORD` | The password for Couchbase. | `true` | `""` |
| `COUCHBASE_USERNAME` | The username for Couchbase. | `true` | `""` |
| `BUCKET_NAME` | The name of the Couchbase bucket. | `true` | `""` |
| `BUCKET_SIZE` | The size of the Couchbase bucket. | `true` | `""` |

### Runs

This action is a `composite` action.

### Usage

```yaml
- uses: ***PROJECT***@***VERSION***
  with:
    ACR_PULL_PASSWORD:
    # Azure Registry Password.
    #
    # Required: true
    # Default: ""

    ACR_PULL_USERNAME:
    # Azure Registry Username.
    #
    # Required: true
    # Default: ""

    NAMESPACE:
    # The namespace for Couchbase.
    #
    # Required: true
    # Default: ""

    RELEASE_NAME:
    # The release name for Couchbase.
    #
    # Required: true
    # Default: ""

    COUCHBASE_CLUSTER:
    # The Couchbase cluster name.
    #
    # Required: true
    # Default: ""

    COUCHBASE_PASSWORD:
    # The password for Couchbase.
    #
    # Required: true
    # Default: ""

    COUCHBASE_USERNAME:
    # The username for Couchbase.
    #
    # Required: true
    # Default: ""

    BUCKET_NAME:
    # The name of the Couchbase bucket.
    #
    # Required: true
    # Default: ""

    BUCKET_SIZE:
    # The size of the Couchbase bucket.
    #
    # Required: true
    # Default: ""
```
