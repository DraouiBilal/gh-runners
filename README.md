# GitHub Actions Runner OCI Container

An OCI container for running GitHub Actions self-hosted runners with Podman support for container-based workflows.

## Features

- Ubuntu 22.04 base image
- GitHub Actions Runner (v2.331.0)
- Podman with docker compatibility layer for running containers
- Rootless container execution

## Configuration

### Config File Structure

Create a YAML configuration file with your runner settings. By default, the container looks for `config/runner-config.yaml`, but you can specify a custom path using the `RUNNER_CONFIG_FILE` environment variable.

**Example configuration (`config/runner-config.yaml`):**

```yaml
runner_config:
  url: "https://github.com/your-org/your-repo"
  labels: 
    - "linux"
    - "docker"
    - "self-hosted"
    - "podman"
  runner_group: "Default"
  work_directory: "_work"
```
### Configuration Parameters

| Parameter | Description | Example |
|-----------|-------------|---------|
| `url` | GitHub repository or organization URL | `https://github.com/myorg/myrepo` |
| `labels` | Array of labels for the runner | `["linux", "docker", "custom"]` |
| `runner_group` | Runner group name (org-level runners) | `Default` or `Production` |
| `work_directory` | Working directory for job execution | `_work` |

### Required Environment Variables

The following environment variables must be set when running the container:

- `TOKEN` - GitHub runner registration token (generate from repository/organization settings)
- `NAME` - Unique name for this runner instance

### Optional Environment Variables

- `RUNNER_CONFIG_FILE` - Path to custom config file (default: `config/runner-config.yaml`)

## Usage

### Building the Image

```bash
podman build -t github-actions-runner .
```

### Running the Container

```bash
podman run -d \
  --name my-runner \
  -e TOKEN="your-github-runner-token" \
  -e NAME="my-runner-01" \
  -v $(pwd)/config:/home/runner/actions-runner/config \
  github-actions-runner
```
