## Set Kubernetes Context

### Description

A GitHub Action for setting the Kubernetes context for deployment.

### Inputs

| name | description | required | default |
| --- | --- | --- | --- |
| `K8S_URL` | The URL for the kubernetes cluster. | `true` | `""` |
| `K8S_SECRET` | The secret used to authenticate to the cluster. | `true` | `""` |

### Runs

This action is a `composite` action.

### Usage

```yaml
- uses: ***PROJECT***@***VERSION***
  with:
    K8S_URL:
    # The URL for the kubernetes cluster.
    #
    # Required: true
    # Default: ""

    K8S_SECRET:
    # The secret used to authenticate to the cluster.
    #
    # Required: true
    # Default: ""
```
