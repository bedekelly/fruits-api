FROM python
MAINTAINER me@bede.io
EXPOSE 80

# Install nginx and nano.
RUN apt-get update     &&         \
    apt-get upgrade -y &&         \
    apt-get install -y            \
        nginx                     \
	nano           &&         \
    apt-get clean      &&         \
    rm -rf /var/lib/apt/lists/*   \
           /tmp/*                 \
	   /var/tmp/*

# Install Python dependencies
COPY ops/requirements.txt /tmp/
RUN pip install -r /tmp/requirements.txt

# Configure nginx.
COPY ops/nginx.conf /etc/nginx/nginx.conf

# Copy our source code.
COPY src/fruitsapi /src/fruitsapi

# Run Gunicorn and nginx as a reverse proxy.
WORKDIR /src
CMD nginx &&                         \
    gunicorn                         \
      --workers 9                    \
      fruitsapi:app		     \
