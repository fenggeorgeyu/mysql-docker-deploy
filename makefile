
name1=mysql-dk1
#image1=mysql:5
image1=mariadb
db_cmd=mariadb
name2=phpmyadmin-dk1
image2=phpmyadmin/phpmyadmin
pl1=3306
pdk1=3306
passwd=ysu123
host_dir=$(shell pwd)

# db folder
vol1=${host_dir}/db
mnt1=/var/lib/mysql
# share folder
vol2=${host_dir}/shared
mnt2=/shared

# mysql config folder
vol3=${host_dir}/mysql-config
mnt3=/etc/mysql/conf.d

# control if container auto restart on docker starting
# restart=--restart=always
restart=

pull:
	docker pull ${image1}
	docker pull ${image2}

create: create-mysql create-phpmyadmin

create-mysql:
	[ -d ${vol1} ] || mkdir ${vol1}
	[ -d ${vol2} ] || mkdir ${vol2}
	[ -d ${vol3} ] || mkdir ${vol3}
	docker run -d -it ${restart} --name ${name1} -v ${vol1}:${mnt1} -v ${vol2}:${mnt2} -v ${vol3}:${mnt3} -e MYSQL_ROOT_PASSWORD=${passwd} -p ${pl1}:${pdk1} ${image1}

create-phpmyadmin:
	docker run --name ${name2} -d ${restart} --link ${name1}:db -p 8080:80 ${image2}

# fix problem of phpmyadmin connect to MySQL 8
root-passwd-config:
	sleep 3
	docker exec mysql-dk1 mysql -uroot -p${passwd} -e "alter user 'root' identified with mysql_native_password by '${passwd}';"

start:
	docker start ${name1}
	docker start ${name2}

stop:
	docker stop ${name1}
	docker stop ${name2}

delete:
	docker rm ${name1}
	docker rm ${name2}

commit:
	git add .
	git commit -am 'auto'
	git push

bash:
	docker exec -it ${name1} /bin/bash

sql:
	docker exec -it ${name1} ${db_cmd} -uroot -p${passwd}





