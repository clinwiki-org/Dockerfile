docker run --rm -d --name testdb -v d:\cw\Dockerfile\AACT:/aact -p 5555:5432 postgres:11.4 
docker exec -it testdb bash
