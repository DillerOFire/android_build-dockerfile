First, build the image:
```
# Copy your host gitconfig, or create a stripped down version
$ git config --global user.email "you@example.com"
$ git config --global user.name "Your Name"
$ cp ~/.gitconfig gitconfig
$ podman build --build-arg userid=$(id -u) --build-arg groupid=$(id -g) --build-arg username=$(id -un) -t android-build-16 .
```

change ANDROID BUILD TOP and CCACHE DIR as you want:
```
$ podman run -it --rm -v $ANDROID_BUILD_TOP:/src -v $CCACHE_DIR:/ccache android-build-16
Or
$ podman run --security-opt label=disable -it --rm -v /home/sfier/hcapacity/aosip/:/src -v /home/sfier/ccache/:/ccache androidbuild
> cd /src; source build/envsetup.sh
> lunch aosp_arm-userdebug
> m -j6
```
