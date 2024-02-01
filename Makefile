NAME = inception
COMPOSE = ./srcs/docker-compose.yml

all: conf up

conf:
	@cp ../.env ./srcs/
	@echo "Creating volumes...\n"
	@mkdir -p /home/jomirand/data/mariadb_data /home/jomirand/data/wordpress_data
	@sudo sed -i '/^127.0.0.1/ {/jomirand.42.fr/! s/localhost/localhost jomirand.42.fr/}' /etc/hosts
	@echo "\n"
	@echo "Starting docker compose up..."

up:
	docker compose -p $(NAME) -f $(COMPOSE) up --build -d

down:
	docker compose -p $(NAME) down --volumes

start:
	docker compose -p $(NAME) start

stop:
	docker compose -p $(NAME) stop

clean-images:
	docker rmi -f $$(docker images -q) || true

clean: down clean-images

fclean: clean
	@sudo rm -rf /home/jomirand/data
	@docker system prune -a
	@rm -f ./srcs/.env

re: fclean conf up
