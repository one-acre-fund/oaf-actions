## Setup Helm Environment

### Description

A GitHub Action for configuring and preparing the environment to deploy Helm charts. This action sets up necessary artifacts, installs Helm and kubectl, and configures the Kubernetes context for deployment.

### Inputs

| name | description | required | default |
| --- | --- | --- | --- |
| `GITHUB_TOKEN` | The token required to download the artifact. | `true` | `""` |
| `RUN_ID` | The unique workflow run id from the CI workflow. | `true` | `""` |
| `ARTIFACT_NAME` | The name of the artifact to download. | `true` | `""` |
| `CI_REPOSITORY` | The CI repository. | `true` | `""` |
| `K8S_URL` | The URL for the kubernetes cluster. | `true` | `""` |
| `K8S_SECRET` | The secret used to authenticate to the cluster. | `true` | `""` |

### Runs

This action is a `composite` action.

### Usage

```yaml
- uses: ***PROJECT***@***VERSION***
  with:
    GITHUB_TOKEN:
    # The token required to download the artifact.
    #
    # Required: true
    # Default: ""

    RUN_ID:
    # The unique workflow run id from the CI workflow.
    #
    # Required: true
    # Default: ""

    ARTIFACT_NAME:
    # The name of the artifact to download.
    #
    # Required: true
    # Default: ""

    CI_REPOSITORY:
    # The CI repository.
    #
    # Required: true
    # Default: ""

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
