## Dispatch Deployment Event

### Description

Trigger a deployment event for a specific workflow run.

### Inputs

| name | description | required | default |
| --- | --- | --- | --- |
| `TOKEN` | The GitHub token to use for the dispatch. | `true` | `""` |
| `RUN_ID` | The run id of the workflow to dispatch. | `true` | `""` |
| `REF` | The name of the branch to deploy. | `true` | `""` |
| `REF_NAME` | The name of the branch to deploy. | `false` | `""` |
| `SHA` | The commit sha to deploy. | `false` | `""` |
| `CI_REPOSITORY` | The name of the repository to dispatch the workflow from. | `true` | `""` |
| `CD_REPOSITORY` | The name of the repository to dispatch the workflow to. | `true` | `""` |
| `CD_BRANCH` | The name of the branch to deploy to. | `false` | `main` |
| `API_VERSION` | The GitHub API version to use. | `false` | `2022-11-28` |

### Runs

This action is a `composite` action.

### Usage

```yaml
- uses: one-acre-fund/oaf-actions/dispatch@main
  with:
    TOKEN:
    # The GitHub token to use for the dispatch.
    #
    # Required: true
    # Default: ""

    RUN_ID:
    # The run id of the workflow to dispatch.
    #
    # Required: true
    # Default: ""

    REF:
    # The name of the branch to deploy.
    #
    # Required: true
    # Default: ""

    REF_NAME:
    # The name of the branch to deploy.
    #
    # Required: false
    # Default: ""

    SHA:
    # The commit sha to deploy.
    #
    # Required: false
    # Default: ""

    CI_REPOSITORY:
    # The name of the repository to dispatch the workflow from.
    #
    # Required: true
    # Default: ""

    CD_REPOSITORY:
    # The name of the repository to dispatch the workflow to.
    #
    # Required: true
    # Default: ""

    CD_BRANCH:
    # The name of the branch to deploy to.
    #
    # Required: false
    # Default: main

    API_VERSION:
    # The GitHub API version to use.
    #
    # Required: false
    # Default: 2022-11-28
```
