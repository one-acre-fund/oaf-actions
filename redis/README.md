## Helm Redis

### Description

GitHub Action for deploying production-grade Redis with Helm. Supports AOF/RDB persistence, eviction policies, authentication, and standalone or replication architectures.

### Inputs

| name | description | required | default |
| --- | --- | --- | --- |
| `NAMESPACE` | The namespace to deploy the Redis server to. | `true` | `""` |
| `RELEASE_NAME` | The name of the release for the Redis server. | `true` | `redis` |
| `INSTALL_REDIS` | Whether to install Redis or not. | `true` | `false` |
| `IMAGE_PULL_SECRET_NAME` | The name of the image pull secret to use for pulling the Redis image. | `false` | `dockerhub-secret` |
| `REDIS_ARCHITECTURE` | Redis architecture: standalone or replication. | `false` | `standalone` |
| `REDIS_IMAGE_REPOSITORY` | The image repository for the Redis server. | `false` | `bitnami/redis` |
| `REDIS_IMAGE_TAG` | The image tag for the Redis server. | `false` | `7.4` |
| `REDIS_AUTH_ENABLED` | Whether to enable Redis authentication. | `false` | `true` |
| `REDIS_PASSWORD` | The password for the Redis server. Required if AUTH_ENABLED is true. | `false` | `""` |
| `REDIS_AOF_ENABLED` | Enable AOF (Append Only File) persistence. | `false` | `true` |
| `REDIS_AOF_FSYNC` | AOF fsync policy: always, everysec, or no. | `false` | `everysec` |
| `REDIS_RDB_ENABLED` | Enable RDB persistence (snapshotting). | `false` | `true` |
| `REDIS_MAXMEMORY_POLICY` | Redis eviction policy. | `false` | `allkeys-lru` |
| `REDIS_MAXMEMORY` | Maximum memory Redis can use (e.g., 256mb, 1gb). | `false` | `""` |
| `REDIS_STORAGE_CLASS` | The storage class for Redis persistent storage. | `false` | `""` |
| `REDIS_STORAGE_SIZE` | The storage size for Redis persistent storage. | `false` | `8Gi` |
| `REDIS_CPU_LIMIT` | The CPU limit for the Redis master/standalone node. | `false` | `1` |
| `REDIS_MEMORY_LIMIT` | The memory limit for the Redis master/standalone node. | `false` | `1Gi` |
| `REDIS_CPU_REQUEST` | The CPU request for the Redis master/standalone node. | `false` | `500m` |
| `REDIS_MEMORY_REQUEST` | The memory request for the Redis master/standalone node. | `false` | `512Mi` |
| `REDIS_REPLICA_COUNT` | Number of Redis replicas (replication mode only). | `false` | `3` |
| `REDIS_REPLICA_CPU_LIMIT` | The CPU limit for Redis replica nodes. | `false` | `1` |
| `REDIS_REPLICA_MEMORY_LIMIT` | The memory limit for Redis replica nodes. | `false` | `1Gi` |
| `REDIS_REPLICA_CPU_REQUEST` | The CPU request for Redis replica nodes. | `false` | `500m` |
| `REDIS_REPLICA_MEMORY_REQUEST` | The memory request for Redis replica nodes. | `false` | `512Mi` |
| `REDIS_AOF_AUTO_FIX` | Run redis-check-aof --fix on startup to repair corrupted AOF files. | `false` | `false` |
| `EXTENDED_CONFIGURATION` | Additional Redis configuration parameters (one per line). | `false` | `""` |

### Eviction Policies

Available values for `REDIS_MAXMEMORY_POLICY`:

| Policy | Description |
| --- | --- |
| `noeviction` | Return errors when memory limit is reached |
| `allkeys-lru` | Evict least recently used keys first (default) |
| `volatile-lru` | Evict least recently used keys with TTL set |
| `allkeys-random` | Evict random keys |
| `volatile-random` | Evict random keys with TTL set |
| `volatile-ttl` | Evict keys with shortest TTL |
| `allkeys-lfu` | Evict least frequently used keys |
| `volatile-lfu` | Evict least frequently used keys with TTL set |

### AOF Fsync Policies

Available values for `REDIS_AOF_FSYNC`:

| Policy | Description |
| --- | --- |
| `always` | Fsync after every write (slowest, safest) |
| `everysec` | Fsync once per second (recommended for production) |
| `no` | Let the OS handle fsyncing (fastest, least safe) |

### Runs

This action is a `composite` action.

### Usage

#### Standalone with Authentication (Production)

```yaml
- uses: one-acre-fund/oaf-actions/redis@main
  with:
    NAMESPACE: my-namespace
    RELEASE_NAME: redis
    INSTALL_REDIS: "true"
    REDIS_ARCHITECTURE: standalone
    REDIS_AUTH_ENABLED: "true"
    REDIS_PASSWORD: ${{ secrets.REDIS_PASSWORD }}
    REDIS_AOF_ENABLED: "true"
    REDIS_AOF_FSYNC: everysec
    REDIS_MAXMEMORY_POLICY: allkeys-lru
    REDIS_MAXMEMORY: 512mb
    REDIS_STORAGE_SIZE: 10Gi
```

#### Replication Mode (High Availability)

```yaml
- uses: one-acre-fund/oaf-actions/redis@main
  with:
    NAMESPACE: my-namespace
    RELEASE_NAME: redis
    INSTALL_REDIS: "true"
    REDIS_ARCHITECTURE: replication
    REDIS_AUTH_ENABLED: "true"
    REDIS_PASSWORD: ${{ secrets.REDIS_PASSWORD }}
    REDIS_AOF_ENABLED: "true"
    REDIS_AOF_FSYNC: everysec
    REDIS_RDB_ENABLED: "true"
    REDIS_MAXMEMORY_POLICY: volatile-lru
    REDIS_REPLICA_COUNT: "3"
    REDIS_STORAGE_CLASS: premium-ssd
    REDIS_STORAGE_SIZE: 20Gi
    REDIS_CPU_LIMIT: "2"
    REDIS_MEMORY_LIMIT: 2Gi
```

#### With AOF Auto-Fix (Prevents Corruption Issues)

```yaml
- uses: one-acre-fund/oaf-actions/redis@main
  with:
    NAMESPACE: my-namespace
    RELEASE_NAME: redis
    INSTALL_REDIS: "true"
    REDIS_ARCHITECTURE: replication
    REDIS_AUTH_ENABLED: "true"
    REDIS_PASSWORD: ${{ secrets.REDIS_PASSWORD }}
    REDIS_AOF_ENABLED: "true"
    REDIS_AOF_AUTO_FIX: "true"
    REDIS_STORAGE_SIZE: 20Gi
```

#### Without Authentication (Development/Testing)

```yaml
- uses: one-acre-fund/oaf-actions/redis@main
  with:
    NAMESPACE: dev
    RELEASE_NAME: redis-dev
    INSTALL_REDIS: "true"
    REDIS_ARCHITECTURE: standalone
    REDIS_AUTH_ENABLED: "false"
    REDIS_AOF_ENABLED: "false"
    REDIS_RDB_ENABLED: "false"
```

#### Full Configuration Reference

```yaml
- uses: one-acre-fund/oaf-actions/redis@main
  with:
    NAMESPACE:
    # The namespace to deploy the Redis server to.
    #
    # Required: true

    RELEASE_NAME:
    # The name of the release for the Redis server.
    #
    # Required: true
    # Default: redis

    INSTALL_REDIS:
    # Whether to install Redis or not.
    #
    # Required: true
    # Default: false

    IMAGE_PULL_SECRET_NAME:
    # The name of the image pull secret.
    #
    # Required: false
    # Default: dockerhub-secret

    REDIS_ARCHITECTURE:
    # Redis architecture: standalone or replication.
    #
    # Required: false
    # Default: standalone

    REDIS_IMAGE_REPOSITORY:
    # The image repository for the Redis server.
    #
    # Required: false
    # Default: bitnami/redis

    REDIS_IMAGE_TAG:
    # The image tag for the Redis server.
    #
    # Required: false
    # Default: 7.4

    REDIS_AUTH_ENABLED:
    # Whether to enable Redis authentication.
    #
    # Required: false
    # Default: true

    REDIS_PASSWORD:
    # The password for the Redis server.
    #
    # Required: false (required if AUTH_ENABLED is true)

    REDIS_AOF_ENABLED:
    # Enable AOF (Append Only File) persistence.
    #
    # Required: false
    # Default: true

    REDIS_AOF_FSYNC:
    # AOF fsync policy: always, everysec, or no.
    #
    # Required: false
    # Default: everysec

    REDIS_RDB_ENABLED:
    # Enable RDB persistence (snapshotting).
    #
    # Required: false
    # Default: true

    REDIS_MAXMEMORY_POLICY:
    # Redis eviction policy.
    #
    # Required: false
    # Default: allkeys-lru

    REDIS_MAXMEMORY:
    # Maximum memory Redis can use (e.g., 256mb, 1gb).
    #
    # Required: false

    REDIS_STORAGE_CLASS:
    # The storage class for Redis persistent storage.
    #
    # Required: false

    REDIS_STORAGE_SIZE:
    # The storage size for Redis persistent storage.
    #
    # Required: false
    # Default: 8Gi

    REDIS_CPU_LIMIT:
    # The CPU limit for the Redis master/standalone node.
    #
    # Required: false
    # Default: 1

    REDIS_MEMORY_LIMIT:
    # The memory limit for the Redis master/standalone node.
    #
    # Required: false
    # Default: 1Gi

    REDIS_CPU_REQUEST:
    # The CPU request for the Redis master/standalone node.
    #
    # Required: false
    # Default: 500m

    REDIS_MEMORY_REQUEST:
    # The memory request for the Redis master/standalone node.
    #
    # Required: false
    # Default: 512Mi

    REDIS_REPLICA_COUNT:
    # Number of Redis replicas (replication mode only).
    #
    # Required: false
    # Default: 3

    REDIS_REPLICA_CPU_LIMIT:
    # The CPU limit for Redis replica nodes.
    #
    # Required: false
    # Default: 1

    REDIS_REPLICA_MEMORY_LIMIT:
    # The memory limit for Redis replica nodes.
    #
    # Required: false
    # Default: 1Gi

    REDIS_REPLICA_CPU_REQUEST:
    # The CPU request for Redis replica nodes.
    #
    # Required: false
    # Default: 500m

    REDIS_REPLICA_MEMORY_REQUEST:
    # The memory request for Redis replica nodes.
    #
    # Required: false
    # Default: 512Mi

    REDIS_AOF_AUTO_FIX:
    # Run redis-check-aof --fix on startup to repair corrupted AOF files.
    # Useful for preventing Redis startup failures due to AOF corruption.
    #
    # Required: false
    # Default: false

    EXTENDED_CONFIGURATION:
    # Additional Redis configuration parameters (one per line).
    #
    # Required: false
```
