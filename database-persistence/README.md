## Database Persistence Manager

### Description

Unified GitHub Action for deploying multiple database systems (PostgreSQL, Redis, MongoDB, Couchbase) with a single action call. This wrapper action simplifies multi-database deployments by providing a single interface to all database actions.

### Features

- Deploy one or more databases with a single action
- Consistent configuration interface across all databases
- Sensible defaults for common use cases
- Optional Kubernetes context setup
- Support for standalone and high-availability architectures

### Supported Databases

| Database | Architectures | Default Storage |
| --- | --- | --- |
| PostgreSQL | Single instance | 15Gi |
| Redis | standalone, replication | 8Gi |
| MongoDB | standalone, replicaset | 8Gi |
| Couchbase | Cluster | - |

### Inputs

#### Common Inputs

| name | description | required | default |
| --- | --- | --- | --- |
| `NAMESPACE` | The namespace to deploy databases to. | `true` | `""` |
| `K8S_URL` | Kubernetes cluster URL (optional if context already set). | `false` | `""` |
| `K8S_SECRET` | Kubernetes authentication secret. | `false` | `""` |
| `IMAGE_PULL_SECRET_NAME` | Image pull secret name. | `false` | `dockerhub-secret` |

#### Database Selection

| name | description | required | default |
| --- | --- | --- | --- |
| `INSTALL_POSTGRES` | Whether to install PostgreSQL. | `false` | `false` |
| `INSTALL_REDIS` | Whether to install Redis. | `false` | `false` |
| `INSTALL_MONGODB` | Whether to install MongoDB. | `false` | `false` |
| `INSTALL_COUCHBASE` | Whether to install Couchbase. | `false` | `false` |

#### PostgreSQL Inputs

| name | description | required | default |
| --- | --- | --- | --- |
| `POSTGRES_RELEASE_NAME` | Release name for PostgreSQL. | `false` | `db` |
| `POSTGRES_DATABASE_NAME` | Database name. | `false` | `postgres` |
| `POSTGRES_DATABASE_USER` | Database user. | `false` | `postgres` |
| `POSTGRES_DATABASE_PASSWORD` | Database password. | `false` | `""` |
| `POSTGRES_STORAGE_SIZE` | Storage size. | `false` | `15Gi` |
| `POSTGRES_STORAGE_CLASS` | Storage class. | `false` | `""` |
| `POSTGRES_IMAGE_TAG` | Image tag. | `false` | `""` |
| `POSTGRES_CPU_LIMIT` | CPU limit. | `false` | `2` |
| `POSTGRES_MEMORY_LIMIT` | Memory limit. | `false` | `3Gi` |

#### Redis Inputs

| name | description | required | default |
| --- | --- | --- | --- |
| `REDIS_RELEASE_NAME` | Release name for Redis. | `false` | `redis` |
| `REDIS_ARCHITECTURE` | Architecture: standalone or replication. | `false` | `standalone` |
| `REDIS_PASSWORD` | Redis password. | `false` | `""` |
| `REDIS_STORAGE_SIZE` | Storage size. | `false` | `8Gi` |
| `REDIS_STORAGE_CLASS` | Storage class. | `false` | `""` |
| `REDIS_REPLICA_COUNT` | Number of replicas (replication mode). | `false` | `3` |
| `REDIS_CPU_LIMIT` | CPU limit. | `false` | `1` |
| `REDIS_MEMORY_LIMIT` | Memory limit. | `false` | `1Gi` |

#### MongoDB Inputs

| name | description | required | default |
| --- | --- | --- | --- |
| `MONGODB_RELEASE_NAME` | Release name for MongoDB. | `false` | `mongodb` |
| `MONGODB_ARCHITECTURE` | Architecture: standalone or replicaset. | `false` | `standalone` |
| `MONGODB_ROOT_PASSWORD` | Root password. | `false` | `""` |
| `MONGODB_STORAGE_SIZE` | Storage size. | `false` | `8Gi` |
| `MONGODB_STORAGE_CLASS` | Storage class. | `false` | `""` |
| `MONGODB_REPLICA_COUNT` | Number of replicas (replicaset mode). | `false` | `3` |
| `MONGODB_CPU_LIMIT` | CPU limit. | `false` | `1` |
| `MONGODB_MEMORY_LIMIT` | Memory limit. | `false` | `2Gi` |

#### Couchbase Inputs

| name | description | required | default |
| --- | --- | --- | --- |
| `COUCHBASE_RELEASE_NAME` | Release name for Couchbase. | `false` | `couchbase-deps` |
| `COUCHBASE_CLUSTER` | Cluster name. | `false` | `couchbase-cluster` |
| `COUCHBASE_USERNAME` | Couchbase username. | `false` | `Administrator` |
| `COUCHBASE_PASSWORD` | Couchbase password. | `false` | `""` |
| `COUCHBASE_BUCKET_NAME` | Bucket name. | `false` | `default` |
| `COUCHBASE_BUCKET_SIZE` | Bucket size in MB. | `false` | `1024` |
| `ACR_PULL_USERNAME` | Azure Container Registry username. | `false` | `""` |
| `ACR_PULL_PASSWORD` | Azure Container Registry password. | `false` | `""` |

### Runs

This action is a `composite` action that orchestrates multiple database deployment actions.

### Usage Examples

#### Single Database (PostgreSQL)

```yaml
- uses: one-acre-fund/oaf-actions/database-persistence@main
  with:
    NAMESPACE: my-namespace
    INSTALL_POSTGRES: "true"
    POSTGRES_DATABASE_PASSWORD: ${{ secrets.DB_PASSWORD }}
```

#### Multiple Databases (PostgreSQL + Redis)

```yaml
- uses: one-acre-fund/oaf-actions/database-persistence@main
  with:
    NAMESPACE: production
    INSTALL_POSTGRES: "true"
    POSTGRES_DATABASE_NAME: myapp
    POSTGRES_DATABASE_USER: appuser
    POSTGRES_DATABASE_PASSWORD: ${{ secrets.POSTGRES_PASSWORD }}
    POSTGRES_STORAGE_SIZE: 20Gi
    INSTALL_REDIS: "true"
    REDIS_ARCHITECTURE: replication
    REDIS_PASSWORD: ${{ secrets.REDIS_PASSWORD }}
    REDIS_REPLICA_COUNT: "3"
```

#### Full Stack (All Databases)

```yaml
- name: Set Kubernetes Context
  uses: one-acre-fund/oaf-actions/set_context@main
  with:
    K8S_URL: ${{ secrets.K8S_URL }}
    K8S_SECRET: ${{ secrets.K8S_SECRET }}

- name: Deploy All Databases
  uses: one-acre-fund/oaf-actions/database-persistence@main
  with:
    NAMESPACE: production

    # PostgreSQL
    INSTALL_POSTGRES: "true"
    POSTGRES_DATABASE_PASSWORD: ${{ secrets.POSTGRES_PASSWORD }}

    # Redis
    INSTALL_REDIS: "true"
    REDIS_ARCHITECTURE: replication
    REDIS_PASSWORD: ${{ secrets.REDIS_PASSWORD }}

    # MongoDB
    INSTALL_MONGODB: "true"
    MONGODB_ARCHITECTURE: replicaset
    MONGODB_ROOT_PASSWORD: ${{ secrets.MONGODB_PASSWORD }}

    # Couchbase
    INSTALL_COUCHBASE: "true"
    COUCHBASE_PASSWORD: ${{ secrets.COUCHBASE_PASSWORD }}
    ACR_PULL_USERNAME: ${{ secrets.ACR_USERNAME }}
    ACR_PULL_PASSWORD: ${{ secrets.ACR_PASSWORD }}
```

#### High Availability Setup

```yaml
- uses: one-acre-fund/oaf-actions/database-persistence@main
  with:
    NAMESPACE: production
    IMAGE_PULL_SECRET_NAME: dockerhub-secret

    # PostgreSQL with larger resources
    INSTALL_POSTGRES: "true"
    POSTGRES_DATABASE_PASSWORD: ${{ secrets.POSTGRES_PASSWORD }}
    POSTGRES_STORAGE_SIZE: 50Gi
    POSTGRES_STORAGE_CLASS: premium-ssd
    POSTGRES_CPU_LIMIT: "4"
    POSTGRES_MEMORY_LIMIT: 8Gi

    # Redis replication with 5 replicas
    INSTALL_REDIS: "true"
    REDIS_ARCHITECTURE: replication
    REDIS_PASSWORD: ${{ secrets.REDIS_PASSWORD }}
    REDIS_REPLICA_COUNT: "5"
    REDIS_STORAGE_SIZE: 20Gi
    REDIS_STORAGE_CLASS: premium-ssd

    # MongoDB replicaset with 5 replicas
    INSTALL_MONGODB: "true"
    MONGODB_ARCHITECTURE: replicaset
    MONGODB_ROOT_PASSWORD: ${{ secrets.MONGODB_PASSWORD }}
    MONGODB_REPLICA_COUNT: "5"
    MONGODB_STORAGE_SIZE: 30Gi
    MONGODB_STORAGE_CLASS: premium-ssd
```

#### With Kubernetes Context Setup

```yaml
- uses: one-acre-fund/oaf-actions/database-persistence@main
  with:
    # Optional: Set context inline
    K8S_URL: ${{ secrets.K8S_URL }}
    K8S_SECRET: ${{ secrets.K8S_SECRET }}

    NAMESPACE: my-namespace
    INSTALL_POSTGRES: "true"
    POSTGRES_DATABASE_PASSWORD: ${{ secrets.DB_PASSWORD }}
```

### Architecture Decisions

1. **set_context Handling**: The wrapper includes an optional step to call `set_context` if `K8S_URL` is provided. However, it's recommended to call `set_context` separately before using this action for better clarity and separation of concerns.

2. **Local Action References**: All database actions are referenced using relative paths (`./db`, `./redis`, etc.) which works when this action is part of the same repository.

3. **Image Pull Secrets**: All databases share the same `IMAGE_PULL_SECRET_NAME` for consistency. Individual databases can still be deployed with different secrets if needed by using them directly.

4. **Minimal Required Inputs**: Only `NAMESPACE` and database-specific passwords are required. All other inputs have sensible defaults.

### Individual Database Actions

If you need more fine-grained control or want to use advanced features, you can use the individual database actions directly:

- **PostgreSQL**: `one-acre-fund/oaf-actions/db@main`
- **Redis**: `one-acre-fund/oaf-actions/redis@main`
- **MongoDB**: `one-acre-fund/oaf-actions/mongodb@main`
- **Couchbase**: `one-acre-fund/oaf-actions/couchbase_dependencies@main`

Each action has its own README with detailed configuration options.
