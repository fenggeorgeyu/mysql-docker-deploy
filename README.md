*Warning*: This script only works with docker mysql:5. The latest mysql 8.0 update the password plugin which may conflict with phpmyadmin login. It's advised to only use mysql:5 for now.

# mysql docker deploy


Before start use docker to pull the images of mysql and phpmyadmin

    docker pull mysql:5
    docker pull phpmyadmin/phpmyadmin

To create the containers of mysql and phpmyadmin run

    make create

To access phpymyadmin type in your web browser: `http://localhost:8080`. By default, the root password is `ysu123`. You may change the password in the makefile `passwd`

To login to mysql in bash

    make connect

To stop containers

    make stop

To start containers

    make start

To delete containers

    make delete



