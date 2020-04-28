# docker-ctf
Simple Docker Image for solving ctfs

## Installation
`git clone https://github.com/Roxiun/docker-ctf/ && cd docker-ctf`
`docker build . -t docker-ctf -f Dockerfile`


## Usage
`docker run --privileged --rm -it -v $PWD:/ctf --cap-add=SYS_PTRACE  --security-opt seccomp=unconfined -p 127.0.0.1:5555:5555 -i docker-ctf /bin/bash`

Then run:
`cd /problems/`
