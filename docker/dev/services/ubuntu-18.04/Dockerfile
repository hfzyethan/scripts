FROM ubuntu:18.04

ENV LANG=en_US.UTF-8
ENV LC_ALL=C.UTF-8

RUN cp -a /etc/apt/sources.list /etc/apt/sources.list.bak && \
    sed -i "s@http://.*archive.ubuntu.com@https://repo.huaweicloud.com@g" /etc/apt/sources.list && \
    sed -i "s@http://.*security.ubuntu.com@https://repo.huaweicloud.com@g" /etc/apt/sources.list && \

    sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list && \
    sed -i 's/security.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list && \
    apt-get update -y && \
    apt-get install -y gcc g++ rsync sudo automake autoconf libtool make cmake && \
    apt-get install -y ssh vim wget curl telnet openssl openssh-server gdb gdbserver && \
    apt-get install -y git subversion doxygen lighttpd net-tools inetutils-ping && \
    apt-get install -y libbz2-dev libdb++-dev libssl-dev libdb-dev libssl-dev \
    libreadline-dev libcurl4-openssl-dev libncurses-dev autotools-dev build-essential libicu-dev python-dev && \
    mkdir /var/run/sshd && \
    sed -i 's/#[ ]*Port[ ]*22/Port 36000/' /etc/ssh/sshd_config && \
    echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config && \
    mkdir /home/dev && \
    useradd -s /bin/bash dev && \
    echo "dev:dev" | chpasswd && \
    chown -R dev:dev /home/dev && \ 
    chmod 644 /etc/sudoers && \
    echo "dev ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    chmod 440 /etc/sudoers

EXPOSE 36000

CMD ["/usr/sbin/sshd", "-D"]
