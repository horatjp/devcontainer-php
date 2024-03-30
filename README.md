# Visual Studio Code Remote Containers PHP Development

**devcontainer-php** is a PHP development environment using [**Visual Studio Code Remote - Containers**](https://code.visualstudio.com/docs/remote/containers).
Launches a Docker container from Visual Studio Code and enables development within the container.


## Container

* PHP(CLI)
* nginx
* PHP(FPM)
* MySQL
* PostgreSQL
* Redis
* Mailhog
* selenium


## System requirements

* Visual Studio Code
* Visual Studio Code Remote Containers Extension
* Docker Desktop


## Quick Start

1. Place the `.devcontainer` in your project directory.
1. Start VS Code, run the [**Remote-Containers: Reopen in Container**] from the Command Palette (F1)
1. Start building the development container
1. After completion, VS Code will automatically connect to the container.

If you don't have a terminal open, open one.`Ctlr + @`
You will see that PHP(CLI) is available.
```bash
php -v
```

You can also see that nginx and PHP(FPM) are running.
```bash
mkdir -p public
echo '<?php phpinfo();' > public/phpinfo.php
```
http://localhost/phpinfo.php


## Usage

Create a project directory, expand **devcontainer-php** and start VS Code.
```bash
mkdir php-develop
cd php-develop
curl -L https://github.com/horatjp/devcontainer-php/archive/refs/tags/php8.2.tar.gz | tar --strip-components=1 -xz
code .
```

### .devcontainer

Various settings are made in the `.devcontainer` directory.

#### devcontainer.json

Configure the VS Code settings in `devcontainer.json`.

You can use `settings` to configure the settings in the VS Code container, and `extensions` to configure the extension to be used.
Change it to your liking.

```json
{
    "name": "PHP Development",
    "dockerComposeFile": [
        "docker-compose.yml"
    ],
    "service": "workspace",
    "workspaceFolder": "/var/www",
    "remoteUser": "vscode",

    "customizations": {
        "vscode": {
            "settings": {
                "php.validate.enable": false,
                "php.suggest.basic": false,
                "[php]": {
                    "editor.formatOnSave": true,
                    "editor.defaultFormatter": "bmewburn.vscode-intelephense-client"
                },
                "search.exclude": {
                    "**/node_modules": true,
                    "**/bower_components": true,
                    "**/*.code-search": true,
                    "**/vendor/*/**": true
                }
            },
            "extensions": [
                "mikestead.dotenv",
                "EditorConfig.EditorConfig",
                "mhutchie.git-graph",
                "eamodio.gitlens",
                "xdebug.php-debug",
                "neilbrayfield.php-docblocker",
                "bmewburn.vscode-intelephense-client",
                "recca0120.vscode-phpunit"
            ]
        }
    }
}

```

#### Docker Compose environment file
Create and configure the environment file.
```bash
cp .devcontainer/.env.example .devcontainer/.env
```

`.env` will be the environment file for Docker Compose.  
Please refer to the file to set your preferences.

```ini
TIME_ZONE=Asia/Tokyo
LOCALE=ja_JP.UTF-8

DB_DATABASE=docker
DB_USERNAME=docker
DB_PASSWORD=docker

MINIO_USERNAME=minio
MINIO_PASSWORD=password
MINIO_BUCKET=default

# Local Loopback Address(127.0.0.0/8):
IP_ADDRESS_SETTING=127.127.127.127:
```

##### IP_ADDRESS_SETTING
Docker allows you to set the IP address to be published for each port, but it is recommended to set the IP address so that you don't have to worry about duplicate ports for multiple projects.

It is convenient to configure the `hosts` with the configured IP address.
```
127.127.127.127 php-develop.test
```

> macOS
> ```
> sudo ifconfig lo0 alias 127.127.127.127
> ```


#### docker-compose.yml
Docker is configured in `docker-compose.yml`.
Other detailed settings for Docker exist in the `docker` directory.
These are not dedicated to VS Code, so they can be run on their own.

You may have a variety of containers set up, but for pure PHP-only development, only the `workspace` container will do.
You can delete the other containers if you wish.


### Start Remote - Containers

1. Run the [**Remote-Containers: Reopen in Container**] from the Command Palette (F1)
1. Start building the development container
1. After completion, VS Code will automatically connect to the container.


### Xdebug

If the `.vscode/launch.json` file is set up, Xdebug will work with both CLI and FPM.
Please give it a try.


### Install Laravel

I would like to install Laravel.

```bash
composer create-project laravel/laravel:11.* /tmp/laravel
mv -n /tmp/laravel/* /tmp/laravel/.[^\.]* .
```

Check to see if it is working.
http://php-develop.test
or
http://127.127.127.127


#### Database

If you want to use a database, you will need to configure it in the `.env` file.

**MySQL**
```ini
DB_CONNECTION=mysql
DB_HOST=mysql
DB_PORT=3306
DB_DATABASE=docker
DB_USERNAME=docker
DB_PASSWORD=docker
```

**PostgreSQL**
```ini
DB_CONNECTION=pgsql
DB_HOST=postgres
DB_PORT=5432
DB_DATABASE=docker
DB_USERNAME=docker
DB_PASSWORD=docker
```

Laravel migrate
```bash
php artisan migrate:refresh --seed
```

#### Mailpit

Mailpit is a mail catcher.
You can check the mail sent from the application.
http://php-develop.test:8025

Set the following in the `.env` file.
```ini
MAIL_MAILER=smtp
MAIL_HOST=mailpit
MAIL_PORT=1025
```

#### MinIO

MinIO is available for object storage.
http://php-develop.test:8900
minio:password


```php
composer require league/flysystem-aws-s3-v3 "^3.0" --with-all-dependencies
```

Set the following in the `.env` file.
```ini
AWS_ACCESS_KEY_ID=minio
AWS_SECRET_ACCESS_KEY=password
AWS_DEFAULT_REGION=us-east-1
AWS_BUCKET=default
AWS_USE_PATH_STYLE_ENDPOINT=true
AWS_ENDPOINT=http://minio:9001
AWS_URL=http://php-develop.test:9001/default
```

#### Laravel Dusk

Laravel Dusk is available for browser testing.
```bash
composer require laravel/dusk --dev
php artisan dusk:install
php artisan dusk:chrome-driver --detect
```

Set the following in the `.env` file.
```ini
APP_URL=http://nginx
```

Run the test.
```bash
php artisan dusk
```


### Exit and resume

When you exit VS Code, the container will also exit.

The next time you start it, the container will start automatically and start with the environment in the container.

Alternatively, with VS Code open, use `Ctrl + R` to show the recently opened folders and select "Dev Container" to start developing in a container environment.

## In the end

Sharing a `.devcontainer` allows everyone involved in a project to develop in the same environment.

Although it is not officially up and running yet, it may become possible to develop using [**GitHub Codespaces**](https://github.com/features/codespaces).
