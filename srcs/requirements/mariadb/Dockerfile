FROM debian:bullseye

EXPOSE 3306

RUN	apt update \
	&& apt install -y --no-install-recommends --no-install-suggests \
	mariadb-server \
	&& rm -rf /var/lib/apt/lists/*

COPY	conf/50-server.cnf /etc/mysql/mariadb.conf.d/

COPY	tools/script.sh /bin/
RUN	chmod +x /bin/script.sh

CMD	["script.sh", "mysqld_safe"]