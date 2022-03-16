# Installation
```sh
# Download docker-compose.sh
$ curl https://raw.githubusercontent.com/jahirvidrio/docker-compose-utility/main/docker-compose.sh -o ~/docker-compose.sh

# Add execution permission
$ chmod +x ~/docker-compose.sh

# Add alias in ~/.bashrc or ~/.zshrc
$ echo "alias docker-compose=~/docker-compose.sh" >> .zshrc
```

# Usage
Compose files must match `any-name.compose.yml` e.g. `mongodb.compose.yml`, `www.compose.yml`, `api.compose.yml`, etc.

```sh
$ pwd
/path/to/compose/files

$ ls -l
total 12
drwxr-xr-x 2 user group 4096 Mar 15 23:43 mongodb
-rw-r--r-- 1 user group 1318 Mar 15 23:43 mongodb.compose.yml       # --> *.compose.yml
drwxr-xr-x 2 user group 4096 Mar 15 23:43 nginx-proxy
-rw-r--r-- 1 user group  641 Mar 15 23:44 nginx-proxy.compose.yml   # --> *.compose.yml
drwxr-xr-x 2 user group 4096 Mar 15 23:43 registry
-rw-r--r-- 1 user group  135 Mar 15 23:44 registry.compose.yml      # --> *.compose.yml
```
## Run command
```sh
$ docker-compose up -d
[$] docker compose -f mongodb.compose.yml -f nginx-proxy.compose.yml -f registry.compose.yml up -d
  > Confirm? [y/N]: y

[+] Running 4/4
 ⠿ Network test_default          Created        0.0s
 ⠿ Container test-mongodb-1      Started        0.5s
 ⠿ Container test-nginx-proxy-1  Started        0.5s
 ⠿ Container test-registry-1     Started        0.5s
```

## Run with explicit confirmation
Just add `-y` to beginning of arguments

```sh
$ docker-compose -y up -d
[$] docker compose -f mongodb.compose.yml -f nginx-proxy.compose.yml -f registry.compose.yml up -d

[+] Running 4/4
 ⠿ Network test_default          Created        0.0s
 ⠿ Container test-mongodb-1      Started        0.5s
 ⠿ Container test-nginx-proxy-1  Started        0.5s
 ⠿ Container test-registry-1     Started        0.5s
```

## All docker compose commands available
```sh
$ docker-compose -y up -d
$ docker-compose -y down
$ docker-compose -y logs -f service
$ docker-compose -y restart
...
```

# All containers in the same network
With this method, all containers inhabit the same network. You can use yours customs networks as usual.