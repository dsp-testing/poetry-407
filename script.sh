#!/bin/bash
set -e
# Start the proxy and give it time to start, otherwise the certs aren't ready
mitmdump &
sleep 2
# install certs system-wide
cp /root/.mitmproxy/mitmproxy-ca-cert.cer /usr/local/share/ca-certificates/mitm.crt
update-ca-certificates
# Poetry seems to prefer this environment variable
export REQUESTS_CA_BUNDLE="/root/.mitmproxy/mitmproxy-ca-cert.cer"
# Do the update
poetry update fastapi
# You can try what's on master with this line
# ~/.local/bin/poetry@git update fastapi
