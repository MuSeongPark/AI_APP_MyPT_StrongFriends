# # See here for image contents: https://github.com/microsoft/vscode-dev-containers/tree/v0.191.1/containers/codespaces-linux/.devcontainer/base.Dockerfile

FROM mcr.microsoft.com/vscode/devcontainers/universal:1-focal

ENV UID=1000
ENV GID=1000
ENV USER="codespace"
ENV JAVA_VERSION="8"
ENV ANDROID_TOOLS_URL="https://dl.google.com/android/repository/commandlinetools-linux-7583922_latest.zip"
ENV ANDROID_VERSION="30"
ENV ANDROID_BUILD_TOOLS_VERSION="30.0.3"
ENV ANDROID_ARCHITECTURE="x86_64"
ENV ANDROID_SDK_ROOT="home/${USER}/opt/android"
ENV FLUTTER_URL="https://storage.googleapis.com/flutter_infra/releases/$FLUTTER_CHANNEL/linux/flutter_linux_$FLUTTER_VERSION-$FLUTTER_CHANNEL.tar.xz"
ENV FLUTTER_HOME="/home/$USER/opt/flutter"
ENV FLUTTER_CHANNEL="stable"
ENV FLUTTER_VERSION="2.5.2"
ENV PATH="$ANDROID_SDK_ROOT/cmdline-tools/tools/bin:$ANDROID_SDK_ROOT/emulator:$ANDROID_SDK_ROOT/platform-tools:$ANDROID_SDK_ROOT/platforms:$FLUTTER_HOME/bin:$PATH"

# create user
RUN groupadd --gid $GID $USER && \
  useradd -s /bin/bash --uid $UID --gid $GID -m $USER && \
  RUN echo $USER ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USER && \
  chmod 0440 /etc/sudoers.d/$USER

USER $USER
WORKDIR /home/$USER

# [Optional] Uncomment this section to install additional OS packages.
# RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
#     && apt-get -y install --no-install-recommends <your-package-list-here>
ENV DEBIAN_FRONTEND="noninteractive"
RUN apt-get update \
  && apt-get install --yes --no-install-recommends openjdk-$JAVA_VERSION-jdk curl unzip sed git bash xz-utils libglvnd0 ssh xauth x11-xserver-utils libpulse0 libxcomposite1 libgl1-mesa-glx sudo \
  && rm -rf /var/lib/{apt,dpkg,cache,log}


RUN mkdir -p $ANDROID_SDK_ROOT \
    && mkdir -p /home/$USER/opt/android.android \
    && touch /home/$USER/.android/repositories.cfg \
    && curl -o android_tools.zip $ANDROID_TOOLS_URL \
    && unzip -qq -d "$ANDROID_SDK_ROOT" android_tools.zip \
    && rm android_tools.zip \
    && mkdir -p $ANDROID_SDK_ROOT/cmdline-tools/tools \
    && mv $ANDROID_SDK_ROOT/cmdline-tools/bin $ANDROID_SDK_ROOT/cmdline-tools/tools \
    && mv $ANDROID_SDK_ROOT/cmdline-tools/lib $ANDROID_SDK_ROOT/cmdline-tools/tools \
    && yes "y" | sdkmanager "build-tools;$ANDROID_BUILD_TOOLS_VERSION" \
    && yes "y" | sdkmanager "platforms;android-$ANDROID_VERSION" \
    && yes "y" | sdkmanager "platform-tools" \
    && yes "y" | sdkmanager "emulator" \
    && yes "y" | sdkmanager "system-images;android-$ANDROID_VERSION;google_apis_playstore;$ANDROID_ARCHITECTURE"
    
RUN curl -o flutter.tar.xz $FLUTTER_URL \
    && mkdir -p $FLUTTER_HOME \
    && tar xf flutter.tar.xz -C /home/$USER/opt \
    && rm flutter.tar.xz \
    && flutter config --no-analytics \
    && flutter precache \
    && yes "y" | flutter doctor --android-licenses \
    && flutter doctor \
    && flutter emulators --create \
    && flutter update-packages

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]
