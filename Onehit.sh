#!/usr/bin/env bash

#################################################################
#################################################################
#################  Please Check Veriables #######################
################# Change them Accordingly #######################
#################################################################
#################################################################

## Variables
mkdir ~/tools
tools=~/tools
DEFAULT_SHELL=~/.bashrc                      #could be zshrc

## Making Directories
# Main Directories
mkdir $tools/asn $tools/subdomain $tools/cloud $tools/dork $tools/fingerprint $tools/content_discovery $tools/port_analysis $tools/wordlists

# Sub Directories
# Asn
asn_dir=$tools/asn

# SubDomain
subdom_dir=$tools/subdomain

# Cloud
cloud_dir=$tools/cloud

# Dork
dork_dir=$tools/dork

# Fingerprinting
fingerp_dir=$tools/fingerprint

# Content discovery
cont_disc_dir=$tools/content_discovery
mkdir $cont_disc_dir/crawlers $cont_disc_dir/js $cont_disc_dir/parameter_discovery $cont_disc_dir/Directory_Busting
## Variables for Content Discovery
js_dir=$cont_disc_dir/js
Direct_brute_dir=$cont_disc_dir/Directory_Busting
crawl_dir=$cont_disc_dir/crawlers

# Port Analysis
port_dir=$tools/port_analysis

# Wordlists
wordlist_dir=$tools/wordlists



logo(){
    echo -e "\e[91m
    ██████╗ ███╗   ██╗███████╗██╗  ██╗██╗████████╗
   ██╔═══██╗████╗  ██║██╔════╝██║  ██║██║╚══██╔══╝\e[0m \e[92m
   ██║   ██║██╔██╗ ██║█████╗  ███████║██║   ██║
   ██║   ██║██║╚██╗██║██╔══╝  ██╔══██║██║   ██║\e[0m \e[96m
   ╚██████╔╝██║ ╚████║███████╗██║  ██║██║   ██║
    ╚═════╝ ╚═╝  ╚═══╝╚══════╝╚═╝  ╚═╝╚═╝   ╚═╝\e[0m \e[95m
        One Hit To Install Them All\e[0m
  "
}
logo


# Prerequisite
Preq(){
    #apt-fast
    sudo add-apt-repository -y ppa:apt-fast/stable < /dev/null
    sudo echo debconf apt-fast/maxdownloads string 16 | debconf-set-selections
    sudo echo debconf apt-fast/dlflag boolean true | debconf-set-selections
    sudo echo debconf apt-fast/aptmanager string apt-get | debconf-set-selections
    sudo apt install -y apt-fast

    #https Transport
    sudo apt-fast install -y apt-transport-https

    #git
    sudo apt-fast install -y git

    #golang
    wget -q -O - https://raw.githubusercontent.com/canha/golang-tools-install-script/master/goinstall.sh | bash
    #Go Paths
    if ! grep -Fxq "GOPATH" "$DEFAULT_SHELL"; then
      export GOROOT=$HOME/.go
      export PATH=$GOROOT/bin:$PATH
      export GOPATH=$HOME/go
    echo 'export GOROOT=$HOME/.go' >> $DEFAULT_SHELL
    echo 'export GOPATH=$HOME/go' >> $DEFAULT_SHELL
    echo 'export PATH=$GOPATH/bin:$GOROOT/bin:$PATH' >> $DEFAULT_SHELL
    source $DEFAULT_SHELL
    fi
    source $DEFAULT_SHELL

    #python3-pip python python-pip
    sudo apt-fast install python3-pip
    sudo apt-fast install python
    curl https://bootstrap.pypa.io/get-pip.py --output get-pip.py
    sudo python2 get-pip.py
    rm get-pip.py

    #parallel
    sudo apt-fast install -y parallel
} > /dev/null 2>&1
Preq


# ASN Enumeration
echo "Downloading Tools Related To ASN Recon"
Asn_Enum(){
asn_dir=$tools/asn
cd $asn_dir

    #asnrecon
    git clone https://github.com/orlyjamie/asnrecon.git
    sudo python3 -m pip install -r asnrecon/requirements.txt

    #asnlookuup
    git clone https://github.com/yassineaboukir/Asnlookup
    sudo python3 -m pip install -r Asnlookup/requirements.txt

    #metabigor
    go get -u github.com/j3ssie/metabigor
} > /dev/null 2>&1
Asn_Enum


# Subdomain
echo "Downloading Tools Related To SubDomain Recon"
Subdomain_Enum(){
cd $subdom_dir

    #amass
    export GO111MODULE=on
    go get -u github.com/OWASP/Amass/v3/...

    #subfinder v2
    GO111MODULE=auto
    go get -u github.com/projectdiscovery/subfinder/cmd/subfinder

    #assetfinder
    go get -u github.com/tomnomnom/assetfinder

    #sublist3r
    git clone https://github.com/aboul3la/Sublist3r.git
    sudo python3 -m pip install -r Sublist3r/requirements.txt

    #altdns
    sudo python -m pip install py-altdns

    #dnsgen
    sudo python3 -m pip install dnsgen

    #tko-subs
    go get github.com/anshumanbh/tko-subs

    #subjack
    go get github.com/haccer/subjack
} > /dev/null 2>&1
Subdomain_Enum


# Cloud
echo "Downloading Tools Related To Cloud Recon"
Cloud_Enum(){
cd $cloud_dir

    #aws-cli
    sudo python3 -m pip install awscli

    #festin
    sudo python3 -m pip install festin

    #spaces-finder
    git clone https://github.com/appsecco/spaces-finder.git
    sudo python3 -m pip install -r spaces-finder/requirements.txt

    #git clonepbukcetbrute
    git clone https://github.com/RhinoSecurityLabs/GCPBucketBrute.git
    sudo python3 -m pip install -r GCPBucketBrute/requirements.txt

    #cloud_enum
    git clone https://github.com/initstring/cloud_enum.git
    sudo python3 -m pip install -r cloud_enum/requirements.txt
} > /dev/null 2>&1
Cloud_Enum


# Dork
echo "Downloading Tools Related To OSINT and Dorking"
Dorking(){
dork_dir=$tools/dork
cd $dork_dir

    #github-search
    git clone https://github.com/gwen001/github-search.git
    sudo python -m pip install -r github-search/requirements2.txt
    sudo python3 -m pip install -r github-search/requirements3.txt

    #github-dork
    git clone https://github.com/techgaun/github-dorks.git
    sudo python3 -m pip install -r github-dorks/requirements.txt

    #truffleHog
    sudo python3 -m pip install trufflehog

    #fast Google Dorking
    git clone https://github.com/IvanGlinkin/Fast-Google-Dorks-Scan.git

    #uDork
    git clone https://github.com/m3n0sd0n4ld/uDork.git

    #photon
    git clone https://github.com/s0md3v/Photon.git
    sudo python3 -m pip install -r Photon/requirements.txt
} > /dev/null 2>&1
Dorking


# Resolving and Probing
echo "Downloading Tools Related To Resolving and Probing"
Resolv_Probe(){
cd $subdom_dir

    #massdns
    git clone https://github.com/blechschmidt/massdns.git
    mkdir -p ./massdns/bin
    cc  -O3 -std=c11 -DHAVE_EPOLL -DHAVE_SYSINFO -Wall -fstack-protector-strong ./massdns/src/main.c -o ./massdns/bin/massdns

    #shuffledns
    go get -u github.com/projectdiscovery/shuffledns/cmd/shuffledns

    #httpx
    go get -u github.com/projectdiscovery/httpx/cmd/httpx
}  > /dev/null 2>&1
Resolv_Probe


# Visual Recon
echo "Downloading Tools Related To Visual Recon"
Visual_Recon(){

    #aquatone
    go get -u github.com/michenriksen/aquatone

    #gowitness
    go get -u github.com/sensepost/gowitness
} > /dev/null 2>&1
Visual_Recon


# JS Enum
echo "Downloading Tools Related To JavaScript Enumeration"
JS_Enum(){
cd $js_dir

    #getjs
    go get -u github.com/003random/getJS

    #jsparser
    git clone https://github.com/nahamsec/JSParser.git
    sudo python3 -m pip install -r JSParser/requirements.txt

    #linkfinder
    git clone https://github.com/GerbenJavado/LinkFinder.git
    sudo python3 -m pip install -r LinkFinder/requirements.txt

    #scripthunter
    git clone https://github.com/robre/scripthunter.git
} > /dev/null 2>&1
JS_Enum


# Fuzzers
echo "Downloading Tools Related To Fuzzing"
Fuzzers(){

    #wfuzz
    sudo apt-fast install wfuzz

    #ffuf
    go get -u github.com/ffuf/ffuf

    #dirb
    sudo apt-fast install dirb

    #waybackurls
    go get -u github.com/tomnomnom/waybackurls
} > /dev/null 2>&1
Fuzzers


# Directory Bruteforcing
echo "Downloading Tools Related To Directory Bruteforcing"
Directory_Brute(){
cd $Direct_brute_dir

    #gobuster
    go get -u github.com/OJ/gobuster

    #dirsearch
    git clone https://github.com/maurosoria/dirsearch.git
} > /dev/null 2>&1
Directory_Brute


# Fingerprint
echo "Downloading Tools Related To Fingerprinting"
Fingerprint(){
cd $fingerp_dir

    #webtech
    sudo python3 -m pip install install webtech

    #nuclei
    go get -u github.com/projectdiscovery/nuclei/v2/cmd/nuclei

    #nuclei-templates
    git clone https://github.com/projectdiscovery/nuclei-templates.git
} > /dev/null 2>&1
Fingerprint


# Crawlers
echo "Downloading Tools Related To Crawling"
Crawlspiders(){
cd $crawl_dir

    #gospider
    go get -u github.com/jaeles-project/gospider

    #hakrawler
    go get -u github.com/hakluke/hakrawler

    #paramspider
    git clone https://github.com/devanshbatham/ParamSpider.git
    sudo python3 -m pip install -r ParamSpider/requirements.txt

    #anew
    go get -u github.com/tomnomnom/anew

    #gf
    go get -u github.com/tomnomnom/gf
    echo 'source $GOPATH/src/github.com/tomnomnom/gf/gf-completion.bash' >> $DEFAULT_SHELL

    # gf patterns
    mkdir ~/.gf
    cp -r $GOPATH/src/github.com/tomnomnom/gf/examples ~/.gf
    git clone https://github.com/1ndianl33t/Gf-Patterns
    mv Gf-Patterns/*.json ~/.gf

    #gau
    go get -u github.com/lc/gau
} > /dev/null 2>&1
Crawlspiders


# Port Analysis
echo "Downloading Tools Related To Port Analysis"
Port_analysis(){
cd $port_dir

    #nmap
    sudo apt-fast install -y nmap

    #brutespray
    sudo apt-fast install -y brutespray

    #masscan
    sudo apt-fast install -y masscan

    #naabu
    go get -u github.com/projectdiscovery/naabu/cmd/naabu

    #dnmasscan
    wget https://raw.githubusercontent.com/rastating/dnmasscan/master/dnmasscan -o dnmasscan
} > /dev/null 2>&1
Port_Analysis


# Wordlists
echo "Downloading Wordlists"
Wordlists(){
cd $wordlist_dir

    #cewl
    sudo apt-fast install -y cewl

    #commonspeak2
    git clone https://github.com/assetnote/commonspeak2-wordlists

    #mad-robot dicc
    wget https://raw.githubusercontent.com/Mad-robot/recon-tools/master/dicc.txt

    #intruder payloads
    git clone https://github.com/1N3/IntruderPayloads

    #payloadallthethings
    git clone https://github.com/swisskyrepo/PayloadsAllTheThings

    #seclists
    git clone https://github.com/danielmiessler/SecLists
} > /dev/null 2>&1
Wordlists

echo "All Done You Are Good To Go"
