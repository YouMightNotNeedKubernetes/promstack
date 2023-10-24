# promstack
A simple development stack for Prometheus, Alertmanager and Grafana.

## Usage

You might need to create swarm-scoped overlay network called `promstack` for all the stacks to communicate if you haven't already.

```sh
$ docker network create --scope swarm --driver overlay --attachable promstack
```

### Deploy

To deploy the stack, run the following command:

```sh
$ make deploy
```

### Destroy

To destroy the stack, run the following command:

```sh
$ make destroy
```

## Sending metrics to Grafana Mimir

Add the following to your `prometheus.yml`:

```yaml
global:
  # Add this block to your global config
  external_labels:
      cluster: demo
      namespace: demo

# Set remote_write.url to your Grafana Mimir endpoint
remote_write:
  - url: http://mimir:3200/api/v1/push
    # If you enabled authentication, add the following
    headers:
      "X-Scope-OrgID": demo
```
