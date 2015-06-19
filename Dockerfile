FROM golang

RUN apt-get update && apt-get -y upgrade
RUN apt-get -y install git mercurial
RUN cd /go/src && mkdir -p github.com/spf13 && \
    cd github.com/spf13 && \
    git clone https://github.com/spf13/hugo.git && \
    cd hugo && \
    git reset --hard v0.14 && \
    go get github.com/spf13/hugo
RUN git clone https://github.com/gigovich/debug.ge.git /home/debug.ge
RUN cd /home/debug.ge && git submodule update --init themes/hyde-x

WORKDIR /home/debug.ge
VOLUME ["/home/debug.ge"]

ENTRYPOINT git pull -u && git submodule update && /go/bin/hugo server --watch --baseUrl=http://debug.ge --port=80 --appendPort=false --bind=0.0.0.0
EXPOSE 80
