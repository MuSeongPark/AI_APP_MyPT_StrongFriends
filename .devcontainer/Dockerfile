FROM ubuntu:20.04

RUN uname -a && uname -m

ENV ANDROID_HOME="/opt/android-sdk" \
    ANDROID_NDK="/opt/android-sdk/ndk/current" \
    FLUTTER_HOME="/opt/flutter"

# support amd64 and arm64
RUN JDK_PLATFORM=$(if [ "$(uname -m)" = "aarch64" ]; then echo "arm64"; else echo "amd64"; fi) \
    sudo echo export JDK_PLATFORM=$JDK_PLATFORM >> /etc/jdk.env && \
    sudo echo export JAVA_HOME="/usr/lib/jvm/java-8-openjdk-$JDK_PLATFORM/" >> /etc/jdk.env && \
    sudo echo . /etc/jdk.env >> /etc/bash.bashrc && \
    sudoecho . /etc/jdk.env >> /etc/profile