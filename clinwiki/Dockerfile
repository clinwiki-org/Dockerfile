from ruby:2.5.3

RUN wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | apt-key add -
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y apt-transport-https apt-utils && \
    echo deb https://artifacts.elastic.co/packages/6.x/apt stable main > /etc/apt/sources.list.d/elastic-6.x.list && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    postgresql \
    redis-server \
    htop \
    curl \
    make \
    sudo \
    openjdk-8-jre \
    screen \
    vim \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    elasticsearch \
    && apt-get clean

# configure locale
RUN echo en_US.UTF-8 UTF-8 >> /etc/locale.gen && locale-gen 
ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'
ENV DATABASE_URL='postgres://postgres@localhost:5432/clinwiki' REDIS_URL='redis://127.0.0.1:6379/0'
ENV SHELL bash

# configure vim
RUN echo 'set background=dark \n\
set showcmd \n\
set showmatch \n\
set ignorecase \n\
set smartcase \n\
set incsearch \n\
set autowrite \n\
set hidden \n\
set mouse= \n\
imap jj <Esc> \n\
' >> /etc/vim/vimrc


# configure elastic and postgresql
ENV PGCONF=/etc/postgresql/9.6/main/
RUN echo "listen_addresses = '*'" >> $PGCONF/postgresql.conf &&\
    echo "host all all 0.0.0.0/0 trust" >> $PGCONF/pg_hba.conf &&\
    echo 'network.host: 0.0.0.0 \n\
http.port: 9200' >> /etc/elasticsearch/elasticsearch.yml &&\
    sed -i 's/md5/trust/' $PGCONF/pg_hba.conf

# make sure to set AACT_DATABASE_URL

