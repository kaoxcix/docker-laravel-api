# Docker for Web API by Laravel (And SPA)
  
**This docker's tested in MacOS only.**  

This docker contains:
- Nginx Proxy
- Nginx with PHP7-FPM (Laravel API)
- Nginx (Front SPA)
- SQL Server (Database)
- Beanstalk (Queue)
- Laravel Echo Server (Broadcasting)
- Redis (In-Memory Store)
- Mailcatcher (Fake SMTP)

## How to use (for first time!)
1. Make .env `cp env-example .env`
2. Config `HOST_PORT`, `DB NAME`, etc. in .env
3. Execute `bin/docker-first-build`
4. Start development!!

**Note.** 
Network list:  
- Application

    |Service Name|Virtual host|Local Address / Port|
    |------------|----|------------|
    |Proxy|http://localhost:80|-| 
    |API                |http://api.laravel.test            |http://localhost:8001|
    |Front              |http://front.laravel.test          |http://localhost:8002|
    |Laravel-Echo-Server|http://broadcasting.laravel.test   |http://localhost:8003|
    |Redis              |-                                  |:6379| 
    |SQL-Server         |-                                  |:1433| 

- Development tools

    |Service Name|Virtual host|Local Address / Port|
    |------------|----|------------|
    |Adminer                        |http://dt-adminer.laravel.test       |http://localhost:9003|
    |Beanstalk-Console              |http://dt-queue.laravel.test         |http://localhost:9004|
    |Mailcatcher-Client             |http://dt-mailcatcher.laravel.test   |http://localhost:9002|
    |Redis-Commander                |http://dt-redis.laravel.test         |http://localhost:9001|

## Structure
### Directory
|Location|Detail|
|--------|------|
|bin|Execution files for controlling Docker|
|docker|Docker components|
|docker/data|data for each service|
|docker/log|Log for each service|
|docker/services|Dockerfile and configuration|
|src|Project files|
|src/api|Laravel API|
|src/front|SPA by Angular, React, VueJs, etc|

### Bin (Sh cript)
|Name|Detail|
|----|------|
|docker-clean-log|Remove everything in `docker/logs/xxx/*`|
|docker-first-build|Build and start Docker|
|docker-rebuild|Rebuild and start Docker|
|docker-rebuild-deeply|Rebuild and start Docker (without Docker caching)|
|docker-start|Start Docker (build Docker first!)|
|docker-stop|Stop Docker (Just stopping. It's not removing container)|
|docker-ports|Lists all ports|
|docker-vhosts|Lists all Virtual Host|

**Note.**  
- It's shortcut for `docker-compose` command.
