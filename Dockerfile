FROM ruby:2.5-stretch
MAINTAINER Ryan Moore <moorer@udel.edu>

# Copy over the aligners
WORKDIR /usr/local/bin
COPY vendor/clustalo .
COPY vendor/mafft-7.313-linux.tgz .
RUN tar xzf mafft-7.313-linux.tgz
RUN mv mafft-linux64/mafft.bat mafft-linux64/mafft
RUN mv mafft-linux64/* .

RUN gem install bundler

RUN \curl -sSL https://github.com/mooreryan/pasv/archive/v1.2.0.tar.gz \
    | tar -v -C /home -xz
RUN mv /home/pasv-1.2.0 /home/pasv

RUN chmod 755 /home/pasv/pasv
RUN ln -s /home/pasv/pasv /usr/local/bin

WORKDIR /home/pasv
RUN bundle install

CMD ["/home/pasv/pasv"]
