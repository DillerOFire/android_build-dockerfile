FROM ubuntu:20.04
ARG userid
ARG groupid
ARG username
RUN apt-get -qq update
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Vladivostok
RUN apt-get -qqy upgrade
RUN apt-get install -y bc bison build-essential ccache curl flex g++-multilib gcc-multilib git gnupg gperf imagemagick lib32ncurses5-dev lib32readline-dev lib32z1-dev liblz4-tool libncurses5 libncurses5-dev libsdl1.2-dev libssl-dev libxml2 libxml2-utils lzop pngcrush rsync schedtool squashfs-tools xsltproc zip zlib1g-dev zsh neovim

RUN curl https://storage.googleapis.com/git-repo-downloads/repo > /usr/local/bin/repo
RUN chmod a+x /usr/local/bin/repo

RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 10

RUN ln -sf /proc/self/mounts /etc/mtab
#END
RUN groupadd -g $groupid $username \
 && useradd -m -u $userid -g $groupid $username \
 && echo $username >/root/username \
 && echo "export USER="$username >>/home/$username/.gitconfig
COPY gitconfig /home/$username/.gitconfig
COPY zsh_history /home/$username/.zsh_history
RUN chown $userid:$groupid /home/$username/.gitconfig
RUN chown $userid:$groupid /home/$username/.zsh_history
ENV HOME=/home/$username
ENV USER=$username
ENV USE_CCACHE 1
ENV CCACHE_SIZE 50G
ENV CCACHE_DIR=/ccache
ENV JAVA_TOOL_OPTIONS=-Xmx12G
RUN chsh -s $(which zsh)
RUN RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

ENTRYPOINT chroot / /usr/bin/zsh -i
#ENTRYPOINT chroot --userspec=$(cat /root/username):$(cat /root/username) / /bin/bash -i
