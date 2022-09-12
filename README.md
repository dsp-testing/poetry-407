
# Poetry HTTP 407 Bug

This recreates a bug in Poetry where it fails to authenticate with a proxy that requires authentication.

## Steps to reproduce

Requires Docker since there's a bit of setup involved.

1. Run `docker run -it --rm $(docker build -q .)`
2. Inside the container, run `./script.sh`
3. There will be a 407 error

While still in the container, try `curl https://example.com`, it works.

### Explanation

The script runs `mitmproxy` which is [configured to require authentication](mitm-config.yaml). Poetry is configured to use the proxy via environment variables in the Dockerfile. 

The problem correlates with the git source in `pyproject.toml`. Remove it and the problem is gone.

> **Note** This is somewhat mitigated by https://github.com/python-poetry/poetry/pull/6131. Most people will pin to a revision or tag and not see this issue after Poetry's next release.
