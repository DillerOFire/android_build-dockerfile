This shit is convient as fuck. No more fucking deps just build this image//////////////////////////

First, build the image:
```
# Copy your host gitconfig, or create a stripped down version
$ git config --global user.email "you@example.com"
$ git config --global user.name "Your Name"
$ cp ~/.gitconfig gitconfig
$ docker build --build-arg userid=$(id -u) --build-arg groupid=$(id -g) --build-arg username=$(id -un) -t android-build-16 .
```

change ANDROID BUILD TOP and CCACHE DIR as you want:
```
$ docker run -it --rm -v $ANDROID_BUILD_TOP:/src -v $CCACHE_DIR:/ccache android-build-16
> cd /src; source build/envsetup.sh
> lunch aosp_arm-userdebug
> m -j6
```
