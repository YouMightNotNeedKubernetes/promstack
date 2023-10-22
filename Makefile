-include .env
docker_stack_name = promstack

it:
	@echo "make [deploy|destroy]"

configs:
	test -f "services/prometheus/prometheus.yml" || cp services/prometheus/prometheus.default.yml services/prometheus/prometheus.yml
	test -f "services/alertmanager/alertmanager.yml" || cp services/alertmanager/alertmanager.default.yml services/alertmanager/alertmanager.yml

deploy: configs
	docker stack deploy -c docker-compose.yml $(docker_stack_name)

destroy:
	docker stack rm $(docker_stack_name)
