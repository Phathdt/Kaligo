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
