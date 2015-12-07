FROM debian:latest
MAINTAINER Raül Pérez <repejota@gmail.com>

ENV RUST_VERSION=1.4.0

ENV USER root
ENV HOME /root

WORKDIR /tmp

RUN apt-get update
RUN apt-get install -y --no-install-recommends build-essential \
    ca-certificates \
    curl \
    git \
    libssl-dev \
    tmux \
    vim-nox

RUN curl -sO https://static.rust-lang.org/dist/rust-$RUST_VERSION-x86_64-unknown-linux-gnu.tar.gz
RUN tar -xzf rust-$RUST_VERSION-x86_64-unknown-linux-gnu.tar.gz
RUN ./rust-$RUST_VERSION-x86_64-unknown-linux-gnu/install.sh --without=rust-docs

VOLUME ["/source"]

WORKDIR /root

RUN git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell
RUN git clone https://github.com/magicmonty/bash-git-prompt.git ~/.config/bash-git-prompt

RUN mkdir -p ~/.vim/bundle                                              && \
    cd  ~/.vim/bundle                                                   && \
    git clone https://github.com/gmarik/Vundle.vim.git                  && \
    git clone https://github.com/chriskempson/base16-vim.git            && \
    git clone https://github.com/rust-lang/rust.vim.git                 && \
    git clone https://github.com/cespare/vim-toml.git                   && \
    git clone https://github.com/scrooloose/nerdtree.git                && \
    git clone https://github.com/ctrlpvim/ctrlp.vim.git                 && \
    vim +PluginInstall +qall

ADD bashrc /root/.bashrc
ADD vimrc /root/.vimrc
ADD tmux.conf /root/.tmux.conf

ENTRYPOINT ["bash", "-l"]
