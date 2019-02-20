from ruby:2.5

# Install postgresql
# install redis
# install elasticsearch

RUN wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | apt-key add -
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y apt-transport-https apt-utils && \
    echo deb https://artifacts.elastic.co/packages/5.x/apt stable main > /etc/apt/sources.list.d/elastic-5.x.list && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    postgresql \
    redis-server \
    elasticsearch \
    htop \
    curl \
    make \
    sudo \
    openjdk-8-jre \
    vim \
    && apt-get clean

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
http.port: 9200' >> /etc/elasticsearch/elasticsearch.yml

