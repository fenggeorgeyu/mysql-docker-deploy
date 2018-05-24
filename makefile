
name=mysql-dk1
image=mysql
name2=phpmyadmin-dk1
image2=phpmyadmin/phpmyadmin
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

pl1=3306
pd1=3306
passwd=ysu123


create: create-mysql create-phpmyadmin

create-mysql:
	[ -d ${vol1} ] || mkdir ${vol1}
	[ -d ${vol2} ] || mkdir ${vol2}
	[ -d ${vol3} ] || mkdir ${vol3}
	docker run -d -it --name ${name} -v ${vol1}:${mnt1} -v ${vol2}:${mnt2} -v ${vol3}:${mnt3} -e MYSQL_ROOT_PASSWORD=${passwd} ${image}

	# sleep 3
	# docker exec ${name} mysql -uroot -p${passwd} -e "alter user 'root' identified with mysql_native_password by '${passwd}';"

create-phpmyadmin:
	docker run --name ${name2} -d --link ${name}:db -p 8080:80 ${image2}

bash:
	docker exec -it ${name} /bin/bash

connect:
	docker exec -it ${name} mysql -uroot -p${passwd}

start:
	docker start ${name}
	docker start ${name2}

stop:
	docker stop ${name}
	docker stop ${name2}

delete:
	docker rm ${name}
	docker rm ${name2}





