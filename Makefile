build:
	@docker-compose build --no-cache

run:
	@mkdir -p htdocs
	@docker-compose up -d
	@docker-sync stop && docker-sync clean && docker-sync start

stop:
	@docker-compose stop
	@docker-sync stop

clean:
	@docker-sync stop
	@docker-compose stop
	@rm -fR ./htdocs
	@docker volume rm -f app

get-user-web:
	@docker exec docker-prestashop17x-php7-fpm_web_1 id -u web

get-user-prestashop:
	@docker exec docker-prestashop17x-php7-fpm_prestashop_1 id -u php

get-app-logs:
	@docker logs -f app