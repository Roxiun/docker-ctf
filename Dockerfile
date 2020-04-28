FROM ubuntu:18.04
ENV LC_CTYPE C.UTF-8
ENV TZ=Australia/Perth
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# add i386, update everything and install some tools
RUN dpkg --add-architecture i386 && \
apt-get update && \
apt-get install -y \
    strace \
    ltrace \
    curl \
    wget \
    gcc \
    net-tools \
    vim \
    gdb \
    python \
    python-pip \
    python3 \
    python3-pip \
    wget \
    git \
    dirb \
    vim-nox \
    netcat \
    make \
    patchelf \
    procps \
    libpcre3-dev \
    ruby \
    ruby-dev \
    libdb-dev \
    libxt-dev \
    libxaw7-dev \
    libc6:i386 \
    file \
    build-essential \
    exiftool \
    libncurses5:i386 \
    sudo \
    nano \
    tk-dev \
    pandoc \
    libssl-dev \
    libffi-dev \
    libgd-dev \
    stegsnow \
    steghide \
    apktool \
    nodejs \
    binwalk \
    python-tk \
    bison \ 
    tmux \
    golang \
    libstdc++6:i386

RUN DEBIAN_FRONTEND=noninteractive \
    apt install -y git sudo bash make nano vim zsh tmux cmake binutils nasm gcc gdb g++ gcc-multilib g++-multilib \
    build-essential libc6-dev-i386 libc6-dbg libc6-dbg:i386 libstdc++6:i386 \
    python python-pip python3 python3-pip curl netcat htop iotop iftop man strace ltrace wget \
    manpages-posix manpages-posix-dev libgmp3-dev libmpfr-dev libmpc-dev \
    nmap zmap libssl-dev inetutils-ping dnsutils whois mtr net-tools iproute2 tzdata ruby

RUN apt-get install -y \
	python-tk \
	tk-dev \
	libffi-dev \
	libssl-dev \
	pandoc \
	libgmp3-dev \
	libzbar-dev \
	tesseract-ocr \
	xsel \
	libpoppler-cpp-dev \
	libmpc-dev \
	libdbus-glib-1-dev \
	ruby \
	libenchant-dev \
	apktool \
	nodejs \
	groff \
	binwalk \
	foremost \
	tcpflow \
	poppler-utils \
	exiftool \
	steghide \
	stegsnow \
	bison \
	ffmpeg \
	libgd-dev \
    python3-venv \
	less


RUN (wget -q -O- https://github.com/hugsy/gef/raw/master/scripts/gef.sh | sh)

RUN pip install \
    capstone \
    requests \
    pwntools \
    r2pipe

RUN pip3 install \
    unicorn \
    capstone \
    ropper \
    pwntools \
    ROPgadget \
    keystone-engine

RUN gem install rdoc --no-document
RUN gem install zsteg


RUN mkdir /tools && cd /tools && \
    git clone https://github.com/JonathanSalwan/ROPgadget && \
    git clone https://github.com/radare/radare2 && \
    cd radare2 && sys/install.sh

RUN git clone https://github.com/pwndbg/pwndbg && cd pwndbg && ./setup.sh && cd .. && \
    git clone https://github.com/Ganapati/RsaCtfTool.git ~/RsaCtfTool && \
    git clone https://github.com/scwuaptx/peda.git ~/peda && cp ~/peda/.inputrc ~/ && \
    git clone https://github.com/scwuaptx/Pwngdb.git ~/Pwngdb && \
    sudo rm -rf ~/.cache/pip && \
    sudo gem install one_gadget

#ZSH Scripts
RUN sh -c "\$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" || true && \
    curl https://raw.githubusercontent.com/zzh1996/zshrc/master/zshrc.sh > ~/.zshrc.sh && \
    #sed -i '/source \\\$ZSH\/oh-my-zsh.sh/isource ~/.zshrc.sh' ~/.zshrc && \
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions && \
    git clone https://github.com/zsh-users/zsh-completions ~/.oh-my-zsh/custom/plugins/zsh-completions && \
    git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting && \
    curl https://raw.githubusercontent.com/wklken/vim-for-server/master/vimrc > ~/.vimrc

# Katana Scripts
RUN cd / && git clone --recursive https://github.com/JohnHammond/katana.git /katana
RUN cd /katana && pip install -r requirements.txt && python3 -m venv env && python setup.py install

