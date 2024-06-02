# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: kchaouki <kchaouki@student.1337.ma>        +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/05/18 16:27:43 by kchaouki          #+#    #+#              #
#    Updated: 2024/06/02 17:33:45 by kchaouki         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

all : up

init:
	bash srcs/requirements/tools/script.sh

up : init
	@docker-compose -f srcs/docker-compose.yml up --build -d

down : 
	@docker-compose -f srcs/docker-compose.yml down

re: clean up

clean:
	@docker-compose -f srcs/docker-compose.yml down -v
	@rm -rf /home/kchaouki/data/database/*
	@rm -rf /home/kchaouki/data/wordpress/*

da := $(shell docker images -qa)

fclean: clean
	@docker rmi -f $(da)

status : 
	@docker ps

logs:
	@docker-compose -f srcs/docker-compose.yml logs -f

nginx_logs:
	@docker-compose -f srcs/docker-compose.yml logs nginx

wordpress_logs:
	@docker-compose -f srcs/docker-compose.yml logs wordpress

mariadb_logs:
	@docker-compose -f srcs/docker-compose.yml logs mariadb

.PHONY: all init up down re clean fclean status logs nginx_logs wordpress_logs mariadb_logs