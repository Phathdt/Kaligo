# README

first start compose

```
docker-compose build

```

start app

```
docker-compose up
```

create db, migrate and seed data 

```
docker-compose run web rake db:create db:migrate db:seed
```

sample query

```
http://localhost:3000/hotel/search?destination=Rome&suppliers=supplier2,supplier3
http://localhost:3000/hotel/search?destination=Rome
http://localhost:3000/hotel/search?destination=Singapore
http://localhost:3000/hotel/search?destination=Singapore&suppliers=supplier1
```

check response, time and Redis
