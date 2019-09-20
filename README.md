# Amazing Wiki

A wiki system based on [MinDoc](https://github.com/lifei6671/mindoc), made some modify and run in docker-compose with monitor [grafana/loki](https://github.com/grafana/loki#loki-like-prometheus-but-for-logs), use mysql to persist data.


## Start

* clone this repo
* install docker on computer
* install docker [log driver plugin of loki](https://github.com/grafana/loki/tree/master/cmd/docker-driver)
* run `make docker` and `docker-compose up`

## Init

Before run service, please add an install command to amazing_wiki's docker-compose file

```
     command: install
```

it will initialize beego's config and mysql tables. 


