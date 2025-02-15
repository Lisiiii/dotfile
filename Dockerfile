FROM ubuntu:22.04 AS ubuntu-base

# Change bash as default shell instead of sh
SHELL ["/bin/bash", "-c"]

# Install some tools and libraries.
RUN apt-get update && apt-get -y install \
    vim wget curl unzip git \
    gcc g++ 

# install oh my zsh & change theme to af-magic
RUN apt-get update && apt-get -y install zsh 
RUN wget https://gitee.com/mirrors/oh-my-zsh/raw/master/tools/install.sh -O zsh-install.sh && \
    chmod +x ./zsh-install.sh  && \
    sed -i 's/REPO=${REPO:-ohmyzsh\/ohmyzsh}/REPO=${REPO:-mirrors\/oh-my-zsh}/' ./zsh-install.sh && \
    sed -i 's/REMOTE=${REMOTE:-https:\/\/github.com\/${REPO}.git}/REMOTE=${REMOTE:-https:\/\/gitee.com\/${REPO}.git}/' ./zsh-install.sh && ./zsh-install.sh && \
    sed -i 's/ZSH_THEME=\"[a-z0-9\-]*\"/ZSH_THEME="af-magic"/g' ~/.zshrc && \
    sed -i 's/plugins=(git)/plugins=(git zsh-syntax-highlighting zsh-autosuggestions)/g' ~/.zshrc  && \
    git clone https://gitee.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting && git clone https://gitee.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions && \
    rm ./zsh-install.sh 

RUN chsh root -s /bin/zsh

ENV NVIDIA_VISIBLE_DEVICES all
    
ENV NVIDIA_DRIVER_CAPABILITIES compute,utility