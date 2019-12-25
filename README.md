# README

build image kaligo

```
docker build -t kaligo:v2 .
```

first start compose

```
docker-compose build
docker-compse run web rake db:create db:migrate db:seed
```

start app

```
docker-compose up
```

sample query

```
http://localhost:3000/hotel/search?destination=Rome&suppliers=supplier2,supplier3
http://localhost:3000/hotel/search?destination=Rome
http://localhost:3000/hotel/search?destination=Singapore
http://localhost:3000/hotel/search?destination=Singapore&suppliers=supplier1
```

check response, time and Redis
