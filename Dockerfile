FROM python

WORKDIR /app
RUN pip install mitmproxy pipx poetry
# Install Poetry from master to verify once it's fixed
RUN pipx install --force --suffix=@git 'poetry @ git+https://github.com/python-poetry/poetry.git'
ENV http_proxy="http://user:pass@localhost:8080"
ENV https_proxy="http://user:pass@localhost:8080"
COPY pyproject.toml .
COPY poetry.lock .
COPY script.sh .
COPY mitm-config.yaml /root/.mitmproxy/config.yaml

CMD /bin/bash
