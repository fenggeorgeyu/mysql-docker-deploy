
name=mysql-dk1
image=mysql
name2=phpmyadmin-dk1
image2=phpmyadmin/phpmyadmin
host_dir=$(shell pwd)
vol1=${host_dir}/db
mnt1=/var/lib/mysql
vol2=${host_dir}/shared
mnt2=/shared
pl1=3306
pd1=3306
passwd=ysu123


create: create-mysql create-phpmyadmin

create-mysql:
	docker run -d -it --name ${name} -v ${vol1}:${mnt1} -v ${vol2}:${mnt2} -e MYSQL_ROOT_PASSWORD=${passwd} ${image}
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





