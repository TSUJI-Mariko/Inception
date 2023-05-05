all:
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

clean:	down
	@echo "Pruning containers, images, volumes, and networks"
	@docker system prune -af --volumes

.PHONY: all re down clean fclean
