# mysql docker deploy


Before start use docker to pull the images of mysql and phpmyadmin

    docker pull mysql
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



