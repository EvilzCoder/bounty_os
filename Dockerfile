# Kali Linux latest with useful tools by tsumarios
FROM kalilinux/kali-rolling

# Set working directory to /root
WORKDIR /root

# Update
RUN apt -y update && DEBIAN_FRONTEND=noninteractive apt -y dist-upgrade && apt -y autoremove && apt clean

# Install common and useful tools
RUN apt -y install curl wget vim git net-tools whois netcat-traditional pciutils usbutils

# Install useful languages
RUN apt -y install python3-pip golang nodejs npm

# Install Kali Linux "Top 10" metapackage and a few cybersecurity useful tools
RUN DEBIAN_FRONTEND=noninteractive apt -y install kali-tools-top10 exploitdb man-db dirb nikto wpscan uniscan lsof apktool dex2jar ltrace strace binwalk

# Install Tor and proxychains, then configure proxychains with Tor
RUN apt -y install tor proxychains
COPY config/proxychains.conf /etc/proxychains.conf

# Install ZSH shell with custom settings and set it as default shell
RUN apt -y install zsh
RUN sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
COPY config/.zshrc .

ENV PATH="$PATH:/root/go/bin/"

RUN apt install golang-go netcat-openbsd python3 python3-pip subfinder sublist3r amass assetfinder -y
RUN pip3 install arjun
RUN pip3 install uro

RUN go install github.com/hahwul/dalfox/v2@latest   
RUN go install github.com/projectdiscovery/katana/cmd/katana@latest
RUN go install github.com/lc/gau/v2/cmd/gau@latest
RUN go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest

RUN mkdir -p /root/programs

ENTRYPOINT ["/bin/zsh"]
