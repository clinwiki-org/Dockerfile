from ruby:2.5.3

RUN apt-get update -qq && \
   DEBIAN_FRONTEND=noninteractive apt-get install -y nodejs postgresql-client htop curl make sudo screen vim 

RUN mkdir /clinwiki
WORKDIR /clinwiki
COPY clinwiki/Gemfile* /clinwiki/
RUN bundle install

# Add a script to be executed with the container starts
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
EXPOSE 3000

# CMD ["rails", "server", "-b", "0.0.0.0"]
CMD ["/usr/bin/entrypoint.sh"]



