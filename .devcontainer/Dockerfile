FROM ubuntu:20.04

RUN apt update && apt install -y curl git unzip xz-utils zip libglu1-mesa openjdk-8-jdk wget
   
# Set up new user
RUN useradd -ms /bin/bash codespace
USER codespace
WORKDIR /home/codespace
   
# Prepare Android directories and system variables
RUN mkdir -p Android/sdk
ENV ANDROID_SDK_ROOT /home/codespace/Android/sdk
RUN mkdir -p .android && touch .android/repositories.cfg
   
# Set up Android SDK
RUN wget -O sdk-tools.zip https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip
RUN unzip sdk-tools.zip && rm sdk-tools.zip
RUN mv tools Android/sdk/tools
RUN cd Android/sdk/tools/bin && yes | ./sdkmanager --licenses
RUN cd Android/sdk/tools/bin && ./sdkmanager "build-tools;29.0.2" "patcher;v4" "platform-tools" "platforms;android-29" "sources;android-29"
ENV PATH "$PATH:/home/codespace/Android/sdk/platform-tools"

ENV ANDROID_HOME="/opt/android-sdk" \
    ANDROID_NDK="/opt/android-sdk/ndk/current" \
    FLUTTER_HOME="/opt/flutter"

# support amd64 and arm64
RUN JDK_PLATFORM=$(if [ "$(uname -m)" = "aarch64" ]; then echo "arm64"; else echo "amd64"; fi) \
    sudo echo export JDK_PLATFORM=$JDK_PLATFORM >> /etc/jdk.env && \
    sudo echo export JAVA_HOME="/usr/lib/jvm/java-8-openjdk-$JDK_PLATFORM/" >> /etc/jdk.env && \
    sudo echo . /etc/jdk.env >> /etc/bash.bashrc && \
    sudo echo . /etc/jdk.env >> /etc/profile
