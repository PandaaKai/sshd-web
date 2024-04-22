FROM ubuntu:22.04
MAINTAINER "Panda Junkai"

# timezone
RUN apt update && apt install -y tzdata; \
    apt clean;

# sshd
RUN mkdir /run/sshd; \
    apt install -y openssh-server; \
    sed -i 's/^#\(PermitRootLogin\) .*/\1 yes/' /etc/ssh/sshd_config; \
    sed -i 's/^\(UsePAM yes\)/# \1/' /etc/ssh/sshd_config; \
    apt clean;

RUN apt-get update;\
    apt-get install -y nginx curl;

# entrypoint
RUN { \
    echo '#!/bin/bash -eu'; \
    echo 'service nginx start'; \
    echo 'ln -fs /usr/share/zoneinfo/${TZ} /etc/localtime'; \
    echo 'echo "root:${ROOT_PASSWORD}" | chpasswd'; \
    echo 'exec "$@"'; \
    } > /usr/local/bin/entry_point.sh; \
    chmod +x /usr/local/bin/entry_point.sh;

ENV TZ Asia/Shanghai
ENV WEB_PORT 8080
ENV ROOT_PASSWORD root@asdzxc

EXPOSE 22

ENTRYPOINT ["entry_point.sh"]
CMD ["/usr/sbin/sshd", "-D", "-e"]
