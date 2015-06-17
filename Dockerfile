FROM golang

RUN apt-get update && apt-get -y upgrade
RUN apt-get -y install git mercurial
