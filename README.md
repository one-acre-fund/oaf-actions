# OAF Actions

This repository contains reusable GitHub Actions designed to simplify and standardize Kubernetes and Helm-related workflows at One Acre Fund.

## Available Actions

### Set Kubernetes Context

**Purpose**: Sets the Kubernetes context for deployment.

**Inputs**:

- `K8S_URL` (required): The URL for the Kubernetes cluster.
- `K8S_SECRET` (required): The secret used to authenticate with the cluster.

---

### Deploy OAuth2 Proxy

**Purpose**: Deploys the OAuth2 Proxy using Helm with a dynamically generated values file.

**Inputs**:

- `NAMESPACE` (required): Kubernetes namespace for deployment.
- `RELEASE_NAME` (required): Helm release name for the OAuth2 Proxy deployment.
- `VERSION` (optional, default: `7.8.0`): OAuth2 Proxy Helm chart version.
- OAuth2-related secrets and configurations:
  - `OAUTH_CLIENT_ID` (required)
  - `OAUTH_CLIENT_SECRET` (required)
  - `OAUTH_COOKIE_SECRET` (required)
  - `OAUTH_COOKIE_DOMAIN` (default: `oneacrefund.org`)
  - `OAUTH_COOKIE_EXPIRE` (default: `24h0m0s`)
  - `OAUTH_PROXY_UPSTREAM` (required)
  - `OAUTH_PROXY_SET_XAUTHREQUEST` (default: `true`)

---

### Setup Helm Environment

**Purpose**: Configures and prepares the environment for deploying Helm charts.

**Inputs**:

- `GITHUB_TOKEN` (required): Token for artifact download.
- `RUN_ID` (required): Workflow run ID from the CI workflow.
- `ARTIFACT_NAME` (required): Artifact name to download.
- `CI_REPOSITORY` (required): Repository where the artifact is located.
- Kubernetes context inputs:
  - `K8S_URL` (required)
  - `K8S_SECRET` (required)

---

### Deploy OIDC Gatekeeper Proxy

**Purpose**: Automates deployment of the Gatekeeper (OpenID Connect) proxy to manage secure access to upstream services.

**Inputs**:

- `NAMESPACE` (required): Kubernetes namespace for deployment.
- `RELEASE_NAME` (required): Helm release name for the Gatekeeper deployment.
- OpenID Connect and proxy configurations:
  - `PROXY_CLIENT_SECRET` (required)
  - `DISCOVER_URL` (required)
  - `CLIENT_ID` (required)
  - `UPSTREAM_URL` (required)
  - `PROXY_ENCRYPTION_KEY` (required)
  - `PROXY_REDIRECTION_URL` (required)
  - `ROLE` (required)

---

### Dispatch Deployment Event

**Purpose**: Triggers a deployment event for a specific workflow run.

**Inputs**:

- `TOKEN` (required): GitHub token for dispatching.
- `RUN_ID` (required): Workflow run ID.
- `REF` (required): Branch or tag to deploy.
- `REF_NAME` (optional): Name of the branch to deploy.
- `SHA` (optional): Commit SHA to deploy.
- Deployment repositories:
  - `CI_REPOSITORY` (required)
  - `CD_REPOSITORY` (required)
- `CD_BRANCH` (optional, default: `main`): Target branch for deployment.
- `API_VERSION` (optional, default: `2022-11-28`): GitHub API version.

---

### Helm PostgreSQL

**Purpose**: Deploys PostgreSQL using Helm.

**Inputs**:

- `NAMESPACE` (required): Namespace for PostgreSQL deployment.
- `RELEASE_NAME` (optional, default: `db`): Release name for PostgreSQL.
- Database configurations:
  - `INSTALL_POSTGRES` (optional, default: `false`): Whether to install PostgreSQL.
  - `POSTGRES_DATABASE_NAME` (required)
  - `POSTGRES_DATABASE_USER` (required)
  - `POSTGRES_DATABASE_PASSWORD` (required)
  - `POSTGRES_IMAGE_TAG` (optional): Image tag for PostgreSQL.
  - `POSTGRES_STORAGE_CLASS` (optional): Storage class for PostgreSQL.
  - `POSTGRES_STORAGE_SIZE` (optional): Storage size for PostgreSQL.

---

### Deploy Helm Couchbase Dependencies

**Purpose**: Deploys Couchbase dependencies using Helm.

**Inputs**:

- `NAMESPACE` (required): The namespace for Couchbase.
- `RELEASE_NAME` (required): The release name for Couchbase.
- Couchbase configurations:
  - `ACR_PULL_USERNAME` (required)
  - `ACR_PULL_PASSWORD` (required)
  - `COUCHBASE_CLUSTER` (required)
  - `COUCHBASE_USERNAME` (required)
  - `COUCHBASE_PASSWORD` (required)
  - `BUCKET_NAME` (required)
  - `BUCKET_SIZE` (required)

---
