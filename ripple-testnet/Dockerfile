FROM ubuntu:latest

RUN export LANGUAGE=C.UTF-8; export LANG=C.UTF-8; export LC_ALL=C.UTF-8; export DEBIAN_FRONTEND=noninteractive

# install rippled
RUN apt-get update -y && \
    apt-get install wget -y && \
    cd /tmp && \
    wget https://repos.ripple.com/repos/rippled-deb/pool/stable/rippled_1.5.0-1_amd64.deb && \
    dpkg -i rippled_1.5.0-1_amd64.deb && \
    rm -rf /var/lib/apt/lists/*

RUN ln -s /opt/ripple/bin/rippled /usr/bin/rippled

COPY . /opt/ripple/etc
RUN chmod +x /opt/ripple/etc/entrypoint.sh
RUN chmod +x /opt/ripple/etc/die_gracefully.sh

EXPOSE 5005 5006

ENTRYPOINT [ "/opt/ripple/etc/entrypoint.sh" ]