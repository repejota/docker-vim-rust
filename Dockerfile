FROM debian:latest
MAINTAINER Raül Pérez <repejota@gmail.com>
ENV USER root
ENV RUST_VERSION=1.4.0
ENV HOME /root
WORKDIR /root
RUN apt-get update
RUN apt-get install -y --no-install-recommends build-essential ca-certificates curl git libssl-dev tmux vim-nox
RUN curl -sO https://static.rust-lang.org/dist/rust-$RUST_VERSION-x86_64-unknown-linux-gnu.tar.gz
RUN tar -xzf rust-$RUST_VERSION-x86_64-unknown-linux-gnu.tar.gz
RUN ./rust-$RUST_VERSION-x86_64-unknown-linux-gnu/install.sh --without=rust-docs
RUN git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell
RUN git clone https://github.com/magicmonty/bash-git-prompt.git ~/.config/bash-git-prompt
VOLUME ["/source"]
ADD bashrc /root/.bashrc
ADD tmux.conf /root/.tmux.conf
ENTRYPOINT ["bash"]
