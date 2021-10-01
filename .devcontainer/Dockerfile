FROM mcr.microsoft.com/vscode/devcontainers/universal:1-focal

USER root

ARG USERNAME=codespace
ARG USER_UID=1000
ARG USER_GID=$USER_UID
ARG HOMEDIR=/home/$USERNAME

ARG DEBIAN_FRONTEND=noninteractive

RUN uname -a && uname -m

RUN apt-get update && apt-get install -y --no-install-recommends apt-utils && apt-get install -y curl git unzip xz-utils zip libglu1-mesa openjdk-8-jdk wget
   
#Android_SDK, Android_NDK, Flutter_home path
ENV ANDROID_HOME="/opt/android-sdk" \
    ANDROID_NDK="/opt/android-sdk/ndk/current" \
    FLUTTER_HOME="/opt/flutter"

# support amd64 and arm64
RUN JDK_PLATFORM=$(if [ "$(uname -m)" = "aarch64" ]; then echo "arm64"; else echo "amd64"; fi) && \
    echo export JDK_PLATFORM=$JDK_PLATFORM >> /etc/jdk.env && \
    echo export JAVA_HOME="/usr/lib/jvm/java-8-openjdk-$JDK_PLATFORM/" >> /etc/jdk.env && \
    echo . /etc/jdk.env >> /etc/bash.bashrc && \
    echo . /etc/jdk.env >> /etc/profile

ENV TZ=America/Los_Angeles

# Get the latest version from https://developer.android.com/studio/index.html
ENV ANDROID_SDK_TOOLS_VERSION="7583922"

# nodejs version
ENV NODE_VERSION="14.x"

# Set locale
ENV LANG="en_US.UTF-8" \
    LANGUAGE="en_US.UTF-8" \
    LC_ALL="en_US.UTF-8"

RUN apt-get clean && \
    apt-get update -qq && \
    apt-get install -qq -y apt-utils locales && \
    locale-gen $LANG

ENV TERM=dumb \
    DEBIAN_FRONTEND=noninteractive

# Variables must be references after they are created
ENV ANDROID_SDK_HOME="$ANDROID_HOME"

ENV PATH="$JAVA_HOME/bin:$PATH:$ANDROID_SDK_HOME/emulator:$ANDROID_SDK_HOME/tools/bin:$ANDROID_SDK_HOME/tools:$FLUTTER_HOME/bin:$FLUTTER_HOME/bin/cache/dart-sdk/bin"

WORKDIR /tmp

# Installing packages
RUN apt-get update -qq > /dev/null && \
    apt-get install -qq locales > /dev/null && \
    locale-gen "$LANG" > /dev/null && \
    apt-get install -qq --no-install-recommends \
        autoconf \
        build-essential \
        curl \
        file \
        git \
        gpg-agent \
        less \
        libc6-dev \
        libgmp-dev \
        libmpc-dev \
        libmpfr-dev \
        libxslt-dev \
        libxml2-dev \
        m4 \
        ncurses-dev \
        ocaml \
        openjdk-8-jdk \
        openjdk-11-jdk \
        openssh-client \
        pkg-config \
        ruby-full \
        software-properties-common \
        tzdata \
        unzip \
        vim-tiny \
        wget \
        zip \
        zlib1g-dev > /dev/null && \
    echo "JVM directories: `ls -l /usr/lib/jvm/`" && \
    . /etc/jdk.env && \
    echo "Java version (default):" && \
    java -version && \
    echo "set timezone" && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone && \
    echo "nodejs, npm, cordova, ionic, react-native" && \
    curl -sL -k https://deb.nodesource.com/setup_${NODE_VERSION} \
        | bash - > /dev/null && \
    curl -sS -k https://dl.yarnpkg.com/debian/pubkey.gpg \
        | apt-key add - > /dev/null && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" \
        | tee /etc/apt/sources.list.d/yarn.list > /dev/null && \
    apt-get update -qq > /dev/null && \
    apt-get install -qq yarn > /dev/null && \
    rm -rf /var/lib/apt/lists/ && \
    npm install --quiet -g npm > /dev/null && \
    npm install --quiet -g \
        bower \
        cordova \
        eslint \
        gulp \
        ionic \
        jshint \
        karma-cli \
        mocha \
        node-gyp \
        npm-check-updates \
        react-native-cli > /dev/null && \
    npm cache clean --force > /dev/null && \
    rm -rf /tmp/* /var/tmp/*

# Install Android SDK
RUN echo "sdk tools ${ANDROID_SDK_TOOLS_VERSION}" && \
    wget --quiet --output-document=sdk-tools.zip \
        "https://dl.google.com/android/repository/sdk-tools-linux-${ANDROID_SDK_TOOLS_VERSION}.zip" && \
    mkdir --parents "$ANDROID_HOME" && \
    unzip -q sdk-tools.zip -d "$ANDROID_HOME" && \
    rm --force sdk-tools.zip

# Install SDKs
# Please keep these in descending order!
# The `yes` is for accepting all non-standard tool licenses.
RUN mkdir --parents "$ANDROID_HOME/.android/" && \
    echo '### User Sources for Android SDK Manager' > \
        "$ANDROID_HOME/.android/repositories.cfg" && \
    . /etc/jdk.env && \
    yes | "$ANDROID_HOME"/tools/bin/sdkmanager --licenses > /dev/null

# List all available packages.
# redirect to a temp file `packages.txt` for later use and avoid show progress
RUN . /etc/jdk.env && \
    "$ANDROID_HOME"/tools/bin/sdkmanager --list > packages.txt && \
    cat packages.txt | grep -v '='

#
# https://developer.android.com/studio/command-line/sdkmanager.html
#
# RUN echo "platforms" && \
#     . /etc/jdk.env && \
#     yes | "$ANDROID_HOME"/tools/bin/sdkmanager \
#         "platforms;android-30" \
#         "platforms;android-29" \
#         "platforms;android-28" > /dev/null

# RUN echo "platform tools" && \
#     . /etc/jdk.env && \
#     yes | "$ANDROID_HOME"/tools/bin/sdkmanager \
#         "platform-tools" > /dev/null

# RUN echo "build tools 25-30" && \
#     . /etc/jdk.env && \
#     yes | "$ANDROID_HOME"/tools/bin/sdkmanager \
#         "build-tools;30.0.0" "build-tools;30.0.2" "build-tools;30.0.3" \
#         "build-tools;29.0.3" "build-tools;29.0.2" \
#         "build-tools;28.0.3" "build-tools;28.0.2" > /dev/null
# List sdk directory content
RUN ls -l $ANDROID_HOME

RUN du -sh /opt/android-sdk

RUN echo "kotlin & gradle" && \
    wget --quiet -O sdk.install.sh "https://get.sdkman.io" && \
    bash -c "bash ./sdk.install.sh > /dev/null && source ~/.sdkman/bin/sdkman-init.sh && sdk install kotlin && sdk install gradle 7.2" && \
    rm -f sdk.install.sh

RUN echo "Flutter sdk" && \
    if [ "$(uname -m)" != "x86_64" ]; then echo "Flutter only support Linux x86 64bit. skip for $(uname -m)"; exit 0; fi && \
    cd /opt && \
    wget --quiet https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_2.5.1-stable.tar.xz -O flutter.tar.xz && \
    tar xf flutter.tar.xz && \
    flutter config --no-analytics && \
    rm -f flutter.tar.xz

# # Copy sdk license agreement files.
RUN mkdir -p $ANDROID_HOME/licenses
COPY sdk/licenses/* $ANDROID_HOME/licenses/

# # Create some jenkins required directory to allow this image run with Jenkins
# RUN mkdir -p /var/lib/jenkins/workspace && \
#     mkdir -p /home/jenkins && \
#     chmod 777 /home/jenkins && \
#     chmod 777 /var/lib/jenkins/workspace && \
#     chmod -R 775 $ANDROID_HOME

# RUN echo "fastlane" && \
#     cd / && \
#     gem install bundler --quiet --no-document > /dev/null && \
#     mkdir -p /.fastlane && \
#     chmod 777 /.fastlane && \
#     bundle install --quiet

# # Add jenv to control which version of java to use, default to 11.
# RUN git clone https://github.com/jenv/jenv.git ~/.jenv && \
#     echo 'export PATH="$HOME/.jenv/bin:$PATH"' >> ~/.bash_profile && \
#     echo 'eval "$(jenv init -)"' >> ~/.bash_profile && \
#     . ~/.bash_profile && \
#     . /etc/jdk.env && \
#     java -version && \
#     jenv add /usr/lib/jvm/java-8-openjdk-$JDK_PLATFORM && \
#     jenv add /usr/lib/jvm/java-11-openjdk-$JDK_PLATFORM && \
#     jenv versions && \
#     jenv global 11 && \
#     java -version
