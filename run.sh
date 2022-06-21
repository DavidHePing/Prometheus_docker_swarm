# show variable when run ci/cd
set -x

DockerHubUrl="localhost:5000"
ProjectName=$1
Tag=$2
ImageName=""
Ip=""
StackNname="$1_stack"

if [ -z "$1" ]; then
    echo "ProjectName NOT ALLOW empty"
    exit
fi	

if [ -z "$2" ]; then
    echo "Tag NOT ALLOW empty"
    exit
fi

PrometheusImageName="$DockerHubUrl/prometheus_test:${Tag}"
GrafanaImageName="$DockerHubUrl/grafana_test:${Tag}"
ManagerNodeName="LAPTOP-RJCSV869"

# execute as a subcommand in order to avoid the variables remain set
(
	export ProjectName=$ProjectName
	export PrometheusImageName=$PrometheusImageName
	export GrafanaImageName=$GrafanaImageName
	export ManagerNodeName=$ManagerNodeName
		
	docker image pull "$PrometheusImageName"
	docker image pull "$GrafanaImageName"	
	
	docker stack deploy -c docker-compose.yml $StackNname
)
