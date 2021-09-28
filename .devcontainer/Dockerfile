FROM ubuntu:20.04

RUN apt update && apt install -y curl git unzip xz-utils zip libglu1-mesa openjdk-8-jdk wget
   
# Set up new user
RUN useradd -ms /bin/bash codespace
USER codespace
WORKDIR /home/codespace

# support amd64 and arm64
RUN JDK_PLATFORM=$(if [ "$(uname -m)" = "aarch64" ]; then echo "arm64"; else echo "amd64"; fi) \
    sudo echo export JDK_PLATFORM=$JDK_PLATFORM >> /etc/jdk.env && \
    sudo echo export JAVA_HOME="/usr/lib/jvm/java-8-openjdk-$JDK_PLATFORM/" >> /etc/jdk.env && \
    sudo echo . /etc/jdk.env >> /etc/bash.bashrc && \
    sudo echo . /etc/jdk.env >> /etc/profile
   
