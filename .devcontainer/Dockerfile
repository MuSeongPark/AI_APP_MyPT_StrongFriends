FROM ubuntu:20.04

RUN apt update && apt install -y curl git unzip xz-utils zip libglu1-mesa openjdk-8-jdk wget
   
# Set up new user
RUN useradd -ms /bin/bash codespace
USER codespace
WORKDIR /home/codespace

#Android_SDK, Android_NDK, Flutter_home path
ENV ANDROID_HOME="/opt/android-sdk" \
    ANDROID_NDK="/opt/android-sdk/ndk/current" \
    FLUTTER_HOME="/opt/flutter"

# support amd64 and arm64
RUN JDK_PLATFORM=$(if [ "$(uname -m)" = "aarch64" ]; then echo "arm64"; else echo "amd64"; fi) \
    sudo echo export JDK_PLATFORM=$JDK_PLATFORM >> /etc/jdk.env && \
    sudo echo export JAVA_HOME="/usr/lib/jvm/java-8-openjdk-$JDK_PLATFORM/" >> /etc/jdk.env && \
    sudo echo . /etc/jdk.env >> /etc/bash.bashrc && \
    sudo echo . /etc/jdk.env >> /etc/profile

ENV TZ= Asia/Seoul

# Get the latest version from https://developer.android.com/studio/index.html
ENV ANDROID_SDK_TOOLS_VERSION="4333796"

# Set locale
ENV LANG="en_US.UTF-8" \
    LANGUAGE="en_US.UTF-8" \
    LC_ALL="en_US.UTF-8"

RUN apt-get clean && \
    apt-get update -qq && \
    apt-get install -qq -y apt-utils locales && \
    locale-gen $LANG


