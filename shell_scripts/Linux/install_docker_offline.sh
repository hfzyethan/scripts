#!/bin/bash

###################################
# 1. install docker-ce
# 2. write service
# 3. start docker service
# 4. install bash-completion <optional>
###################################

usage(){
    echo "Usage: $0 [-f docker_tgz_file] [-t offline]"
    echo "eg:    sudo bash $0 -f docker-19.03.3.tgz -t offline"
    echo "------------------------------"
    echo "Get docker-ce binary from: https://download.docker.com/linux/static/stable/"
    echo "choose your hardware platform and download the .tgz file relating to the version of Docker Engine."
    echo "eg:  wget https://download.docker.com/linux/static/stable/x86_64/docker-19.03.4.tgz"
    echo ""
}

check_system(){
    if [[ -z `command -v systemctl` ]]; then
        echo "systemd must be installed.\n"
        exit 1
    fi

    if [[ -z `uname -a | grep x86_64` ]]; then
        echo "docker only support 64-bit system.\n"
        exit 1
    fi
}

check_file(){
    local binary_file=$1
    if [ ! -e $binary_file ]; then
        echo "docker binary file ${binary_file} does not exist!\n"
        exit 1
    elif [ ! -f $binary_file ]; then
        echo "${binary_file} is not a file.\n"
        exit 1
    fi

    # file exist
    DOCKER_FILE_NAME=$(echo ${binary_file##*/})
    DOCKER_FILE_PATH=$(get_full_path ${binary_file})

    # .tgz or .tar.gz
    if [[ ! $DOCKER_FILE_NAME =~ ".tgz" && ! $DOCKER_FILE_NAME =~ ".tar.gz" ]]; then
        echo "$DOCKER_FILE_NAME is not tgz or tar.gz file.\n"
        exit 1
    fi
}

get_full_path(){
    local current_path=`pwd`
    if [ -d $1 ]; then
        cd $1
    elif [ -f $1 ]; then
        cd `dirname $1`
    fi
    echo $(cd ..;cd -)
}

create_socket_file(){
    if [ ! -d /usr/lib/systemd/system ]; then
        mkdir -p /usr/lib/systemd/system
    fi
    cat > /usr/lib/systemd/system/docker.socket << EOF
[Unit]
Description=Docker Socket for the API
PartOf=docker.service

[Socket]
# If /var/run is not implemented as a symlink to /run, you may need to
# specify ListenStream=/var/run/docker.sock instead.
ListenStream=/run/docker.sock
SocketMode=0660
SocketUser=root
SocketGroup=docker

[Install]
WantedBy=sockets.target
EOF
}

create_service_file(){
    if [ ! -d /usr/lib/systemd/system ]; then
        mkdir -p /usr/lib/systemd/system
    fi
    cat > /usr/lib/systemd/system/docker.service << EOF
[Unit]
Description=Docker Application Container Engine
Documentation=https://docs.docker.com
After=network-online.target firewalld.service
Wants=network-online.target

[Service]
Type=notify
# the default is not to use systemd for cgroups because the delegate issues still
# exists and systemd currently does not support the cgroup feature set required
# for containers run by docker
ExecStart=/usr/bin/dockerd
ExecReload=/bin/kill -s HUP $MAINPID
# Having non-zero Limit*s causes performance problems due to accounting overhead
# in the kernel. We recommend using cgroups to do container-local accounting.
LimitNOFILE=infinity
LimitNPROC=infinity
LimitCORE=infinity
# Uncomment TasksMax if your systemd version supports it.
# Only systemd 226 and above support this version.
#TasksMax=infinity
TimeoutStartSec=0
# set delegate yes so that systemd does not reset the cgroups of docker containers
Delegate=yes
# kill only the docker process, not all processes in the cgroup
KillMode=process
# restart the docker process if it exits prematurely
Restart=on-failure
StartLimitBurst=3
StartLimitInterval=60s

[Install]
WantedBy=multi-user.target
EOF
}

do_install(){

    # system check
    check_system

    task=$1
    if [ $task == "online" ]; then
        online_install
    fi
    offline_install

    # create service and socket file
    create_socket_file
    create_service_file

    systemctl daemon-reload
    systemctl enable docker.service
    systemctl start docker

    echo "`docker --version` success installed.\n"
}

# online_install(){}

offline_install(){
    local current_path=`pwd`
    cd $DOCKER_FILE_PATH
    tar xzpf $DOCKER_FILE_NAME
    cp -rf docker/* /usr/bin/
    rm -rf docker/
    cd $current_path
}

# install_bash_completion(){}

# auto_install(){}

# get all parameters
while [ $# > 0 ]; do
    value="$1"
    case $value in
        -f|--file)
            DOCKER_TGZ_FILE="$2"
            check_file $DOCKER_TGZ_FILE
            shift 2
            ;;
        -t|--task)
            task="$2"
            do_install $task
            shift 2
            ;;
        -h|--help)
            usage
            exit 1
            ;;
        *)
            exit 1
            ;;
    esac
done
