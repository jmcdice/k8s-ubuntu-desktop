FROM ubuntu:latest
ENV DEBIAN_FRONTEND noninteractive
MAINTAINER Joey <jmcdice@gmail.com>

# RUN sed -i 's#http://archive.ubuntu.com/#http://ubuntu.mirrors.tds.net/pub/ubuntu/#' /etc/apt/sources.list

# Packages and Desktop Stuff.
RUN apt-get update
RUN apt-get -o Dpkg::Options::='--force-confold' --force-yes -fuy dist-upgrade
RUN apt-get install -y python-apt
RUN apt-get install -y --no-install-recommends software-properties-common curl
RUN apt-get install -y --no-install-recommends --allow-unauthenticated supervisor openssh-server \
        pwgen sudo vim-common net-tools x11vnc xserver-xorg-video-dummy gtk2-engines-murrine \
        ttf-ubuntu-font-family firefox nginx python-pip python-dev build-essential \
        mesa-utils libgl1-mesa-dri gnome-themes-standard gtk2-engines-pixbuf \
        gtk2-engines-murrine pinta dbus-x11 x11-utils wget tmux htop git \
        dconf-editor apt-utils ubuntu-mate-desktop mate-terminal mate-backgrounds \
        mate-themes mate-control-center ubuntu-mate-wallpapers 

# Create my user
RUN useradd -ms /bin/bash mate
RUN adduser mate sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Install Chrome
RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
RUN dpkg -i google-chrome-stable_current_amd64.deb; apt-get -fy install

# Install VSCode
RUN wget "https://go.microsoft.com/fwlink/?LinkID=760868" -O code.deb
RUN dpkg -i code.deb

# Install Slack (Update: SlackApp Crashes, disabling)
#RUN wget "https://downloads.slack-edge.com/linux_releases/slack-desktop-3.4.2-amd64.deb"
#RUN dpkg -i slack-desktop-3.4.2-amd64.deb; apt-get -fy install

RUN apt-get -y update && apt-get -y dist-upgrade
RUN apt-get autoclean
RUN apt-get autoremove 

# tini for subreap                                   
ENV TINI_VERSION v0.9.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /bin/tini
RUN chmod +x /bin/tini

ADD image /
RUN pip install setuptools wheel && pip install -r /usr/lib/web/requirements.txt

EXPOSE 80
WORKDIR /root

ENTRYPOINT ["/startup.sh"]
