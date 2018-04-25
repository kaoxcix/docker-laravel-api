# Docker for Web API by Laravel (And SPA)
  
**This docker's tested in MacOS only.**  

This docker contains:
- Nginx Proxy
- Nginx with PHP7-FPM (Laravel API)
- Nginx (Front SPA)
- SQL Server (Main database)

## How to use (for first time!)
1. Make .env `cp env-example .env`
2. Config `HOST_PORT`, `DB NAME`, etc. in .env
3. Execute `bin/docker-first-build`
4. Start development!!

**Note.** 
Network list:  
- Application

    |Service Name|Local Address / Port|Virtual host|
    |------------|----|------------|
    |Proxy|http://localhost:80|-| 
    |API                |http://localhost:8001  |http://api.laravel.test| 
    |Front              |http://localhost:8002  |http://front.laravel.test|
    |SQL Server         |:1433                  |-| 
    |Redis              |:6379                  |-| 

- Development tools

    |Service Name|Local Address / Port|Virtual host|
    |------------|----|------------|
    |Mailcatcher-Client |http://localhost:9001  |http://devtool-mailcatcher.laravel.test| 
    |Redis-Commander    |http://localhost:9002  |http://devtool-redis.laravel.test| 

## Structure
### Directory
|Location|Detail|
|--------|------|
|bin|Execution files for controlling Docker|
|docker|Docker components|
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

**Note.**  
- It's shortcut for `docker-compose` command.
