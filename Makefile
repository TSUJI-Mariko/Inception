all:
	@echo "Making data directory"
	@sudo mkdir -p /home/mtsuji/data/wordpress
	@sudo mkdir -p /home/mtsuji/data/mysql
	@echo "Building containers"
	@docker-compose -f ./srcs/docker-compose.yml up -d --build

down:
	@echo "Stopping containers"
	@docker-compose -f ./srcs/docker-compose.yml down

re:	down all

fclean:
	@echo "Stopping containers"
	@docker stop $$(docker ps -qa)
	@echo "Removing containers"
	@docker rm $$(docker ps -qa)
	@echo "Removing images"
	@docker rmi -f $$(docker images -qa)
	@echo "Removing volumes"
	@docker volume rm $$(docker volume ls -q)
	@echo "Removing network"
	@docker network rm $$(docker network ls -q)
	@echo "Deleting data directory"
	@sudo rm -rf /home/mtsuji/data/wordpress
	@sudo rm -rf /home/mtsuji/data/mysql

clean:	down
	@echo "Pruning containers, images, volumes, and networks"
	@docker system prune -af --volumes
	@echo "Deleting data directory"
	@sudo rm -rf /home/mtsuji/data/wordpress
	@sudo rm -rf /home/mtsuji/data/mysql

.PHONY: all re down clean fclean
