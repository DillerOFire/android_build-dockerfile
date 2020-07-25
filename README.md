The Dockerfile in this directory sets up an Huiumba image ready to build
a variety of Android branches (>= MIUI). It's particulary useful to build
older branches that required 16.04 if you've upgraded to something newer.

First, build the image:
```
# Copy your host gitconfig, or create a stripped down version
$ cp ~/.gitconfig gitconfig
$ docker build --build-arg userid=$(id -u) --build-arg groupid=$(id -g) --build-arg username=$(id -un) -t android-build-16 .
```

Then you can start up new instances with:
```
$ docker run -it --rm -v $ANDROID_BUILD_TOP:/src -v $CCACHE_DIR:/ccache android-build-16
> cd /src; source build/envsetup.sh
> lunch aosp_arm-userdebug
> m -j6
```
