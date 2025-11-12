# Post-Deployment Test and Rollback Action

A reusable GitHub composite action that runs post-deployment tests and automatically rolls back on failure.

## Features

- ✅ **Automated Testing**: Runs custom test scripts after deployment
- 🔄 **Automatic Rollback**: Reverts to previous Helm revision on test failure
- ✅ **Rollback Verification**: Re-runs tests after rollback to ensure system health
- 📊 **Detailed Reporting**: Generates GitHub Actions step summary
- 📢 **Slack Notifications**: Sends alerts on both deployment success and rollback events
- 🎯 **Flexible**: Supports custom test scripts and environment variables
- 🔒 **Safe**: Prevents rollback on first deployment (no previous revision)

## Usage

### 1. Capture Current Revision (Before Deployment)

```yaml
- name: Capture Current Helm Revision
  id: pre_deploy
  run: |
    CURRENT_REVISION=$(helm list -n ${{ env.NAMESPACE }} -o json | jq -r '.[] | select(.name=="${{ env.RELEASE_NAME }}") | .revision' || echo "0")
    echo "current_revision=$CURRENT_REVISION" >> $GITHUB_OUTPUT
  continue-on-error: true
```

### 2. Deploy Your Application

```yaml
- name: Deploy Application
  run: |
    helm upgrade --install myapp ./charts/myapp -n myapp
```

### 3. Run Post-Deployment Tests

```yaml
- name: Run Post-Deployment Tests and Rollback
  uses: "./.github/actions/post_deployment_test"
  with:
    namespace: myapp
    release_name: myapp
    test_script: scripts/myapp-post-deployment-test.sh
    pre_deploy_revision: ${{ steps.pre_deploy.outputs.current_revision }}
    enable_rollback: 'true'
    rollback_timeout: '5m'
    slack_webhook_url: ${{ secrets.SLACK_WEBHOOK_URL }}
    slack_channel: '#deployment-alerts'
    environment: 'Production'  # Integration, QA, UAT, or Production
    github_run_url: ${{ github.server_url }}/${{ github.repository }}/actions/runs/${{ github.run_id }}
    test_env_vars: |
      {
        "ENABLE_DATABASE": "true",
        "SKIP_ENDPOINT_TEST": "false"
      }
```

## Inputs

| Input | Description | Required | Default |
|-------|-------------|----------|---------|
| `namespace` | Kubernetes namespace | Yes | - |
| `release_name` | Helm release name | Yes | - |
| `test_script` | Path to test script (relative to repo root) | Yes | - |
| `pre_deploy_revision` | Helm revision before deployment | Yes | - |
| `enable_rollback` | Enable automatic rollback on failure | No | `true` |
| `rollback_timeout` | Timeout for rollback operation | No | `5m` |
| `test_env_vars` | Additional env vars for test script (JSON) | No | `{}` |
| `slack_webhook_url` | Slack webhook URL for notifications | No | `''` |
| `slack_channel` | Slack channel name (e.g., #deployments) | No | `#deployment-alerts` |
| `environment` | Deployment environment (Integration, QA, UAT, Production) | No | `''` |
| `github_run_url` | GitHub Actions run URL for linking | No | Auto-generated |

## Outputs

| Output | Description |
|--------|-------------|
| `test_result` | Result of tests (`passed` or `failed`) |
| `rollback_triggered` | Whether rollback was triggered (`true` or `false`) |
| `final_revision` | Final Helm revision after test/rollback |

## Slack Notifications

The action can send Slack notifications for both successful deployments and rollback events.

### Setup

1. Create a Slack Incoming Webhook:
   - Go to your Slack workspace settings
   - Create an Incoming Webhook for your desired channel
   - Copy the webhook URL

2. Add the webhook URL to GitHub Secrets:
   ```
   Settings > Secrets and Variables > Actions > New repository secret
   Name: SLACK_WEBHOOK_URL
   Value: https://hooks.slack.com/services/YOUR/WEBHOOK/URL
   ```

3. Configure in your workflow:
   ```yaml
   slack_webhook_url: ${{ secrets.SLACK_WEBHOOK_URL }}
   slack_channel: '#deployment-alerts'  # Optional
   environment: 'Production'  # Optional: Integration, QA, UAT, or Production
   ```

### Notification Types

**Success Notification** (Green):
- Sent when all post-deployment tests pass
- Includes: service name, environment, namespace, revision change, health status, deployed by, workflow link
- Color: `good` (green)
- Icon: `:rocket:`
- Environment-specific emojis:
  - Production: 🚀 `:rocket:`
  - QA: 🧪 `:test_tube:`
  - UAT: 🔍 `:mag:`
  - Integration: ⚙️ `:gear:`

**Rollback Notification** (Red):
- Sent when deployment fails and rollback is triggered
- Includes: service name, environment, namespace, rollback revision, rollback status, failure reason, deployed by, workflow link
- Color: `danger` (red)
- Icon: `:rotating_light:`

### Message Features

Both notification types include:
- **Emoji icons** for visual clarity and quick identification
- **Environment badges** with environment-specific emojis
- **Code-formatted values** for service names and technical details
- **Bold text** for environments and important values
- **Pretext headers** for at-a-glance status
- **Descriptive text** explaining the deployment outcome
- **Clickable buttons** to view workflow details
- **Footer** showing source (GitHub Actions • CD Pipeline)
- **Timestamps** for tracking deployment times

## Creating a Test Script

### Option 1: Use the Template

Copy the template and customize for your service:

```bash
cp scripts/post-deployment-test-template.sh scripts/myapp-post-deployment-test.sh
chmod +x scripts/myapp-post-deployment-test.sh
```

Edit the script and customize:
- Pod label selectors
- Service names
- Database/cache connectivity tests
- Health endpoint checks

### Option 2: Create Custom Script

Your test script must:
1. Accept configuration via environment variables
2. Exit with code `0` on success
3. Exit with non-zero code on failure

```bash
#!/bin/bash
set -e

# Get configuration from environment
NAMESPACE="${NAMESPACE:-default}"
RELEASE_NAME="${RELEASE_NAME:-myapp}"

# Run your tests
echo "Testing application health..."

# Check if pods are running
kubectl get pods -n "$NAMESPACE" -l "app=$RELEASE_NAME"

# Test service endpoint
kubectl exec -n "$NAMESPACE" deployment/$RELEASE_NAME -- curl -f http://localhost:8080/health

echo "All tests passed!"
exit 0
```

## Complete Example: Keycloak Deployment

```yaml
name: "Keycloak CD"
on:
  workflow_dispatch:

env:
  NAMESPACE: tools
  RELEASE_NAME: keycloak

jobs:
  QA:
    runs-on: ubuntu-latest
    environment:
      name: Keycloak-QA
    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Set up Kubernetes context
        uses: one-acre-fund/oaf-actions/set_context@1.0.0
        with:
          K8S_URL: "${{ secrets.K8S_QA_URL }}"
          K8S_SECRET: "${{ secrets.K8S_QA_DEFAULT }}"

      - name: Capture Current Helm Revision
        id: pre_deploy
        run: |
          CURRENT_REVISION=$(helm list -n ${{ env.NAMESPACE }} -o json | jq -r '.[] | select(.name=="${{ env.RELEASE_NAME }}") | .revision' || echo "0")
          echo "current_revision=$CURRENT_REVISION" >> $GITHUB_OUTPUT
        continue-on-error: true

      - name: Deploy Keycloak
        uses: "./.github/actions/helm_keycloak"
        with:
          NAMESPACE: ${{ env.NAMESPACE }}
          RELEASE_NAME: ${{ env.RELEASE_NAME }}
          KEYCLOAK_IMAGE_TAG: "${{ vars.KEYCLOAK_IMAGE_TAG }}"
          ADMIN_PASSWORD: "${{ secrets.KEYCLOAK_ADMIN_PASSWORD }}"
          # ... other inputs

      - name: Run Post-Deployment Tests and Rollback
        uses: "./.github/actions/post_deployment_test"
        with:
          namespace: ${{ env.NAMESPACE }}
          release_name: ${{ env.RELEASE_NAME }}
          test_script: scripts/keycloak-post-deployment-test.sh
          pre_deploy_revision: ${{ steps.pre_deploy.outputs.current_revision }}
          enable_rollback: 'true'
          rollback_timeout: '5m'
          test_env_vars: |
            {
              "ENABLE_POSTGRESQL": "${{ vars.KEYCLOAK_ENABLE_POSTGRESQL }}",
              "ADMIN_URL": "${{ vars.KEYCLOAK_FRONTEND_URL }}"
            }
```

## Testing Rollback Mechanism

To validate that rollback works correctly, add a workflow input:

```yaml
on:
  workflow_dispatch:
    inputs:
      force_test_failure:
        description: Force test failure to validate rollback
        type: boolean
        default: false
```

Then pass it to the test script:

```yaml
test_env_vars: |
  {
    "FORCE_TEST_FAILURE": "${{ github.event.inputs.force_test_failure }}"
  }
```

In your test script, add:

```bash
if [ "$FORCE_TEST_FAILURE" = "true" ]; then
    echo "[ERROR] FORCED TEST FAILURE - Testing rollback mechanism"
    exit 1
fi
```

## Workflow Execution Flow

### Success Flow
```
1. Capture revision (e.g., rev 5)
2. Deploy new version (creates rev 6)
3. Run tests ✅
4. Workflow succeeds
```

### Failure Flow with Rollback
```
1. Capture revision (e.g., rev 5)
2. Deploy new version (creates rev 6)
3. Run tests ❌
4. Trigger rollback to rev 5
5. Wait for rollback completion
6. Verify rollback succeeded ✅
7. Workflow fails (alerts team)
```

## GitHub Actions Summary

The action generates a summary visible in the GitHub Actions UI:

```markdown
## Post-Deployment Test Summary

**Release:** keycloak
**Namespace:** tools
**Pre-Deploy Revision:** 5
**Final Revision:** 6

✅ **Test Result:** Passed
✅ **Rollback:** Not needed
```

Or on failure:

```markdown
## Post-Deployment Test Summary

**Release:** keycloak
**Namespace:** tools
**Pre-Deploy Revision:** 5
**Final Revision:** 5

❌ **Test Result:** Failed
🔄 **Rollback:** Triggered and completed
```

## Best Practices

1. **Always capture revision before deployment**
   - Use `continue-on-error: true` to handle first deployments

2. **Keep test scripts fast**
   - Skip slow tests by default (use env vars to enable)
   - Use readiness probes as primary health signal

3. **Test the rollback mechanism**
   - Use `force_test_failure` on QA before production

4. **Monitor rollback events**
   - Check GitHub Actions step summaries
   - Set up alerts for rollback failures

5. **Production safety**
   - Never enable `force_test_failure` in production
   - Consider longer rollback timeouts for critical services

## Troubleshooting

### Rollback Not Triggered

**Issue:** Tests fail but rollback doesn't run

**Solutions:**
- Check `enable_rollback` is set to `'true'` (string, not boolean)
- Verify `pre_deploy_revision` is not `'0'`
- Check workflow logs for "Rollback conditions met" message

### Rollback Fails

**Issue:** Rollback times out or fails

**Solutions:**
- Increase `rollback_timeout` (default: 5m)
- Check Helm history: `helm history <release> -n <namespace>`
- Verify previous revision is valid
- Check pod resources aren't exhausted

### Tests Pass Locally But Fail in CI

**Issue:** Script works locally but not in GitHub Actions

**Solutions:**
- Check environment variables are passed correctly
- Verify kubectl context is set properly
- Ensure test script has correct permissions (`chmod +x`)
- Check script uses absolute paths, not relative

## Contributing

To improve this action:

1. Update `.github/actions/post_deployment_test/action.yml`
2. Test changes with Superset workflow first
3. Update this README with new features
4. Roll out to other services

## See Also

- [Test Script Template](../../../scripts/post-deployment-test-template.sh)
- [Superset Example](../../../.github/workflows/superset.yml)
- [Superset Test Script](../../../scripts/superset-post-deployment-test.sh)
