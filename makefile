
name=mysql-dk1
image=mysql
image2=phpmyadmin/phpmyadmin
host_dir=$(shell pwd)
vol1=${host_dir}/db
mnt1=/var/lib/mysql
vol2=${host_dir}/shared
mnt2=/shared
pl1=3306
pd1=3306
passwd=ysu123



create:
	docker run -d -it --name ${name} -v ${vol1}:${mnt1} -v ${vol2}:${mnt2} -e MYSQL_ROOT_PASSWORD=${passwd} ${image}

bash:
	docker exec -it ${name} /bin/bash

psql:
	docker exec -it ${name} psql -U postgres


stop:
	docker stop ${name}

start:
	docker start ${name}

delete:
	docker rm ${name}





