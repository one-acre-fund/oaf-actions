## Helm MongoDB

### Description

GitHub Action for deploying production-grade MongoDB with Helm. Supports authentication, standalone or replicaset architectures, and customizable resource allocation.

### Inputs

| name | description | required | default |
| --- | --- | --- | --- |
| `NAMESPACE` | The namespace to deploy the MongoDB server to. | `true` | `""` |
| `RELEASE_NAME` | The name of the release for the MongoDB server. | `true` | `mongodb` |
| `INSTALL_MONGODB` | Whether to install MongoDB or not. | `true` | `false` |
| `IMAGE_PULL_SECRET_NAME` | The name of the image pull secret. | `false` | `dockerhub-secret` |
| `MONGODB_ARCHITECTURE` | MongoDB architecture: standalone or replicaset. | `false` | `standalone` |
| `MONGODB_IMAGE_REPOSITORY` | The image repository for the MongoDB server. | `false` | `bitnamilegacy/mongodb` |
| `MONGODB_IMAGE_TAG` | The image tag for the MongoDB server. | `false` | `8.0` |
| `MONGODB_ROOT_PASSWORD` | The root password for the MongoDB server. | `true` | `""` |
| `MONGODB_ROOT_USER` | The root username for the MongoDB server. | `false` | `root` |
| `MONGODB_USERNAME` | Optional custom username for MongoDB. | `false` | `""` |
| `MONGODB_PASSWORD` | Password for the custom MongoDB user. | `false` | `""` |
| `MONGODB_DATABASE` | Database name for the custom MongoDB user. | `false` | `""` |
| `MONGODB_REPLICA_SET_NAME` | The replica set name (replicaset mode only). | `false` | `rs0` |
| `MONGODB_REPLICA_COUNT` | Number of MongoDB replicas (replicaset mode only). | `false` | `3` |
| `MONGODB_REPLICA_SET_KEY` | The replica set key for authentication (replicaset mode only). | `false` | `""` |
| `MONGODB_STORAGE_CLASS` | The storage class for MongoDB persistent storage. | `false` | `""` |
| `MONGODB_STORAGE_SIZE` | The storage size for MongoDB persistent storage. | `false` | `8Gi` |
| `MONGODB_CPU_LIMIT` | The CPU limit for MongoDB nodes. | `false` | `1` |
| `MONGODB_MEMORY_LIMIT` | The memory limit for MongoDB nodes. | `false` | `2Gi` |
| `MONGODB_CPU_REQUEST` | The CPU request for MongoDB nodes. | `false` | `500m` |
| `MONGODB_MEMORY_REQUEST` | The memory request for MongoDB nodes. | `false` | `1Gi` |
| `EXTENDED_CONFIGURATION` | Additional MongoDB configuration parameters. | `false` | `""` |

### Runs

This action is a `composite` action.

### Usage

#### Standalone Mode (Development)

```yaml
- uses: one-acre-fund/oaf-actions/mongodb@main
  with:
    NAMESPACE: my-namespace
    RELEASE_NAME: mongodb
    INSTALL_MONGODB: "true"
    MONGODB_ARCHITECTURE: standalone
    MONGODB_ROOT_PASSWORD: ${{ secrets.MONGODB_ROOT_PASSWORD }}
    MONGODB_STORAGE_SIZE: 10Gi
```

#### ReplicaSet Mode (Production)

```yaml
- uses: one-acre-fund/oaf-actions/mongodb@main
  with:
    NAMESPACE: production
    RELEASE_NAME: mongodb
    INSTALL_MONGODB: "true"
    MONGODB_ARCHITECTURE: replicaset
    MONGODB_ROOT_PASSWORD: ${{ secrets.MONGODB_ROOT_PASSWORD }}
    MONGODB_REPLICA_COUNT: "3"
    MONGODB_STORAGE_CLASS: premium-ssd
    MONGODB_STORAGE_SIZE: 20Gi
    MONGODB_CPU_LIMIT: "2"
    MONGODB_MEMORY_LIMIT: 4Gi
```

#### With Custom User and Database

```yaml
- uses: one-acre-fund/oaf-actions/mongodb@main
  with:
    NAMESPACE: my-namespace
    RELEASE_NAME: mongodb
    INSTALL_MONGODB: "true"
    MONGODB_ARCHITECTURE: standalone
    MONGODB_ROOT_PASSWORD: ${{ secrets.MONGODB_ROOT_PASSWORD }}
    MONGODB_USERNAME: appuser
    MONGODB_PASSWORD: ${{ secrets.MONGODB_APP_PASSWORD }}
    MONGODB_DATABASE: myapp
    MONGODB_STORAGE_SIZE: 15Gi
```

#### Full Configuration Reference

```yaml
- uses: one-acre-fund/oaf-actions/mongodb@main
  with:
    NAMESPACE:
    # The namespace to deploy the MongoDB server to.
    #
    # Required: true

    RELEASE_NAME:
    # The name of the release for the MongoDB server.
    #
    # Required: true
    # Default: mongodb

    INSTALL_MONGODB:
    # Whether to install MongoDB or not.
    #
    # Required: true
    # Default: false

    IMAGE_PULL_SECRET_NAME:
    # The name of the image pull secret.
    #
    # Required: false
    # Default: dockerhub-secret

    MONGODB_ARCHITECTURE:
    # MongoDB architecture: standalone or replicaset.
    #
    # Required: false
    # Default: standalone

    MONGODB_IMAGE_REPOSITORY:
    # The image repository for the MongoDB server.
    #
    # Required: false
    # Default: bitnamilegacy/mongodb

    MONGODB_IMAGE_TAG:
    # The image tag for the MongoDB server.
    #
    # Required: false
    # Default: 8.0

    MONGODB_ROOT_PASSWORD:
    # The root password for the MongoDB server.
    #
    # Required: true

    MONGODB_ROOT_USER:
    # The root username for the MongoDB server.
    #
    # Required: false
    # Default: root

    MONGODB_USERNAME:
    # Optional custom username for MongoDB.
    #
    # Required: false

    MONGODB_PASSWORD:
    # Password for the custom MongoDB user.
    #
    # Required: false

    MONGODB_DATABASE:
    # Database name for the custom MongoDB user.
    #
    # Required: false

    MONGODB_REPLICA_SET_NAME:
    # The replica set name (replicaset mode only).
    #
    # Required: false
    # Default: rs0

    MONGODB_REPLICA_COUNT:
    # Number of MongoDB replicas (replicaset mode only).
    #
    # Required: false
    # Default: 3

    MONGODB_REPLICA_SET_KEY:
    # The replica set key for authentication (replicaset mode only).
    #
    # Required: false

    MONGODB_STORAGE_CLASS:
    # The storage class for MongoDB persistent storage.
    #
    # Required: false

    MONGODB_STORAGE_SIZE:
    # The storage size for MongoDB persistent storage.
    #
    # Required: false
    # Default: 8Gi

    MONGODB_CPU_LIMIT:
    # The CPU limit for MongoDB nodes.
    #
    # Required: false
    # Default: 1

    MONGODB_MEMORY_LIMIT:
    # The memory limit for MongoDB nodes.
    #
    # Required: false
    # Default: 2Gi

    MONGODB_CPU_REQUEST:
    # The CPU request for MongoDB nodes.
    #
    # Required: false
    # Default: 500m

    MONGODB_MEMORY_REQUEST:
    # The memory request for MongoDB nodes.
    #
    # Required: false
    # Default: 1Gi

    EXTENDED_CONFIGURATION:
    # Additional MongoDB configuration parameters.
    #
    # Required: false
```
