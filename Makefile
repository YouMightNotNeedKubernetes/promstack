-include .env
docker_stack_name = promstack

compose_files := -c docker-compose.yml
ifneq ("$(wildcard docker-compose.override.yml)","")
	compose_files += -c docker-compose.override.yml
endif

it:
	@echo "make [deploy|destroy]"

configs:
	test -f "services/alertmanager/alertmanager.yml" || cp services/alertmanager/alertmanager.default.yml services/alertmanager/alertmanager.yml
	test -f "services/prometheus/prometheus.yml" || cp services/prometheus/prometheus.default.yml services/prometheus/prometheus.yml
	test -f "services/promtail/promtail.yml" || cp services/promtail/promtail.default.yml services/promtail/promtail.yml

deploy: configs
	docker stack deploy $(compose_files) $(docker_stack_name)

destroy:
	docker stack rm $(docker_stack_name)
