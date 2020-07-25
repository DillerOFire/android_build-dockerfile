FROM ubuntu:16.04
ARG userid
ARG groupid
ARG username
RUN apt-get -qq update
RUN apt-get -qqy upgrade
RUN apt-get install -y bc bison bsdmainutils build-essential ccache cgpt cron \
      curl flex g++-multilib gcc-multilib git gnupg gperf imagemagick kmod \
      lib32ncurses5-dev lib32readline-dev lib32z1-dev liblz4-tool libncurses5 \
      libncurses5-dev libsdl1.2-dev libssl-dev libwxgtk3.0-dev libxml2 \
      libxml2-utils lsof lzop maven openjdk-11-jdk pngcrush procps python3 rsync \
      schedtool squashfs-tools wget xdelta3 xsltproc yasm zip zlib1g-dev
#RUN curl -o jdk8.tgz https://android.googlesource.com/platform/prebuilts/jdk/jdk8/+archive/master.tar.gz \
 #&& tar -zxf jdk8.tgz linux-x86 \
 #&& mv linux-x86 /usr/lib/jvm/java-8-openjdk-amd64 \
 #&& rm -rf jdk8.tgz

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
RUN chown $userid:$groupid /home/$username/.gitconfig
ENV HOME=/home/$username
ENV USER=$username
ENV USE_CCACHE 1
ENV CCACHE_SIZE 50G
ENV CCACHE_DIR=/ccache

ENTRYPOINT chroot / /bin/bash -i
#ENTRYPOINT chroot --userspec=$(cat /root/username):$(cat /root/username) / /bin/bash -i
