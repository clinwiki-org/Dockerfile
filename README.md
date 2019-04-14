# ClinWiki Dockerfile
For quickly setting up a machine with all the requirements to run ClinWiki

## Build the image

This will take a few minutes.

```sh
docker build . -t cdub
```

## Bootstrap database

- Start Docker  
docker run -it -v $PWD:/clinwiki -p 3000:3000 -p 5432:5432 -p 9200:9200 -e AACT_DATABASE_URL=postgres://$AACT_USER:$AACT_PASS@aact-db.ctti-clinicaltrials.org:5432/aact --name cdub cwiki bash   

**NOTE: You should make sure docker can use at least 4GiB of memory.  The default docker install on Windows and Mac will give it 2 which is not quite enough to start elasticsearch.**  
Without enough memory elasticsearch will terminate silently on startup.

For client side development work only port 3000 is required.  The other -p arguments are to expose postgresql and elasticsearch.  $AACT_USER and $AACT_PASS should be the credentials you created on https://www.ctti-clinicaltrials.org/aact-database

- Start services   
    ```
    sudo service postgresql start  
    sudo service elasticsearch start
    sudo service redis-server start
    ```

- Create clinwiki database
    ```
    cd /clinwiki
    bundle install
    bundle exec rake db:create
    bundle exec rake db:migrate
    ```

- Start Clinwiki processes  
    I use screen to multiplex the terminal. You can use whatever you are comfortable with for running multiple commands.
    ```
    cd /clinwiki
    screen
    bundle exec sidekiq -C config/sidekiq.yml
    # ctrl-a ctrl-c to create another terminal
    bundle exec rails server -b 0.0.0.0
    ```

    At this point clinwiki is running in your docker image but the index is empty. In another terminal run `rake search:bootstrap` to index 1000 random studies.

## Resuming where you left off

* `docker stop cwiki`: Will stop the running image and save the filesystem.
* `docker start -a -i cwiki`: Will restart the image.  The filesystem is preserved but the running processe are not.  To get back to your previous state attach to the image and start things up.  If you prefer you can start and attach in 2 steps with `docker start cwiki`, `docker attach cwiki`

```
    sudo service postgresql start  
    sudo service elasticsearch start
    sudo service redis-server start
    cd /clinwiki
    screen
    bundle exec sidekiq -C config/sidekiq.yml
    bundle exec rails server -b 0.0.0.0
```

